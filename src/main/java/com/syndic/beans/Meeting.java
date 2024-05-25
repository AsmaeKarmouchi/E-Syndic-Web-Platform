package com.syndic.beans;


import java.sql.Date;
import java.sql.Time;

public class Meeting {
    private int meetingId;
    private Date meetingDate;
    private String meetingTime;
    private String meetingTopic;
    private String meetingLocation;
    private String meetingType;
    private String meetingResidence;
    private String meetingConclusion;
    private int syndicId;

    // Constructeur
    public Meeting(int meetingId, Date meetingDate, String meetingTime, String meetingTopic, String meetingLocation,
                   String meetingType, String meetingResidence, String meetingConclusion, int syndicId) {
        this.meetingId = meetingId;
        this.meetingDate = meetingDate;
        this.meetingTime = meetingTime;
        this.meetingTopic = meetingTopic;
        this.meetingLocation = meetingLocation;
        this.meetingType = meetingType;
        this.meetingResidence = meetingResidence;
        this.meetingConclusion = meetingConclusion;
        this.syndicId = syndicId;
    }

    public Meeting( Date meetingDate, String meetingTime, String meetingTopic, String meetingLocation,
                    String meetingType, String meetingResidence, String meetingConclusion, int syndicId) {

        this.meetingDate = meetingDate;
        this.meetingTime = meetingTime;
        this.meetingTopic = meetingTopic;
        this.meetingLocation = meetingLocation;
        this.meetingType = meetingType;
        this.meetingResidence = meetingResidence;
        this.meetingConclusion = meetingConclusion;
        this.syndicId = syndicId;
    }

    // Getters and Setters
    public int getMeetingId() {
        return meetingId;
    }

    public void setMeetingId(int meetingId) {
        this.meetingId = meetingId;
    }

    public Date getMeetingDate() {
        return meetingDate;
    }

    public void setMeetingDate(Date meetingDate) {
        this.meetingDate = meetingDate;
    }

    public String getMeetingTime() {
        return meetingTime;
    }

    public void setMeetingTime(String meetingTime) {
        this.meetingTime = meetingTime;
    }

    public String getMeetingTopic() {
        return meetingTopic;
    }

    public void setMeetingTopic(String meetingTopic) {
        this.meetingTopic = meetingTopic;
    }

    public String getMeetingLocation() {
        return meetingLocation;
    }

    public void setMeetingLocation(String meetingLocation) {
        this.meetingLocation = meetingLocation;
    }

    public String getMeetingType() {
        return meetingType;
    }

    public void setMeetingType(String meetingType) {
        this.meetingType = meetingType;
    }

    public String getMeetingResidence() {
        return meetingResidence;
    }

    public void setMeetingResidence(String meetingResidence) {
        this.meetingResidence = meetingResidence;
    }

    public String getMeetingConclusion() {
        return meetingConclusion;
    }

    public void setMeetingConclusion(String meetingConclusion) {
        this.meetingConclusion = meetingConclusion;
    }

    public int getSyndicId() {
        return syndicId;
    }

    public void setSyndicId(int syndicId) {
        this.syndicId = syndicId;
    }

    // Méthode toString() pour l'affichage
    @Override
    public String toString() {
        return "Meeting{" +
                "meetingId=" + meetingId +
                ", meetingDate=" + meetingDate +
                ", meetingTime=" + meetingTime +
                ", meetingTopic='" + meetingTopic + '\'' +
                ", meetingLocation='" + meetingLocation + '\'' +
                ", meetingType='" + meetingType + '\'' +
                ", meetingResidence='" + meetingResidence + '\'' +
                ", meetingConclusion='" + meetingConclusion + '\'' +
                ", syndicId=" + syndicId +
                '}';
    }
}
