<%@ page import="java.util.List" %>
<%@ page import="com.syndic.beans.Task" %>
<%@ page import="com.syndic.beans.Member" %>

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
  <jsp:include page="templates/member_sidenav.jsp" />

  <main>

    <div class="flex justify-between items-center p-6 bg-gray-100 shadow-md border rounded-md">
      <h1 class="text-3xl font-bold text-gray-800">Residence Task</h1>
      <div class="text-lg text-gray-600"><%=java.time.LocalDate.now()%></div>
    </div>
     <br><br><br><br><br><br>
      <!-- Task Form -->
      <div class="max-w-screen-xl mx-auto px-4 md:px-6 mt-12">
        <div class="grid grid-cols-1 gap-4 md:grid-cols-1 lg:grid-cols-1 mt-12">
          <% List<Task> tasks = (List<Task>) session.getAttribute("tasks"); %>
          <% if (tasks != null && !tasks.isEmpty()) { %>
          <% for (Task task : tasks) { %>
          <div class="bg-white overflow-hidden shadow-sm rounded-lg">
            <div class="p-6">
              <h2 class="flex items-center justify-between text-xl font-semibold mb-4" onclick="toggleDetails(this)">
                <span class="text-blue-500">Task N° <%= task.getTaskId() %> : <%= task.getTaskName() %></span>
                <button class="bg-orange-500 text-white px-3 py-1 rounded" >
                  More
                </button>
              </h2>
              <div class="hidden bg-gray-100 shadow-md rounded-lg p-4 mb-4">
                <div class="flex flex-wrap -mx-2">
                  <div class="w-full md:w-1/2 px-2 mb-4 md:mb-0">
                    <p class="text-gray-800"><strong>Name:</strong> <%= task.getTaskName() %></p>
                    <p class="text-gray-800"><strong>Description:</strong> <%= task.getTaskDescription() %></p>
                  </div>
                  <div class="w-full px-2 mt-4">
                    <strong class="text-gray-800 block mb-2">Status:</strong>
                    <div class="bg-white rounded-lg shadow-md p-4">
                      <%= task.getTaskStatus() %>
                    </div>
                  </div>
                  <div class="w-full px-2 mt-4">
                    <strong class="text-gray-800 block mb-2">Supplier ID:</strong>
                    <div class="bg-white rounded-lg shadow-md p-4">
                      <%= task.getTaskSId() %>
                    </div>
                  </div>
                  <div class="w-full px-2 mt-4">
                    <strong class="text-gray-800 block mb-2">Due Date:</strong>
                    <div class="bg-white rounded-lg shadow-md p-4">
                      <%= task.getTaskDueDate() %>
                    </div>
                  </div>

                </div>
                <div class="w-full px-2 mt-4">
                  <form action="addtask" method="post" class="inline">
                    <input type="hidden" name="task_id" value="<%= task.getTaskId() %>">
                    <input type="hidden" name="action" value="delete">
                  </form>
                </div>
              </div>
            </div>
          </div>
          <% } %>
          <% } else { %>
          <p class="col-span-3 px-6 py-4">No tasks available at the moment.</p>
          <% } %>
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
          <p>Hey, <b><%= ((Member) session.getAttribute("member")).getFirstName() %></b></p>
          <small class="text-muted">Member</small>
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
<script>
  function toggleDetails(element) {
    var details = element.nextElementSibling;
    details.classList.toggle("hidden");
  }
</script>
<script>
  document.getElementById("membertask").classList.add("active");
</script>
</body>
</html>

