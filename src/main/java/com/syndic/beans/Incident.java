package com.syndic.beans;

import java.util.Date;

public class Incident {
    private int incidentId;
    private Date incidentDate;
    private String incidentType;
    private String incidentDescription;
    private String incidentStatus;
    private Date incidentResolutionDate;
    private int incidentSId;

    // Constructor
    public Incident() {
    }

    public Incident(int incidentId, Date incidentDate, String incidentType, String incidentDescription, String incidentStatus, Date incidentResolutionDate, int incidentSId) {
        this.incidentId = incidentId;
        this.incidentDate = incidentDate;
        this.incidentType = incidentType;
        this.incidentDescription = incidentDescription;
        this.incidentStatus = incidentStatus;
        this.incidentResolutionDate = incidentResolutionDate;
        this.incidentSId = incidentSId;
    }

    public Incident(int incidentId, String incidentType, String incidentDescription, String incidentStatus, Date incidentResolutionDate, int incidentSId) {
        this.incidentId = incidentId;
        this.incidentType = incidentType;
        this.incidentDescription = incidentDescription;
        this.incidentStatus = incidentStatus;
        this.incidentResolutionDate = incidentResolutionDate;
        this.incidentSId = incidentSId;
    }

    public Incident(String incidentType, String incidentDescription, String incidentStatus, int incidentSId) {

        this.incidentType = incidentType;
        this.incidentDescription = incidentDescription;
        this.incidentStatus = incidentStatus;
        this.incidentSId = incidentSId;
    }

    // Getters and Setters
    public int getIncidentId() {
        return incidentId;
    }

    public void setIncidentId(int incidentId) {
        this.incidentId = incidentId;
    }

    public Date getIncidentDate() {
        return incidentDate;
    }

    public void setIncidentDate(Date incidentDate) {
        this.incidentDate = incidentDate;
    }

    public String getIncidentType() {
        return incidentType;
    }

    public void setIncidentType(String incidentType) {
        this.incidentType = incidentType;
    }

    public String getIncidentDescription() {
        return incidentDescription;
    }

    public void setIncidentDescription(String incidentDescription) {
        this.incidentDescription = incidentDescription;
    }

    public String getIncidentStatus() {
        return incidentStatus;
    }

    public void setIncidentStatus(String incidentStatus) {
        this.incidentStatus = incidentStatus;
    }

    public Date getIncidentResolutionDate() {
        return incidentResolutionDate;
    }

    public void setIncidentResolutionDate(Date incidentResolutionDate) {
        this.incidentResolutionDate = incidentResolutionDate;
    }

    public int getIncidentSId() {
        return incidentSId;
    }

    public void setIncidentSId(int incidentSId) {
        this.incidentSId = incidentSId;
    }

    // toString method
    @Override
    public String toString() {
        return "Incident{" +
                "incidentId=" + incidentId +
                ", incidentDate=" + incidentDate +
                ", incidentType='" + incidentType + '\'' +
                ", incidentDescription='" + incidentDescription + '\'' +
                ", incidentStatus='" + incidentStatus + '\'' +
                ", incidentResolutionDate=" + incidentResolutionDate +
                ", incidentSId=" + incidentSId +
                '}';
    }
}
