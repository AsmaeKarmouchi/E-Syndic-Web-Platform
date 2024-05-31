<%@ page import="com.syndic.beans.PaymentFlow" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.syndic.beans.Syndic" %>
<%@ page import="com.syndic.connection.Syndic_con" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.syndic.dao.MemberProfileDAOImpl" %>
<%@ page import="com.syndic.dao.MemberProfileDAO" %>
<%@ page language="java" %>
<%     double solde = ((Syndic) session.getAttribute("syndic2")).getAccount();
    String Res = ((Syndic) session.getAttribute("syndic2")).getResidenceName();
    int syndicid = ((Syndic) session.getAttribute("syndic2")).getId();

    Connection connection = null;
    int memberCount = 0;
    try {
        connection = Syndic_con.getConnection();
        MemberProfileDAO memberProfileDAO = new MemberProfileDAOImpl(connection);
        memberCount = memberProfileDAO.getMemberCountsyndic(syndicid);
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

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
            <h1 class="text-3xl font-bold text-gray-800">Monitoring of Residence Expenses, Tasks, and Payments</h1>
            <div class="text-lg text-gray-600"><%=java.time.LocalDate.now()%></div>
        </div>
        <div>
            <div class="recent-updates"></div>
        </div>
        <br><br><br><br><br><br>
        <div class="max-w-screen-xl mx-auto px-4 md:px-6">
            <div class="items-start justify-between md:flex">
                <div class="mt-3 md:mt-0 flex gap-4">
                    <input type="number" id="filterId" placeholder="Filter by Flow Type" class="px-4 py-2 border rounded-md">
                    <input type="date" id="filterStartDate" class="px-4 py-2 border rounded-md" placeholder="Start Date">
                    <input type="date" id="filterEndDate" class="px-4 py-2 border rounded-md" placeholder="End Date">
                    <button id="filterPaymentsBtn" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-blue-600 rounded-lg hover:bg-blue-500 active:bg-blue-700 md:text-sm btn">
                        Filter Payments Flows
                    </button>
                    <button id="printInvoiceBtn" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-green-600 rounded-lg hover:bg-green-500 active:bg-green-700 md:text-sm btn">
                        Print Invoice
                    </button>
                </div>
            </div>
            <div class="mt-12 shadow-lg border rounded-lg overflow-x-auto">
                <table class="w-full table-auto text-sm text-left" id="paymentTable">
                    <thead class="bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-semibold">
                    <tr>

                        <th class="py-3 px-6">Flow Type</th>
                        <th class="py-3 px-6">Amount</th>
                        <th class="py-3 px-6">description</th>
                        <th class="py-3 px-6">Date Transaction</th>
                    </tr>
                    </thead>
                    <tbody class="text-gray-800 divide-y divide-gray-200" id="paymentTableBody">
                    <!-- Boucle sur chaque syndic -->
                    <% List<PaymentFlow> paymentsflow = (List<PaymentFlow>) session.getAttribute("paymentsflow"); %>
                    <% if ( paymentsflow != null && !paymentsflow.isEmpty())  { %>
                    <% for  (PaymentFlow pf : paymentsflow) { %>
                    <tr class="bg-white hover:bg-gray-100 transition duration-150">

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
                    <img src="image/logo.jpg" alt="Oluwadare Taye Ayo">
                </div>
            </div>
        </div>
        <!---------ANALYSE DES SYNDICS --------->
        <div class="sales-analytics">
            <h2>Syndic Analysis</h2>

            <!-----NOUVEAUX SYNDICS ENREGISTRÉS----->
            <div class="item online">
                <i class='bx bx-user'></i>
                <div class="right">
                    <div class="info">
                        <h3>Monitor Payment Flow</h3>
                        <a href="paymentflow.jsp"><small class="text-muted">Follow-up</small></a>
                    </div>
                    <h5 class="success">+10%</h5>
                    <h3>234</h3>
                </div>
            </div>

            <!-----SYNDICS ACTIFS----->
            <div class="item offline">
                <i class='bx bx-wallet'></i>
                <div class="right">
                    <div class="info">
                        <h3>Residence Account Balance</h3>
                        <small class="text-muted"><%=solde%></small>
                    </div>
                    <h5 class="danger">-17%</h5>
                </div>
            </div>

            <!-----NOUVELLES DEMANDES D'ADHÉSION----->
            <div class="item customers">
                <i class='bx bx-user-check'></i>
                <div class="right">
                    <div class="info">
                        <h3>Number of Residents in <%= Res %></h3>
                        <small class="text-muted"><%=memberCount%></small>
                    </div>
                    <h5 class="success"></h5>
                    <h3></h3>
                </div>
            </div>
            <!----------AJOUTER UN NOUVEAU SYNDIC------->
            <div class="item add-product">
                <div>
                    <i class="bx-add"></i>
                    <a href="meeting"><h3>Organize a General Assembly</h3></a>      </div>
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
        var flowType = document.getElementById('filterId').value;
        var startDate = document.getElementById('filterStartDate').value;
        var endDate = document.getElementById('filterEndDate').value;

        var rows = document.querySelectorAll('#paymentTable tbody tr');
        rows.forEach(function (row) {
            var flowtypeCell = row.querySelector('td:nth-child(1)').textContent;
            var dateCell = row.querySelector('td:nth-child(4)').textContent;

            var showRow = true;

            if (flowType && flowtypeCell !== flowType) {
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
        var flowType = document.getElementById('filterId').value;
        var startDate = document.getElementById('filterStartDate').value;
        var endDate = document.getElementById('filterEndDate').value;

        // Construire l'URL avec les paramètres de filtrage
        var url = "paymentflowPrint.jsp?";
        var params = [];

        if (flowType) {
            params.push("flowType=" + encodeURIComponent(flowType));
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
</script>


</body>
</html>
