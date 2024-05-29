<%@ page import="com.syndic.beans.Member" %>
<%@ page import="java.util.List" %>
<%@ page import="com.syndic.beans.Syndic" %>
<%@ page import="com.syndic.beans.Payment" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="static com.itextpdf.kernel.xmp.PdfConst.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
  <link rel="stylesheet" href="https://demos.creative-tim.com/notus-js/assets/styles/tailwind.css">
  <link rel="stylesheet" href="https://demos.creative-tim.com/notus-js/assets/vendor/@fortawesome/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

</head>

<body>
<div class="container">
  <jsp:include page="templates/syndic_sidenav.jsp" />

  <!------------MIDDLE ------------>
  <main>
      <% Syndic syndic = (Syndic) session.getAttribute("syndic2");%>

    <div class="flex justify-between items-center p-6 bg-blue-300 shadow-md border rounded-md">
      <h1 class="text-3xl font-bold text-gray-800"> Members of <%= syndic.getResidenceName() %> Residence </h1>
      <div class="text-lg text-gray-600"><%=java.time.LocalDate.now()%></div>
    </div>
    <br><br><br>

    <div>
    <%
      List<Payment> listPayments = (List<Payment>) session.getAttribute("payments");%>

    <div class="grid grid-cols-1 gap-4 md:grid-cols-1 lg:grid-cols-1" >
      <% if (session.getAttribute("list_members") != null) {
        List<Member> membersList = (List<Member>) session.getAttribute("list_members");
        for (Member member : membersList) {
          int memberId = member.getId();
      %>
      <div class="bg-white overflow-hidden shadow-sm rounded-lg">
        <div class="p-6">
          <h2 class="flex items-center justify-between text-xl font-semibold mb-4" onclick="toggleDetails(this)" >
            <span><%= member.getFirstName() %> <%= member.getLastName() %></span>
            <button class="bg-orange-500 text-white px-3 py-1 rounded" >
              More
            </button>
          </h2>

          <div class="hidden bg-gray-100 shadow-md rounded-lg p-4 mb-4">

            <div class="flex flex-wrap -mx-2">
              <div class="w-full md:w-1/2 px-2 mb-4 md:mb-0">
                <p class="text-gray-800"><strong>First Name:</strong> <%= member.getFirstName() %></p>
                <p class="text-gray-800"><strong>Last Name:</strong> <%= member.getLastName() %></p>
                <p class="text-gray-800"><strong>Phone Number:</strong> <%= member.getPhoneNumber() %></p>
              </div>

              <div class="w-full md:w-1/2 px-2">
                <p class="text-gray-800"><strong>Full Address:</strong> <%= member.getFulladdress() %></p>
                <p class="text-gray-800"><strong>Postal Code:</strong> <%= member.getCodepostal() %></p>
                <p class="text-gray-800"><strong>Property Code:</strong> <%= member.getPropertyCode() %></p>
              </div>
            </div>

            <div class="w-full px-2 mt-4">
              <strong class="text-gray-800 block mb-2">Email:</strong>
              <div class="bg-white rounded-lg shadow-md p-4">
                <%= member.getMail() %>
              </div>
            </div>

            <div class="w-full px-2 mt-4">
              <strong class="text-gray-800 block mb-2">Property Type:</strong>
              <div class="bg-white rounded-lg shadow-md p-4">
                <%= member.getPropertyType() %>
              </div>
            </div>

            <div class="w-full px-2 mt-4">
              <strong class="text-gray-800 block mb-2">Property Size:</strong>
              <div class="bg-white rounded-lg shadow-md p-4">
                <%= member.getPropertySize() %> sqm
              </div>
            </div>

            <div class="w-full px-2 mt-4">
              <strong class="text-gray-800 block mb-2">Co-Ownership Fee:</strong>
              <div class="bg-white rounded-lg shadow-md p-4">
                <%= member.getCoOwnershipFee() %> dh
              </div>
            </div>


            <tr>

              <!-- Vérifiez si le paiement a été effectué pour ce mois -->
              <td class="px-6 py-4 whitespace-nowrap">
                <table>
                  <tbody>
            <tr>
            <!-- Remplacez 'listPayments' par votre liste de paiements filtrée pour ce membre -->
            <%

              SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

              for (int i = 1; i <= 12; i++) { // Boucle sur les 12 mois
                boolean paymentDone = false; // Par défaut, aucun paiement n'est effectué pour ce mois
                // Vérifiez si le paiement pour ce mois existe dans la liste de paiements filtrée
                for (Payment payment : listPayments) {
                  Calendar calendar = Calendar.getInstance();
                  calendar.setTime(dateFormat.parse(payment.getDate()));
                  int mounth = calendar.get(Calendar.MONTH) + 1;
                  if (payment.getMember_id() == memberId && mounth == i) {
                    paymentDone = true; // Paiement effectué
                    break;
                  }
                }
            %>


              <!-- Vérifiez si le paiement a été effectué pour ce mois -->
              <td class="px-6 py-4 whitespace-nowrap">
                <span> M-<%= i %> <br></span>
                <div class="h-8 w-8 rounded-full flex items-center justify-center <% if (paymentDone) { %>bg-green-500<% } else { %>bg-red-500<% } %>">
                  <i class="bx <% if (paymentDone) { %>bx-check<% } else { %>bx-x<% } %> text-white"></i>
                </div>

              </td>

            <% } // Fin de la boucle sur les mois %>

            </tr>
                  </tbody>
                </table>
              </td>
            </tr>

            <!-- Add the alert button with enhanced styling and aligned to the left -->
            <div class="w-full px-4 mt-4 button-left">
              <form action="membersbysyndic" method="POST">
                <input type="hidden" name="memberId" value="<%= member.getId() %>">
                <input type="hidden" name="memberFirstName" value="<%= member.getFirstName() %>">
                <input type="hidden" name="memberLastName" value="<%= member.getLastName() %>">
                <input type="hidden" name="membermail" value="<%= member.getMail() %>">
                <button type="submit" class="bg-red-500 hover:bg-red-600 text-white font-bold px-5 py-2 rounded shadow-lg transition duration-300">
                  Alerte <%= member.getFirstName() %> <%= member.getLastName() %>  to pay
                </button>
              </form>
            </div>

          </div>
        </div>
        <% } // Fin de la boucle sur les membres %>
        <%} else { %>
        <p class="text-gray-600">Aucun membre trouvé.</p>
        <% } %>



          </div>
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

  function toggleDetails(element) {
    var details = element.nextElementSibling;
    details.classList.toggle("hidden");
  }


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
  document.getElementById("membersbySyndic").classList.add("active");
</script>
</body>

<script src="javascript/main.js"></script>
</html>


