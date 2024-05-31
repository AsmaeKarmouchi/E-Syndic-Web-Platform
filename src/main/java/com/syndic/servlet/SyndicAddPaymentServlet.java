package com.syndic.servlet;

import com.syndic.beans.Payment;
import com.syndic.beans.PaymentFlow;
import com.syndic.beans.Syndic;
import com.syndic.connection.Syndic_con;
import com.syndic.dao.MemberProfileDAOImpl;
import com.syndic.dao.PaymentDAOImpl;
import com.syndic.dao.PaymentFlowDAOImpl;
import com.syndic.dao.SyndicProfileDAOImpl;
import com.syndic.mail.NotificationService;
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
import java.util.ArrayList;
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

        MemberProfileDAOImpl memberProfileDAO = new MemberProfileDAOImpl(connection);
        Member member = memberProfileDAO.getMemberById(member_id);
        NotificationService notificationService = new NotificationService();

        // Liste des e-mails à notifier
        List<String> emails = new ArrayList<>();
        emails.add(member.getMail());
        emails.add("kendimohammedamine@gmail.com");
        emails.add("karmouchiasmae@gmail.com");
        System.out.println(emails);

        String subject = "Payment Confirmation";

        // Corps de l'email
        String message = "<html>"
                + "<head>"
                + "<style>"
                + "body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f4f4f4; }"
                + ".container { background-color: #ffffff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); max-width: 600px; margin: auto; }"
                + ".header { text-align: center; margin-bottom: 20px; }"
                + ".header img { width: 100px; margin-bottom: 10px; }"
                + ".header h1 { font-size: 24px; color: #333333; margin: 0; }"
                + "h2 { color: #333333; border-bottom: 2px solid #eeeeee; padding-bottom: 10px; }"
                + "p { line-height: 1.6; color: #555555; }"
                + ".label { font-weight: bold; color: #333333; }"
                + ".intro { margin-bottom: 20px; }"
                + ".footer { margin-top: 20px; font-size: 12px; text-align: center; color: #999999; }"
                + "</style>"
                + "</head>"
                + "<body>"
                + "<div class='container'>"
                + "<div class='header'>"
                + "<img src='cid:logo' alt='Logo'>"
                + "<h1>Ensias_Syndic</h1>"
                + "</div>"
                + "<div class='intro'>"
                + "<p>Dear " + member.getFirstName() + " " + member.getLastName() + ",</p>"
                + "<p>We are pleased to confirm that your payment has been received successfully.</p>"
                + "</div>"
                + "<h2>Payment Details</h2>"
                + "<p><span class='label'>Payment Code:</span> " + code + "</p>"
                + "<p><span class='label'>Payment Date:</span> " + date + "</p>"
                + "<p><span class='label'>Amount:</span> " + amount + "</p>"
                + "<p><span class='label'>Payment Method:</span> " + method + "</p>"
                + "<p><span class='label'>Payment Type:</span> " + type + "</p>"
                + "<p><span class='label'>Payment Status:</span> " + status + "</p>"
                + "<p>Thank you for your prompt payment.</p>"
                + "<p>Best regards,</p>"
                + "<p>The Syndic Team</p>"
                + "<div class='footer'>"
                + "<p>&copy; 2024 Ensias_Syndic. All rights reserved.</p>"
                + "</div>"
                + "</div>"
                + "</body>"
                + "</html>";

        // Get the absolute path of the logo
        String logoPath = getServletContext().getRealPath("/image/logo2.png");

        // Envoyer des e-mails à tous les utilisateurs
        notificationService.sendEmailToUsers(emails, subject, message, logoPath);


        if (success) {
            PaymentFlow paymentFlow = new PaymentFlow();
            paymentFlow.setSyndicId(syndicId);
            paymentFlow.setFlowType(0);
            paymentFlow.setAmount(amount);
            paymentFlow.setDescription("Payment added with code: " + code+ " type: "+type + " By Member: "+ member_id);
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
