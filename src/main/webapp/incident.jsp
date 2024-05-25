<%@ page import="com.syndic.beans.Syndic" %>
<%@ page import="com.syndic.beans.Meeting" %>
<%@ page import="java.util.List" %>
<%@ page import="com.syndic.beans.Incident" %>
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
        <div class="flex justify-between items-center p-6 bg-gray-100 shadow-md border rounded-md">
            <h1 class="text-3xl font-bold text-gray-800">Incidents</h1>
            <div class="text-lg text-gray-600"><%=java.time.LocalDate.now()%></div>
        </div>

        <!---------INSIGHTS------->
        <div class="bg-white rounded-lg overflow-hidden shadow-lg p-6 m-5">
            <div class="px-6 py-4">
                <h2 class="text-2xl font-semibold mb-3 text-red-500 flex items-center">
                    <svg class="h-8 w-8 fill-current mr-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                        <path d="M10 3c4.97 0 9 4.03 9 9s-4.03 9-9 9-9-4.03-9-9 4.03-9 9-9m0-2c-5.52 0-10 4.48-10 10s4.48 10 10 10 10-4.48 10-10-4.48-10-10-10z"/>
                        <circle cx="10" cy="14" r="2"/>
                        <path d="M9 5h2v7H9z"/>
                    </svg>
                    Incident Reporting Regulation
                </h2>
                <p class="text-gray-700">To maintain a safe and well-maintained environment in our residence, please follow these guidelines:</p>
                <ul class="list-disc mt-3 ml-5">
                    <li><strong>Reporting:</strong> Any incident must be reported immediately to the property manager or the condominium association.</li>
                    <li><strong>Documentation:</strong> It's important to document the incident in detail, including date, time, location, and description.</li>
                    <li><strong>Communication:</strong> Residents should communicate any relevant information regarding the incident.</li>
                    <li><strong>Cooperation:</strong> All residents must fully cooperate with maintenance staff and authorities to resolve incidents effectively.</li>
                    <li><strong>Confidentiality:</strong> Details of reported incidents should be treated with confidentiality.</li>
                </ul>
                <p class="text-gray-700 mt-3">Adhering to these rules contributes to ensuring a safe environment for all residents.</p>
            </div>
        </div>

        <!-- Add Incident Button -->
        <div class="flex items-center justify-center">
            <button onclick="showAddIncidentForm()" id="addNewsBtn" class="bg-blue-500 hover:bg-blue-700 text-white font-bold text-lg py-3 px-6 rounded-lg mt-4">Add Incident</button>
        </div>

        <!-- Add Incident Form -->
        <div class="flex items-center justify-center p-12">
            <div class="mx-auto w-full max-w-[550px] hidden" id="addIncidentForm">
                <form action="incident" method="POST">
                    <input type="hidden" name="action" value="addIncident">
                    <div class="-mx-3 flex flex-wrap">
                        <div class="w-full px-3 sm:w-1/2">
                            <div class="mb-5">
                                <label for="incident_type" class="mb-2 block text-base font-medium">Incident Type</label>
                                <input type="text" name="incident_type" id="incident_type" placeholder="Incident Type" class="w-full rounded-md border border-gray-300 bg-white py-3 px-6 text-base font-medium text-gray-600 outline-none focus:border-blue-500 focus:shadow-md"/>
                            </div>
                        </div>
                        <div class="w-full px-3 sm:w-1/2">
                            <div class="mb-5">
                                <label for="incident_status" class="mb-3 block text-base font-medium">Incident Status</label>
                                <input type="text" name="incident_status" id="incident_status" placeholder="Type" class="w-full rounded-md border border-gray-300 bg-white py-3 px-6 text-base font-medium text-gray-600 outline-none focus:border-blue-500 focus:shadow-md"/>
                            </div>
                        </div>
                    </div>
                    <div class="mb-5">
                        <label for="incident_description" class="mb-3 block text-base font-medium">Incident Description</label>
                        <input type="text" name="incident_description" id="incident_description" placeholder="Description of the incident" class="w-full appearance-none rounded-md border border-gray-300 bg-white py-3 px-6 text-base font-medium text-gray-600 outline-none focus:border-blue-500 focus:shadow-md"/>
                    </div>
                    <div class="flex justify-end">
                        <button class="hover:shadow-form rounded-md bg-blue-500 py-3 px-8 text-center text-base font-semibold text-white outline-none">Submit</button>
                    </div>
                </form>
            </div>
        </div>

        <% String successMessage = (String) request.getSession().getAttribute("successMessage"); %>
        <% if (successMessage != null) { %>
        <script> alert('<%= successMessage %>');</script>
        <% request.getSession().removeAttribute("successMessage");} %>

        <h1 class="text-3xl font-bold mb-4">List of Incidents</h1>
        <div class="mb-4 relative">
            <input type="text" id="filter" class="form-input border-gray-300 rounded-md shadow-sm pl-10 pr-4 py-2 w-full" placeholder="Filter Incidents" onkeyup="filterIncidents()">
            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M6 8a2 2 0 1 1 0-4 2 2 0 0 1 0 4zm8 6a2 2 0 1 1 0-4 2 2 0 0 1 0 4zm3-6a7 7 0 1 1-14 0 7 7 0 0 1 14 0z" clip-rule="evenodd"/>
                </svg>
            </div>
        </div>

        <div class="grid grid-cols-1 gap-4 md:grid-cols-1 lg:grid-cols-1">
            <% List<Incident> listIncidents = (List<Incident>) session.getAttribute("list_Incidents"); %>
            <% if (listIncidents != null) { %>
            <% for (Incident incident : listIncidents) { %>
            <div class="bg-white overflow-hidden shadow-sm rounded-lg">
                <div class="p-6">
                    <h2 class="flex items-center justify-between text-xl font-semibold mb-4 cursor-pointer" onclick="toggleDetails(this)">
                        <span class="text-red-500"> Incident N°<%= incident.getIncidentId() %></span>
                        <svg class="h-6 w-6 fill-current text-gray-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                            <path d="M10 15l-5-5h10z"/>
                        </svg>
                    </h2>
                    <div class="hidden bg-gray-100 shadow-md rounded-lg p-4 mb-4">
                        <div class="flex flex-wrap -mx-2">
                            <div class="w-full md:w-1/2 px-2 mb-4 md:mb-0">
                                <p class="text-gray-800"><strong>Incident ID:</strong> <%= incident.getIncidentId() %></p>
                                <p class="text-gray-800"><strong>Date:</strong> <%= incident.getIncidentDate() %></p>
                            </div>
                            <div class="w-full md:w-1/2 px-2">
                                <p class="text-gray-800"><strong>Status:</strong> <%= incident.getIncidentStatus() %></p>
                                <p class="text-gray-800"><strong>Type:</strong> <%= incident.getIncidentType() %></p>
                            </div>
                        </div>
                        <div class="w-full px-2 mt-4">
                            <strong class="text-gray-800 block mb-2">Incident Description:</strong>
                            <div class="bg-white rounded-lg shadow-md p-4">
                                <%= incident.getIncidentDescription() %>
                            </div>
                        </div>
                        <div class="w-full px-2 mt-4">
                            <strong class="text-gray-800 block mb-2">Resolution Date:</strong>
                            <div class="bg-white rounded-lg shadow-md p-4">
                                <%= incident.getIncidentResolutionDate() %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="flex justify-end">
                    <button onclick="toggleEditForm(<%= incident.getIncidentSId() %>)" class="m-2 px-4 py-2 text-lg font-medium text-white bg-indigo-600 rounded-md hover:bg-indigo-700 focus:outline-none focus:bg-indigo-700">Edit</button>
                </div>
                <form id="editForm_<%= incident.getIncidentSId() %>" class="edit-form hidden" action="meeting" method="post">
                    <input type="hidden" name="action" value="editIncident">
                    <input type="hidden" name="meetingId" value="<%= incident.getIncidentSId() %>">
                    <label for="newStatus_<%= incident.getIncidentSId() %>" class="block mb-2 text-base font-medium text-gray-700">Incident Status:</label>
                    <div class="relative">
                        <textarea id="newStatus_<%= incident.getIncidentSId() %>" name="newStatus" rows="4" class="w-full px-3 py-2 text-base text-gray-700 placeholder-gray-600 border rounded-md focus:outline-none focus:border-indigo-500 focus:shadow-outline-indigo resize-none"></textarea>
                    </div>
                    <div class="flex justify-end mt-4">
                        <button type="submit" class="ml-auto m-2 px-4 py-2 text-lg font-medium text-white bg-indigo-600 rounded-md hover:bg-indigo-700 focus:outline-none focus:bg-indigo-700">Save</button>
                    </div>
                </form>
            </div>
            <% } %>
            <% } %>
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
    document.getElementById("incident").classList.add("active");
</script>
<script>
    function filterIncidents() {
        var input, filter, meetings, meeting, txtValue, i;
        input = document.getElementById("filter");
        filter = input.value.toUpperCase();
        meetings = document.querySelectorAll(".grid > div");
        for (i = 0; i < meetings.length; i++) {
            meeting = meetings[i].querySelector("h2");
            txtValue = meeting.textContent || meeting.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                meetings[i].style.display = "";
            } else {
                meetings[i].style.display = "none";
            }
        }
    }


    function showAddIncidentForm() {
        var form = document.getElementById("addIncidentForm");
        form.classList.toggle("hidden");
    }

    function toggleDetails(element) {
        var details = element.nextElementSibling;
        details.classList.toggle("hidden");
    }

    <!-- JavaScript pour afficher/cacher les formulaires de modification -->
        function toggleEditForm(incidentId) {
        var editForm = document.getElementById("editForm_" + incidentId);
        if (editForm.classList.contains("hidden")) {
        editForm.classList.remove("hidden");
    } else {
        editForm.classList.add("hidden");
    }
    }

    function printMeetingDetails(incidentId) {

        window.open("meetingPrint.jsp?meetingId=" + incidentId, "_blank");
    }







</script>



</body>

<script src="javascript/main.js"></script>
</html>