package com.syndic.servlet;
import com.syndic.beans.*;
import com.syndic.connection.Syndic_con;
import com.syndic.dao.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
public class SyndicAddTaskServlet extends HttpServlet {
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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (connection == null) {
            return;
        }

        HttpSession session = req.getSession();
        Integer syndicId = (Integer) session.getAttribute("syndic_id");
        System.out.println("syndicid "+syndicId);

        if (syndicId == null) {
            // Rediriger vers la page de connexion si le syndic_id n'est pas défini
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        if (connection == null) {
            return;
        }
        TaskDAOImpl taskDAO = new TaskDAOImpl(connection);
        List<Task> tasks = taskDAO.getTasksBySyndic(syndicId);
        req.setAttribute("tasks",tasks);
        System.out.println(tasks);

        List<Supplier> suppliers;
        SupplierDAOImpl supplierDAO = new SupplierDAOImpl(connection);
        suppliers = supplierDAO.getAllSuppliers(syndicId);
        req.setAttribute("suppliers", suppliers);

        RequestDispatcher dispatcher = req.getRequestDispatcher("Syndicaddtask.jsp");
        dispatcher.forward(req, resp);
    }


    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        switch (action) {
            case "add":
                addTask(req, resp);
                break;
            case "edit":
                updateTask(req, resp);
                break;
            case "delete":
                deleteTask(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/Syndicaddtask");
                break;
        }
    }

    private void addTask(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Récupérer les données du formulaire pour ajouter une nouvelle tâche
        String taskName = req.getParameter("taskName");
        String taskDescription = req.getParameter("taskDescription");
        double taskAmount = Double.parseDouble(req.getParameter("taskAmount"));
        String taskDueDate = req.getParameter("taskDueDate");
        String taskStatus = req.getParameter("taskStatus");
        String taskSupplier = req.getParameter("supplier");
        System.out.println("--"+taskName+"--"+taskAmount);


        HttpSession session = req.getSession();
        Integer syndicId = (Integer) session.getAttribute("syndic_id");


        // Créer une instance de la tâche avec les données récupérées
        Task task = new Task();
        task.setTaskName(taskName);
        task.setTaskDescription(taskDescription);
        task.setTaskDueDate(taskDueDate);
        task.setTaskStatus(taskStatus);
        task.setTaskAmount(taskAmount);
        task.setTaskSId(syndicId);
        // Récupérer l'ID du fournisseur à partir de la base de données
        SupplierDAOImpl supplierDAO = new SupplierDAOImpl(connection);
        try {
            int supplierId = supplierDAO.getSupplierIdByName(taskSupplier);
            task.setTaskSupplierId(supplierId);
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur lors de la récupération de l'ID du fournisseur.");
            resp.sendRedirect(req.getContextPath() + "/Syndicaddtask");
            return;
        }
//---------------------------

        // Récupérer le solde actuel du compte du syndic depuis la base de données
        SyndicProfileDAOImpl syndicProfileDAO = new SyndicProfileDAOImpl(connection);
        Syndic syndic;
        try {
            syndic = syndicProfileDAO.getSyndicById(syndicId);
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur lors de la récupération du profil du syndic.");
            resp.sendRedirect(req.getContextPath() + "/Syndicaddtask");
            return;
        }
        double newAccountBalance = syndic.getAccount() - taskAmount;
        syndic.setAccount((int) newAccountBalance);
        try {
            syndicProfileDAO.updateSyndic3(syndic);
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur lors de la mise à jour du solde du syndic.");
            resp.sendRedirect(req.getContextPath() + "/Syndicaddtask");
            return;
        }
        //---------------------------

        // Utiliser le DAO pour insérer la nouvelle tâche dans la base de données
        TaskDAOImpl taskDAO = new TaskDAOImpl(connection);
        boolean success = taskDAO.insertTask(task);
        if (success) {
            PaymentFlow paymentFlow = new PaymentFlow();
            paymentFlow.setSyndicId(syndicId);
            paymentFlow.setFlowType(1);
            paymentFlow.setAmount((taskAmount * -1 ));
            paymentFlow.setDescription("Task added with name: " + taskName);
            paymentFlow.setTransactionDate(java.sql.Date.valueOf(taskDueDate));
            PaymentFlowDAOImpl paymentFlowDAO = new PaymentFlowDAOImpl(connection);
            try {
                paymentFlowDAO.addPaymentFlow(paymentFlow);

                List<PaymentFlow> paymentsflow;
                paymentsflow = paymentFlowDAO.getPaymentFlowsBySyndicId(syndicId);
                session.setAttribute("paymentsflow", paymentsflow);

            } catch (SQLException e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", "Erreur lors de l'ajout du flux de paiement.");
                resp.sendRedirect(req.getContextPath() + "/Syndicaddtask");
                return;
            }
            session = req.getSession();
            session.setAttribute("successMessage", "task a été ajouté avec succès !");
            System.out.println("succès");
        } else {
            session = req.getSession();
            session.setAttribute("errorMessage", "Une erreur s'est produite lors de l'ajout du task.");
            System.out.println("erreur");
        }
        resp.sendRedirect(req.getContextPath() + "/Syndicaddtask");
    }

    private void updateTask(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Implémentez la logique pour mettre à jour une tâche existante
    }

    private void deleteTask(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Implémentez la logique pour supprimer une tâche existante
    }
}
