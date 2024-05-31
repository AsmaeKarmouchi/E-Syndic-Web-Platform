package com.syndic.dao;

import com.syndic.beans.Member;
import com.syndic.beans.Task;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TaskDAOImpl implements TaskDAO {
    private final Connection connection;

    private static final String COUNT_TASKS = "SELECT COUNT(*) FROM tasks";

    private static final String SUM_TASKS_AMOUNT = "SELECT SUM(task_amount) FROM tasks";

    public TaskDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public List<Task> getAllTasks() {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Task task = new Task();
                task.setTaskId(rs.getInt("task_id"));
                task.setTaskName(rs.getString("task_name"));
                task.setTaskDescription(rs.getString("task_description"));
                task.setTaskDueDate(rs.getString("task_due_date"));
                task.setTaskStatus(rs.getString("task_status"));
                task.setTaskSId(rs.getInt("task_s_id"));
                task.setTaskAmount(rs.getDouble("task_amount"));

                tasks.add(task);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tasks;
    }

    public float getTaskSum() throws SQLException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(SUM_TASKS_AMOUNT);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getBigDecimal(1).floatValue();
            }
            return 0;
        }
    }

    @Override
    public boolean insertTask(Task task) {
        String query = "INSERT INTO tasks (task_name, task_description, task_due_date, task_status, task_s_id, task_amount, task_supplier_id) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, task.getTaskName());
            statement.setString(2, task.getTaskDescription());
            statement.setString(3, task.getTaskDueDate());
            statement.setString(4, task.getTaskStatus());
            statement.setInt(5, task.getTaskSId());
            statement.setDouble(6, task.getTaskAmount());
            statement.setInt(7, task.getTaskSupplierId());
            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateTask(Task task) {
        String query = "UPDATE tasks SET task_name = ?, task_description = ?, task_due_date = ?, task_status = ?, task_s_id = ?, task_amount = ? , task_supplier_id = ? WHERE task_id = ?";


        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, task.getTaskName());
            statement.setString(2, task.getTaskDescription());
            statement.setString(3, task.getTaskDueDate());
            statement.setString(4, task.getTaskStatus());
            statement.setInt(5, task.getTaskSId());
            statement.setDouble(6, task.getTaskAmount());
            statement.setInt(7, task.getTaskId());
            statement.setInt(8,task.getTaskSupplierId());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteTask(int task_id) {
        String query = "DELETE FROM tasks WHERE task_id = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, task_id);

            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getTaskCount() throws SQLException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(COUNT_TASKS);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
            return 0;
        }
    }
    public int getTaskCountsyndic(int syndicid) throws SQLException {
        String COUNT_TASKSSyndic = "SELECT COUNT(*) FROM tasks WHERE task_s_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(COUNT_TASKSSyndic)) {
            preparedStatement.setInt(1, syndicid);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }
        }
        return 0;
    }



    @Override
    public List<Task> getTasksBySyndic(int syndicId) {
        List<Task> tasks = new ArrayList<>();
        String query = "SELECT * FROM tasks WHERE task_s_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, syndicId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Task task = new Task();
                    task.setTaskId(rs.getInt("task_id"));
                    task.setTaskName(rs.getString("task_name"));
                    task.setTaskDescription(rs.getString("task_description"));
                    task.setTaskDueDate(rs.getString("task_due_date"));
                    task.setTaskStatus(rs.getString("task_status"));
                    task.setTaskSId(rs.getInt("task_s_id"));
                    task.setTaskAmount(rs.getDouble("task_amount"));
                    task.setTaskSupplierId(rs.getInt("task_supplier_id"));

                    tasks.add(task);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }

    @Override
    public List<Member> getMembersBySyndic(int syndicId) {
        List<Member> members = new ArrayList<>();
        String query = "SELECT * FROM members WHERE member_syndic_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, syndicId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Member member = new Member();
                    member.setId(rs.getInt("member_id"));
                    member.setFirstName(rs.getString("member_firstname"));
                    member.setLastName(rs.getString("member_lastname"));
                    // Compléter les autres champs si nécessaire
                    members.add(member);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return members;
    }
}
