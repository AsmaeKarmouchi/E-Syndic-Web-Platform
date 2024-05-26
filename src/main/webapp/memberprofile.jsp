<%@ page import="com.syndic.beans.User" %>
<%@ page import="com.syndic.beans.Member" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>

<body>
<div class="container">
    <div class="sidenav">
        <jsp:include page="templates/member_sidenav.jsp"/>
    </div>
    <main>
        <% Member member = (Member) session.getAttribute("member"); %>

        <div class="main-content flex flex-col p-6">
            <div class="recent-updates w-full">
                <h1 class="text-3xl font-bold text-blue-600 mb-4">Welcome <%= member.getFirstName() %>!</h1>
                <div class="form-container">
                    <form action="memberprofile" method="post" class="w-full">
                        <!-- Syndic Information -->
                        <section class="py-1">
                            <div class="w-full px-4 mx-auto mt-6">
                                <div class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-gray-100 border-0">
                                    <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
                                        <div class="text-center flex justify-between">
                                            <h6 class="text-gray-700 text-xl font-bold m-4">
                                                <i class="fas fa-info-circle fa-2x mr-2"></i>Member Informations
                                            </h6>
                                        </div>
                                        <div class="flex flex-wrap">
                                            <!-- First Name -->
                                            <div class="w-full lg:w-6/12 px-4">
                                                <div class="relative w-full mb-3">
                                                    <label class="block uppercase text-gray-600 text-xs font-bold mb-2" for="firstname">
                                                        <i class="fas fa-user fa-2x mr-1"></i>First Name
                                                    </label>
                                                    <input type="text" id="firstname" name="firstname" class="border-0 px-3 py-3 placeholder-gray-300 text-gray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= member.getFirstName() %>">
                                                </div>
                                            </div>
                                            <!-- Last Name -->
                                            <div class="w-full lg:w-6/12 px-4">
                                                <div class="relative w-full mb-3">
                                                    <label class="block uppercase text-gray-600 text-xs font-bold mb-2" for="lastname">
                                                        <i class="fas fa-user fa-2x mr-1"></i>Last Name
                                                    </label>
                                                    <input type="text" id="lastname" name="lastname" class="border-0 px-3 py-3 placeholder-gray-300 text-gray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= member.getLastName() %>">
                                                </div>
                                            </div>
                                            <!-- Postal Code -->
                                            <div class="w-full lg:w-6/12 px-4">
                                                <div class="relative w-full mb-3">
                                                    <label class="block uppercase text-gray-600 text-xs font-bold mb-2" for="codepostal">
                                                        <i class="fas fa-map-marker-alt fa-2x mr-1"></i>Postal Code
                                                    </label>
                                                    <input type="text" id="codepostal" name="codepostal" class="border-0 px-3 py-3 placeholder-gray-300 text-gray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= member.getCodepostal() %>">
                                                </div>
                                            </div>
                                            <!-- Phone Number -->
                                            <div class="w-full lg:w-6/12 px-4">
                                                <div class="relative w-full mb-3">
                                                    <label class="block uppercase text-gray-600 text-xs font-bold mb-2" for="phonenumber">
                                                        <i class="fas fa-phone fa-2x mr-1"></i>Phone Number
                                                    </label>
                                                    <input type="text" id="phonenumber" name="phonenumber" class="border-0 px-3 py-3 placeholder-gray-300 text-gray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= member.getPhoneNumber() %>">
                                                </div>
                                            </div>
                                            <!-- Full Address -->
                                            <div class="w-full lg:w-6/12 px-4">
                                                <div class="relative w-full mb-3">
                                                    <label class="block uppercase text-gray-600 text-xs font-bold mb-2" for="fulladdress">
                                                        <i class="fas fa-address-card fa-2x mr-1"></i>Full Address
                                                    </label>
                                                    <input type="text" id="fulladdress" name="fulladdress" class="border-0 px-3 py-3 placeholder-gray-300 text-gray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= member.getFulladdress() %>">
                                                </div>
                                            </div>
                                            <!-- E-mail -->
                                            <div class="w-full lg:w-6/12 px-4">
                                                <div class="relative w-full mb-3">
                                                    <label class="block uppercase text-gray-600 text-xs font-bold mb-2" for="mail">
                                                        <i class="fas fa-envelope fa-2x mr-1"></i>E-mail
                                                    </label>
                                                    <input type="text" id="mail" name="mail" class="border-0 px-3 py-3 placeholder-gray-300 text-gray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= member.getMail() %>">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <!-- Residence Information -->
                        <section class="py-1">
                            <div class="w-full px-4 mx-auto mt-6">
                                <div class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-gray-100 border-0">
                                    <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
                                        <div class="text-center flex justify-between">
                                            <h6 class="text-gray-700 text-xl font-bold m-4">
                                                <i class="fas fa-home fa-2x mr-2"></i>About Property
                                            </h6>
                                        </div>
                                        <div class="flex flex-wrap">
                                            <!-- Residence Name -->
                                            <div class="w-full lg:w-6/12 px-4">
                                                <div class="relative w-full mb-3">
                                                    <label class="block uppercase text-gray-600 text-xs font-bold mb-2" for="property_code">
                                                        <i class="fas fa-building fa-2x mr-1"></i>Property Code
                                                    </label>
                                                    <input type="text" id="property_code" name="property_code" class="border-0 px-3 py-3 placeholder-gray-300 text-gray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%=member.getPropertyCode() %>">
                                                </div>
                                            </div>

                                            <!-- Residence Type -->
                                            <div class="w-full lg:w-6/12 px-4">
                                                <div class="relative w-full mb-3">
                                                    <label class="block uppercase text-gray-600 text-xs font-bold mb-2" for="property_address">
                                                        <i class="fas fa-home fa-2x mr-1"></i>Property Address
                                                    </label>
                                                    <input type="text" id="property_address" name="property_address" class="border-0 px-3 py-3 placeholder-gray-300 text-gray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= member.getPropertyAddress() %>">
                                                </div>
                                            </div>
                                            <!-- Residence Size -->
                                            <div class="w-full lg:w-6/12 px-4">
                                                <div class="relative w-full mb-3">
                                                    <label class="block uppercase text-gray-600 text-xs font-bold mb-2" for="property_size">
                                                        <i class="fas fa-ruler-combined fa-2x mr-1"></i>Property Size (m²)
                                                    </label>
                                                    <input type="number" id="property_size" name="property_size" class="border-0 px-3 py-3 placeholder-gray-300 text-gray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= member.getPropertySize() %>">
                                                </div>
                                            </div>

                                            <!-- Number of Villas -->
                                            <div class="w-full lg:w-6/12 px-4">
                                                <div class="relative w-full mb-3">
                                                    <label class="block uppercase text-gray-600 text-xs font-bold mb-2" for="property_type">
                                                        <i class="fas fa-home fa-2x mr-1"></i>Property Type
                                                    </label>
                                                    <input type="number" id="property_type" name="property_type" class="border-0 px-3 py-3 placeholder-gray-300 text-gray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= member.getPropertyType() %>">
                                                </div>
                                            </div>



                                            <!-- Number of Elevators -->
                                            <div class="w-full lg:w-6/12 px-4">
                                                <div class="relative w-full mb-3">
                                                    <label class="block uppercase text-gray-600 text-xs font-bold mb-2" for="co_ownership_fee">
                                                        <i class="fas fa-elevator fa-2x mr-1"></i>Co-Ownership_Fee
                                                    </label>
                                                    <input type="number" id="co_ownership_fee" name="co_ownership_fee" class="border-0 px-3 py-3 placeholder-gray-300 text-gray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= member.getCoOwnershipFee() %>">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="text-center mt-6">
                                            <button type="submit" class="bg-blue-500 text-white active:bg-blue-600 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none ease-linear transition-all duration-150">
                                                <i class="fas fa-save fa-2x mr-2"></i>Save
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </form>
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
    document.getElementById("memberprofile").classList.add("active");
</script>
<script src="javascript/main.js"></script>
</body>
</html>
