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

        <div class="flex justify-between items-center p-6 bg-purple-300 shadow-md border rounded-md">
            <h1 class="text-3xl font-bold text-gray-800">Registred Syndics </h1>
            <div class="text-lg text-gray-600"><%=java.time.LocalDate.now()%></div>
        </div>
        <br><br><br>
        <div class="max-w-screen-xl mx-auto px-4 md:px-6">
            <h3 class="text-light-800 text-xl font-bold sm:text-2xl m-4">Liste des Syndics</h3>

            <div class="grid grid-cols-1 sm:grid-cols-1 md:grid-cols-1 lg:grid-cols-1 gap-6">
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
                            <!-- Adresse complète -->
                            <div class="flex items-center mb-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0L18 9.586V18a1 1 0 01-1 1h-4a1 1 0 01-1-1v-4H8v4a1 1 0 01-1 1H3a1 1 0 01-1-1V9.586l6.293-6.293a1 1 0 011.414 0zM10 4.414L4 10.414V17h2v-4a1 1 0 011-1h6a1 1 0 011 1v4h2v-6.586l-6-6z" clip-rule="evenodd"/>
                                </svg>
                                <p class="text-gray-600 text-sm">
                                    <span class="variable-title"><strong> Syndic Address:</strong></span>
                                    <span class="ml-10 bg-blue-200 rounded-lg shadow-md p-1"><%= syndic.getFulladdress() %></span>
                                </p>

                            </div>
                            <br>

                            <!-- Numéro de téléphone -->
                            <div class="flex items-center mb-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M2 3a2 2 0 012-2h12a2 2 0 012 2v14a2 2 0 01-2 2H4a2 2 0 01-2-2V3zm13 4a1 1 0 100-2h-8a1 1 0 100 2h8zm0 2a1 1 0 100-2h-8a1 1 0 100 2h8zm-3 2a1 1 0 100-2h-5a1 1 0 100 2h5zm0 2a1 1 0 100-2h-5a1 1 0 100 2h5z" clip-rule="evenodd"/>
                                </svg>
                                <p class="text-gray-600 text-sm">
                                    <span class="variable-title"><strong>Syndic Number:</strong></span>
                                    <span class="ml-10 bg-blue-200 rounded-lg shadow-md px-10 py-1"><%= syndic.getPhoneNumber() %></span>
                                </p>

                            </div>
                            <br>
                            <!-- Adresse email -->
                            <div class="flex items-center mb-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                                    <path d="M2.003 5.884L10 10.882l7.997-4.998a1 1 0 00-1-1.732L10 8.618 3.003 4.152a1 1 0 10-1 1.732zM3 8v6a2 2 0 002 2h10a2 2 0 002-2V8a1 1 0 112 0v6a4 4 0 01-4 4H5a4 4 0 01-4-4V8a1 1 0 112 0z"/>
                                </svg>
                                <p class="text-gray-600 text-sm">
                                    <span class="variable-title"><strong>Syndic Mail:</strong></span>
                                    <span class="ml-16 bg-blue-200 rounded-lg shadow-md px-10 py-1"><%= syndic.getMail() %></span>
                                </p>

                            </div>
                            <br>

                            <!-- Compte -->
                            <div class="flex items-center mb-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M3.5 3a1.5 1.5 0 00-1.5 1.5v11a1.5 1.5 0 001.5 1.5h13a1.5 1.5 0 001.5-1.5v-11A1.5 1.5 0 0016.5 3h-13zm2.5 9a1 1 0 011-1h8a1 1 0 110 2h-8a1 1 0 01-1-1zm1-4a1 1 0 100-2h-1a1 1 0 100 2h1z" clip-rule="evenodd"/>
                                </svg>
                                <p class="text-gray-600 text-sm">
                                    <span class="variable-title"><strong>Account:</strong></span>
                                    <span class="ml-20 bg-green-200 rounded-lg shadow-md px-10 py-1"> <%= syndic.getAccount() %> DH</span>
                                </p>

                            </div>


                            <br><br><br>
                            <!-- Nom de la résidence -->
                            <div class="flex items-center mb-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                                    <path d="M3 4a1 1 0 100 2h14a1 1 0 100-2H3zm0 4a1 1 0 000 2h14a1 1 0 100-2H3zm0 4a1 1 0 000 2h14a1 1 0 100-2H3zm0 4a1 1 0 000 2h14a1 1 0 100-2H3z"/>
                                </svg>
                                <p class="text-gray-600 text-sm">
                                    <span class="variable-title"><strong>ResidenceName:</strong></span>
                                    <span class="ml-14 bg-yellow-200 rounded-lg shadow-md px-10 py-1"><%= syndic.getResidenceName() %></span>
                                </p>

                            </div>
                            <!-- Adresse de la résidence -->
                            <div class="flex items-center mb-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0L18 9.586V18a1 1 0 01-1 1h-4a1 1 0 01-1-1v-4H8v4a1 1 0 01-1 1H3a1 1 0 01-1-1V9.586l6.293-6.293a1 1 0 011.414 0zM10 4.414L4 10.414V17h2v-4a1 1 0 011-1h6a1 1 0 011 1v4h2v-6.586l-6-6z" clip-rule="evenodd"/>
                                </svg>
                                <p class="text-gray-600 text-sm">
                                    <span class="variable-title"><strong>Residence Address:</strong></span>
                                    <span class="ml-10 bg-yellow-200 rounded-lg shadow-md px-10 py-1"><%= syndic.getResidenceAddress() %></span>
                                </p>

                            </div>
                            <!-- Type de la résidence -->
                            <div class="flex items-center mb-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                                    <path d="M8.25 3a1 1 0 00-.97.757l-.73 2.924H3.5a1 1 0 100 2h2.609l.547 2.185-2.5 1.673a1 1 0 00.68 1.846h3.64a1 1 0 00.68-.275l2.446-2.446 2.446 2.446a1 1 0 00.68.275h3.64a1 1 0 00.68-1.846l-2.5-1.673.547-2.185H16.5a1 1 0 100-2h-2.049l-.73-2.924A1 1 0 0012.75 3h-4.5zM8.25 5h3.5l.547 2.185h-4.594L8.25 5z"/>
                                </svg>
                                <p class="text-gray-600 text-sm">
                                    <span class="variable-title"><strong>Residence Type:</strong></span>
                                    <span class="ml-16 bg-yellow-200 rounded-lg shadow-md px-10 py-1"><%= syndic.getResidenceType() %></span>
                                </p>
                            </div>
                            <!-- Taille de la résidence -->
                            <div class="flex items-center mb-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                                    <path d="M3.75 3A1.75 1.75 0 002 4.75v10.5C2 16.216 3.784 18 5.75 18h8.5c1.966 0 3.75-1.784 3.75-3.75V4.75A1.75 1.75 0 0014.25 3h-10.5zM3.5 4.75c0-.138.112-.25.25-.25h10.5a.25.25 0 01.25.25v10.5c0 .966-.784 1.75-1.75 1.75h-8.5a1.75 1.75 0 01-1.75-1.75V4.75z"/>
                                </svg>
                                <p class="text-gray-600 text-sm">
                                    <span class="variable-title"><strong>Residence Size:</strong></span>
                                    <span class="ml-16 bg-yellow-200 rounded-lg shadow-md px-10 py-1"><%= syndic.getResidenceSize() %> m²</span>
                                </p>
                            </div>
                            <!-- Nombre d'appartements -->
                            <div class="flex items-center mb-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                                    <path d="M6 2a2 2 0 00-2 2v12a2 2 0 002 2h8a2 2 0 002-2V4a2 2 0 00-2-2H6zM5 4a1 1 0 011-1h8a1 1 0 011 1v1H5V4zm0 3h10v9a1 1 0 01-1 1H6a1 1 0 01-1-1V7z"/>
                                </svg>
                                <p class="text-gray-600 text-sm">
                                    <span class="variable-title"><strong>Appartment Count:</strong></span>
                                    <span class="ml-10 bg-yellow-200 rounded-lg shadow-md px-10 py-1"><%= syndic.getApartmentCount() %></span>
                                </p>
                            </div>
                            <!-- Nombre de villas -->
                            <div class="flex items-center mb-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                                    <path d="M10 3a1 1 0 011 1v1h2.5A1.5 1.5 0 0115 6.5V9a1 1 0 102 0V6.5A3.5 3.5 0 0013.5 3H11V2a1 1 0 10-2 0v1H6.5A3.5 3.5 0 003 6.5V9a1 1 0 102 0V6.5A1.5 1.5 0 016.5 5H9v1a1 1 0 102 0V4a1 1 0 011-1z"/>
                                    <path d="M4.293 12.293a1 1 0 011.414 0L10 16.586l4.293-4.293a1 1 0 111.414 1.414l-5 5a1 1 0 01-1.414 0l-5-5a1 1 0 010-1.414z"/>
                                </svg>
                                <p class="text-gray-600 text-sm">
                                    <span class="variable-title"><strong>Villas Count:</strong></span>
                                    <span class="ml-20 bg-yellow-200 rounded-lg shadow-md px-10 py-1"><%= syndic.getVillaCount() %></span>
                                </p>
                            </div>
                            <!-- Nombre de jardins -->
                            <div class="flex items-center mb-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                                    <path d="M10.707 8.293a1 1 0 00-1.414 0L7 10.586V3a1 1 0 10-2 0v7.586L2.707 8.293a1 1 0 00-1.414 1.414l4 4a1 1 0 001.414 0l4-4a1 1 0 000-1.414zM17.707 8.293a1 1 0 00-1.414 0L14 10.586V3a1 1 0 10-2 0v7.586l-2.293-2.293a1 1 0 00-1.414 1.414l4 4a1 1 0 001.414 0l4-4a1 1 0 000-1.414z"/>
                                </svg>
                                <p class="text-gray-600 text-sm">
                                    <span class="variable-title"><strong>Gardens Count:</strong></span>
                                    <span class="ml-16 bg-yellow-200 rounded-lg shadow-md px-10 py-1"> <%= syndic.getGardenCount() %></span>
                                </p>
                            </div>
                            <!-- Nombre de piscines -->
                            <div class="flex items-center mb-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M7.5 3a.75.75 0 01.75-.75h3.5a.75.75 0 010 1.5h-3.5A.75.75 0 017.5 3zm0 2.25A.75.75 0 018.25 4.5h3.5a.75.75 0 010 1.5h-3.5a.75.75 0 01-.75-.75zm1.5 2.25a.75.75 0 00-1.5 0v1.236c0 .321-.162.619-.431.772a3.272 3.272 0 00-1.036.949c-.263.35-.507.68-.76.944-.476.485-.994.789-1.523.791a1.711 1.711 0 01-.787-.184.75.75 0 10-.716 1.311 3.211 3.211 0 001.503.351c.916 0 1.656-.466 2.184-1.002.283-.289.554-.631.821-1.004a1.946 1.946 0 01.29-.334v1.316a.75.75 0 001.5 0v-2.25c0-.053 0-.105-.003-.157a.73.73 0 00-.057-.29c-.023-.044-.07-.13-.157-.217a1.372 1.372 0 00-.193-.163c-.08-.062-.19-.127-.335-.195-.298-.136-.722-.268-1.231-.268H7.5a.75.75 0 00-.75.75v.063a.646.646 0 01-.154.378 1.272 1.272 0 00-.218.358 1.372 1.372 0 01-.161.19c-.078.078-.183.143-.326.204-.286.123-.717.254-1.225.254-.51 0-.935-.135-1.236-.27-.153-.068-.264-.132-.345-.195a1.371 1.371 0 01-.192-.163c-.088-.087-.134-.173-.157-.217a.727.727 0 00-.057-.29c-.003-.052-.003-.104-.003-.157v-1.5a.75.75 0 00-1.5 0v.75c0 .397.161.782.447 1.069.289.29.675.45 1.069.45h.075a2.571 2.571 0 001.141-.356 5.648 5.648 0 001.02-.801 1.738 1.738 0 00.484-.723.75.75 0 00.152-.455v-.063a.75.75 0 00-.75-.75h-.075a.75.75 0 00-.75.75v.063a.647.647 0 01-.154.378 1.272 1.272 0 00-.218.358 1.372 1.372 0 01-.161.19c-.078.078-.183.143-.326.204-.286.123-.717.254-1.225.254-.51 0-.935-.135-1.236-.27-.153-.068-.264-.132-.345-.195a1.371 1.371 0 01-.192-.163c-.088-.087-.134-.173-.157-.217a.727.727 0 00-.057-.29c-.003-.052-.003-.104-.003-.157v-.75a.75.75 0 00-1.5 0v1.236c0 .395.158.77.441 1.052.283.282.658.441 1.052.441h.075a2.571 2.571 0 001.141-.356 5.648 5.648 0 001.02-.801c.2-.233.371-.514.484-.723.094-.18.151-.37.151-.455v-.063a.75.75 0 00-.75-.75h-.075a.75.75 0 00-.75.75v.063c0 .116.037.237.102.336a1.236 1.236 0 00.218.358 1.37 1.37 0 01.161.19c.078.078.183.143.326.204.286.123.717.254 1.225.254.51 0 .935-.135 1.236-.27.153-.068.264-.132.345-.195a1.371 1.371 0 01.192-.163c.088-.087.134-.173.157-.217a.727.727 0 00.057-.29c.003-.052.003-.104.003-.157V5.5a.75.75 0 00-.75-.75h-4a.75.75 0 01-.75-.75v-1a.75.75 0 00-.75-.75h-2.25z" clip-rule="evenodd"/>
                                </svg>
                                <p class="text-gray-600 text-sm">
                                    <span class="variable-title"><strong>Pools Count:</strong></span>
                                    <span class="ml-20 bg-yellow-200 rounded-lg shadow-md px-10 py-1">    <%= syndic.getPoolCount() %></span>
                                </p>
                            </div>
                            <!-- Nombre de parkings -->
                            <div class="flex items-center mb-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                                    <path d="M10 2a8 8 0 100 16 8 8 0 000-16zM8.5 5a1.5 1.5 0 013 0v5.5a1.5 1.5 0 01-3 0V5zm4.5 0a1.5 1.5 0 011.5 1.5v6a1.5 1.5 0 01-3 0v-6A1.5 1.5 0 0113 5z"/>
                                </svg>
                                <p class="text-gray-600 text-sm">
                                    <span class="variable-title"><strong>Parkings Count:</strong></span>
                                    <span class="ml-20 bg-yellow-200 rounded-lg shadow-md px-10 py-1"> <%= syndic.getParkingCount() %></span>
                                </p>
                            </div>


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


