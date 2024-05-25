<%@ page import="com.syndic.beans.Member" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
</head>

<body>
<div class="container">
  <jsp:include page="templates/member_sidenav.jsp" />

  <!------------MIDDLE ------------>
  <main>
    <!----------TOP -------->
    <h1>Dashboard</h1>
    <div class="date">
      <input type="date">
    </div>

    <!---------INSIGHTS------->
    <div class="insights">
      <h1>Welcome <%= ((Member) session.getAttribute("member")).getFirstName() %>!</h1>

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
</body>

<script src="javascript/main.js"></script>
</html>
