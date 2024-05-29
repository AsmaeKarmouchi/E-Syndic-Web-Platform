<%@ page import="com.syndic.beans.PaymentFlow" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>payments flows</title>
    <link rel="shortcut icon" href="/Assets/images/logo.png" type="image/x-icon">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="css/style.css">
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body>
<div class="container">
    <jsp:include page="templates/syndic_sidenav.jsp" />

    <main>

        <div class="flex justify-between items-center p-6 bg-purple-300 shadow-md border rounded-md">
            <h1 class="text-3xl font-bold text-gray-800">Comprehensive Monitoring of Residence Expenses, Tasks, and Payments</h1>
            <div class="text-lg text-gray-600"><%=java.time.LocalDate.now()%></div>
        </div>
        <div>
            <div class="recent-updates"></div>
        </div>
        <br><br><br><br><br><br>
        <div class="max-w-screen-xl mx-auto px-4 md:px-6">
            <div class="items-start justify-between md:flex">
                <div class="mt-3 md:mt-0 flex gap-4">
                    <input type="number" id="filterId" placeholder="Filter by type de flow" class="px-4 py-2 border rounded-md">
                    <input type="number" id="filterdate" placeholder="Filter by date " class="px-4 py-2 border rounded-md">
                    <button id="filterPaymentsBtn" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-blue-600 rounded-lg hover:bg-blue-500 active:bg-blue-700 md:text-sm btn">
                        Filter Payments Flows
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

                        <th class="py-3 px-6">Flow Type</th>
                        <th class="py-3 px-6">Amount</th>
                        <th class="py-3 px-6">description</th>
                        <th class="py-3 px-6">Date Transaction</th>
                    </tr>
                    </thead>
                    <tbody class="text-gray-600 divide-y" id="paymentTableBody">
                    <!-- Boucle sur chaque syndic -->
                    <% List<PaymentFlow> paymentsflow = (List<PaymentFlow>) session.getAttribute("paymentsflow"); %>
                    <% if ( paymentsflow != null && !paymentsflow.isEmpty())  { %>
                    <% for  (PaymentFlow pf : paymentsflow) { %>
                    <tr>

                        <td class="px-6 py-4 whitespace-nowrap"><%= pf.getFlowType() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= pf.getAmount()%></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= pf.getDescription()%></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%=  pf.getTransactionDate()%></td>
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
    var PaymentForm = document.getElementById('PaymentForm');
    var paymentTable = document.getElementById('paymentTable');
    var paymentFormElement = document.getElementById('paymentFormElement');
    var actionInput = document.getElementById('action');

    // Event listener for Filter Payments button
    document.getElementById('filterPaymentsBtn').addEventListener('click', function () {
        var Id = document.getElementById('filterId').value;
        var date = document.getElementById('filterdate').value;

        // Fetch all rows in the table
        var rows = document.querySelectorAll('#paymentTable tbody tr');
        rows.forEach(function (row) {
            var IdCell = row.querySelector('td:nth-child(1)').textContent;
            var dateCell = row.querySelector('td:nth-child(5)').textContent;

            // Convert the dateCell and filter date to Date objects for comparison
            var dateCellDate = new Date(dateCell);
            var filterDate = new Date(date);

            // Check if the row matches the filter criteria
            if ((Id === '' || IdCell === Id) &&
                (date === '' || dateCellDate.getTime() === filterDate.getTime())) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });

    // Event listener for Print Invoice button
    document.getElementById('printInvoiceBtn').addEventListener('click', function () {
        // Récupérer les valeurs des filtres
        var Id = document.getElementById('filterId').value;
        var date = document.getElementById('filterdate').value;

        // Construire l'URL avec les paramètres de filtrage
        var url = "paymentflowPrint.jsp?Id=" + Id + "&date=" + date;

        // Ouvrir la page dans une nouvelle fenêtre
        window.open(url, '_blank');
    });
</script>


</body>
</html>
