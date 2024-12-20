package com.syndic.dao;

import com.syndic.beans.Syndic;

import java.sql.SQLException;
import java.util.List;

public interface SyndicProfileDAO {

    void addSyndic(Syndic syndic) throws SQLException ;
    void updateSyndic(Syndic syndic) throws SQLException;

    void updateSyndic2(Syndic syndic) throws SQLException;
    void updateSyndic3(Syndic syndic) throws SQLException;

    Syndic getSyndicByUserId(int userId) throws SQLException;
    int getSyndicIdByUserId(int userId) throws SQLException;

    Syndic getSyndicByresidence(String residence) throws SQLException;

    Syndic getSyndicById(int id) throws SQLException;

    List<Syndic> getSyndic() throws SQLException;

    int getSyndicIdByResidence(String residence)throws SQLException ;
     boolean deleteSyndic(int syndicId) ;

}
