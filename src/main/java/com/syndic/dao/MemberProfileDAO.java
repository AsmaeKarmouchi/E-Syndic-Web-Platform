package com.syndic.dao;

import com.syndic.beans.User;
import java.sql.SQLException;
import java.util.List;

import com.syndic.beans.Member;

public interface MemberProfileDAO {

    void addMember(Member member) throws SQLException ;

    Member getMemberByUserId(int userId) throws SQLException;

    void updateMember(Member member) throws SQLException;

    List<Member> getMember();
    int getMemberCount() throws SQLException;
}

