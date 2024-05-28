<%@ page import="java.util.List" %>
<%@ page import="com.syndic.beans.Payment" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.syndic.beans.Member" %>
<%@ page import="java.util.ArrayList" %>

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
      <h1 class="text-3xl font-bold text-gray-800">My Payment</h1>
      <div class="text-lg text-gray-600"><%=java.time.LocalDate.now()%></div>
    </div>

    <div>
      <div class="recent-updates"></div>
    </div>
    <br><br><br><br><br><br>
    <div class="max-w-screen-xl mx-auto px-4 md:px-6">
      <div class="items-start justify-between md:flex">
        <div class="mt-3 md:mt-0 flex gap-4">

      </div>
      <div class="mt-12 shadow-sm border rounded-lg overflow-x-auto">
        <table class="min-w-full bg-white rounded-lg shadow-md" id="paymentTable">
          <thead class="bg-gray-800 text-white">
          <tr>
            <th class="py-3 px-6">Code</th>
            <th class="py-3 px-6">Date</th>
            <th class="py-3 px-6">Amount</th>
            <th class="py-3 px-6">Method</th>
            <th class="py-3 px-6">Type</th>
            <th class="py-3 px-6">Member ID</th>
            <th class="py-3 px-6">Status</th>
            <th class="py-3 px-6">Actions</th>
          </tr>
          </thead>
          <tbody class="text-gray-600 divide-y" id="paymentTableBody">
          <% List<Payment> payments = (List<Payment>) session.getAttribute("payments"); %>
          <% Member member = (Member) session.getAttribute("member"); %>
          <% int memberId = member.getId();%>
          <%
            if (payments != null && !payments.isEmpty()) {
              List<Payment> memberpayments = new ArrayList<>();
              for (Payment mpayment : payments) {
                if (mpayment.getMember_id() == memberId) {
                  memberpayments.add(mpayment);
                }
              }

          %>
          <% for (Payment payment : memberpayments) { %>
          <tr>
            <td class="px-6 py-4 whitespace-nowrap"><%= payment.getCode() %></td>
            <td class="px-6 py-4 whitespace-nowrap"><%= payment.getDate() %></td>
            <td class="px-6 py-4 whitespace-nowrap"><%= payment.getAmount() %></td>
            <td class="px-6 py-4 whitespace-nowrap"><%= payment.getMethod() %></td>
            <td class="px-6 py-4 whitespace-nowrap"><%= payment.getType() %></td>
            <td class="px-6 py-4 whitespace-nowrap"><%= payment.getMember_id() %></td>
            <td class="px-6 py-4 whitespace-nowrap"><%= payment.getStatus() %></td>
            <td class="text-right px-4 whitespace-nowrap">
              <button class="editPaymentBtn py-2 px-3 font-medium text-indigo-600 hover:text-indigo-500 duration-150 hover:bg-gray-50 rounded-lg"
                      data-code="<%= payment.getCode() %>"
                      data-date="<%= payment.getDate() %>"
                      data-amount="<%= payment.getAmount() %>"
                      data-method="<%= payment.getMethod() %>"
                      data-type="<%= payment.getType() %>"
                      data-member_id="<%= payment.getMember_id() %>"
                      data-status="<%= payment.getStatus() %>">
                Pay
              </button>
              <form action="Syndicaddpayment" method="post" class="inline">
                <input type="hidden" name="code" value="<%= payment.getCode() %>">
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
            <td colspan="9" class="px-6 py-4">No payments available at the moment.</td>
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
          <small class="text-muted"> Member</small>
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

  // Event listener for Filter Payments button
  document.getElementById('filterPaymentsBtn').addEventListener('click', function () {
    var memberId = document.getElementById('filterMemberId').value;

    // Fetch all rows in the table
    var rows = document.querySelectorAll('#paymentTable tbody tr');
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

    // Construire l'URL avec les paramètres de filtrage
    var url = "syndicpaymentPrint.jsp?memberId=" + memberId;

    // Ouvrir la page dans une nouvelle fenêtre
    window.open(url, '_blank');
  });


</script>
<script>
  document.getElementById("memberpaiment").classList.add("active");
</script>
</body>
</html>