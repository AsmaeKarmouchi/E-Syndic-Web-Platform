package com.syndic.servlet;

import com.syndic.beans.Payment;
import com.syndic.beans.PaymentFlow;
import com.syndic.beans.Syndic;
import com.syndic.connection.Syndic_con;
import com.syndic.dao.PaymentDAOImpl;
import com.syndic.dao.PaymentFlowDAOImpl;
import com.syndic.dao.SyndicProfileDAOImpl;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.syndic.beans.Member;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class SyndicAddPaymentServlet extends HttpServlet {
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

    @Override
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

        PaymentDAOImpl paymentDAO = new PaymentDAOImpl(connection);
        List<Payment> payments = paymentDAO.getPaymentsBySyndic(syndicId);
        req.setAttribute("payments", payments);
        System.out.println(payments);
        // Ajouter la liste des membres pour le syndic connecté
       // List<Member> members = paymentDAO.getMembersBySyndic(syndicId);
        //req.setAttribute("members", members);

        RequestDispatcher dispatcher = req.getRequestDispatcher("Syndicaddpayment.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        switch (action) {
            case "add":
                addPayment(req, resp);
                break;
            case "edit":
                updatePayment(req, resp);
                break;
            case "delete":
                deletePayment(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/Syndicaddpayment");
                break;
        }
    }

    private void addPayment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int code = Integer.parseInt(req.getParameter("code"));
        String date = req.getParameter("date");
        double amount = Double.parseDouble(req.getParameter("amount"));
        String method = req.getParameter("method");
        String type = req.getParameter("type");
      //  int account_id = Integer.parseInt(req.getParameter("account_id"));
        int member_id = Integer.parseInt(req.getParameter("member_id"));
        String status = req.getParameter("status");
        System.out.println("rec "+code +" "+ date + amount +method +type+member_id +status);

        HttpSession session = req.getSession();
        Integer syndicId = (Integer) session.getAttribute("syndic_id");

        if (syndicId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Payment payment = new Payment();
        payment.setCode(code);
        payment.setDate(date);
        payment.setAmount(amount);
        payment.setMethod(method);
        payment.setType(type);
       // payment.setAccount_id(account_id);
        payment.setMember_id(member_id);
        payment.setStatus(status);
        payment.setSyndicId(syndicId);
//---------------------------
        // Récupérer le solde actuel du compte du syndic depuis la base de données
        SyndicProfileDAOImpl syndicProfileDAO = new SyndicProfileDAOImpl(connection);
        Syndic syndic;
        try {
            syndic = syndicProfileDAO.getSyndicById(syndicId);
        } catch (SQLException e) {
            e.printStackTrace();
            // Gérer l'erreur de récupération du syndic
            return;
        }
        System.out.println("loreeee "+syndic.getAccount());
        // Calculer le nouveau solde du compte du syndic
        double newAccountBalance = syndic.getAccount() + amount;
        System.out.println("loraaaa "+newAccountBalance);
        // Mettre à jour le solde du compte du syndic dans la base de données
        try {
            syndic.setAccount((int) newAccountBalance);
            syndicProfileDAO.updateSyndic3(syndic);
        } catch (SQLException e) {
            e.printStackTrace();
            // Gérer l'erreur de mise à jour du solde du compte du syndic
            return;
        }
//---------------------------


        PaymentDAOImpl paymentDAO = new PaymentDAOImpl(connection);
        boolean success = paymentDAO.insertPayment(payment);

        if (success) {
            PaymentFlow paymentFlow = new PaymentFlow();
            paymentFlow.setSyndicId(syndicId);
            paymentFlow.setFlowType(0);
            paymentFlow.setAmount(amount);
            paymentFlow.setDescription("Payment added with code: " + code+ "type: "+type + "By Member"+ member_id);
            paymentFlow.setTransactionDate(java.sql.Date.valueOf(date));
            PaymentFlowDAOImpl paymentFlowDAO = new PaymentFlowDAOImpl(connection);
            try {
                paymentFlowDAO.addPaymentFlow(paymentFlow);
            } catch (SQLException e) {
                e.printStackTrace();
                // Gérer l'erreur de l'ajout du flux de paiement
                return;
            }
            session = req.getSession();
            session.setAttribute("successMessage", "Le paiement a été ajouté avec succès !");
            System.out.println("succès");
        } else {
            session = req.getSession();
            session.setAttribute("errorMessage", "Une erreur s'est produite lors de l'ajout du paiement.");
            System.out.println("erreur");
        }
        resp.sendRedirect(req.getContextPath() + "/Syndicaddpayment");
    }

    private void updatePayment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int code = Integer.parseInt(req.getParameter("code"));
        String date = req.getParameter("date");
        double amount = Double.parseDouble(req.getParameter("amount"));
        String method = req.getParameter("method");
        String type = req.getParameter("type");
        int account_id = Integer.parseInt(req.getParameter("account_id"));
        int member_id = Integer.parseInt(req.getParameter("member_id"));
        String status = req.getParameter("status");

        Payment payment = new Payment();
        payment.setCode(code);
        payment.setDate(date);
        payment.setAmount(amount);
        payment.setMethod(method);
        payment.setType(type);
        payment.setAccount_id(account_id);
        payment.setMember_id(member_id);
        payment.setStatus(status);

        PaymentDAOImpl paymentDAO = new PaymentDAOImpl(connection);
        boolean success = paymentDAO.updatePayment(payment);

        if (success) {
            HttpSession session = req.getSession();
            session.setAttribute("successMessage", "Le paiement a été mis à jour avec succès !");
        } else {
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "Une erreur s'est produite lors de la mise à jour du paiement.");
        }
        resp.sendRedirect(req.getContextPath() + "/Syndicaddpayment");
    }

    private void deletePayment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int code = Integer.parseInt(req.getParameter("code"));

        PaymentDAOImpl paymentDAO = new PaymentDAOImpl(connection);
        boolean success = paymentDAO.deletePayment(code);

        if (success) {
            HttpSession session = req.getSession();
            session.setAttribute("successMessage", "Le paiement a été supprimé avec succès !");
        } else {
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "Une erreur s'est produite lors de la suppression du paiement.");
        }
        resp.sendRedirect(req.getContextPath() + "/Syndicaddpayment");
    }
}
