<%@ page import="com.syndic.beans.Member" %>
<%@ page import="com.syndic.beans.Meeting" %>
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
    <jsp:include page="templates/syndic_sidenav.jsp" />

    <!------------MIDDLE ------------>
    <main>
        <!----------TOP -------->
        <div class="flex justify-between items-center p-6 bg-gray-100 shadow-md border rounded-md">
            <h1 class="text-3xl font-bold text-gray-800">Meeting</h1>
            <div class="text-lg text-gray-600"><%=java.time.LocalDate.now()%></div>
        </div>

        <div class="bg-white rounded-lg overflow-hidden shadow-lg p-6 m-5">
            <div class="px-6 py-4">
                <h2 class="text-2xl font-semibold mb-3 text-red-500 flex items-center">
                    <svg class="h-8 w-8 fill-current mr-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                        <path d="M10 3c4.97 0 9 4.03 9 9s-4.03 9-9 9-9-4.03-9-9 4.03-9 9-9m0-2c-5.52 0-10 4.48-10 10s4.48 10 10 10 10-4.48 10-10-4.48-10-10-10z"/>
                        <circle cx="10" cy="14" r="2"/>
                        <path d="M9 5h2v7H9z"/>
                    </svg>
                    Meeting Regulation
                </h2>
                <div class="px-6 py-4 text-center">
                    <h2 class="text-xl font-semibold mb-2">Law No. 18-00 concerning the status of condominiums in built-up areas.<br><br></h2>
                    <h3 class="text-left text-xl font-semibold mb-4">Rules of the General Meeting of Condominium Owners<br></h3>
                    <ul class="text-left">
                        <li><b>Participation :</b> Each condominium owner has the right to participate in person or by proxy.</li>
                        <li><b>Agenda :</b> Only the items listed on the agenda can be discussed and voted upon.</li>
                        <li><b>Deliberation :</b> Decisions are made according to the majority rules defined by law or condominium regulations.</li>
                        <li><b>Minutes :</b> A written record of the meeting must be drafted, signed by the chairman, and kept in the condominium's archives.</li>
                        <li><b>Transparency :</b> Important information must be made available to condominium owners before the meeting.</li>
                        <li><b>Respect for Rules :</b> Condominium owners must behave respectfully and adhere to the established rules for the meeting.</li>
                    </ul>
                </div>
            </div>
        </div>


        <h1 class="text-3xl font-bold mb-4">List of Meetings</h1>
        <div class="mb-4 relative">
            <input type="text" id="filter" class="form-input border-gray-300 rounded-md shadow-sm pl-10 pr-4 py-2 w-full" placeholder="Filter Residence Meeting" onkeyup="filterMeetings()">
            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M6 8a2 2 0 1 1 0-4 2 2 0 0 1 0 4zm8 6a2 2 0 1 1 0-4 2 2 0 0 1 0 4zm3-6a7 7 0 1 1-14 0 7 7 0 0 1 14 0z" clip-rule="evenodd" />
                </svg>
            </div>
        </div>

        <div class="grid grid-cols-1 gap-4 md:grid-cols-1 lg:grid-cols-1">
                <%
                    List<Meeting> listMeetings = (List<Meeting>) session.getAttribute("list_Meetings");
                    if (listMeetings != null) {
                        for (Meeting meeting : listMeetings) {
                %>
                <div class="bg-white overflow-hidden shadow-sm rounded-lg">
                    <div class="p-6">
                        <h2 class="flex items-center justify-between text-xl font-semibold mb-4" onclick="toggleDetails(this)" >
                            <span><%= meeting.getMeetingTopic() %></span>
                            <button class="bg-orange-500 text-white px-3 py-1 rounded" >
                                More
                            </button>
                        </h2>

                        <div class="hidden bg-gray-100 shadow-md rounded-lg p-4 mb-4">
                            <div class="flex flex-wrap -mx-2">
                                <div class="w-full md:w-1/2 px-2 mb-4 md:mb-0">
                                    <p class="text-gray-800"><strong>Meeting ID:</strong> <%= meeting.getMeetingId() %></p>
                                    <p class="text-gray-800"><strong>Date:</strong> <%= meeting.getMeetingDate() %></p>

                                </div>
                                <div class="w-full md:w-1/2 px-2">
                                    <p class="text-gray-800"><strong>Location:</strong> <%= meeting.getMeetingLocation() %></p>
                                    <p class="text-gray-800"><strong>Time:</strong> <%= meeting.getMeetingTime() %></p>
                                </div>
                            </div>
                            <div class="w-full px-2 mt-4">
                                <strong class="text-gray-800 block mb-2">Residence:</strong>
                                <div class="bg-white rounded-lg shadow-md p-4">
                                    <%= meeting.getMeetingResidence() %>
                                </div>
                            </div>

                            <div class="w-full px-2 mt-4">
                                <strong class="text-gray-800 block mb-2">Type:</strong>
                                <div class="bg-white rounded-lg shadow-md p-4">
                                    <%= meeting.getMeetingType() %>
                                </div>
                            </div>
                            <div class="w-full px-2 mt-4">
                                <strong class="text-gray-800 block mb-2">Topic:</strong>
                                <div class="bg-white rounded-lg shadow-md p-4">
                                    <%= meeting.getMeetingTopic() %>
                                </div>
                            </div>
                            <div class="w-full px-2 mt-4">
                                <strong class="text-gray-800 block mb-2">Conclusion:</strong>
                                <div class="bg-white rounded-lg shadow-md p-4">
                                    <%= meeting.getMeetingConclusion() %>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- Formulaire de modification de la conclusion -->
                    <form id="editForm_<%= meeting.getMeetingId() %>" class="edit-form hidden" action="meeting" method="post">
                        <input type="hidden" name="action" value="editConclusion">
                        <input type="hidden" name="meetingId" value="<%= meeting.getMeetingId() %>">
                        <label for="newConclusion_<%= meeting.getMeetingId() %>" class="block mb-2 text-base font-medium text-gray-700">Meeting Conclusion:</label>
                        <div class="relative">
                            <textarea id="newConclusion_<%= meeting.getMeetingId() %>" name="newConclusion" rows="4" class="w-full px-3 py-2 text-base text-gray-700 placeholder-gray-600 border rounded-md focus:outline-none focus:border-indigo-500 focus:shadow-outline-indigo resize-none"></textarea>
                        </div>
                        <div class="flex justify-end mt-4">
                            <button type="submit" class="ml-auto px-6 py-2 text-lg font-medium text-white bg-indigo-600 rounded-md hover:bg-indigo-700 focus:outline-none focus:bg-indigo-700">Save</button>
                        </div>
                    </form>
                </div>

                <%
                        }
                    }
                %>
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
                    <p>Hey, <b><%= ((Member) session.getAttribute("member")).getFirstName() %></b></p>
                    <small class="text-muted">Member</small>
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
    document.getElementById("meeting").classList.add("active");
</script>
<script>
    function filterMeetings() {
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

    function toggleDetails(element) {
        var details = element.nextElementSibling;
        details.classList.toggle("hidden");
    }

    function showAddMeetingForm() {
        var form = document.getElementById("addMeetingForm");
        form.classList.toggle("hidden");
    }

    <!-- JavaScript pour afficher/cacher les formulaires de modification -->
        function toggleEditForm(meetingId) {
        var editForm = document.getElementById("editForm_" + meetingId);
        if (editForm.classList.contains("hidden")) {
        editForm.classList.remove("hidden");
    } else {
        editForm.classList.add("hidden");
    }
    }

    function printMeetingDetails(meetingId) {

        window.open("meetingPrint.jsp?meetingId=" + meetingId, "_blank");
    }







</script>



</body>

<script src="javascript/main.js"></script>
</html>