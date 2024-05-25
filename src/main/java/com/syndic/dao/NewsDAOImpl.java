package com.syndic.dao;



import com.syndic.beans.Incident;
import com.syndic.beans.News;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NewsDAOImpl implements NewsDAO {

    private final Connection connection;


    public NewsDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void addNews(News news) throws SQLException {
        String query = "INSERT INTO News_communication (news_title, news_content, news_category, news_attachment, news_s_id) " +
                "VALUES (?, ?, ?, ?, ?) ";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, news.getNewsTitle());
            preparedStatement.setString(2, news.getNewsContent());
            preparedStatement.setString(3, news.getNewsCategory());
            preparedStatement.setString(4, news.getNewsAttachment());
            preparedStatement.setInt(5, news.getNewsSId());
            preparedStatement.executeUpdate();
        }
    }

    @Override

    public List<News> getNewsBySyndicId(int syndicId) throws SQLException {
        List<News> newss = new ArrayList<>();
        String query = "SELECT * FROM News_communication WHERE news_s_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, syndicId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    News news = new News();
                    news.setNewsId(resultSet.getInt("news_id"));
                    news.setNewsTitle(resultSet.getString("news_title"));
                    news.setNewsContent(resultSet.getString("news_content"));
                    news.setNewsDate(resultSet.getDate("news_date"));
                    news.setNewsCategory(resultSet.getString("news_category"));
                    news.setNewsAttachment(resultSet.getString("news_attachment"));
                    news.setNewsSId(resultSet.getInt("news_s_id"));
                    newss.add(news); // Ajouter la réunion à la liste
                }
            }
        }
        return newss; // Retourner la liste de réunions
    }


}
