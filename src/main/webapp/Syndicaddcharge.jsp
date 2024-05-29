<%@ page import="java.util.List" %>
<%@ page import="com.syndic.beans.Charge" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Charge</title>
    <link rel="shortcut icon" href="/Assets/images/logo.png" type="image/x-icon">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="css/style.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
<div class="container">
    <jsp:include page="templates/syndic_sidenav.jsp" />
        <main>

            <div class="flex justify-between items-center p-6 bg-blue-300 shadow-md border rounded-md">
                <h1 class="text-3xl font-bold text-gray-800">Add Charge</h1>
                <div class="text-lg text-gray-600"><%=java.time.LocalDate.now()%></div>
            </div>
            <div>
                <div class="recent-updates"></div>
            </div>
            <br><br><br><br><br><br>
            <div class="max-w-screen-xl mx-auto px-4 md:px-6">
                <div class="items-start justify-between md:flex">
                    <div class="mt-3 md:mt-0 flex gap-4">
                        <button id="addChargeBtn"
                                class="inline-block px-4 py-2 text-white duration-150 font-medium bg-indigo-600 rounded-lg hover:bg-indigo-500 active:bg-indigo-700 md:text-sm btn">
                            Add Charge
                        </button>
                        <input type="number" id="filterMemberId" placeholder="Filter by Member ID" class="px-4 py-2 border rounded-md">
                        <button id="filterChargesBtn" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-blue-600 rounded-lg hover:bg-blue-500 active:bg-blue-700 md:text-sm btn">
                            Filter Charges
                        </button>
                        <button id="printInvoiceBtn" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-green-600 rounded-lg hover:bg-green-500 active:bg-green-700 md:text-sm btn">
                            Print Invoice
                        </button>
                    </div>
                </div>

                <div class="mt-12 shadow-lg border rounded-lg overflow-x-auto">
                    <table class="min-w-full bg-white rounded-lg shadow-md" id="chargeTable">
                        <thead class="bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-semibold">
                        <tr>
                            <th class="py-3 px-6 uppercase tracking-wider">Charge Name</th>
                            <th class="py-3 px-6 uppercase tracking-wider">Charge Description</th>
                            <th class="py-3 px-6 uppercase tracking-wider">Charge Amount</th>
                            <th class="py-3 px-6 uppercase tracking-wider">Frequency</th>
                            <th class="py-3 px-6 uppercase tracking-wider">Category</th>
                            <th class="py-3 px-6 uppercase tracking-wider">Date</th>
                            <th class="py-3 px-6 uppercase tracking-wider">Actions</th>
                        </tr>
                        </thead>
                        <tbody class="text-gray-800 divide-y divide-gray-200" id="chargeTableBody">
                        <% List<Charge> charges = (List<Charge>) request.getAttribute("charges"); %>
                        <% if (charges != null && !charges.isEmpty()) { %>
                        <% for (Charge charge : charges) { %>
                        <tr class="bg-white hover:bg-gray-100 transition duration-150">
                            <td class="px-6 py-4 whitespace-nowrap"><%= charge.getChargeName() %></td>
                            <td class="px-6 py-4 whitespace-nowrap"><%= charge.getChargeDescription() %></td>
                            <td class="px-6 py-4 whitespace-nowrap"><%= charge.getChargeAmount() %></td>
                            <td class="px-6 py-4 whitespace-nowrap"><%= charge.getChargeFrequency() %></td>
                            <td class="px-6 py-4 whitespace-nowrap"><%= charge.getChargeCategory() %></td>
                            <td class="px-6 py-4 whitespace-nowrap"><%= charge.getChargeDate() %></td>
                            <td class="text-right px-4 whitespace-nowrap">
                                <button class="editChargeBtn py-2 px-3 font-medium text-indigo-600 hover:text-indigo-500 transition duration-150 hover:bg-gray-50 rounded-lg"
                                        data-name="<%= charge.getChargeName() %>"
                                        data-description="<%= charge.getChargeDescription() %>"
                                        data-amount="<%= charge.getChargeAmount() %>"
                                        data-frequency="<%= charge.getChargeFrequency() %>"
                                        data-category="<%= charge.getChargeCategory() %>"
                                        data-date="<%= charge.getChargeDate() %>">
                                    Edit
                                </button>
                                <form action="Syndicaddcharge" method="post" class="inline">
                                    <input type="hidden" name="code" value="<%= charge.getChargeName() %>">
                                    <input type="hidden" name="action" value="delete">
                                    <button type="submit" class="deleteChargeBtn py-2 leading-none px-3 font-medium text-red-600 hover:text-red-500 transition duration-150 hover:bg-gray-50 rounded-lg">
                                        Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                        <% } else { %>
                        <tr>
                            <td colspan="7" class="px-6 py-4 text-center text-gray-500">No charges available at the moment.</td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>


                <div id="ChargeForm" class="form hidden mt-6 p-6 bg-blue-200 shadow-lg rounded-lg">
                    <form id="chargeFormElement" class="grid grid-cols-1 gap-6 md:grid-cols-2" action="Syndicaddcharge" method="post">
                        <input type="hidden" id="action" name="action" value="add">
                        <input type="hidden" id="edit_charge_id" name="edit_charge_id" value="">

                        <div class="col-span-1">
                            <label for="chargeName" class="block text-sm font-medium text-gray-700">Charge Name:</label>
                            <input type="text" id="chargeName" name="chargeName" required class="mt-1 p-2 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                        </div>
                        <div class="col-span-1">
                            <label for="chargeDescription" class="block text-sm font-medium text-gray-700">Charge Description:</label>
                            <input type="text" id="chargeDescription" name="chargeDescription" required class="mt-1 p-2 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                        </div>
                        <div class="col-span-1">
                            <label for="chargeAmount" class="block text-sm font-medium text-gray-700">Charge Amount:</label>
                            <input type="text" id="chargeAmount" name="chargeAmount" required class="mt-1 p-2 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                        </div>
                        <div class="col-span-1">
                            <label for="chargeFrequency" class="block text-sm font-medium text-gray-700">Charge Frequency:</label>
                            <input type="text" id="chargeFrequency" name="chargeFrequency" required class="mt-1 p-2 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                        </div>
                        <div class="col-span-1">
                            <label for="chargeCategory" class="block text-sm font-medium text-gray-700">Charge Category:</label>
                            <input type="text" id="chargeCategory" name="chargeCategory" required class="mt-1 p-2 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                        </div>
                        <div class="col-span-1">
                            <label for="chargeDate" class="block text-sm font-medium text-gray-700">Date:</label>
                            <input type="date" id="chargeDate" name="chargeDate" class="mt-1 p-2 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
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
                !----------AJOUTER UN NOUVEAU SYNDIC------->
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
    var addChargeBtn = document.getElementById('addChargeBtn');
    var chargeForm = document.getElementById('ChargeForm');
    var chargeTable = document.getElementById('chargeTable');
    var chargeFormElement = document.getElementById('chargeFormElement');
    var actionInput = document.getElementById('action');
    var editCodeInput = document.getElementById('edit_charge_id');

    // Event listener for Add Charge button
    addChargeBtn.addEventListener('click', function () {
        chargeForm.classList.remove('hidden');
        chargeTable.classList.add('hidden');
        actionInput.value = "add";
        chargeFormElement.reset();
    });

    // Event listeners for Edit buttons
    document.querySelectorAll('.editChargeBtn').forEach(button => {
        button.addEventListener('click', function () {
            chargeForm.classList.remove('hidden');
            chargeTable.classList.add('hidden');
            actionInput.value = "edit";
            editCodeInput.value = button.getAttribute('data-name');
            document.getElementById('chargeName').value = button.getAttribute('data-name');
            document.getElementById('chargeDescription').value = button.getAttribute('data-description');
            document.getElementById('chargeAmount').value = button.getAttribute('data-amount');
            document.getElementById('chargeFrequency').value = button.getAttribute('data-frequency');
            document.getElementById('chargeCategory').value = button.getAttribute('data-category');
            document.getElementById('chargeDate').value = button.getAttribute('data-date');
        });
    });

    // Event listener for Filter button
    document.getElementById('filterChargesBtn').addEventListener('click', function () {
        var memberId = document.getElementById('filterMemberId').value;

        // Fetch all rows in the table
        var rows = document.querySelectorAll('#chargeTable tbody tr');
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
        var status = actionInput.value;

        // Construire l'URL avec les paramètres de filtrage
        var url = "chargePrint.jsp?status=" + status;
        // Ouvrir la page dans une nouvelle fenêtre
        window.open(url, '_blank');
    });
</script>

</body>
</html>
