package com.syndic.servlet;

import com.syndic.beans.Syndic;
import com.syndic.beans.User;
import com.syndic.beans.Account;
import com.syndic.dao.*;
import com.syndic.connection.Syndic_con;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.RequestDispatcher;
import java.math.BigDecimal;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;

import org.mindrot.jbcrypt.BCrypt;


public class AddSyndicServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;
    public AddSyndicServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        RequestDispatcher dispatcher = request.getRequestDispatcher("addsyndic.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String residence = request.getParameter("residence");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Connection connection = null;
        // Crypter le mot de passe avant de l'ajouter à la base de données
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        do {
            try {
                connection = Syndic_con.getConnection();
                if (connection != null) {
                    userDAO = new UserDAOImpl(connection);
                    // Cr�er un nouvel utilisateur
                    User newUser = new User(0, name, email, hashedPassword,2);

                    // Appeler la m�thode pour ajouter l'utilisateur � la base de donn�es
                    userDAO.createSyndic(newUser);

                    // Récupérer l'ID de l'utilisateur nouvellement créé
                    int userId = userDAO.getUserIdByEmail(email);
                    // Créer un nouveau syndic
                    Syndic newSyndic = new Syndic();
                    newSyndic.setUserId(userId);
                    newSyndic.setResidenceName(residence);
                    SyndicProfileDAO syndicDAO = new SyndicProfileDAOImpl(connection);
                    syndicDAO.addSyndic(newSyndic);
                    int syndicId = syndicDAO.getSyndicIdByUserId(userId);
                    // Create two accounts for the syndic
                    AccountDAO accountDAO = new AccountDAOImpl(connection);

                    int lastAccountNumber = accountDAO.getLastAccountNumber();

                    Account primaryAccount = new Account();
                    primaryAccount.setAccountNumber(lastAccountNumber + 1);
                    primaryAccount.setAccountType("Principal");
                    primaryAccount.setAccountBalance(BigDecimal.ZERO);
                    primaryAccount.setAccountCreatedAt(new Date());
                    primaryAccount.setAccountSyndicId(syndicId);
                    accountDAO.createAccount(primaryAccount);

                    Account secondaryAccount = new Account();
                    secondaryAccount.setAccountNumber(lastAccountNumber + 2);
                    secondaryAccount.setAccountType("Secondaire");
                    secondaryAccount.setAccountBalance(BigDecimal.ZERO);
                    secondaryAccount.setAccountCreatedAt(new Date());
                    secondaryAccount.setAccountSyndicId(syndicId);
                    accountDAO.createAccount(secondaryAccount);


                    // Définir un attribut de session pour le message
                    HttpSession session = request.getSession();
                    session.setAttribute("successMessage", "Le syndic a été ajouté avec succès !");
                    // Rediriger vers la même page
                    response.sendRedirect(request.getRequestURI());

                    return;
                }
            } catch (IOException e) {
                e.printStackTrace();
                // Définir un attribut de session pour le message d'échec
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Une erreur s'est produite lors de l'ajout du syndic.");
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        } while (true);
    }

}
