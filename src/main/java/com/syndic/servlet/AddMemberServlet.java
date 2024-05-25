package com.syndic.servlet;


import com.syndic.beans.Member;
import com.syndic.beans.User;
import com.syndic.connection.Syndic_con;
import com.syndic.dao.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;


public class AddMemberServlet extends HttpServlet {
    private UserDAO userDAO;
    private SyndicProfileDAO syndicDAO;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        RequestDispatcher dispatcher = request.getRequestDispatcher("addmember.jsp");
        dispatcher.forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les données du formulaire
        String residence = request.getParameter("residence");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        // Crypter le mot de passe avant de l'ajouter à la base de données
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        Connection connection = null;


        do {
            try {
                connection = Syndic_con.getConnection();
                if (connection != null) {
                    userDAO = new UserDAOImpl(connection);
                    // Cr�er un nouvel utilisateur
                    User newUser = new User(0, name, email, hashedPassword,0);
                    // Appeler la m�thode pour ajouter l'utilisateur � la base de donn�es
                    userDAO.createUser(newUser);
                    // Récupérer l'ID de l'utilisateur nouvellement créé
                    int userId = userDAO.getUserIdByEmail(email);
                    // Créer un nouveau membre
                    Member newMember = new Member();
                    newMember.setUserId(userId);

                    syndicDAO = new SyndicProfileDAOImpl(connection);

                    newMember.setMemberSId(syndicDAO.getSyndicByresidence(residence).getId());
                    MemberProfileDAO memberDAO = new MemberProfileDAOImpl(connection);
                    memberDAO.addMember(newMember);


                    // Définir un attribut de session pour le message
                    HttpSession session = request.getSession();
                    session.setAttribute("successMessage", "Le membre a été ajouté avec succès !");
                    // Rediriger vers la même page
                    response.sendRedirect(request.getRequestURI());

                    return;
                }
            } catch (IOException e) {
                e.printStackTrace();
                // Définir un attribut de session pour le message d'échec
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Une erreur s'est produite lors de l'ajout du membre.");
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }

        } while (true);
    }


}
