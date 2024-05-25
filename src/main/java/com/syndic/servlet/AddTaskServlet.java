package com.syndic.servlet;

import com.syndic.beans.Task;
import com.syndic.connection.Syndic_con;
import com.syndic.dao.TaskDAOImpl;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

public class AddTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Connection connection;

    public void init() {
        connection = Syndic_con.getConnection();
        if (connection != null) {
            System.out.println("Connexion à la base de données établie avec succès.");
        } else {
            System.out.println("Échec de la connexion à la base de données.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (connection == null) {
            return;
        }

        List<Task> tasks;
        TaskDAOImpl taskDAO = new TaskDAOImpl(connection);
        tasks = taskDAO.getAllTasks();
        req.setAttribute("tasks", tasks);

        RequestDispatcher dispatcher = req.getRequestDispatcher("addtask.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            resp.sendRedirect(req.getContextPath() + "/addtask");
            return;
        }

        TaskDAOImpl taskDAO = new TaskDAOImpl(connection);
        HttpSession session = req.getSession();
        boolean success = false;

        switch (action) {
            case "add":
                success = addTask(req, taskDAO);
                session.setAttribute("message", success ? "Une tâche a été ajoutée avec succès !" : "Une erreur s'est produite lors de l'ajout de la tâche.");
                break;
            case "update":
                success = updateTask(req, taskDAO);
                session.setAttribute("message", success ? "La tâche a été mise à jour avec succès !" : "Une erreur s'est produite lors de la mise à jour de la tâche.");
                break;
            case "delete":
                success = deleteTask(req, taskDAO);
                session.setAttribute("message", success ? "La tâche a été supprimée avec succès !" : "Une erreur s'est produite lors de la suppression de la tâche.");
                break;
            default:
                session.setAttribute("message", "Action non reconnue.");
                break;
        }

        resp.sendRedirect(req.getContextPath() + "/addtask");
    }

    private boolean addTask(HttpServletRequest req, TaskDAOImpl taskDAO) {
        String task_name = req.getParameter("task_name");
        String task_description = req.getParameter("task_description");
        String task_due_date = req.getParameter("task_due_date");
        String task_status = req.getParameter("task_status");
        int task_s_id = Integer.parseInt(req.getParameter("task_s_id"));
        String task_created = req.getParameter("task_created");
        System.out.println("task_created: " + task_created);

        Task task = new Task();
        task.setTaskName(task_name);
        task.setTaskDescription(task_description);
        task.setTaskDueDate(task_due_date);
        task.setTaskStatus(task_status);
        task.setTaskSId(task_s_id);
        task.setTaskCreated(task_created);

        return taskDAO.insertTask(task);
    }

    private boolean updateTask(HttpServletRequest req, TaskDAOImpl taskDAO) {
        int task_id = Integer.parseInt(req.getParameter("task_id"));
        String task_name = req.getParameter("task_name");
        String task_description = req.getParameter("task_description");
        String task_due_date = req.getParameter("task_due_date");
        String task_status = req.getParameter("task_status");
        int task_s_id = Integer.parseInt(req.getParameter("task_s_id"));
        String task_created = req.getParameter("task_created");

        Task task = new Task();
        task.setTaskSId(task_id);
        task.setTaskName(task_name);
        task.setTaskDescription(task_description);
        task.setTaskDueDate(task_due_date);
        task.setTaskStatus(task_status);
        task.setTaskSId(task_s_id);
        task.setTaskCreated(task_created );

        return taskDAO.updateTask(task);
    }

    private boolean deleteTask(HttpServletRequest req, TaskDAOImpl taskDAO) {
        int task_id = Integer.parseInt(req.getParameter("task_id"));
        return taskDAO.deleteTask(task_id);
    }
}
