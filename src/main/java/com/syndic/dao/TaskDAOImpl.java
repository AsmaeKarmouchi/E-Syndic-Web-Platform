package com.syndic.dao;

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


    public TaskDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public List<Task> getAllTasks() {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM Tasks";

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
                task.setTaskCreated(rs.getString("task_created"));

                tasks.add(task);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tasks;
    }

    @Override
    public boolean insertTask(Task task) {
        String query = "INSERT INTO Tasks (task_name, task_description, task_due_date, task_status, task_s_id, task_created) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, task.getTaskName());
            statement.setString(2, task.getTaskDescription());
            statement.setString(3, task.getTaskDueDate());
            statement.setString(4, task.getTaskStatus());
            statement.setInt(5, task.getTaskSId());
            statement.setString(6,task.getTaskCreated());

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateTask(Task task) {
        String query = "UPDATE Tasks SET task_name = ?, task_description = ?, task_due_date = ?, task_status = ?, task_s_id = ?, task_created = ? WHERE task_id = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, task.getTaskName());
            statement.setString(2, task.getTaskDescription());
            statement.setString(3, task.getTaskDueDate());
            statement.setString(4, task.getTaskStatus());
            statement.setInt(5, task.getTaskSId());
            statement.setString(6,task.getTaskCreated());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteTask(int task_id) {
        String query = "DELETE FROM Tasks WHERE task_id = ?";

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
}
