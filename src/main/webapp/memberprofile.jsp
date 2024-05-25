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
                <form action="memberprofile" method="post" class="w-full">
                    <!-- Member Information -->
                    <section class="py-1">
                        <div class="w-full px-4 mx-auto mt-6">
                            <div class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0">
                                <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
                                    <div class="text-center flex justify-between">
                                        <h6 class="text-blueGray-700 text-xl font-bold m-4">
                                            Member Information
                                        </h6>
                                    </div>
                                    <div class="flex flex-wrap">
                                        <div class="w-full lg:w-6/12 px-4">
                                            <div class="relative w-full mb-3">
                                                <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="firstname">
                                                    First Name
                                                </label>
                                                <input type="text" id="firstname" name="firstname" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="${member.firstName}">
                                            </div>
                                        </div>
                                        <div class="w-full lg:w-6/12 px-4">
                                            <div class="relative w-full mb-3">
                                                <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="lastname">
                                                    Last Name
                                                </label>
                                                <input type="text" id="lastname" name="lastname" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="${member.lastName}">
                                            </div>
                                        </div>
                                        <div class="w-full lg:w-6/12 px-4">
                                            <div class="relative w-full mb-3">
                                                <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="codepostal">
                                                    Postal Code
                                                </label>
                                                <input type="text" id="codepostal" name="codepostal" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="${member.codepostal}">
                                            </div>
                                        </div>
                                        <div class="w-full lg:w-6/12 px-4">
                                            <div class="relative w-full mb-3">
                                                <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="phonenumber">
                                                    Phone Number
                                                </label>
                                                <input type="text" id="phonenumber" name="phonenumber" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="${member.phoneNumber}">
                                            </div>
                                        </div>
                                        <div class="w-full lg:w-6/12 px=4">
                                            <div class="relative w-full mb-3">
                                                <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="fulladdress">
                                                    Full Address
                                                </label>
                                                <input type="text" id="fulladdress" name="fulladdress" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="${member.fulladdress}">
                                            </div>
                                        </div>
                                        <div class="w-full lg:w-6/12 px=4">
                                            <div class="relative w-full mb-3">
                                                <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="mail">
                                                    E-mail
                                                </label>
                                                <input type="text" id="mail" name="mail" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="${member.mail}">
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
                                            Property Information
                                        </h6>
                                    </div>
                                    <div class="flex flex-wrap">
                                        <div class="w-full lg:w-6/12 px-4">
                                            <div class="relative w-full mb-3">
                                                <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="property_code">
                                                    Property Code
                                                </label>
                                                <input type="text" id="property_code" name="property_code" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="${member.propertyCode}">
                                            </div>
                                        </div>
                                        <div class="w-full lg:w-6/12 px-4">
                                            <div class="relative w-full mb-3">
                                                <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="property_address">
                                                    Property Address
                                                </label>
                                                <input type="text" id="property_address" name="property_address" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="${member.propertyAddress}">
                                            </div>
                                        </div>
                                        <div class="w-full lg:w-6/12 px-4">
                                            <div class="relative w-full mb-3">
                                                <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="property_type">
                                                    Property Type
                                                </label>
                                                <input type="text" id="property_type" name="property_type" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="${member.propertyType}">
                                            </div>
                                        </div>
                                        <div class="w-full lg:w-6/12 px-4">
                                            <div class="relative w-full mb-3">
                                                <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="property_size">
                                                    Property Size (m²)
                                                </label>
                                                <input type="number" id="property_size" name="property_size" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="${member.propertySize}">
                                            </div>
                                        </div>
                                        <div class="w-full lg:w-6/12 px-4">
                                            <div class="relative w-full mb-3">
                                                <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="co_ownership_fee">
                                                    Co-ownership Fee
                                                </label>
                                                <input type="number" id="co_ownership_fee" name="co_ownership_fee" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="${member.coOwnershipFee}">
                                            </div>
                                        </div>
                                    </div>
                                    <button type="submit" class="bg-blue-500 text-white active:bg-blue-600 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none ease-linear transition-all duration-150">
                                        Save
                                    </button>
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
