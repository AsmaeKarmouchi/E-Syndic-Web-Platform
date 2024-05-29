package com.syndic.servlet;

import com.syndic.beans.Syndic;
import com.syndic.dao.SyndicProfileDAO;
import com.syndic.dao.SyndicProfileDAOImpl;
import com.syndic.connection.Syndic_con;
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

public class DeleteSyndicServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SyndicProfileDAO syndicDAO;
    private Connection connection;

    public void init() {
        connection = Syndic_con.getConnection();
        if (connection != null) {
            System.out.println("Connexion à la base de données établie avec succès.");
            syndicDAO = new SyndicProfileDAOImpl(connection);
        } else {
            System.out.println("Échec de la connexion à la base de données.");
        }
    }



    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("syndics.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int syndicId = Integer.parseInt(request.getParameter("syndicId"));
            System.out.println("syndicId  :"+syndicId);
            syndicDAO = new SyndicProfileDAOImpl(connection);
            boolean success = syndicDAO.deleteSyndic(syndicId);
            List<Syndic> List_syndics;
            syndicDAO = new SyndicProfileDAOImpl(connection);
            List_syndics = syndicDAO.getSyndic();
            session.setAttribute("List_syndics", List_syndics);
            if (success) {
                session.setAttribute("successMessage", "Le paiement a été supprimé avec succès !");
                System.out.println("suc");
            } else {
                session.setAttribute("errorMessage", "Une erreur s'est produite lors de la suppression du paiement.");
                System.out.println("nop");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "ID de syndic invalide.");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Erreur interne du serveur.");
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/syndics.jsp");
    }
}
