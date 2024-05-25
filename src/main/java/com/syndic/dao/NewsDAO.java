package com.syndic.dao;

import com.syndic.beans.Incident;
import com.syndic.beans.News;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

public interface NewsDAO {

    void addNews(News news) throws SQLException;
    List<News> getNewsBySyndicId(int syndicId) throws SQLException;

}
