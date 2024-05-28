<%@ page import="java.util.List" %>
<%@ page import="com.syndic.beans.Supplier" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DASHBOARD</title>
    <link rel="shortcut icon" href="/Assets/images/logo.png" type="image/x-icon">
    <!---BOX ICON CDN-->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <!----STYLESHEET---->
    <link rel="stylesheet" href="css/style.css">
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body>
<div class="container">
    <jsp:include page="templates/syndic_sidenav.jsp" />

    <!------------MIDDLE ------------>
    <main>
        <div class="right">
            <!--------TOP-->
            <!-------END OF TOP------>

            <!---------RECENT UPDATES------>
            <div class="recent-updates"></div>
            <!-------END OF RECENT UPDATES---->

        </div>
        <!---------END OF RIGHT------->
        <br><br><br><br><br><br>
        <div class="max-w-screen-xl mx-auto px-4 md:px-6">
            <div class="items-start justify-between md:flex">
                <div class="max-w-lg">
                    <h3 class="text-light-800 text-xl font-bold sm:text-2xl">Suppliers</h3>
                </div>
                <div class="mt-3 md:mt-0">
                    <button id="addSupplierBtn" class="inline-block px-4 py-2 text-white duration-150 font-medium bg-indigo-600 rounded-lg hover:bg-indigo-500 active:bg-indigo-700 md:text-sm btn">Add Supplier</button>
                </div>
            </div>
            <div class="mt-12 shadow-sm border rounded-lg overflow-x-auto">
                <table class="w-full table-auto text-sm text-left" id="supplierTable">
                    <!-- Table headers -->
                    <thead class="bg-gray-50 text-gray-600 font-medium border-b">
                    <tr>
                        <th class="py-3 px-6">Name</th>
                        <th class="py-3 px-6">Email</th>
                        <th class="py-3 px-6">Phone</th>
                        <th class="py-3 px-6">Type</th>
                        <th class="py-3 px-6">Active</th>
                        <th class="py-3 px-6">Rating</th>

                        <th class="py-3 px-6">Actions</th>
                    </tr>
                    </thead>
                    <!-- Table body -->
                    <tbody class="text-gray-600 divide-y">
                    <% List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers"); %>
                    <% if (suppliers != null && !suppliers.isEmpty()) { %>
                    <% for (Supplier supplier : suppliers) { %>
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap"><%= supplier.getSupplier_name() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= supplier.getSupplier_email() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= supplier.getSupplier_phone() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= supplier.getSupplier_type() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= supplier.isSupplier_active() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= supplier.getSupplier_rating() %></td>
                        <td class="text-right px-4 whitespace-nowrap">
                            <!-- Edit Supplier -->
                            <button type="button" class="editSupplierBtn py-2 px-3 font-medium text-indigo-600 hover:text-indigo-500 duration-150 hover:bg-gray-50 rounded-lg"
                                    data-supplier_name="<%= supplier.getSupplier_name() %>"
                                    data-supplier_email="<%= supplier.getSupplier_email() %>"
                                    data-supplier_phone="<%= supplier.getSupplier_phone() %>"
                                    data-supplier_type="<%= supplier.getSupplier_type() %>"
                                    data-supplier_active="<%= supplier.isSupplier_active() %>"
                                    data-supplier_rating="<%= supplier.getSupplier_rating() %>">
                                Edit
                            </button>
                            <!-- Delete Supplier -->
                            <form action="addsupplier" method="post" class="inline">
                                <input type="hidden" name="supplier_s_id" value="<%= supplier.getSupplier_s_id() %>">
                                <input type="hidden" name="action" value="delete">
                                <button type="submit" class="deleteSupplierBtn py-2 leading-none px-3 font-medium text-red-600 hover:text-red-500 duration-150 hover:bg-gray-50 rounded-lg">
                                    Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                    <% } else { %>
                    <tr>
                        <td colspan="8" class="px-6 py-4">No suppliers available at the moment.</td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <!-- Formulaire d'ajout et de modification -->
            <div id="SupplierForm" class="form hidden mt-6">
                <form id="supplierFormElement" class="grid grid-cols-2 gap-6" action="addsupplier" method="post">
                    <input type="hidden" id="action" name="action" value="add">

                    <div class="col-span-1">
                        <label for="supplier_name" class="block text-sm font-medium text-light-700">Name:</label>
                        <input type="text" id="supplier_name" name="supplier_name" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                    </div>
                    <div class="col-span-1">
                        <label for="supplier_email" class="block text-sm font-medium text-light-700">Email:</label>
                        <input type="email" id="supplier_email" name="supplier_email" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                    </div>
                    <div class="col-span-1">
                        <label for="supplier_phone" class="block text-sm font-medium text-light-700">Phone:</label>
                        <input type="text" id="supplier_phone" name="supplier_phone" required class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                    </div>
                    <div class="col-span-1">
                        <label for="supplier_type" class="block text-sm font-medium text-light-700">Type:</label>
                        <select id="supplier_type" name="supplier_type" required class="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                            <option value="service">Service</option>
                        </select>
                    </div>
                    <div class="col-span-1">
                        <label for="supplier_active" class="block text-sm font-medium text-light-700">Active:</label>
                        <select id="supplier_active" name="supplier_active" required class="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                            <option value="true">Yes</option>
                            <option value="false">No</option>
                        </select>
                    </div>
                    <div class="col-span-1">
                        <label for="supplier_rating" class="block text-sm font-medium text-light-700">Rating:</label>
                        <select id="supplier_rating" name="supplier_rating" required class="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                            <option value="excellent">Excellent</option>
                            <option value="good">Good</option>
                            <option value="average">Average</option>
                            <option value="poor">Poor</option>
                        </select>
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

</body>
<script src="javascript/main.js"></script>
<script>
    var addSupplierBtn = document.getElementById('addSupplierBtn');
    var SupplierForm = document.getElementById('SupplierForm');
    var supplierTable = document.getElementById('supplierTable');
    var supplierFormElement = document.getElementById('supplierFormElement');
    var actionInput = document.getElementById('action');

    addSupplierBtn.addEventListener('click', function () {
        SupplierForm.classList.remove('hidden');
        supplierTable.classList.add('hidden');
        actionInput.value = 'add';
        supplierFormElement.action = 'addsupplier';
    });

    document.querySelectorAll('.editSupplierBtn').forEach(function (button) {
        button.addEventListener('click', function (event) {
            event.preventDefault();
            SupplierForm.classList.remove('hidden');
            supplierTable.classList.add('hidden');
            actionInput.value = 'update';
            supplierFormElement.action = 'addsupplier';

            supplierFormElement.supplier_name.value = button.dataset.supplier_name;
            supplierFormElement.supplier_email.value = button.dataset.supplier_email;
            supplierFormElement.supplier_phone.value = button.dataset.supplier_phone;
            supplierFormElement.supplier_type.value = button.dataset.supplier_type;
            supplierFormElement.supplier_active.value = button.dataset.supplier_active;
            supplierFormElement.supplier_rating.value = button.dataset.supplier_rating;
        });
    });
</script>
</html>
