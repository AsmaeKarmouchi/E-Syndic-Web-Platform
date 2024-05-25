<%@ page import="java.util.List" %>
<%@ page import="com.syndic.beans.Task" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>DASHBOARD</title>
  <link rel="shortcut icon" href="/Assets/images/logo.png" type="image/x-icon">
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <link rel="stylesheet" href="css/style.css">
  <script src="https://cdn.tailwindcss.com"></script>
</head>

<body>
<div class="container">
  <jsp:include page="templates/admin_sidenav.jsp" />

  <main>
     <br><br><br><br><br><br>
      <!-- Task Form -->
      <div class="max-w-screen-xl mx-auto px-4 md:px-6 mt-12">
        <div class="items-start justify-between md:flex">
          <div class="max-w-lg">
            <h3 class="text-light-800 text-xl font-bold sm:text-2xl">Tasks</h3>
          </div>
          <div class="mt-3 md:mt-0">
            <button id="addTaskBtn" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-indigo-600 rounded-lg hover:bg-indigo-500 active:bg-indigo-700 md:text-sm btn">
              Add Task
            </button>
          </div>
        </div>
        <div class="mt-12 shadow-sm border rounded-lg overflow-x-auto">
          <table class="w-full table-auto text-sm text-left" id="taskTable">
            <thead class="bg-gray-50 text-gray-600 font-medium border-b">
            <tr>
              <th class="py-3 px-6">ID</th>
              <th class="py-3 px-6">Name</th>
              <th class="py-3 px-6">Description</th>
              <th class="py-3 px-6">D_Date</th>
              <th class="py-3 px-6">Status</th>
              <th class="py-3 px-6">S_ID</th>
              <th class="py-3 px-6">created_at</th>
              <th class="py-3 px-6">Actions</th>
            </tr>
            </thead>
            <tbody class="text-gray-600 divide-y">
            <% List<Task> tasks = (List<Task>) request.getAttribute("tasks"); %>
            <% if (tasks != null && !tasks.isEmpty()) { %>
            <% for (Task task : tasks) { %>
            <tr>
              <td class="px-6 py-4 whitespace-nowrap"><%= task.getTaskId() %></td>
              <td class="px-6 py-4 whitespace-nowrap"><%= task.getTaskName() %></td>
              <td class="px-6 py-4 whitespace-nowrap"><%= task.getTaskDescription() %></td>
              <td class="px-6 py-4 whitespace-nowrap"><%= task.getTaskDueDate() %></td>
              <td class="px-6 py-4 whitespace-nowrap"><%= task.getTaskStatus() %></td>
              <td class="px-6 py-4 whitespace-nowrap"><%= task.getTaskSId() %></td>
              <td class="px-6 py-4 whitespace-nowrap"><%= task.getTaskCreated() %></td>
              <td class="text-right px-4 whitespace-nowrap">
                <button class="editTaskBtn py-2 px-3 font-medium text-indigo-600 hover:text-indigo-500 duration-150 hover:bg-gray-50 rounded-lg"
                        data-id="<%= task.getTaskId() %>"
                        data-name="<%= task.getTaskName() %>"
                        data-description="<%= task.getTaskDescription() %>"
                        data-due_date="<%= task.getTaskDueDate() %>"
                        data-status="<%= task.getTaskStatus() %>"
                        data-supplier_id="<%= task.getTaskSId() %>"
                        data-created_at="<%= task.getTaskCreated() %>">

                  Edit
                </button>
                <form action="addtask" method="post" class="inline">
                  <input type="hidden" name="task_id" value="<%= task.getTaskId() %>">
                  <input type="hidden" name="action" value="delete">
                  <button type="submit" class="deleteTaskBtn py-2 leading-none px-3 font-medium text-red-600 hover:text-red-500 duration-150 hover:bg-gray-50 rounded-lg">
                    Delete
                  </button>
                </form>
              </td>
            </tr>
            <% } %>
            <% } else { %>
            <tr>
              <td colspan="7" class="px-6 py-4">No tasks available at the moment.</td>
            </tr>
            <% } %>
            </tbody>
          </table>
        </div>

        <!-- Task Form -->
        <div id="TaskForm" class="form hidden mt-6">
          <form id="taskFormElement" class="grid grid-cols-2 gap-6" action="addtask" method="post">
            <input type="hidden" id="action" name="action" value="add">
            <input type="hidden" id="edit_id" name="edit_id" value="">

            <div class="col-span-1">
              <label for="task_name" class="block text-sm font-medium text-light-700">Name:</label>
              <input type="text" id="task_name" name="task_name" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
            </div>
            <div class="col-span-1">
              <label for="task_description" class="block text-sm font-medium text-light-700">Description:</label>
              <input type="text" id="task_description" name="task_description" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
            </div>
            <div class="col-span-1">
              <label for="task_due_date" class="block text-sm font-medium text-light-700">Due Date:</label>
              <input type="date" id="task_due_date" name="task_due_date" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
            </div>
            <div class="col-span-1">
              <label for="task_status" class="block text-sm font-medium text-light-700">Status:</label>
              <select id="task_status" name="task_status" required class="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                <option value="Pending">Pending</option>
                <option value="In Progress">In Progress</option>
                <option value="Completed">Completed</option>
              </select>
            </div>
            <div class="col-span-1">
              <label for="task_s_id" class="block text-sm font-medium text-light-700">Supplier ID:</label>
              <input type="number" id="task_s_id" name="task_s_id" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
            </div>
            <div class="col-span-1">
              <label for="task_created" class="block text-sm font-medium text-light-700">Created at</label>
              <input type="date" id="task_created" name="task_created"  value="<%=java.time.LocalDate.now()%>" class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
            </div>

            <div class="col-span-2 flex justify-end">
              <button type="submit" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                Save
              </button>
            </div>
          </form>
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
  // Elements
  var addTaskBtn = document.getElementById('addTaskBtn');
  var TaskForm = document.getElementById('TaskForm');
  var taskTable = document.getElementById('taskTable');
  var taskFormElement = document.getElementById('taskFormElement');
  var actionInput = document.getElementById('action');
  var editIdInput = document.getElementById('edit_id');

  // Event listener for Add Task button
  addTaskBtn.addEventListener('click', function () {
    TaskForm.classList.remove('hidden');
    taskTable.classList.add('hidden');
    actionInput.value = "add";
    taskFormElement.reset();
  });

  // Event listeners for Edit buttons
  document.querySelectorAll('.editTaskBtn').forEach(button => {
    button.addEventListener('click', function () {
      TaskForm.classList.remove('hidden');
      taskTable.classList.add('hidden');
      actionInput.value = "edit";
      editIdInput.value = button.getAttribute('data-id');
      document.getElementById('task_name').value = button.getAttribute('data-name');
      document.getElementById('task_description').value = button.getAttribute('data-description');
      document.getElementById('task_due_date').value = button.getAttribute('data-due_date');
      document.getElementById('task_status').value = button.getAttribute('data-status');
      document.getElementById('task_s_id').value = button.getAttribute('data-supplier_id');
      document.getElementById('task_created').value = button.getAttribute('data-created_at');
    });
  });
</script>
</body>
</html>

