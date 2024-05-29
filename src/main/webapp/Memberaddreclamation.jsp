<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.syndic.beans.Reclamation" %>
<%@ page import="com.syndic.beans.Syndic" %>
<%@ page import="com.syndic.beans.Member" %>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>DASHBOARD</title>
  <link rel="shortcut icon" href="/Assets/images/logo.png" type="image/x-icon">
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <link rel="stylesheet" href="css/style.css">
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
<div class="container">
  <jsp:include page="templates/member_sidenav.jsp" />

    <main>

      <div class="flex justify-between items-center p-6 bg-gray-100 shadow-md border rounded-md">
        <h1 class="text-3xl font-bold text-gray-800">Add Reclamation</h1>
        <div class="text-lg text-gray-600"><%=java.time.LocalDate.now()%></div>
      </div>

      <div>
        <div class="recent-updates"></div>
      </div>
      <br><br><br><br><br><br>
      <div class="max-w-screen-xl mx-auto px-4 md:px-6">
        <div class="items-start justify-between md:flex">
          <div class="mt-3 md:mt-0 flex gap-4">
            <button id="addReclamationBtn"
                    class="inline-block px-4 py-2 text-white duration-150 font-medium bg-indigo-600 rounded-lg hover:bg-indigo-500 active:bg-indigo-700 md:text-sm btn">
              Add Reclamation
            </button>
            <!-- Ajoutez d'autres boutons d'action si nécessaire -->
            </button>
            <input type="number" id="filterMemberId" placeholder="Filter by Member ID" class="px-4 py-2 border rounded-md">
            <button id="filterTasksBtn" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-blue-600 rounded-lg hover:bg-blue-500 active:bg-blue-700 md:text-sm btn">
              Filter tasks
            </button>
            <button id="printInvoiceBtn" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-green-600 rounded-lg hover:bg-green-500 active:bg-green-700 md:text-sm btn">
              Print Invoice
            </button>
          </div>
        </div>


        <div class="mt-12 shadow-sm border rounded-lg overflow-x-auto">
          <table class="min-w-full bg-white rounded-lg shadow-md" id="reclamationTable">
            <thead class="bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-semibold">
            <tr>
              <th class="py-3 px-6">Reclamation Date</th>
              <th class="py-3 px-6">Reclamation Type</th>
              <th class="py-3 px-6">Reclamation Description</th>
              <th class="py-3 px-6">Reclamation Status</th>
              <th class="py-3 px-6">Resolution Date</th>

            </tr>
            </thead>
            <tbody class="text-gray-600 divide-y" id="taskTableBody">
            <% List<Reclamation> reclamations = (List<Reclamation>) request.getAttribute("reclamations"); %>
            <% if (reclamations != null && !reclamations.isEmpty()) { %>
            <% for (Reclamation reclamation : reclamations) { %>
            <tr>
              <td class="px-6 py-4 whitespace-nowrap"><%= reclamation.getDate()%></td>
              <td class="px-6 py-4 whitespace-nowrap"><%= reclamation.getReclaimType() %></td>
              <td class="px-6 py-4 whitespace-nowrap"><%= reclamation.getReclaimDescription()%></td>
              <td class="px-6 py-4 whitespace-nowrap"><%= reclamation.getReclaimStatus() %></td>
              <td class="px-6 py-4 whitespace-nowrap"><%= reclamation.getReclaimResolutionDate() %></td>
              <td class="text-right px-4 whitespace-nowrap">
                <button class="editPaymentBtn py-2 px-3 font-medium text-indigo-600 hover:text-indigo-500 duration-150 hover:bg-gray-50 rounded-lg"
                        data-name="<%= reclamation.getDate() %>"
                        data-description="<%= reclamation.getReclaimType() %>"
                        data-amount="<%= reclamation.getReclaimDescription() %>"
                        data-date="<%= reclamation.getReclaimStatus() %>"
                        data-status="<%= reclamation.getReclaimResolutionDate() %>">

                  Edit
                </button>
                <form action="Memberaddreclamation" method="post" class="inline">
                  <input type="hidden" name="code" value="<%= reclamation.getReclaimDescription() %>">
                  <input type="hidden" name="action" value="delete">
                  <button type="submit" class="deletePaymentBtn py-2 leading-none px-3 font-medium text-red-600 hover:text-red-500 duration-150 hover:bg-gray-50 rounded-lg">
                    Delete
                  </button>
                </form>
              </td>
            </tr>
            <% } %>
            <% } else { %>
            <tr>
              <td colspan="9" class="px-6 py-4">No reclamation available at the moment.</td>
            </tr>
            <% } %>
            </tbody>
          </table>
        </div>

        <div id="ReclamationForm" class="form hidden mt-6 p-6 bg-white shadow-lg rounded-lg">
          <form id="reclamationFormElement" class="grid grid-cols-1 gap-6 md:grid-cols-2" action="Memberaddreclamation" method="post">
            <input type="hidden" id="action" name="action" value="add">
            <input type="hidden" id="edit_reclamation_id" name="edit_reclamation_id" value="">
            <div class="col-span-1">
              <label for="reclaimDate" class="block text-sm font-medium text-gray-700">Resolution Date:</label>
              <input type="date" id="reclaimDate" name="reclaimDate" class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
            </div>
            <div class="col-span-1">
              <label for="reclaimType" class="block text-sm font-medium text-gray-700">Reclamation Type:</label>
              <input type="text" id="reclaimType" name="reclaimType" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
            </div>
            <div class="col-span-1">
              <label for="reclaimDescription" class="block text-sm font-medium text-gray-700">Reclamation Description:</label>
              <input type="text" id="reclaimDescription" name="reclaimDescription" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
            </div>
            <div class="col-span-1">
              <label for="reclaimStatus" class="block text-sm font-medium text-gray-700">Reclamation Status:</label>
              <input type="text" id="reclaimStatus" name="reclaimStatus" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
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
  var addReclamationBtn = document.getElementById('addReclamationBtn');
  var reclamationForm = document.getElementById('ReclamationForm');
  var reclamationTable = document.getElementById('reclamationTable');
  var reclamationFormElement = document.getElementById('reclamationFormElement');
  var actionInput = document.getElementById('action');
  var editReclamationIdInput = document.getElementById('edit_reclamation_id');

  // Event listener for Add Reclamation button
  addReclamationBtn.addEventListener('click', function () {
    reclamationForm.classList.remove('hidden');
    reclamationTable.classList.add('hidden');
    actionInput.value = "add";
    reclamationFormElement.reset();
  });

  // Event listeners for Edit buttons
  document.querySelectorAll('.editPaymentBtn').forEach(button => {
    button.addEventListener('click', function () {
      reclamationForm.classList.remove('hidden');
      reclamationTable.classList.add('hidden');
      actionInput.value = "edit";
      editReclamationIdInput.value = button.getAttribute('data-id');
      document.getElementById('reclaimDate').value = button.getAttribute('data-date');
      document.getElementById('reclaimType').value = button.getAttribute('data-type');
      document.getElementById('reclaimDescription').value = button.getAttribute('data-description');
      document.getElementById('reclaimStatus').value = button.getAttribute('data-status');
      document.getElementById('reclaimResolutionDate').value = button.getAttribute('data-resolution-date');
    });
  });

  // Event listener for Filter button
  document.getElementById('filterTasksBtn').addEventListener('click', function () {
    var memberId = document.getElementById('filterMemberId').value;

    // Fetch all rows in the table
    var rows = document.querySelectorAll('#reclamationTable tbody tr');
    rows.forEach(function (row) {
      var memberIdCell = row.querySelector('td:nth-child(6)').textContent;

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
    var url = "reclamationPrint.jsp?status=" + status;
    // Ouvrir la page dans une nouvelle fenêtre
    window.open(url, '_blank');
  });
</script>


</body>
</html>
