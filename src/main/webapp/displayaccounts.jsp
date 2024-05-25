<%@ page import="com.syndic.beans.Account" %>
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
    <h1>Display Accounts</h1>
    <div class="date">
      <%=java.time.LocalDate.now()%>
    </div>

    <!---------INSIGHTS------->

<br><br>
    <h1>All Accounts</h1>
    <div class="mt-12 shadow-sm border rounded-lg overflow-x-auto">
      <table class="w-full table-auto text-sm text-left" id="paymentTable">
        <thead class="bg-gray-50 text-gray-600 font-medium border-b">
        <tr>
          <th class="py-3 px-6">Code</th>
          <th class="py-3 px-6">Date</th>
          <th class="py-3 px-6">Amount</th>
          <th class="py-3 px-6">Method</th>
          <th class="py-3 px-6">Type</th>
          <th class="py-3 px-6">Account ID</th>

        </tr>
        </thead>
      </tr>
      <% List<Account> accounts = (List<Account>) session.getAttribute("accounts"); %>
      <% if (accounts != null && !accounts.isEmpty()) { %>
      <% for (Account account : accounts ){ %>
        <tr>
          <td class="px-6 py-4 whitespace-nowrap"><%= account.getAccountId()%></td>
          <td class="px-6 py-4 whitespace-nowrap"><%= account.getAccountNumber()%></td>
          <td class="px-6 py-4 whitespace-nowrap"><%= account.getAccountType()%></td>
          <td class="px-6 py-4 whitespace-nowrap"><%= account.getAccountBalance()%></td>
          <td class="px-6 py-4 whitespace-nowrap"><%= account.getAccountCreatedAt()%></td>
          <td class="px-6 py-4 whitespace-nowrap"><%= account.getAccountSyndicId()%></td>
          <td class="text-right px-4 whitespace-nowrap">
            <button class="editPaymentBtn py-2 px-3 font-medium text-indigo-600 hover:text-indigo-500 duration-150 hover:bg-gray-50 rounded-lg"
                    >
              Edit
            </button>

            <form action="addpayment" method="post" class="inline">

              <input type="hidden" name="action" value="delete">
              <button type="submit" class="deletePaymentBtn py-2 leading-none px-3 font-medium text-red-600 hover:text-red-500 duration-150 hover:bg-gray-50 rounded-lg">
                Delete
              </button>
            </form>
          </td>
        </tr>
        <% } %>
        <% } else { %>
        <tr>
          <td colspan="9" class="px-6 py-4">No payments available at the moment.</td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>

    <% String successMessage = (String) request.getSession().getAttribute("successMessage"); %>
    <% if (successMessage != null) {  %>
    <script> alert('<%= successMessage %>');</script>
    <% request.getSession().removeAttribute("successMessage");} %>

    <% String errorMessage = (String) request.getSession().getAttribute("errorMessage"); %>
    <% if (errorMessage != null) { %>
    <script>alert('<%= errorMessage %>');</script>
    <% request.getSession().removeAttribute("errorMessage");} %>
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
  document.getElementById("displayaccounts").classList.add("active");
</script>
</body>

<script src="javascript/main.js"></script>
</html>