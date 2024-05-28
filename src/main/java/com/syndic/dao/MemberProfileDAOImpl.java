package com.syndic.dao;

import com.syndic.beans.Member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MemberProfileDAOImpl implements MemberProfileDAO {
    private final Connection connection;
    private static final String COUNT_MEMBERS = "SELECT COUNT(*) FROM members";

    public MemberProfileDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void addMember(Member member) throws SQLException {

        String query = "INSERT INTO members (m_fulladdress, m_iduser, member_s_id ) VALUES (?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, member.getFulladdress());
            preparedStatement.setInt(2, member.getUserId());
            preparedStatement.setInt(3, member.getMemberSId());
            preparedStatement.executeUpdate();
        }
    }



    @Override
    public Member getMemberByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM members WHERE m_iduser = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    int id = resultSet.getInt("m_id");
                    String firstName = resultSet.getString("m_firstname");
                    String lastName = resultSet.getString("m_lastname");
                    String fulladdress = resultSet.getString("m_fulladdress");
                    String codepostal = resultSet.getString("m_codepostal");
                    String phoneNumber = resultSet.getString("m_phonenumber");
                    String mail = resultSet.getString("m_mail");
                    int memberSId = resultSet.getInt("member_s_id");
                    int propertyCode = resultSet.getInt("property_code");
                    String propertyAddress = resultSet.getString("property_address");
                    String propertyType = resultSet.getString("property_type");
                    int propertySize = resultSet.getInt("property_size");
                    int coOwnershipFee = resultSet.getInt("coOwnershipFee");

                    return new Member(id, firstName, lastName, fulladdress, codepostal, phoneNumber, mail, userId, memberSId, propertyCode, propertyAddress, propertyType, propertySize, coOwnershipFee);
                }
            }
        }
        return null;
    }

    @Override
    public void updateMember(Member member) throws SQLException {
        String query = "UPDATE members SET m_firstname = ?, m_lastname = ?, m_codepostal = ?, m_phonenumber = ?, m_fulladdress = ?, m_mail = ?, property_code = ?, property_address = ?, property_type = ?, property_size = ?, coOwnershipFee = ? WHERE m_iduser = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, member.getFirstName());
            preparedStatement.setString(2, member.getLastName());
            preparedStatement.setString(3, member.getCodepostal());
            preparedStatement.setString(4, member.getPhoneNumber());
            preparedStatement.setString(5, member.getFulladdress());
            preparedStatement.setString(6, member.getMail());
            preparedStatement.setInt(7, member.getPropertyCode());
            preparedStatement.setString(8, member.getPropertyAddress());
            preparedStatement.setString(9, member.getPropertyType());
            preparedStatement.setInt(10, member.getPropertySize());
            preparedStatement.setInt(11, member.getCoOwnershipFee());
            preparedStatement.setInt(12, member.getUserId());
            preparedStatement.executeUpdate();
        }
    }
    @Override
    public List<Member> getMemberbySid(int member_s_id)  {
        List<Member> members = new ArrayList<>();
        String query = "SELECT * FROM members where member_s_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, member_s_id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
               Member member = new Member();
                member.setId(resultSet.getInt("m_id"));
                member.setFirstName(resultSet.getString("m_firstname"));
                member.setLastName(resultSet.getString("m_lastname"));
                member.setLastName(resultSet.getString("m_codepostal"));
                member.setCodepostal(resultSet.getString("m_codepostal"));
                member.setPhoneNumber(resultSet.getString("m_phonenumber"));
                member.setFulladdress(resultSet.getString("m_fulladdress"));
                member.setMail(resultSet.getString("m_mail"));
                members.add(member);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println(members);
        return members;

    }

    @Override
    public List<Member> getMember()  {
        List<Member> members = new ArrayList<>();
        String query = "SELECT * FROM members";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Member member = new Member();
                member.setId(resultSet.getInt("m_id"));
                member.setFirstName(resultSet.getString("m_firstname"));
                member.setLastName(resultSet.getString("m_lastname"));
                member.setCodepostal(resultSet.getString("m_codepostal"));
                member.setPhoneNumber(resultSet.getString("m_phonenumber"));
                member.setFulladdress(resultSet.getString("m_fulladdress"));
                member.setMail(resultSet.getString("m_mail"));
                member.setMemberSId(resultSet.getInt("member_s_id"));
                members.add(member);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println(members);
        return members;
    }

    public int getMemberCount() throws SQLException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(COUNT_MEMBERS);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
            return 0;
        }
    }


    @Override
    public List<Member> getMembersBySyndic(int syndicId) {
        List<Member> members = new ArrayList<>();
        String query = "SELECT * FROM members WHERE member_s_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, syndicId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Member member = new Member();
                    member.setId(rs.getInt("m_id"));
                    member.setFirstName(rs.getString("m_firstname"));
                    member.setLastName(rs.getString("m_lastname"));
                    member.setCodepostal(rs.getString("m_codepostal"));
                    member.setPhoneNumber(rs.getString("m_phonenumber"));
                    member.setFulladdress(rs.getString("m_fulladdress"));
                    member.setMail(rs.getString("m_mail"));
                    member.setUserId(rs.getInt("m_iduser"));
                    member.setPropertyCode(rs.getInt("property_code"));
                    member.setPropertyType(rs.getString("property_type"));
                    member.setPropertySize(rs.getInt("property_size"));
                    member.setCoOwnershipFee(rs.getInt("coOwnershipFee"));
                    members.add(member);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return members;
    }

}
