<%@ page import="java.util.List" %>
<%@ page import="com.syndic.beans.Payment" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body>
<div class="container">
  <jsp:include page="templates/syndic_sidenav.jsp" />

  <main>

    <div class="flex justify-between items-center p-6 bg-gray-100 shadow-md border rounded-md">
      <h1 class="text-3xl font-bold text-gray-800">Add Payment</h1>
      <div class="text-lg text-gray-600"><%=java.time.LocalDate.now()%></div>
    </div>

    <div>
      <div class="recent-updates"></div>
    </div>
    <br><br><br><br><br><br>
    <div class="max-w-screen-xl mx-auto px-4 md:px-6">
      <div class="items-start justify-between md:flex">
        <div class="mt-3 md:mt-0 flex gap-4">
          <button id="addPaymentBtn"
                  class="inline-block px-4 py-2 text-white duration-150 font-medium bg-indigo-600 rounded-lg hover:bg-indigo-500 active:bg-indigo-700 md:text-sm btn">
            Add Payment
          </button>
          <input type="number" id="filterMemberId" placeholder="Filter by Member ID" class="px-4 py-2 border rounded-md">
          <input type="date" id="filterStartDate" class="px-4 py-2 border rounded-md" placeholder="Start Date">
          <input type="date" id="filterEndDate" class="px-4 py-2 border rounded-md" placeholder="End Date">
          <button id="filterPaymentsBtn" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-blue-600 rounded-lg hover:bg-blue-500 active:bg-blue-700 md:text-sm btn">
            Filter Payments
          </button>
          <button id="printInvoiceBtn" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-green-600 rounded-lg hover:bg-green-500 active:bg-green-700 md:text-sm btn">
            Print Invoice
          </button>
        </div>
      </div>
      <div class="mt-12 shadow-lg border rounded-lg overflow-x-auto">
        <table class="min-w-full bg-white rounded-lg shadow-md" id="paymentTable">
          <thead class="bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-semibold">
          <tr>
            <th class="py-3 px-6 uppercase tracking-wider">Code</th>
            <th class="py-3 px-6 uppercase tracking-wider">Date</th>
            <th class="py-3 px-6 uppercase tracking-wider">Amount</th>
            <th class="py-3 px-6 uppercase tracking-wider">Method</th>
            <th class="py-3 px-6 uppercase tracking-wider">Type</th>
            <th class="py-3 px-6 uppercase tracking-wider">Member ID</th>
            <th class="py-3 px-6 uppercase tracking-wider">Status</th>
            <th class="py-3 px-6 uppercase tracking-wider">Actions</th>
          </tr>
          </thead>
          <tbody class="text-gray-800 divide-y divide-gray-200" id="paymentTableBody">
          <% List<Payment> payments = (List<Payment>) request.getAttribute("payments"); %>
          <% if (payments != null && !payments.isEmpty()) { %>
          <% for (Payment payment : payments) { %>
          <tr class="bg-white hover:bg-gray-100 transition duration-150">
            <td class="px-6 py-4 whitespace-nowrap"><%= payment.getCode() %></td>
            <td class="px-6 py-4 whitespace-nowrap"><%= payment.getDate() %></td>
            <td class="px-6 py-4 whitespace-nowrap"><%= payment.getAmount() %></td>
            <td class="px-6 py-4 whitespace-nowrap"><%= payment.getMethod() %></td>
            <td class="px-6 py-4 whitespace-nowrap"><%= payment.getType() %></td>
            <td class="px-6 py-4 whitespace-nowrap"><%= payment.getMember_id() %></td>
            <td class="px-6 py-4 whitespace-nowrap"><%= payment.getStatus() %></td>
            <td class="text-right px-4 whitespace-nowrap">
              <button class="editPaymentBtn py-2 px-3 font-medium text-indigo-600 hover:text-indigo-500 transition duration-150 hover:bg-gray-50 rounded-lg"
                      data-code="<%= payment.getCode() %>"
                      data-date="<%= payment.getDate() %>"
                      data-amount="<%= payment.getAmount() %>"
                      data-method="<%= payment.getMethod() %>"
                      data-type="<%= payment.getType() %>"
                      data-member_id="<%= payment.getMember_id() %>"
                      data-status="<%= payment.getStatus() %>">
                Edit
              </button>
              <form action="Syndicaddpayment" method="post" class="inline">
                <input type="hidden" name="code" value="<%= payment.getCode() %>">
                <input type="hidden" name="action" value="delete">
                <button type="submit" class="deletePaymentBtn py-2 leading-none px-3 font-medium text-red-600 hover:text-red-500 transition duration-150 hover:bg-gray-50 rounded-lg">
                  Delete
                </button>
              </form>
            </td>
          </tr>
          <% } %>
          <% } else { %>
          <tr>
            <td colspan="8" class="px-6 py-4 text-center text-gray-500">No payments available at the moment.</td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>


      <div id="PaymentForm" class="form hidden mt-6 p-6 bg-white shadow-lg rounded-lg">
        <form id="paymentFormElement" class="grid grid-cols-1 gap-6 md:grid-cols-2" action="Syndicaddpayment" method="post">
          <input type="hidden" id="action" name="action" value="add">
          <input type="hidden" id="edit_code" name="edit_code" value="">

          <div class="col-span-1">
            <label for="code" class="block text-sm font-medium text-gray-700">Code:</label>
            <input type="number" id="code" name="code" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
          </div>
          <div class="col-span-1">
            <label for="date" class="block text-sm font-medium text-gray-700">Date:</label>
            <input type="date" id="date" name="date" value="<%=java.time.LocalDate.now()%>" class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
          </div>
          <div class="col-span-1">
            <label for="amount" class="block text-sm font-medium text-gray-700">Amount:</label>
            <input type="number" id="amount" name="amount" class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
          </div>
          <div class="col-span-1">
            <label for="method" class="block text-sm font-medium text-gray-700">Method:</label>
            <input type="text" id="method" name="method" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
          </div>
          <div class="col-span-1">
            <label for="type" class="block text-sm font-medium text-gray-700">Type:</label>
            <input type="text" id="type" name="type" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
          </div>

          <div class="col-span-1">
            <label for="member_id" class="block text-sm font-medium text-gray-700">Member ID:</label>
            <input type="number" id="member_id" name="member_id" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
          </div>
          <div class="col-span-1">
            <label for="status" class="block text-sm font-medium text-gray-700">Status:</label>
            <input type="text" id="status" name="status" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
          </div>
          <div class="col-span-2 flex justify-end">
            <button type="submit" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
              Save
            </button>
          </div>
        </form>
      </div>


    </div>

    <!-- Conteneurs pour les graphiques -->
    <div class="mt-12">
      <h2 class="text-2xl font-bold text-gray-800">Payments Charts</h2>

      <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6">
        <!-- Graphique des paiements par date -->
        <div class="bg-white border border-gray-200 rounded-lg shadow-md">
          <div class="p-6">
            <h3 class="text-lg font-semibold text-gray-800 mb-4">Payments by Date</h3>
            <canvas id="paymentsChart" width="400" height="250"></canvas>
          </div>
        </div>

        <!-- Graphique des paiements par membre -->
        <div class="bg-white border border-gray-200 rounded-lg shadow-md">
          <div class="p-6">
            <h3 class="text-lg font-semibold text-gray-800 mb-4">Payments by Member</h3>
            <canvas id="paymentsByMemberChart" width="400" height="250"></canvas>
          </div>
        </div>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6">
        <!-- Graphique des paiements par type -->
        <div class="bg-white border border-gray-200 rounded-lg shadow-md">
          <div class="p-6">
            <h3 class="text-lg font-semibold text-gray-800 mb-4">Payments by Type</h3>
            <canvas id="paymentsByTypeChart" width="400" height="250"></canvas>
          </div>
        </div>

        <!-- Graphique des paiements par méthode -->
        <div class="bg-white border border-gray-200 rounded-lg shadow-md">
          <div class="p-6">
            <h3 class="text-lg font-semibold text-gray-800 mb-4">Payments by Method</h3>
            <canvas id="paymentsByMethodChart" width="400" height="250"></canvas>
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
  // Elements
  var addPaymentBtn = document.getElementById('addPaymentBtn');
  var PaymentForm = document.getElementById('PaymentForm');
  var paymentTable = document.getElementById('paymentTable');
  var paymentFormElement = document.getElementById('paymentFormElement');
  var actionInput = document.getElementById('action');
  var editCodeInput = document.getElementById('edit_code');

  // Event listener for Add Payment button
  addPaymentBtn.addEventListener('click', function () {
    PaymentForm.classList.remove('hidden');
    paymentTable.classList.add('hidden');
    actionInput.value = "add";
    paymentFormElement.reset();
  });

  // Event listeners for Edit buttons
  document.querySelectorAll('.editPaymentBtn').forEach(button => {
    button.addEventListener('click', function () {
      PaymentForm.classList.remove('hidden');
      paymentTable.classList.add('hidden');
      actionInput.value = "edit";
      editCodeInput.value = button.getAttribute('data-code');
      document.getElementById('code').value = button.getAttribute('data-code');
      document.getElementById('date').value = button.getAttribute('data-date');
      document.getElementById('amount').value = button.getAttribute('data-amount');
      document.getElementById('method').value = button.getAttribute('data-method');
      document.getElementById('type').value = button.getAttribute('data-type');
      document.getElementById('member_id').value = button.getAttribute('data-member_id');
      document.getElementById('status').value = button.getAttribute('data-status');
    });
  });

  document.getElementById('filterPaymentsBtn').addEventListener('click', function () {
    var memberId = document.getElementById('filterMemberId').value;
    var startDate = document.getElementById('filterStartDate').value;
    var endDate = document.getElementById('filterEndDate').value;

    var rows = document.querySelectorAll('#paymentTable tbody tr');
    rows.forEach(function (row) {
      var memberIdCell = row.querySelector('td:nth-child(6)').textContent;
      var dateCell = row.querySelector('td:nth-child(2)').textContent;

      var showRow = true;

      if (memberId && memberIdCell !== memberId) {
        showRow = false;
      }

      if (startDate && new Date(dateCell) < new Date(startDate)) {
        showRow = false;
      }

      if (endDate && new Date(dateCell) > new Date(endDate)) {
        showRow = false;
      }

      row.style.display = showRow ? '' : 'none';
    });
  });


  // Event listener for Print Invoice button
  document.getElementById('printInvoiceBtn').addEventListener('click', function () {
    // Récupérer les valeurs des filtres
    var memberId = document.getElementById('filterMemberId').value;
    var startDate = document.getElementById('filterStartDate').value;
    var endDate = document.getElementById('filterEndDate').value;

    // Construire l'URL avec les paramètres de filtrage
    var url = "syndicpaymentPrint.jsp?";
    var params = [];

    if (memberId) {
      params.push("memberId=" + encodeURIComponent(memberId));
    }
    if (startDate) {
      params.push("startDate=" + encodeURIComponent(startDate));
    }
    if (endDate) {
      params.push("endDate=" + encodeURIComponent(endDate));
    }

    if (params.length > 0) {
      url += params.join("&");
    }

    // Ouvrir la page dans une nouvelle fenêtre
    window.open(url, '_blank');
  });

  // Préparation des données pour les graphiques
  // Convertir les données de paiement en JSON
  var paymentsData = <%= new Gson().toJson(payments) %>;

  // Données pour le graphique de paiements
  // Création d'un objet pour stocker les paiements par mois
  var monthlyPayments = {};

  // Remplissage de l'objet monthlyPayments avec les montants des paiements pour chaque mois
  paymentsData.forEach(function(payment) {
    var date = new Date(payment.date);
    var month = date.getMonth() + 1; // Les mois vont de 0 à 11, donc on ajoute 1 pour obtenir les mois de 1 à 12
    var year = date.getFullYear(); // On obtient l'année

    // Créer une clé de mois unique incluant l'année
    var monthYear = month + '-' + year;

    // Vérifier si le mois existe déjà dans l'objet monthlyPayments
    if (monthlyPayments[monthYear]) {
      monthlyPayments[monthYear] += payment.amount;
    } else {
      monthlyPayments[monthYear] = payment.amount;
    }
  });

  // Création de tableaux pour les labels (mois) et les montants des paiements
  var paymentMonths = [];
  var paymentAmounts = [];

  // Boucle pour obtenir les données des 12 derniers mois
  var currentDate = new Date();
  var month = 0;
  for (var i = 0; i < 12; i++) {
    var month = month + 1; // Les mois vont de 0 à 11, donc on ajoute 1 pour obtenir les mois de 1 à 12
    var year = currentDate.getFullYear(); // On obtient l'année

    // Créer une clé de mois unique incluant l'année
    var monthYear = month + '-' + year;
    paymentMonths.unshift(monthYear); // Ajouter le mois et l'année au début du tableau (pour avoir les mois du plus récent au plus ancien)

    // Vérifier si le mois existe dans les paiements, sinon le montant sera 0
    paymentAmounts.unshift(monthlyPayments[monthYear] || 0);

    // Passer au mois précédent
    currentDate.setMonth(currentDate.getMonth() - 1);
  }

  // Création du graphique des paiements
  var paymentsChartCtx = document.getElementById('paymentsChart').getContext('2d');
  var paymentsChart = new Chart(paymentsChartCtx, {
    type: 'bar',
    data: {
      labels: paymentMonths,
      datasets: [{
        label: 'Payments',
        data: paymentAmounts,
        backgroundColor: 'rgba(54, 162, 235, 0.2)',
        borderColor: 'rgba(54, 162, 235, 1)',
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });


  // Données pour le graphique par membre
  var paymentByMemberData = {};
  paymentsData.forEach(function(payment) {
    var memberId = payment.member_id;
    if (paymentByMemberData[memberId]) {
      paymentByMemberData[memberId] += payment.amount;
    } else {
      paymentByMemberData[memberId] = payment.amount;
    }
  });

  var memberLabels = Object.keys(paymentByMemberData);
  var memberAmounts = Object.values(paymentByMemberData);

  var paymentsByMemberChartCtx = document.getElementById('paymentsByMemberChart').getContext('2d');
  var paymentsByMemberChart = new Chart(paymentsByMemberChartCtx, {
    type: 'bar',
    data: {
      labels: memberLabels,
      datasets: [{
        label: 'Payments by Member',
        data: memberAmounts,
        backgroundColor: 'rgba(255, 99, 132, 0.2)',
        borderColor: 'rgba(255, 99, 132, 1)',
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });

  // Données pour le graphique par type
  var paymentTypes = {};
  paymentsData.forEach(function(payment) {
    if (payment.type in paymentTypes) {
      paymentTypes[payment.type] += payment.amount;
    } else {
      paymentTypes[payment.type] = payment.amount;
    }
  });

  var paymentTypesLabels = Object.keys(paymentTypes);
  var paymentTypesData = Object.values(paymentTypes);

  var paymentsByTypeChartCtx = document.getElementById('paymentsByTypeChart').getContext('2d');
  var paymentsByTypeChart = new Chart(paymentsByTypeChartCtx, {
    type: 'pie',
    data: {
      labels: paymentTypesLabels,
      datasets: [{
        label: 'Payments by Type',
        data: paymentTypesData,
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(54, 162, 235, 0.2)',
          'rgba(255, 206, 86, 0.2)',
          'rgba(75, 192, 192, 0.2)',
          'rgba(153, 102, 255, 0.2)',
          'rgba(255, 159, 64, 0.2)'
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
      responsive: true
    }
  });

  // Données pour le graphique par méthode
  var paymentMethods = {};
  paymentsData.forEach(function(payment) {
    if (payment.method in paymentMethods) {
      paymentMethods[payment.method] += payment.amount;
    } else {
      paymentMethods[payment.method] = payment.amount;
    }
  });

  var paymentMethodsLabels = Object.keys(paymentMethods);
  var paymentMethodsData = Object.values(paymentMethods);

  var paymentsByMethodChartCtx = document.getElementById('paymentsByMethodChart').getContext('2d');
  var paymentsByMethodChart = new Chart(paymentsByMethodChartCtx, {
    type: 'doughnut',
    data: {
      labels: paymentMethodsLabels,
      datasets: [{
        label: 'Payments by Method',
        data: paymentMethodsData,
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(54, 162, 235, 0.2)',
          'rgba(255, 206, 86, 0.2)',
          'rgba(75, 192, 192, 0.2)',
          'rgba(153, 102, 255, 0.2)',
          'rgba(255, 159, 64, 0.2)'
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
      responsive: true
    }
  });






</script>
</body>
</html>
