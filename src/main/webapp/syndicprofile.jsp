<%@ page import="com.syndic.beans.User" %>
<%@ page import="com.syndic.beans.Syndic" %>
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
    <jsp:include page="templates/syndic_sidenav.jsp"/>
  </div>
  <main>
    <% Syndic syndic = (Syndic) session.getAttribute("syndic2"); %>
  <!------------MIDDLE ------------>
  <div class="main-content flex flex-col p-6">
    <div class="recent-updates w-full">
      <h1>Welcome <%= syndic.getFirstName() %>!</h1>
      <div class="form-container">
        <form action="syndicprofile" method="post" class="w-full">
          <!-- Syndic Information -->
          <section class="py-1">
            <div class="w-full px-4 mx-auto mt-6">
              <div class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0">
                <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
                  <div class="text-center flex justify-between">
                    <h6 class="text-blueGray-700 text-xl font-bold m-4">
                      Informations Syndic
                    </h6>
                  </div>
                  <div class="flex flex-wrap">
                    <div class="w-full lg:w-6/12 px-4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="firstname">
                          First Name
                        </label>
                        <input type="text" id="firstname" name="firstname" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getFirstName() %>">
                      </div>
                    </div>
                    <div class="w-full lg:w-6/12 px-4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="lastname">
                          Last Name
                        </label>
                        <input type="text" id="lastname" name="lastname" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getLastName() %>">
                      </div>
                    </div>
                    <div class="w-full lg:w-6/12 px-4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="codepostal">
                          Postal Code
                        </label>
                        <input type="text" id="codepostal" name="codepostal" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getCodepostal() %>">
                      </div>
                    </div>
                    <div class="w-full lg:w-6/12 px-4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="phonenumber">
                          Phone Number
                        </label>
                        <input type="text" id="phonenumber" name="phonenumber" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getPhoneNumber() %>">
                      </div>
                    </div>
                    <div class="w-full lg:w-6/12 px=4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="fulladdress">
                          Full Address
                        </label>
                        <input type="text" id="fulladdress" name="fulladdress" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getFulladdress() %>">
                      </div>
                    </div>
                    <div class="w-full lg:w-6/12 px=4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="mail">
                          E-mail
                        </label>
                        <input type="text" id="mail" name="mail" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getMail() %>">
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
              <div class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0">
                <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
                  <div class="text-center flex justify-between">
                    <h6 class="text-blueGray-700 text-xl font-bold m-4">
                      About Residence
                    </h6>
                  </div>
                  <div class="flex flex-wrap">
                    <div class="w-full lg:w-6/12 px-4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="residenceName">
                          Residence Name
                        </label>
                        <input type="text" id="residenceName" name="residenceName" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getResidenceName() %>">
                      </div>
                    </div>
                    <div class="w-full lg:w-6/12 px-4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="residenceAddress">
                          Residence Address
                        </label>
                        <input type="text" id="residenceAddress" name="residenceAddress" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getResidenceAddress() %>">
                      </div>
                    </div>
                    <div class="w-full lg:w-6/12 px-4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="residenceType">
                          Residence Type
                        </label>
                        <input type="text" id="residenceType" name="residenceType" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getResidenceType() %>">
                      </div>
                    </div>
                    <div class="w-full lg:w-6/12 px-4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="residenceSize">
                          Residence Size (m²)
                        </label>
                        <input type="number" id="residenceSize" name="residenceSize" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getResidenceSize() %>">
                      </div>
                    </div>
                    <div class="w-full lg:w-6/12 px-4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="apartmentCount">
                          Number of Apartments
                        </label>
                        <input type="number" id="apartmentCount" name="apartmentCount" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getApartmentCount() %>">
                      </div>
                    </div>
                    <div class="w-full lg:w-6/12 px-4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="villaCount">
                          Number of Villas
                        </label>
                        <input type="number" id="villaCount" name="villaCount" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getVillaCount() %>">
                      </div>
                    </div>
                    <div class="w-full lg:w-6/12 px-4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="gardenCount">
                          Number of Gardens
                        </label>
                        <input type="number" id="gardenCount" name="gardenCount" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getGardenCount() %>">
                      </div>
                    </div>
                    <div class="w-full lg:w-6/12 px-4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="poolCount">
                          Number of Pools
                        </label>
                        <input type="number" id="poolCount" name="poolCount" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getPoolCount() %>">
                      </div>
                    </div>
                    <div class="w-full lg:w-6/12 px-4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="parkingCount">
                          Number of Parkings
                        </label>
                        <input type="number" id="parkingCount" name="parkingCount" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getParkingCount() %>">
                      </div>
                    </div>
                    <div class="w-full lg:w-6/12 px-4">
                      <div class="relative w-full mb-3">
                        <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" for="elevatorsCount">
                          Number of Elevators
                        </label>
                        <input type="number" id="elevatorsCount" name="elevatorsCount" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" value="<%= syndic.getElevatorsCount() %>">
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
        <p>Hey, <b><%= ((Syndic) session.getAttribute("syndic")).getFirstName() %></b></p>
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
  document.getElementById("syndicprofile").classList.add("active");
</script>
</body>
<script src="javascript/main.js"></script>
</html>
