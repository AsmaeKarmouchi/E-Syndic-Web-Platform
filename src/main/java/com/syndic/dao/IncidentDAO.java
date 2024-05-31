package com.syndic.dao;

import com.syndic.beans.Incident;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

public interface IncidentDAO {

    void addIncident(Incident incident) throws SQLException;

    List<Incident> getIncidentBySyndicId(int syndicId) throws SQLException;

    int getIncidentCountsyndic(int syndicid) throws SQLException;
    void updateIncident(int incidentId, String incidentStatus, Date incidentResolutionDate) throws SQLException;
    int getIncidentCount() throws SQLException;
}
