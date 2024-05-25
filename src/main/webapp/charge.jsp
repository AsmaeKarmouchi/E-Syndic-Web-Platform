<%@ page import="com.syndic.beans.Syndic" %>
<%@ page import="java.util.List" %>
<%@ page import="com.syndic.beans.Charge" %>
<%@ page import="java.util.HashMap" %>
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
    <jsp:include page="templates/syndic_sidenav.jsp" />

    <!------------MIDDLE ------------>
    <main>
        <!----------TOP -------->
        <h1>Charges</h1>
        <div class="date">
            <%=java.time.LocalDate.now()%>
        </div>



        <!---------INSIGHTS------->

        <div class="bg-white rounded-lg overflow-hidden shadow-lg p-4 m-5">
            <div class="px-6 py-4">
                <h2 class="text-2xl font-semibold mb-3 text-red-500 flex items-center"><svg class="h-8 w-8 fill-current mr-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M10 3c4.97 0 9 4.03 9 9s-4.03 9-9 9-9-4.03-9-9 4.03-9 9-9m0-2c-5.52 0-10 4.48-10 10s4.48 10 10 10 10-4.48 10-10-4.48-10-10-10z"/><circle cx="10" cy="14" r="2"/><path d="M9 5h2v7H9z"/></svg>Incident Reporting Regulation</h2>
                <p class="text-gray-700">To maintain a safe and well-maintained environment in our residence, please follow these guidelines:</p>
                <ul class="list-disc mt-3">
                    <li><strong>Reporting:</strong> Any incident must be reported immediately to the property manager or the condominium association.</li>
                    <li><strong>Documentation:</strong> It's important to document the incident in detail, including date, time, location, and description.</li>
                    <li><strong>Communication:</strong> Residents should communicate any relevant information regarding the incident.</li>
                    <li><strong>Cooperation:</strong> All residents must fully cooperate with maintenance staff and authorities to resolve incidents effectively.</li>
                    <li><strong>Confidentiality:</strong> Details of reported incidents should be treated with confidentiality.</li>
                </ul>
                <p class="text-gray-700 mt-3">Adhering to these rules contributes to ensuring a safe environment for all residents.</p>
            </div>
        </div>


            <%
                List<Charge> list_Charges = (List<Charge>) session.getAttribute("list_Charges");

                // HashMap to store unique frequencies and their corresponding colors
                HashMap<String, String> frequencyColors = new HashMap<>();
                // Array of TailwindCSS background colors
                String[] colors = {"bg-blue-100", "bg-green-100", "bg-yellow-100", "bg-red-100", "bg-purple-100", "bg-pink-100"};
                int colorIndex = 0;

                if (list_Charges != null) {
                    for (Charge charge : list_Charges) {
                        String frequency = charge.getChargeFrequency();
                        if (!frequencyColors.containsKey(frequency)) {
                            frequencyColors.put(frequency, colors[colorIndex % colors.length]);
                            colorIndex++;
                        }
                    }
                }
            %>
            <h1 class="text-3xl font-bold mb-4 text-center">List of Charges</h1>
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white rounded-lg shadow-md">
                    <thead class="bg-gray-800 text-white">
                    <tr>
                        <th class="w-1/8 px-4 py-2">ID</th>
                        <th class="w-1/6 px-4 py-2">Code</th>
                        <th class="w-1/6 px-4 py-2">Name</th>
                        <th class="w-1/4 px-4 py-2">Description</th>
                        <th class="w-1/8 px-4 py-2">Amount</th>
                        <th class="w-1/6 px-4 py-2">Frequency</th>
                        <th class="w-1/6 px-4 py-2">Category</th>
                        <th class="w-1/8 px-4 py-2">Due Month</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (list_Charges != null && !list_Charges.isEmpty()) {
                        for (Charge charge : list_Charges) {
                            String rowColor = frequencyColors.get(charge.getChargeFrequency());
                    %>
                    <tr class="border-b <%= rowColor %>">
                        <td class="border px-4 py-2"><%= charge.getChargesId() %></td>
                        <td class="border px-4 py-2"><%= charge.getChargeCode() %></td>
                        <td class="border px-4 py-2"><%= charge.getChargeName() %></td>
                        <td class="border px-4 py-2"><%= charge.getChargeDescription() %></td>
                        <td class="border px-4 py-2"><%= charge.getChargeAmount() %></td>
                        <td class="border px-4 py-2"><%= charge.getChargeFrequency() %></td>
                        <td class="border px-4 py-2"><%= charge.getChargeCategory() %></td>
                        <td class="border px-4 py-2"><%= charge.getChargeDueMonth() %></td>
                    </tr>
                    <% }
                    } else { %>
                    <tr>
                        <td colspan="8" class="text-center px-4 py-2">No charges available</td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
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
    document.getElementById("charge").classList.add("active");
</script>



</body>

<script src="javascript/main.js"></script>
</html>