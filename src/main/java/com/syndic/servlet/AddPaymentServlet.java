package com.syndic.servlet;

import com.syndic.beans.Payment;
import com.syndic.connection.Syndic_con;
import com.syndic.dao.PaymentDAOImpl;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

public class AddPaymentServlet extends HttpServlet {
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

        List<Payment> payments;
        PaymentDAOImpl paymentDAO = new PaymentDAOImpl(connection);
        payments = paymentDAO.getAllPayments();
        req.setAttribute("payments", payments);

        RequestDispatcher dispatcher = req.getRequestDispatcher("addpayment.jsp");
        dispatcher.forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        switch (action) {
            case "add":
                addPayment(req, resp);
                break;
            case "update":
                updatePayment(req, resp);
                break;
            case "delete":
                deletePayment(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/addpayment");
                break;
        }
    }

    private void addPayment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

        // Insérer le paiement dans la base de données
        PaymentDAOImpl paymentDAO = new PaymentDAOImpl(connection);
        boolean success = paymentDAO.insertPayment(payment);

        if (success) {
            HttpSession session = req.getSession();
            session.setAttribute("successMessage", "Le paiement a été ajouté avec succès !");
        } else {
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "Une erreur s'est produite lors de l'ajout du paiement.");
        }
        resp.sendRedirect(req.getContextPath() + "/addpayment");
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

        // Mettre à jour le paiement dans la base de données
        PaymentDAOImpl paymentDAO = new PaymentDAOImpl(connection);
        boolean success = paymentDAO.updatePayment(payment);

        if (success) {
            HttpSession session = req.getSession();
            session.setAttribute("successMessage", "Le paiement a été mis à jour avec succès !");
        } else {
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "Une erreur s'est produite lors de la mise à jour du paiement.");
        }
        resp.sendRedirect(req.getContextPath() + "/addpayment");
    }

    private void deletePayment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int code = Integer.parseInt(req.getParameter("code"));

        // Supprimer le paiement de la base de données
        PaymentDAOImpl paymentDAO = new PaymentDAOImpl(connection);
        boolean success = paymentDAO.deletePayment(code);

        if (success) {
            HttpSession session = req.getSession();
            session.setAttribute("successMessage", "Le paiement a été supprimé avec succès !");
        } else {
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "Une erreur s'est produite lors de la suppression du paiement.");
        }
        resp.sendRedirect(req.getContextPath() + "/addpayment");
    }
}
