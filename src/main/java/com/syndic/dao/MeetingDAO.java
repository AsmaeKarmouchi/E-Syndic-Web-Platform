package com.syndic.dao;

import com.syndic.beans.Meeting;


import java.sql.SQLException;
import java.util.List;

public interface MeetingDAO {

    void addMeeting(Meeting meeting) throws SQLException;

    List<Meeting> getMeetingBySyndicId(int SyndicId) throws SQLException;

    void updateMeetingConclusion(int meetingId, String newConclusion) throws SQLException;
}
