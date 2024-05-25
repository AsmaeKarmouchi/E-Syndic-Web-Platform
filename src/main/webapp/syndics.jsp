<%@ page import="com.syndic.beans.Syndic" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
    <jsp:include page="templates/admin_sidenav.jsp" />

    <!------------MIDDLE ------------>
    <main>
        <div class="max-w-screen-xl mx-auto px-4 md:px-6">
            <h3 class="text-light-800 text-xl font-bold sm:text-2xl m-4">Liste des Syndics</h3>

            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-2 lg:grid-cols-2 gap-6">
                <!-- Boucle sur chaque syndic -->
                <% if (session.getAttribute("List_syndics") != null) {
                    List<Syndic> syndicsList = (List<Syndic>) session.getAttribute("List_syndics");
                    for (Syndic syndic : syndicsList) { %>
                <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                    <div class="px-6 py-4">
                        <div class="flex items-center justify-between" onclick="toggleDetails(this)">
                            <div class="font-bold text-xl mb-2" ><%= syndic.getFirstName() %> <%= syndic.getLastName() %></div>
                            <!-- Placer le bouton toggle hidden ici -->
                            <button class="toggleDetailsBtn text-gray-600 focus:outline-none"  >
                                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </button>


                        </div>
                        <!-- Contenu caché -->
                        <div class="hidden bg-gray-100 shadow-md rounded-lg p-4 mb-4">
                            <p class="text-gray-600 text-sm mb-2"><%= syndic.getFulladdress() %></p>
                            <p class="text-gray-600 text-sm mb-2"><%= syndic.getResidenceName() %></p>
                            <p class="text-gray-600 text-sm mb-2"><%= syndic.getPhoneNumber() %></p>
                            <p class="text-gray-600 text-sm mb-2"><%= syndic.getMail() %></p>
                        </div>
                    </div>
                    <div class="px-6 py-4">
                        <!-- Boutons d'action -->
                        <button class="editSyndicBtn py-2 px-3 font-medium text-indigo-600 hover:text-indigo-500 duration-150 hover:bg-gray-50 rounded-lg"
                                data-id="<%= syndic.getId() %>"
                                data-firstname="<%= syndic.getFirstName() %>"
                                data-lastname="<%= syndic.getLastName() %>"
                                data-address="<%= syndic.getFulladdress() %>"
                                data-postalcode="<%= syndic.getResidenceName() %>"
                                data-phonenumber="<%= syndic.getPhoneNumber() %>"
                                data-email="<%= syndic.getMail() %>">
                            Edit
                        </button>
                        <form action="deletesyndic" method="post" class="inline">
                            <input type="hidden" name="id" value="<%= syndic.getId() %>">
                            <button type="submit" class="deleteSyndicBtn py-2 leading-none px-3 font-medium text-red-600 hover:text-red-500 duration-150 hover:bg-gray-50 rounded-lg">
                                Delete
                            </button>
                        </form>
                    </div>
                </div>

                <% }
                } else { %>
                <div class="col-span-full">Aucun syndic trouvé.</div>
                <% } %>
            </div>
        </div>
    </main>

    <!-------------END OF MIDDLE --------->


    <!---------RIGHT--------->
    <div class="right">

        <!--------TOP-->
        <div class="top">
            <!---MENU ICON-->
            <button id="menu-btn">
                <i class='bx bx-menu'></i>
            </button>

            <!------LIGHT AND DARK THEME BUTTONS-->
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
        <!-------END OF TOP------>

        <!---------RECENT UPDATES------>
        <div class="recent-updates">

        </div>
        <!-------END OF RECENT UPDATES---->
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
    <!---------END OF RIGHT------->

</div>


<script>

    function toggleDetails(element) {
        var details = element.nextElementSibling;
        details.classList.toggle("hidden");
    }

</script>
<script>
    document.getElementById("syndics").classList.add("active");
</script>
</body>

<script src="javascript/main.js"></script>
</html>


