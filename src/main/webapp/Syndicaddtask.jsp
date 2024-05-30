<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.syndic.beans.Task" %>
<%@ page import="com.syndic.beans.Syndic" %>
<%@ page import="com.syndic.beans.Supplier" %>
<%@ page import="com.google.gson.Gson" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DASHBOARD</title>
    <link rel="shortcut icon" href="/Assets/images/logo.png" type="image/x-icon">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="css/style.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- Inclure Moment.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

    <!-- Inclure un adaptateur de date pour Chart.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/adapters/moment.min.js"></script>

</head>

<body>
<div class="container">
    <jsp:include page="templates/syndic_sidenav.jsp" />

    <main>

        <div class="flex justify-between items-center p-6 bg-blue-300 shadow-md border rounded-md">
            <h1 class="text-3xl font-bold text-gray-800">Add Task</h1>
            <div class="text-lg text-gray-600"><%=java.time.LocalDate.now()%></div>
        </div>

        <div>
            <div class="recent-updates"></div>
        </div>
        <br><br><br><br><br><br>
        <div class="max-w-screen-xl mx-auto px-4 md:px-6">
            <div class="items-start justify-between md:flex">
                <div class="mt-3 md:mt-0 flex gap-4">
                    <button id="addTaskBtn"
                            class="inline-block px-4 py-2 text-white duration-150 font-medium bg-indigo-600 rounded-lg hover:bg-indigo-500 active:bg-indigo-700 md:text-sm btn">
                        Add Task
                    </button>
                    <input type="number" id="filterMemberId" placeholder="Filter by Member ID" class="px-4 py-2 border rounded-md">
                    <button id="filterTasksBtn" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-blue-600 rounded-lg hover:bg-blue-500 active:bg-blue-700 md:text-sm btn">
                        Filter tasks
                    </button>
                    <button id="printInvoiceBtn" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-green-600 rounded-lg hover:bg-green-500 active:bg-green-700 md:text-sm btn">
                        Print Invoice
                    </button>
                    <form action="addsupplier" method="get">
                        <button id="addSupplierBtn" type="submit" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-indigo-600 rounded-lg hover:bg-indigo-500 active:bg-indigo-700 md:text-sm btn">Add Supplier</button>
                    </form>
                </div>
            </div>


            <div class="mt-12 shadow-lg border rounded-lg overflow-x-auto">
                <table class="min-w-full bg-white rounded-lg shadow-md" id="taskTable">
                    <thead class="bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-semibold">
                    <tr>
                        <th class="py-2 px-4 uppercase tracking-wider text-xs">Task Name</th>
                        <th class="py-2 px-4 uppercase tracking-wider text-xs">Task Description</th>
                        <th class="py-2 px-4 uppercase tracking-wider text-xs">Task Amount</th>
                        <th class="py-2 px-4 uppercase tracking-wider text-xs">Due Date</th>
                        <th class="py-2 px-4 uppercase tracking-wider text-xs">Status</th>
                        <th class="py-2 px-4 uppercase tracking-wider text-xs">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="text-gray-800 divide-y divide-gray-200" id="taskTableBody">
                    <% List<Task> tasks = (List<Task>) request.getAttribute("tasks"); %>
                    <% if (tasks != null && !tasks.isEmpty()) { %>
                    <% for (Task task : tasks) { %>
                    <tr class="bg-white hover:bg-gray-100 transition duration-150">
                        <td class="px-4 py-2 whitespace-nowrap text-sm"><%= task.getTaskName() %></td>
                        <td class="px-4 py-2 whitespace-nowrap text-sm"><%= task.getTaskDescription() %></td>
                        <td class="px-4 py-2 whitespace-nowrap text-sm"><%= task.getTaskAmount() %></td>
                        <td class="px-4 py-2 whitespace-nowrap text-sm"><%= task.getTaskDueDate() %></td>
                        <td class="px-4 py-2 whitespace-nowrap text-sm"><%= task.getTaskStatus() %></td>
                        <td class="text-right px-4 whitespace-nowrap">
                            <button class="editTaskBtn py-1 px-2 font-medium text-xs text-indigo-600 hover:text-indigo-500 transition duration-150 hover:bg-gray-50 rounded-lg"
                                    data-name="<%= task.getTaskName() %>"
                                    data-description="<%= task.getTaskDescription() %>"
                                    data-amount="<%= task.getTaskAmount() %>"
                                    data-date="<%= task.getTaskDueDate() %>"
                                    data-status="<%= task.getTaskStatus() %>">
                                Edit
                            </button>
                            <form action="Syndicaddtask" method="post" class="inline">
                                <input type="hidden" name="code" value="<%= task.getTaskName() %>">
                                <input type="hidden" name="action" value="delete">
                                <button type="submit" class="deleteTaskBtn py-1 leading-none px-2 font-medium text-xs text-red-600 hover:text-red-500 transition duration-150 hover:bg-gray-50 rounded-lg">
                                    Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                    <% } else { %>
                    <tr>
                        <td colspan="6" class="px-6 py-4 text-center text-gray-500">No tasks available at the moment.</td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>



            <div id="TaskForm" class="form hidden mt-6 p-6 bg-blue-200 shadow-lg rounded-lg">
                <form id="taskFormElement" class="grid grid-cols-1 gap-6 md:grid-cols-2" action="Syndicaddtask" method="post">
                    <input type="hidden" id="action" name="action" value="add">
                    <input type="hidden" id="edit_task_id" name="edit_task_id" value="">

                    <div class="col-span-1">
                        <label for="taskName" class="block text-sm font-medium text-gray-700">Task Name:</label>
                        <input type="text" id="taskName" name="taskName" required class="mt-1 p-2 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                    </div>
                    <div class="col-span-1">
                        <label for="taskDescription" class="block text-sm font-medium text-gray-700">Task Description:</label>
                        <input type="text" id="taskDescription" name="taskDescription" required class="mt-1 p-2 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                    </div>
                    <div class="col-span-1">
                        <label for="taskAmount" class="block text-sm font-medium text-gray-700">Task Amount:</label>
                        <input type="text" id="taskAmount" name="taskAmount" required class="mt-1 p-2 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                    </div>
                    <div class="col-span-1">
                        <label for="taskDueDate" class="block text-sm font-medium text-gray-700">Due Date:</label>
                        <input type="date" id="taskDueDate" name="taskDueDate" class="mt-1 p-2 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                    </div>
                    <div class="col-span-1">
                        <label for="taskStatus" class="block text-sm font-medium text-gray-700">Status:</label>
                        <input type="text" id="taskStatus" name="taskStatus" required class="mt-1 p-2 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                    </div>
                    <div>
                        <label for="supplier" class="text-sm font-medium text-gray-600">Supplier</label>
                        <select id="supplier" name="supplier" class="mt-1 p-2 w-full border-2 border-gray-300 rounded-md focus:outline-none focus:border-indigo-500" required>
                            <option value="">select a Supplier</option>
                            <%
                                List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");

                                if (suppliers != null) {
                                    for (Supplier supplier : suppliers) {
                            %>
                            <option value="<%= supplier.getSupplier_name() %>"><%= supplier.getSupplier_name() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div class="col-span-2 flex justify-end">
                        <button type="submit" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            Save
                        </button>
                    </div>
                </form>
            </div>

            <!-- Diagrammes -->
            <div class="max-w-screen-xl mx-auto px-4 md:px-6 mt-12">
                <div class="grid grid-cols-2 gap-6">
                    <div class="chart-container">
                        <canvas id="tasksByStatusChart"></canvas>
                    </div>
                    <div class="chart-container">
                        <canvas id="tasksByMonthChart"></canvas>
                    </div>
                </div>

                <div class="chart-container">
                    <canvas id="tasksByAmountChart"></canvas>
                </div>

                <div class="grid grid-cols-2 gap-6">
                    <div class="chart-container ">
                        <canvas ></canvas>
                    </div>
                    <div class="chart-container ">
                        <canvas id="tasksBySupplierChart"></canvas>
                    </div>
                </div>

            </div>




        </div>
    </main>
    <div class="right">
        <div class="top">
            <button id="menu-btn">
                <i class='bx bx-menu'></i>
            </button>
            <div class="theme-toggle">
                <i class='bx bx-sun active'></i>
                <i class='bx bx-moon'></i>
            </div>
            <div class="profile">
                <div class="info">
                    <p>Hey, <b>Ayo</b></p>
                    <small class="text-muted">Admin</small>
                </div>
                <div class="profile-photo">
                    <img src="./Assets/images/profile-1.jpg" alt="Oluwadare Taye Ayo">
                </div>
            </div>
        </div>
        <!---------ANALYSE DES SYNDICS --------->
        <div class="sales-analytics">
            <h2>Analyse des Syndics</h2>

            <!-----NOUVEAUX SYNDICS ENREGISTRÉS----->
            <div class="item online">
                <i class='bx bx-user-plus'></i>
                <div class="right">
                    <div class="info">
                        <h3>NOUVEAUX SYNDICS ENREGISTRÉS</h3>
                        <small class="text-muted">Dernières 24 heures</small>
                    </div>
                    <h5 class="success">+38%</h5>
                    <h3>234</h3>
                </div>
            </div>

            <!-----SYNDICS ACTIFS----->
            <div class="item offline">
                <i class='bx bx-user'></i>
                <div class="right">
                    <div class="info">
                        <h3>SYNDICS ACTIFS</h3>
                        <small class="text-muted">Dernières 24 heures</small>
                    </div>
                    <h5 class="danger">-17%</h5>
                    <h3>1100</h3>
                </div>
            </div>

            <!-----NOUVELLES DEMANDES D'ADHÉSION----->
            <div class="item customers">
                <i class='bx bx-user-check'></i>
                <div class="right">
                    <div class="info">
                        <h3>NOUVELLES DEMANDES D'ADHÉSION</h3>
                        <small class="text-muted">Dernières 24 heures</small>
                    </div>
                    <h5 class="success">+25%</h5>
                    <h3>32</h3>
                </div>
            </div>
            <!----------AJOUTER UN NOUVEAU SYNDIC------->
            <div class="item add-product">
                <div>
                    <i class="bx-add"></i>
                    <a href="#"><h3>Ajouter un Nouveau Syndic</h3></a>
                </div>
            </div>

        </div>
        <!------FIN DE L'ANALYSE DES SYNDICS------->

    </div>
</div>

<script src="javascript/main.js"></script>



<script>
    // Exemple de données dynamiques, remplacez-les par vos données JSP
    const tasks = <%= new Gson().toJson(tasks) %>;

    // Préparer les données pour le diagramme des tâches par statut
    const taskStatuses = ['Pending', 'Completed', 'Scheduled'];
    const taskStatusCounts = taskStatuses.map(status =>
        tasks.filter(task => task.taskStatus === status).length
    );




    // Préparer les données pour le diagramme des tâches par date d'échéance
    const taskDueDates = tasks.map(task => task.taskDueDate).sort();
    const uniqueDates = [...new Set(taskDueDates)];
    const taskDueDateCounts = uniqueDates.map(date =>
        tasks.filter(task => task.taskDueDate === date).length
    );


    // Créer le diagramme des tâches par statut
    const tasksByStatusCtx = document.getElementById('tasksByStatusChart').getContext('2d');
    const tasksByStatusChart = new Chart(tasksByStatusCtx, {
        type: 'bar',
        data: {
            labels: taskStatuses,
            datasets: [{
                label: '# of Tasks',
                data: taskStatusCounts,
                backgroundColor: ['#ff6384', '#36a2eb', '#ffce56']
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: 'Tasks by Status'
                }
            }
        }
    });




    // Récupération des noms de tâches et des montants pour le diagramme par montant
    var taskNamesByAmount = tasks.map(function(task) {
        return task.taskName;
    });
    var taskAmounts = tasks.map(function(task) {
        return task.taskamount;
    });

    // Création du diagramme par montant avec plusieurs couleurs
    var tasksByAmountChartCtx = document.getElementById('tasksByAmountChart').getContext('2d');
    var tasksByAmountChart = new Chart(tasksByAmountChartCtx, {
        type: 'bar',
        data: {
            labels: taskNamesByAmount,
            datasets: [{
                label: 'Montant',
                data: taskAmounts,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.6)',
                    'rgba(54, 162, 235, 0.6)',
                    'rgba(255, 206, 86, 0.6)',
                    'rgba(75, 192, 192, 0.6)',
                    'rgba(153, 102, 255, 0.6)'
                    // Ajoutez autant de couleurs que nécessaire
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)'
                    // Correspondance des couleurs de bordure si nécessaire
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    position: 'left',
                    type: 'linear',
                    display: true
                }
            },
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: 'Tasks by Amount'
                }
            }
        }
    });



    // Récupération des dates de tâches pour le diagramme par mois
    var taskDates = tasks.map(function(task) {
        return task.taskDueDate;
    });

    // Comptage des tâches par mois
    var tasksByMonth = {};
    taskDates.forEach(function(date) {
        var month = date.split('-')[1];
        tasksByMonth[month] = (tasksByMonth[month] || 0) + 1;
    });

    // Création du tableau de données pour le diagramme
    var months = Object.keys(tasksByMonth);
    var taskCounts = Object.values(tasksByMonth);

    // Définir des couleurs pour chaque barre du diagramme
    var barColors = [
        'rgba(255, 99, 132, 0.8)',
        'rgba(54, 162, 235, 0.8)',
        'rgba(255, 206, 86, 0.8)',
        'rgba(75, 192, 192, 0.8)',
        'rgba(153, 102, 255, 0.8)',
        'rgba(255, 159, 64, 0.8)'
    ];

    // Création du tableau de datasets pour le diagramme par mois
    var datasets = [{
        label: 'Nombre de Tâches (Barres)',
        data: taskCounts,
        backgroundColor: barColors,
        borderColor: barColors,
        borderWidth: 1
    }, {
        label: 'Nombre de Tâches (Courbe)',
        data: taskCounts,
        fill: false,
        borderColor: 'rgba(75, 192, 192, 1)',
        borderWidth: 2,
        type: 'line'
    }];

    // Création du diagramme par mois avec des barres et une courbe
    var tasksByMonthChartCtx = document.getElementById('tasksByMonthChart').getContext('2d');
    var tasksByMonthChart = new Chart(tasksByMonthChartCtx, {
        type: 'bar',
        data: {
            labels: months,
            datasets: datasets
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    stepSize: 1
                }
            },
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: 'Tasks by Month'
                }
            }
        }
    });


</script>




<script>
    // Elements
    var addTaskBtn = document.getElementById('addTaskBtn');
    var taskForm = document.getElementById('TaskForm');
    var taskTable = document.getElementById('taskTable');
    var taskFormElement = document.getElementById('taskFormElement');
    var statusInput = document.getElementById('action');
    var editCodeInput = document.getElementById(' edit_task_id');

    // Event listener for Add Task button
    addTaskBtn.addEventListener('click', function () {
        taskForm.classList.remove('hidden');
        taskTable.classList.add('hidden');
        actionInput.value = "add";
        taskFormElement.reset();
    });

    // Event listeners for Edit buttons
    document.querySelectorAll('.editTaskBtn').forEach(button => {
        button.addEventListener('click', function () {
            taskForm.classList.remove('hidden');
            taskTable.classList.add('hidden');
            actionInput.value = "edit";
            editCodeInput.value = button.getAttribute('data-name');
            document.getElementById('taskName').value = button.getAttribute('data-name');
            document.getElementById('taskDescription').value = button.getAttribute('data-description');
            document.getElementById('taskDueDate').value = button.getAttribute('data-date');
            document.getElementById('taskAmount').value = button.getAttribute('data-amount');
            document.getElementById('taskStatus').value = button.getAttribute('data-status');
        });
    });

    // Event listener for Filter button
    document.getElementById('filterTasksBtn').addEventListener('click', function () {
        var memberId = document.getElementById('filterMemberId').value;

        // Fetch all rows in the table
        var rows = document.querySelectorAll('#taskTable tbody tr');
        rows.forEach(function (row) {
            var memberIdCell = row.querySelector('td:nth-child(7)').textContent;

            // Check if the row matches the filter criteria
            if (memberId === '' || memberIdCell === memberId) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });

    // Event listener for Print Invoice button
    document.getElementById('printInvoiceBtn').addEventListener('click', function () {
        // Récupérer les valeurs des filtres
        var memberId = document.getElementById('filterMemberId').value;
        var status = statusInput.value;

        // Construire l'URL avec les paramètres de filtrage
        var url = "taskPrint.jsp?status=" + status;
        // Ouvrir la page dans une nouvelle fenêtre
        window.open(url, '_blank');
    });


    // Récupération des fournisseurs de tâches
    var taskSuppliers = {};
    tasks.forEach(function(task) {
        var supplierId = task.taskSupplierId;
        taskSuppliers[supplierId] = (taskSuppliers[supplierId] || 0) + 1;
    });

    // Création du tableau de données pour le diagramme
    var supplierIds = Object.keys(taskSuppliers);
    var taskCountsBySupplier = Object.values(taskSuppliers);

    // Création du diagramme par fournisseur
    var tasksBySupplierChartCtx = document.getElementById('tasksBySupplierChart').getContext('2d');
    var tasksBySupplierChart = new Chart(tasksBySupplierChartCtx, {
        type: 'pie',
        data: {
            labels: supplierIds,
            datasets: [{
                label: 'Tâches par Fournisseur',
                data: taskCountsBySupplier,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.5)',
                    'rgba(54, 162, 235, 0.5)',
                    'rgba(255, 206, 86, 0.5)',
                    'rgba(75, 192, 192, 0.5)',
                    'rgba(153, 102, 255, 0.5)',
                    'rgba(255, 159, 64, 0.5)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    stepSize: 1
                }
            },
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: 'Tasks by Supplier'
                }
            }
        }
    });


</script>
</body>
</html>
