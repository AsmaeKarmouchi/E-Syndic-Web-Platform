<%@ page import="com.syndic.beans.Syndic" %>
<%@ page import="java.util.List" %>
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
    <!----------TOP -------->
    <div class="flex justify-between items-center p-6 bg-gray-100 shadow-md border rounded-md">
      <h1 class="text-3xl font-bold text-gray-800">Add New Member</h1>
      <div class="text-lg text-gray-600"><%=java.time.LocalDate.now()%></div>
    </div>
    <div class="recent-updates">
      <form action="addmember" method="post" class="user-form">
        <label for="name">Nom:</label>
        <input type="text" id="name" name="name" required><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>

        <label for="password">Mot de passe:</label>
        <input type="password" id="password" name="password" required><br>

        <label for="residence">Residence:</label>
        <select id="residence" name="residence" class="mt-1 p-2 w-full border-2 border-gray-300 rounded-md focus:outline-none focus:border-indigo-500" required>
          <option value="">select a residence</option>
          <%
            List<Syndic> List_syndics = (List<Syndic>) request.getAttribute("List_syndics");

            if (List_syndics != null) {
              for (Syndic syndic : List_syndics) {
          %>
          <option value="<%= syndic.getResidenceName() %>"><%= syndic.getResidenceName() %></option>
          <%
              }
            }
          %>
        </select><br>

        <input type="submit" value="Ajouter">
      </form>
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
  document.getElementById("addmember").classList.add("active");
</script>
</body>

<script src="javascript/main.js"></script>
</html>