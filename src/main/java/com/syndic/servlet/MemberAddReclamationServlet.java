package com.syndic.servlet;

import com.syndic.connection.Syndic_con;
import com.syndic.beans.*;
import com.syndic.connection.Syndic_con;
import com.syndic.dao.*;
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

public class MemberAddReclamationServlet extends HttpServlet {
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
        Integer memberid = (Integer) session.getAttribute("memberId");
        Integer syndicid = (Integer) session.getAttribute("syndicId");

        System.out.println("mid :"+ memberid);
        if (memberid == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        ReclamationDAO reclaim = new ReclamationDAOImpl(connection);
        List<Reclamation> reclamations= reclaim.getAllReclamationsByMemberId(memberid);
        req.setAttribute("reclamations",reclamations);
        System.out.println(reclamations);
        RequestDispatcher dispatcher = req.getRequestDispatcher("Memberaddreclamation.jsp");
        dispatcher.forward(req, resp);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        switch (action) {
            case "add":
                try {
                    addReclamation(req, resp);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "edit":
                updateReclamation(req, resp);
                break;
            case "delete":
                deleteReclamation(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/Memberaddreclamation");
                break;
        }
    }

    private void deleteReclamation(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void updateReclamation(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void addReclamation(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        HttpSession session = req.getSession();
        Integer memberid = (Integer) session.getAttribute("memberId");
        Integer syndicid = (Integer) session.getAttribute("syndicId");
System.out.println("syndic id "+syndicid+" Member id :"+memberid);
        String reclaimType = req.getParameter("reclaimType");
        String reclaimDate = req.getParameter("reclaimDate");
        String reclaimDescription = req.getParameter("reclaimDescription");
        String reclaimStatus = req.getParameter("reclaimStatus");
        String reclaimResolutionDate = req.getParameter("reclaimResolutionDate"); // Exemple de récupération d'un champ date

        Reclamation reclamation = new Reclamation();
        reclamation.setReclaimType(reclaimType);
        reclamation.setDate(reclaimDate);
        reclamation.setReclaimDescription(reclaimDescription);
        reclamation.setReclaimStatus(reclaimStatus);
        reclamation.setReclaimResolutionDate(reclaimResolutionDate);
        reclamation.setReclaimMId(memberid);
        reclamation.setReclaimSId(syndicid);

        // Utiliser le DAO pour insérer la nouvelle réclamation dans la base de données
        ReclamationDAO reclaimDAO = new ReclamationDAOImpl(connection);
        boolean success = reclaimDAO.insertReclaim(reclamation);
        if (success) {
            session.setAttribute("successMessage", "Réclamation ajoutée avec succès !");
        } else {
            session.setAttribute("errorMessage", "Une erreur s'est produite lors de l'ajout de la réclamation.");
        }
        resp.sendRedirect(req.getContextPath() + "/Memberaddreclamation");
    }


}
