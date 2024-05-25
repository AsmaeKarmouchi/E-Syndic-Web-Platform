package com.syndic.servlet;

import com.syndic.beans.Incident;
import com.syndic.beans.News;
import com.syndic.beans.Syndic;
import com.syndic.beans.User;
import com.syndic.connection.Syndic_con;
import com.syndic.dao.NewsDAO;
import com.syndic.dao.NewsDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Calendar;


public class NewsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public NewsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("news.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

            if (action != null && action.equals("addNews")) {
                // Récupération des paramètres de la requête
                String newsTitle = request.getParameter("news_title");
                String newsContent = request.getParameter("news_content");
                String newsCategory = request.getParameter("news_category");
                String newsAttachment = request.getParameter("news_attachment");

                try {

                    Connection connection = Syndic_con.getConnection();

                    HttpSession session = request.getSession();

                    int syndicId;
                    News newNews = null;
                    User user = (User) session.getAttribute("user");
                    int userId = user.getAdmin();
                    if (userId == 2) {

                        Syndic syndic = (Syndic) session.getAttribute("syndic");
                        syndicId = syndic.getId();
                        newNews = new News(newsTitle, newsContent, newsCategory, newsAttachment, syndicId);

                    } else {

                    }

                    NewsDAO newsDAO = new NewsDAOImpl(connection);
                    newsDAO.addNews(newNews);
                    // Définir un attribut de session pour le message
                    session.setAttribute("successMessage", "News a été ajouté avec succès !");
                    // Rediriger vers la même page
                    response.sendRedirect(request.getRequestURI());


                } catch (SQLException e) {
                    throw new RuntimeException(e);

                }

        }
    }

}
