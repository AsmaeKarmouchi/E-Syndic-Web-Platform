package com.syndic.servlet;

import com.syndic.beans.PaymentFlow;
import com.syndic.beans.Syndic;
import com.syndic.beans.Charge;
import com.syndic.beans.Task;
import com.syndic.connection.Syndic_con;
import com.syndic.dao.PaymentFlowDAOImpl;
import com.syndic.dao.SyndicProfileDAOImpl;
import com.syndic.dao.ChargeDAOImpl;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class SyndicAddChargeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Connection connection;

    public void init() {
        connection = Syndic_con.getConnection();
        if (connection != null) {
            System.out.println("Connexion à la base de données établie avec succès.");
        } else {
            System.out.println("Échec de la connexion à la base de données.");
        }
    }
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (connection == null) {
            return;
        }
        HttpSession session = req.getSession();
        Integer syndicId = (Integer) session.getAttribute("syndic_id");
        System.out.println("syndicid "+syndicId);
        if (syndicId == null) {
            // Rediriger vers la page de connexion si le syndic_id n'est pas défini
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        if (connection == null) {
            return;
        }
        ChargeDAOImpl chargeDAO = new ChargeDAOImpl(connection);
        List<Charge> charges = null;
        try {
            charges = chargeDAO.getChargesBySyndic(syndicId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        req.setAttribute("charges",charges);
        System.out.println(charges);
        RequestDispatcher dispatcher = req.getRequestDispatcher("Syndicaddcharge.jsp");
        dispatcher.forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        switch (action) {
            case "add":
                try {
                    addCharge(req, resp);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "edit":
                updateCharge(req, resp);
                break;
            case "delete":
                deleteCharge(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/Syndicaddcharge");
                break;
        }
    }
    private void addCharge(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
         String chargeName  = req.getParameter("chargeName");
         String chargeDescription = req.getParameter("chargeDescription");
         double chargeAmount = Double.parseDouble(req.getParameter("chargeAmount"));
         String chargeFrequency = req.getParameter("chargeFrequency");
         String chargeCategory = req.getParameter("chargeCategory");
         String chargeDate = req.getParameter("chargeDate");

        HttpSession session = req.getSession();
        Integer syndicId = (Integer) session.getAttribute("syndic_id");

        Charge charge = new Charge();
        charge.setChargeName(chargeName);
        charge.setChargeDescription(chargeDescription);
        charge.setChargeAmount(chargeAmount);
        charge.setChargeFrequency(chargeFrequency);
        charge.setChargeCategory(chargeCategory);
        charge.setChargeSId(syndicId);
        charge.setChargeDate(chargeDate);

        SyndicProfileDAOImpl syndicProfileDAO = new SyndicProfileDAOImpl(connection);
        Syndic syndic;
        try {
            syndic = syndicProfileDAO.getSyndicById(syndicId);
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur lors de la récupération du profil du syndic.");
            resp.sendRedirect(req.getContextPath() + "/Syndicaddcharge");
            return;
        }
        double newAccountBalance = syndic.getAccount() - chargeAmount;
        syndic.setAccount((int) newAccountBalance);
        try {
            syndicProfileDAO.updateSyndic3(syndic);
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur lors de la mise à jour du solde du syndic.");
            resp.sendRedirect(req.getContextPath() + "/Syndicaddcharge");
            return;
        }
// Utiliser le DAO pour insérer la nouvelle charge dans la base de données
        ChargeDAOImpl chargeDAO = new ChargeDAOImpl(connection);
        boolean success = chargeDAO.insertCharge(charge);
        if (success) {
            PaymentFlow paymentFlow = new PaymentFlow();
            paymentFlow.setSyndicId(syndicId);
            paymentFlow.setFlowType(2);
            paymentFlow.setAmount(chargeAmount * -1);
            paymentFlow.setDescription("Charge added with name: " + chargeName);
            paymentFlow.setTransactionDate(java.sql.Date.valueOf(chargeDate));

            PaymentFlowDAOImpl paymentFlowDAO = new PaymentFlowDAOImpl(connection);
            try {
                paymentFlowDAO.addPaymentFlow(paymentFlow);
            } catch (SQLException e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", "Erreur lors de l'ajout du flux de paiement.");
                resp.sendRedirect(req.getContextPath() + "/Syndicaddcharge");
                return;
            }

            session.setAttribute("successMessage", "Charge a été ajoutée avec succès !");
            System.out.println("succès");
        } else {
            session.setAttribute("errorMessage", "Une erreur s'est produite lors de l'ajout de la charge.");
            System.out.println("erreur");
        }
        resp.sendRedirect(req.getContextPath() + "/Syndicaddcharge");
    }
    private void updateCharge(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    private void deleteCharge(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Implémentez la logique pour supprimer une tâche existante
    }

}
