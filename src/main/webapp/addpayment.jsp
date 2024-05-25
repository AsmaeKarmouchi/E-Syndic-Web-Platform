<%@ page import="java.util.List" %>
<%@ page import="com.syndic.beans.Payment" %>
<%@ page import="java.text.SimpleDateFormat" %>

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

        <div>
            <div class="recent-updates"></div>
        </div>
        <br><br><br><br><br><br>
        <div class="max-w-screen-xl mx-auto px-4 md:px-6">
            <div class="items-start justify-between md:flex">
                <div class="max-w-lg">
                    <h3 class="text-light-800 text-xl font-bold sm:text-2xl">Members Payment</h3>
                </div>
                <div class="mt-3 md:mt-0 flex gap-4">
                    <button id="addPaymentBtn"
                            class="inline-block px-4 py-2 text-white duration-150 font-medium bg-indigo-600 rounded-lg hover:bg-indigo-500 active:bg-indigo-700 md:text-sm btn">
                        Add Payment
                    </button>
                    <input type="number" id="filterAccountId" placeholder="Filter by Account ID" class="px-4 py-2 border rounded-md">
                    <input type="number" id="filterMemberId" placeholder="Filter by Member ID" class="px-4 py-2 border rounded-md">
                    <button id="filterPaymentsBtn" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-blue-600 rounded-lg hover:bg-blue-500 active:bg-blue-700 md:text-sm btn">
                        Filter Payments
                    </button>
                    <button id="printInvoiceBtn" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-green-600 rounded-lg hover:bg-green-500 active:bg-green-700 md:text-sm btn">
                        Print Invoice
                    </button>
                </div>
            </div>
            <div class="mt-12 shadow-sm border rounded-lg overflow-x-auto">
                <table class="w-full table-auto text-sm text-left" id="paymentTable">
                    <thead class="bg-gray-50 text-gray-600 font-medium border-b">
                    <tr>
                        <th class="py-3 px-6">Code</th>
                        <th class="py-3 px-6">Date</th>
                        <th class="py-3 px-6">Amount</th>
                        <th class="py-3 px-6">Method</th>
                        <th class="py-3 px-6">Type</th>
                        <th class="py-3 px-6">Account ID</th>
                        <th class="py-3 px-6">Member ID</th>
                        <th class="py-3 px-6">Status</th>
                        <th class="py-3 px-6">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="text-gray-600 divide-y" id="paymentTableBody">
                    <% List<Payment> payments = (List<Payment>) request.getAttribute("payments"); %>
                    <% if (payments != null && !payments.isEmpty()) { %>
                    <% for (Payment payment : payments) { %>
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap"><%= payment.getCode() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= payment.getDate() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= payment.getAmount() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= payment.getMethod() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= payment.getType() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= payment.getAccount_id() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= payment.getMember_id() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= payment.getStatus() %></td>
                        <td class="text-right px-4 whitespace-nowrap">
                            <button class="editPaymentBtn py-2 px-3 font-medium text-indigo-600 hover:text-indigo-500 duration-150 hover:bg-gray-50 rounded-lg"
                                    data-code="<%= payment.getCode() %>"
                                    data-date="<%= payment.getDate() %>"
                                    data-amount="<%= payment.getAmount() %>"
                                    data-method="<%= payment.getMethod() %>"
                                    data-type="<%= payment.getType() %>"
                                    data-account_id="<%= payment.getAccount_id() %>"
                                    data-member_id="<%= payment.getMember_id() %>"
                                    data-status="<%= payment.getStatus() %>">
                                Edit
                            </button>
                            <form action="addpayment" method="post" class="inline">
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

            <div id="PaymentForm" class="form hidden mt-6">
                <form id="paymentFormElement" class="grid grid-cols-2 gap-6" action="addpayment" method="post">
                    <input type="hidden" id="action" name="action" value="add">
                    <input type="hidden" id="edit_code" name="edit_code" value="">

                    <div class="col-span-1">
                        <label for="code" class="block text-sm font-medium text-light-700">Code:</label>
                        <input type="number" id="code" name="code" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                    </div>
                    <div class="col-span-1">
                        <label for="date" class="block text-sm font-medium text-light-700">Date:</label>
                        <input type="date" id="date" name="date" value="<%=java.time.LocalDate.now()%>" class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                    </div>
                    <div class="col-span-1">
                        <label for="amount" class="block text-sm font-medium text-light-700">Amount:</label>
                        <input type="number" id="amount" name="amount" class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                    </div>
                    <div class="col-span-1">
                        <label for="method" class="block text-sm font-medium text-light-700">Method:</label>
                        <input type="text" id="method" name="method" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                    </div>
                    <div class="col-span-1">
                        <label for="type" class="block text-sm font-medium text-light-700">Type:</label>
                        <input type="text" id="type" name="type" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                    </div>
                    <div class="col-span-1">
                        <label for="account_id" class="block text-sm font-medium text-light-700">Account ID:</label>
                        <input type="number" id="account_id" name="account_id" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                    </div>
                    <div class="col-span-1">
                        <label for="member_id" class="block text-sm font-medium text-light-700">Member ID:</label>
                        <input type="number" id="member_id" name="member_id" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                    </div>
                    <div class="col-span-1">
                        <label for="status" class="block text-sm font-medium text-light-700">Status:</label>
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
            document.getElementById('account_id').value = button.getAttribute('data-account_id');
            document.getElementById('member_id').value = button.getAttribute('data-member_id');
            document.getElementById('status').value = button.getAttribute('data-status');
        });
    });

    // Event listener for Filter Payments button
    document.getElementById('filterPaymentsBtn').addEventListener('click', function () {
        var accountId = document.getElementById('filterAccountId').value;
        var memberId = document.getElementById('filterMemberId').value;

        // Fetch all rows in the table
        var rows = document.querySelectorAll('#paymentTable tbody tr');
        rows.forEach(function (row) {
            var accountIdCell = row.querySelector('td:nth-child(6)').textContent;
            var memberIdCell = row.querySelector('td:nth-child(7)').textContent;

            // Check if the row matches the filter criteria
            if ((accountId === '' || accountIdCell === accountId) &&
                (memberId === '' || memberIdCell === memberId)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });

    // Event listener for Print Invoice button
    document.getElementById('printInvoiceBtn').addEventListener('click', function () {
        // Récupérer les valeurs des filtres
        var accountId = document.getElementById('filterAccountId').value;
        var memberId = document.getElementById('filterMemberId').value;

        // Construire l'URL avec les paramètres de filtrage
        var url = "paymentPrint.jsp?accountId=" + accountId + "&memberId=" + memberId;

        // Ouvrir la page dans une nouvelle fenêtre
        window.open(url, '_blank');
    });


</script>
</body>
</html>
