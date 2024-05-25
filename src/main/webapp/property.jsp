<%@ page import="com.syndic.beans.Syndic" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.syndic.beans.Member" %>

<!DOCTYPE html>
<html>
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
    <link rel="stylesheet" href="https://demos.creative-tim.com/notus-js/assets/styles/tailwind.css">
    <link rel="stylesheet" href="https://demos.creative-tim.com/notus-js/assets/vendor/@fortawesome/fontawesome-free/css/all.min.css">
</head>

<body>
<div class="container">
    <div class="sidenav">
        <jsp:include page="templates/member_sidenav.jsp"/>
    </div>
    <main>

        <div class="main-content flex flex-col p-6">
            <div class="recent-updates w-full">
                <h1>Welcome <%= ((Member) session.getAttribute("member")).getFirstName() %>!</h1>
                <div class="form-container">

                        <!-- Member Information -->
                        <section class="py-1">
                            <div class="w-full px-4 mx-auto mt-6">
                                <div class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0">
                                    <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
                                        <div class="text-center flex justify-between">
                                            <h6 class="text-blueGray-700 text-xl font-bold m-4">
                                                Syndic Information
                                            </h6>
                                        </div>
                                        <div class="p-6">
                                            <h2 class="flex items-center justify-between text-xl font-semibold mb-4 cursor-pointer">
                                                <span><%= ((Syndic) session.getAttribute("syndic")).getFirstName() %> <%= ((Syndic) session.getAttribute("syndic")).getLastName()%> Syndic of <%= ((Syndic) session.getAttribute("syndic")).getResidenceName() %> Residence</span>

                                            </h2>
                                            <div class=" bg-gray-100 shadow-md rounded-lg p-4 mb-4">
                                                <div class="flex flex-wrap -mx-2">
                                                    <div class="w-full md:w-1/2 px-2 mb-4 md:mb-0">
                                                        <p class="text-gray-800"><strong>First Name:</strong> <%= ((Syndic) session.getAttribute("syndic")).getFirstName() %></p>
                                                        <p class="text-gray-800"><strong>Last Name:</strong> <%= ((Syndic) session.getAttribute("syndic")).getLastName()%></p>

                                                    </div>
                                                </div>
                                                <div class="w-full px-2 mt-4">
                                                    <strong class="text-gray-800 block mb-2">Address:</strong>
                                                    <div class="bg-white rounded-lg shadow-md p-4">
                                                        <%= ((Syndic) session.getAttribute("syndic")).getFulladdress() %>
                                                    </div>
                                                </div>

                                                <div class="w-full px-2 mt-4">
                                                    <strong class="text-gray-800 block mb-2">Postal Code:</strong>
                                                    <div class="bg-white rounded-lg shadow-md p-4">
                                                        <%= ((Syndic) session.getAttribute("syndic")).getCodepostal() %>
                                                    </div>
                                                </div>
                                                <div class="w-full px-2 mt-4">
                                                    <strong class="text-gray-800 block mb-2">Phone Number:</strong>
                                                    <div class="bg-white rounded-lg shadow-md p-4">
                                                        <%= ((Syndic) session.getAttribute("syndic")).getPhoneNumber() %>
                                                    </div>
                                                </div>
                                                <div class="w-full px-2 mt-4">
                                                    <strong class="text-gray-800 block mb-2">Email:</strong>
                                                    <div class="bg-white rounded-lg shadow-md p-4">
                                                        <%= ((Syndic) session.getAttribute("syndic")).getMail() %>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <!-- Property Information -->
                        <section class="py-1">
                            <div class="w-full px-4 mx-auto mt-6">
                                <div class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0">
                                    <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
                                        <div class="text-center flex justify-between">
                                            <h6 class="text-blueGray-700 text-xl font-bold m-4">
                                                Residence Information
                                            </h6>
                                        </div>
                                        <div class="p-6">
                                            <h2 class="flex items-center justify-between text-xl font-semibold mb-4 cursor-pointer">
                                                <span><%= ((Syndic) session.getAttribute("syndic")).getFirstName() %> <%= ((Syndic) session.getAttribute("syndic")).getLastName()%> Syndic of <%= ((Syndic) session.getAttribute("syndic")).getResidenceName() %> Residence</span>

                                            </h2>
                                            <div class=" bg-gray-100 shadow-md rounded-lg p-4 mb-4">
                                                <div class="w-full px-2 mt-4">
                                                    <strong class="text-gray-800 block mb-2">Residence Name:</strong>
                                                    <div class="bg-white rounded-lg shadow-md p-4">
                                                        <%= ((Syndic) session.getAttribute("syndic")).getResidenceName() %>
                                                    </div>
                                                </div>
                                                <div class="w-full px-2 mt-4">
                                                    <strong class="text-gray-800 block mb-2">Residence Address:</strong>
                                                    <div class="bg-white rounded-lg shadow-md p-4">
                                                        <%= ((Syndic) session.getAttribute("syndic")).getResidenceAddress() %>
                                                    </div>
                                                </div>
                                                <div class="w-full px-2 mt-4">
                                                    <strong class="text-gray-800 block mb-2">Residence Type:</strong>
                                                    <div class="bg-white rounded-lg shadow-md p-4">
                                                        <%= ((Syndic) session.getAttribute("syndic")).getResidenceType() %>
                                                    </div>
                                                </div>
                                                <div class="w-full px-2 mt-4">
                                                    <strong class="text-gray-800 block mb-2">Residence Size:</strong>
                                                    <div class="bg-white rounded-lg shadow-md p-4">
                                                        <%= ((Syndic) session.getAttribute("syndic")).getResidenceSize() %> sqm
                                                    </div>
                                                </div>
                                                <div class="w-full px-2 mt-4">
                                                    <strong class="text-gray-800 block mb-2">Apartment Count:</strong>
                                                    <div class="bg-white rounded-lg shadow-md p-4">
                                                        <%= ((Syndic) session.getAttribute("syndic")).getApartmentCount() %>
                                                    </div>
                                                </div>
                                                <div class="w-full px-2 mt-4">
                                                    <strong class="text-gray-800 block mb-2">Villa Count:</strong>
                                                    <div class="bg-white rounded-lg shadow-md p-4">
                                                        <%= ((Syndic) session.getAttribute("syndic")).getVillaCount() %>
                                                    </div>
                                                </div>
                                                <div class="w-full px-2 mt-4">
                                                    <strong class="text-gray-800 block mb-2">Garden Count:</strong>
                                                    <div class="bg-white rounded-lg shadow-md p-4">
                                                        <%= ((Syndic) session.getAttribute("syndic")).getGardenCount() %>
                                                    </div>
                                                </div>
                                                <div class="w-full px-2 mt-4">
                                                    <strong class="text-gray-800 block mb-2">Pool Count:</strong>
                                                    <div class="bg-white rounded-lg shadow-md p-4">
                                                        <%= ((Syndic) session.getAttribute("syndic")).getPoolCount() %>
                                                    </div>
                                                </div>
                                                <div class="w-full px-2 mt-4">
                                                    <strong class="text-gray-800 block mb-2">Parking Count:</strong>
                                                    <div class="bg-white rounded-lg shadow-md p-4">
                                                        <%= ((Syndic) session.getAttribute("syndic")).getParkingCount() %>
                                                    </div>
                                                </div>
                                                <div class="w-full px-2 mt-4">
                                                    <strong class="text-gray-800 block mb-2">Elevators Count:</strong>
                                                    <div class="bg-white rounded-lg shadow-md p-4">
                                                        <%= ((Syndic) session.getAttribute("syndic")).getElevatorsCount() %>
                                                    </div>
                                                </div>
                                                <div class="w-full px-2 mt-4">
                                                    <strong class="text-gray-800 block mb-2">Security System:</strong>
                                                    <div class="bg-white rounded-lg shadow-md p-4">
                                                        <%= ((Syndic) session.getAttribute("syndic")).isSecuritySystem() ? "Yes" : "No" %>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                </div>
            </div>
        </div>
        <!-------------END OF MIDDLE --------->
    </main>
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
                    <p>Hey, <b><%= ((Member) session.getAttribute("member")).getFirstName() %></b></p>
                    <small class="text-muted">Syndic</small>
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
    document.getElementById("property").classList.add("active");
</script>
<script src="javascript/main.js"></script>
</body>
</html>
