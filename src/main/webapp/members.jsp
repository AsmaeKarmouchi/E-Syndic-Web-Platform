<%@ page import="com.syndic.beans.Member" %>
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
            <h3 class="text-light-800 text-xl font-bold sm:text-2xl m-4">Liste des résidents</h3>


            <div class="mt-12 shadow-sm border rounded-lg overflow-x-auto">
                <table class="w-full table-auto text-sm text-left">
                    <thead class="bg-gray-50 text-gray-600 font-medium border-b">
                    <tr>
                        <th class="py-3 px-6">ID</th>
                        <th class="py-3 px-6">Prénom</th>
                        <th class="py-3 px-6">Nom</th>
                        <th class="py-3 px-6">code postal</th>
                        <th class="py-3 px-6">Téléphone</th>
                        <th class="py-3 px-6">Adresse</th>
                        <th class="py-3 px-6">Email</th>
                        <th class="py-3 px-6">Residence</th>
                    </tr>
                    </thead>
                    <tbody class="text-gray-600 divide-y" id="syndicsTableBody">
                    <%
                        if (session.getAttribute("list_members") != null) {
                            List<Member> membersList = (List<Member>) session.getAttribute("list_members");
                            for (Member member : membersList) {
                    %>
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap"><%= member.getId() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= member.getFirstName() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= member.getLastName() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= member.getFulladdress() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= member.getPhoneNumber() %></td>
                        <td class="px-6 py-4 whitespace-nowrap"><%= member.getMail() %></td>
                        <td class="text-right px-4 whitespace-nowrap">
                            <button class="editSyndicBtn py-2 px-3 font-medium text-indigo-600 hover:text-indigo-500 duration-150 hover:bg-gray-50 rounded-lg"
                                    data-id="<%= member.getId() %>"
                                    data-firstname="<%= member.getFirstName() %>"
                                    data-lastname="<%= member.getLastName() %>"
                                    data-address="<%= member.getFulladdress() %>"
                                    data-phonenumber="<%= member.getPhoneNumber() %>"
                                    data-email="<%= member.getMail() %>">
                            </button>
                            <form action="deletesyndic" method="post" class="inline">
                                <input type="hidden" name="id" value="<%= member.getId() %>">
                                <button type="submit" class="deleteSyndicBtn py-2 leading-none px-3 font-medium text-red-600 hover:text-red-500 duration-150 hover:bg-gray-50 rounded-lg">
                                    Delete
                                </button>

                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="8" class="px-6 py-4">Aucun member trouvé.</td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
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
                        <h3>NOUVEAUX member ENREGISTRÉS</h3>
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
                        <h3>members ACTIFS</h3>
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
                    <a href="#"><h3>Ajouter un Nouveau member</h3></a>
                </div>
            </div>

        </div>
        <!------FIN DE L'ANALYSE DES SYNDICS------->



    </div>
    <!---------END OF RIGHT------->

</div>
<script>
    function showDetails(id) {
        // Afficher les détails du syndic correspondant
        document.getElementById("details_" + id).style.display = "table-row";
    }

    function hideDetails(id) {
        // Masquer les détails du syndic correspondant
        document.getElementById("details_" + id).style.display = "none";
    }

    function deleteSyndic(id) {
        if (confirm("Êtes-vous sûr de vouloir supprimer ce syndic?")) {
            // Envoyer une requête pour supprimer le syndic avec l'ID correspondant
            window.location.href = "deleteSyndic.jsp?id=" + id;
        }
    }

    // Code pour afficher le nombre total de syndics
    var totalSyndics = <%= request.getAttribute("totalSyndics") %>;
    document.getElementById("totalMembers").innerHTML = "Nombre total de members : " + totalMembers;
</script>
<script>
    document.getElementById("members").classList.add("active");
</script>
</body>

<script src="javascript/main.js"></script>
</html>


