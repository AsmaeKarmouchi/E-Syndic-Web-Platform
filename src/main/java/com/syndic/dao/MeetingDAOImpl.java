package com.syndic.dao;



import com.syndic.beans.Meeting;
import com.syndic.beans.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MeetingDAOImpl implements MeetingDAO {

    private final Connection connection;


    public MeetingDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override

    public void addMeeting(Meeting meeting) throws SQLException {
        String query = "INSERT INTO meetings (meeting_date, meeting_time, meeting_topic, meeting_location, " +
                "meeting_type, meeting_residence, meeting_conclusion, meeting_s_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setDate(1, meeting.getMeetingDate());
            preparedStatement.setString(2, meeting.getMeetingTime());
            preparedStatement.setString(3, meeting.getMeetingTopic());
            preparedStatement.setString(4, meeting.getMeetingLocation());
            preparedStatement.setString(5, meeting.getMeetingType());
            preparedStatement.setString(6, meeting.getMeetingResidence());
            preparedStatement.setString(7, meeting.getMeetingConclusion());
            preparedStatement.setInt(8, meeting.getSyndicId());
            preparedStatement.executeUpdate();
        }
    }

    @Override

    public List<Meeting> getMeetingBySyndicId(int syndicId) throws SQLException {
        List<Meeting> meetings = new ArrayList<>();
        String query = "SELECT * FROM meetings WHERE meeting_s_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, syndicId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    int meetingId = resultSet.getInt("meeting_id");
                    Date meetingDate = resultSet.getDate("meeting_date");
                    String meetingTime = resultSet.getString("meeting_time");
                    String meetingTopic = resultSet.getString("meeting_topic");
                    String meetingLocation = resultSet.getString("meeting_location");
                    String meetingType = resultSet.getString("meeting_type");
                    String meetingResidence = resultSet.getString("meeting_residence");
                    String meetingConclusion = resultSet.getString("meeting_conclusion");
                    Meeting meeting = new Meeting(meetingId, meetingDate, meetingTime, meetingTopic, meetingLocation,
                            meetingType, meetingResidence, meetingConclusion, syndicId);
                    meetings.add(meeting); // Ajouter la réunion à la liste
                }
            }
        }
        return meetings; // Retourner la liste de réunions
    }

    @Override
    public void updateMeetingConclusion(int meetingId, String newConclusion) throws SQLException {
        String query = "UPDATE meetings SET meeting_conclusion = ? WHERE meeting_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, newConclusion);
            preparedStatement.setInt(2, meetingId);
            preparedStatement.executeUpdate();
        }
        }

}
