package com.syndic.dao;

import static org.junit.jupiter.api.Assertions.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.List;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import com.syndic.beans.Task;


public class TaskDAOImplTest {

    private Connection connection;
    private TaskDAOImpl taskDAO;

    @BeforeEach
    void setUp() throws SQLException {

        connection = DriverManager.getConnection("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1");
        taskDAO = new TaskDAOImpl(connection);

        // Créer la table tasks
        try (Statement statement = connection.createStatement()) {
            statement.execute("CREATE TABLE tasks (" +
                    "task_id INT AUTO_INCREMENT PRIMARY KEY," +
                    "task_name VARCHAR(255)," +
                    "task_description VARCHAR(255)," +
                    "task_due_date VARCHAR(255)," +
                    "task_status VARCHAR(255)," +
                    "task_s_id INT," +
                    "task_created VARCHAR(255)" +
                    ")");

            statement.execute("INSERT INTO tasks (task_name, task_description, task_due_date, task_status, task_s_id, task_created) " +
                    "VALUES ('Task1', 'Description1', '2024-05-24', 'Pending', 1, '2024-05-20')");
            statement.execute("INSERT INTO tasks (task_name, task_description, task_due_date, task_status, task_s_id, task_created) " +
                    "VALUES ('Task2', 'Description2', '2024-06-24', 'Completed', 2, '2024-05-21')");
        }
    }

    @AfterEach
    void tearDown() throws SQLException {

        try (Statement statement = connection.createStatement()) {
            statement.execute("DROP TABLE tasks");
        }


        connection.close();
    }

    @Test
    void testGetAllTasks() throws SQLException {

        List<Task> tasks = taskDAO.getAllTasks();


        assertNotNull(tasks);
        assertEquals(2, tasks.size());

        Task task1 = tasks.get(0);
        assertEquals("Task1", task1.getTaskName());
        assertEquals("Description1", task1.getTaskDescription());
        assertEquals("2024-05-24", task1.getTaskDueDate());
        assertEquals("Pending", task1.getTaskStatus());
        assertEquals(1, task1.getTaskSId());
        assertEquals("2024-05-20", task1.getTaskCreated());

        Task task2 = tasks.get(1);
        assertEquals("Task2", task2.getTaskName());
        assertEquals("Description2", task2.getTaskDescription());
        assertEquals("2024-06-24", task2.getTaskDueDate());
        assertEquals("Completed", task2.getTaskStatus());
        assertEquals(2, task2.getTaskSId());
        assertEquals("2024-05-21", task2.getTaskCreated());
    }

    @Test
    void testInsertTask() throws SQLException {

        Task newTask = new Task();
        newTask.setTaskName("Task3");
        newTask.setTaskDescription("Description3");
        newTask.setTaskDueDate("2024-07-24");
        newTask.setTaskStatus("In Progress");
        newTask.setTaskSId(3);
        newTask.setTaskCreated("2024-05-22");

        boolean result = taskDAO.insertTask(newTask);
        assertTrue(result);


        List<Task> tasks = taskDAO.getAllTasks();
        assertEquals(3, tasks.size());
    }



    @Test
    void testDeleteTask() throws SQLException {

        List<Task> tasks = taskDAO.getAllTasks();
        Task taskToDelete = tasks.get(0);

        boolean result = taskDAO.deleteTask(taskToDelete.getTaskId());
        assertTrue(result);


        tasks = taskDAO.getAllTasks();
        assertEquals(1, tasks.size());
    }

    @Test
    void testGetTaskCount() throws SQLException {

        int taskCount = taskDAO.getTaskCount();
        assertEquals(2, taskCount);
    }
}
