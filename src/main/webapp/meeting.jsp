<%@ page import="com.syndic.beans.Syndic" %>
<%@ page import="com.syndic.beans.Meeting" %>
<%@ page import="java.util.List" %>
<%@ page import="com.syndic.beans.Syndic" %>
<%@ page import="com.syndic.connection.Syndic_con" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.syndic.dao.MemberProfileDAOImpl" %>
<%@ page import="com.syndic.dao.MemberProfileDAO" %>
<%@ page language="java"%>
<%
    double solde = ((Syndic) session.getAttribute("syndic2")).getAccount();
    String Res = ((Syndic) session.getAttribute("syndic2")).getResidenceName();
    int syndicid = ((Syndic) session.getAttribute("syndic2")).getId();

    Connection connection = null;
    int memberCount = 0;
    try {
        connection = Syndic_con.getConnection();
        MemberProfileDAO memberProfileDAO = new MemberProfileDAOImpl(connection);
        memberCount = memberProfileDAO.getMemberCountsyndic(syndicid);
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
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

        <div class="flex items-center justify-center">
            <button onclick="showAddMeetingForm()" id="addNewsBtn" class="bg-blue-500 hover:bg-blue-700 text-white font-bold text-lg py-3 px-6 rounded-lg mt-4">Add Meeting</button>
        </div>

        <!-- component -->
        <div class="flex items-center justify-center p-12 hidden" id="addMeetingForm">
            <!-- Author: FormBold Team -->
            <!-- Learn More: https://formbold.com -->
            <div class="mx-auto w-full max-w-[550px]">
                <form action="meeting" method="POST">
                    <input type="hidden" name="action" value="addMeeting">
                    <div class="-mx-3 flex flex-wrap">
                        <div class="w-full px-3 sm:w-1/2">
                            <div class="mb-5">
                                <label
                                        for="meeting_residence"
                                        class="mb-2 block text-base font-medium "
                                >
                                    Residence
                                </label>
                                <input
                                        type="text"
                                        name="meeting_residence"
                                        id="meeting_residence"
                                        placeholder="Residence"
                                        class="w-full rounded-md border border-[#e0e0e0] bg-white py-3 px-6 text-base font-medium text-[#6B7280] outline-none focus:border-[#6A64F1] focus:shadow-md"
                                />
                            </div>
                        </div>
                        <div class="w-full px-3 sm:w-1/2">
                            <div class="mb-5">
                                <label
                                        for="meeting_type"
                                        class="mb-3 block text-base font-medium "
                                >
                                    Type
                                </label>
                                <input
                                        type="text"
                                        name="meeting_type"
                                        id="meeting_type"
                                        placeholder="Type"
                                        class="w-full rounded-md border border-[#e0e0e0] bg-white py-3 px-6 text-base font-medium text-[#6B7280] outline-none focus:border-[#6A64F1] focus:shadow-md"
                                />
                            </div>
                        </div>
                    </div>
                    <div class="mb-5">
                        <label
                                for="meeting_topic"
                                class="mb-3 block text-base font-medium "
                        >
                            Topic
                        </label>
                        <input
                                type="text"
                                name="meeting_topic"
                                id="meeting_topic"
                                placeholder="What the meet is about"
                                class="w-full appearance-none rounded-md border border-[#e0e0e0] bg-white py-3 px-6 text-base font-medium text-[#6B7280] outline-none focus:border-[#6A64F1] focus:shadow-md"
                        />
                    </div>

                    <div class="-mx-3 flex flex-wrap">
                        <div class="w-full px-3 sm:w-1/2">
                            <div class="mb-5">
                                <label
                                        for="meeting_date"
                                        class="mb-3 block text-base font-medium "
                                >
                                    Date
                                </label>
                                <input
                                        type="date"
                                        name="meeting_date"
                                        id="meeting_date"
                                        class="w-full rounded-md border border-[#e0e0e0] bg-white py-3 px-6 text-base font-medium text-[#6B7280] outline-none focus:border-[#6A64F1] focus:shadow-md"
                                />
                            </div>
                        </div>
                        <div class="w-full px-3 sm:w-1/2">
                            <div class="mb-5">
                                <label
                                        for="meeting_time"
                                        class="mb-3 block text-base font-medium "
                                >
                                    Time
                                </label>
                                <input
                                        type="time"
                                        name="meeting_time"
                                        id="meeting_time"
                                        class="w-full rounded-md border border-[#e0e0e0] bg-white py-3 px-6 text-base font-medium text-[#6B7280] outline-none focus:border-[#6A64F1] focus:shadow-md"
                                />
                            </div>
                        </div>
                    </div>

                    <div class="mb-5">
                        <label
                                for="meeting_location"
                                class="mb-3 block text-base font-medium "
                        >
                            Location
                        </label>
                        <input
                                type="text"
                                name="meeting_location"
                                id="meeting_location"
                                placeholder="Where will the meet take place  "
                                class="w-full appearance-none rounded-md border border-[#e0e0e0] bg-white py-3 px-6 text-base font-medium text-[#6B7280] outline-none focus:border-[#6A64F1] focus:shadow-md"
                        />
                    </div>
                    <div class="flex justify-end">
                        <button
                                class="hover:shadow-form rounded-md bg-[#6A64F1] py-3 px-8 text-center text-base font-semibold text-white outline-none"
                        >
                            Submit
                        </button>
                    </div>
                    <div>

                    </div>
                </form>
            </div>
        </div>
        <% String successMessage = (String) request.getSession().getAttribute("successMessage"); %>
        <% if (successMessage != null) {  %>
        <script> alert('<%= successMessage %>');</script>
        <% request.getSession().removeAttribute("successMessage");} %>




            <!-- component -->
            <div class=" flex items-center justify-center p-12">
                <!-- Author: FormBold Team -->
                <!-- Learn More: https://formbold.com -->
                <div class="mx-auto w-full max-w-[550px] bg-white">
                    <form
                            class="py-6 px-9"
                            action="https://formbold.com/s/FORM_ID"
                            method="POST"
                    >
                        <div class="mb-5">
                            <label
                                    for="email"
                                    class="mb-3 block text-base font-medium text-[#07074D]"
                            >
                                Send files to this email:
                            </label>
                            <input
                                    type="email"
                                    name="email"
                                    id="email"
                                    placeholder="example@domain.com"
                                    class="w-full rounded-md border border-[#e0e0e0] bg-white py-3 px-6 text-base font-medium text-[#6B7280] outline-none focus:border-[#6A64F1] focus:shadow-md"
                            />
                        </div>

                        <div class="mb-6 pt-4">
                            <label class="mb-5 block text-xl font-semibold text-[#07074D]">
                                Upload File
                            </label>

                            <div class="mb-8">
                                <input type="file" name="file" id="file" class="sr-only" />
                                <label
                                        for="file"
                                        class="relative flex min-h-[200px] items-center justify-center rounded-md border border-dashed border-[#e0e0e0] p-12 text-center"
                                >
                                    <div>
              <span class="mb-2 block text-xl font-semibold text-[#07074D]">
                Drop files here
              </span>
                                        <span class="mb-2 block text-base font-medium text-[#6B7280]">
                Or
              </span>
                                        <span
                                                class="inline-flex rounded border border-[#e0e0e0] py-2 px-7 text-base font-medium text-[#07074D]"
                                        >
                Browse
              </span>
                                    </div>
                                </label>
                            </div>

                            <div class="mb-5 rounded-md bg-[#F5F7FB] py-4 px-8">
                                <div class="flex items-center justify-between">
            <span class="truncate pr-3 text-base font-medium text-[#07074D]">
              PV_meeting5.pdf
            </span>
                                    <button class="text-[#07074D]">
                                        <svg
                                                width="10"
                                                height="10"
                                                viewBox="0 0 10 10"
                                                fill="none"
                                                xmlns="http://www.w3.org/2000/svg"
                                        >
                                            <path
                                                    fill-rule="evenodd"
                                                    clip-rule="evenodd"
                                                    d="M0.279337 0.279338C0.651787 -0.0931121 1.25565 -0.0931121 1.6281 0.279338L9.72066 8.3719C10.0931 8.74435 10.0931 9.34821 9.72066 9.72066C9.34821 10.0931 8.74435 10.0931 8.3719 9.72066L0.279337 1.6281C-0.0931125 1.25565 -0.0931125 0.651788 0.279337 0.279338Z"
                                                    fill="currentColor"
                                            />
                                            <path
                                                    fill-rule="evenodd"
                                                    clip-rule="evenodd"
                                                    d="M0.279337 9.72066C-0.0931125 9.34821 -0.0931125 8.74435 0.279337 8.3719L8.3719 0.279338C8.74435 -0.0931127 9.34821 -0.0931123 9.72066 0.279338C10.0931 0.651787 10.0931 1.25565 9.72066 1.6281L1.6281 9.72066C1.25565 10.0931 0.651787 10.0931 0.279337 9.72066Z"
                                                    fill="currentColor"
                                            />
                                        </svg>
                                    </button>
                                </div>
                            </div>

                            <div class="rounded-md bg-[#F5F7FB] py-4 px-8">
                                <div class="flex items-center justify-between">
            <span class="truncate pr-3 text-base font-medium text-[#07074D]">
              PV_meeting6.pdf
            </span>
                                    <button class="text-[#07074D]">
                                        <svg
                                                width="10"
                                                height="10"
                                                viewBox="0 0 10 10"
                                                fill="none"
                                                xmlns="http://www.w3.org/2000/svg"
                                        >
                                            <path
                                                    fill-rule="evenodd"
                                                    clip-rule="evenodd"
                                                    d="M0.279337 0.279338C0.651787 -0.0931121 1.25565 -0.0931121 1.6281 0.279338L9.72066 8.3719C10.0931 8.74435 10.0931 9.34821 9.72066 9.72066C9.34821 10.0931 8.74435 10.0931 8.3719 9.72066L0.279337 1.6281C-0.0931125 1.25565 -0.0931125 0.651788 0.279337 0.279338Z"
                                                    fill="currentColor"
                                            />
                                            <path
                                                    fill-rule="evenodd"
                                                    clip-rule="evenodd"
                                                    d="M0.279337 9.72066C-0.0931125 9.34821 -0.0931125 8.74435 0.279337 8.3719L8.3719 0.279338C8.74435 -0.0931127 9.34821 -0.0931123 9.72066 0.279338C10.0931 0.651787 10.0931 1.25565 9.72066 1.6281L1.6281 9.72066C1.25565 10.0931 0.651787 10.0931 0.279337 9.72066Z"
                                                    fill="currentColor"
                                            />
                                        </svg>
                                    </button>
                                </div>
                                <div class="relative mt-5 h-[6px] w-full rounded-lg bg-[#E2E5EF]">
                                    <div
                                            class="absolute left-0 right-0 h-full w-[75%] rounded-lg bg-[#6A64F1]"
                                    ></div>
                                </div>
                            </div>
                        </div>

                        <div>
                            <button
                                    class="hover:shadow-form w-full rounded-md bg-[#6A64F1] py-3 px-8 text-center text-base font-semibold text-white outline-none"
                            >
                                Send File
                            </button>
                        </div>
                    </form>
                </div>
            </div>








        <!---------INSIGHTS------->





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
                        <h2 class="flex items-center justify-between text-xl font-semibold mb-4 cursor-pointer" onclick="toggleDetails(this)">
                            <span><%= meeting.getMeetingTopic() %></span>
                            <svg class="h-6 w-6 fill-current text-gray-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                <path d="M10 15l-5-5h10z"/>
                            </svg>

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
                    <!-- Bouton "Modifier" pour chaque réunion -->
                    <button onclick="toggleEditForm(<%= meeting.getMeetingId() %>)" class="m-4 px-4 py-2 text-lg font-medium text-white bg-indigo-600 rounded-md hover:bg-indigo-700 focus:outline-none focus:bg-indigo-700">Edit</button>

                    <!-- Bouton "Imprimer" -->
                    <a onclick="printMeetingDetails(<%=meeting.getMeetingId() %>)" class="py-2 px-3 inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent bg-blue-600 text-white hover:bg-blue-700 disabled:opacity-50 disabled:pointer-events-none" href="#">
                        <svg class="flex-shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 6 2 18 2 18 9"/><path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"/><rect width="12" height="8" x="6" y="14"/></svg>
                        Print
                    </a>



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
                    <p>Hey, <b><%= ((Syndic) session.getAttribute("syndic")).getFirstName() %></b></p>
                    <small class="text-muted">Syndic</small>
                </div>
                <div class="profile-photo">
                    <img src="image/logo.jpg" alt="Oluwadare Taye Ayo">
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
            <h2>Syndic Analysis</h2>

            <!-----NOUVEAUX SYNDICS ENREGISTRÉS----->
            <div class="item online">
                <i class='bx bx-user'></i>
                <div class="right">
                    <div class="info">
                        <h3>Monitor Payment Flow</h3>
                        <a href="paymentflow.jsp"><small class="text-muted">Follow-up</small></a>
                    </div>
                    <h5 class="success">+10%</h5>
                    <h3>234</h3>
                </div>
            </div>

            <!-----SYNDICS ACTIFS----->
            <div class="item offline">
                <i class='bx bx-wallet'></i>
                <div class="right">
                    <div class="info">
                        <h3>Residence Account Balance</h3>
                        <small class="text-muted"><%=solde%></small>
                    </div>
                    <h5 class="danger">-17%</h5>
                </div>
            </div>

            <!-----NOUVELLES DEMANDES D'ADHÉSION----->
            <div class="item customers">
                <i class='bx bx-user-check'></i>
                <div class="right">
                    <div class="info">
                        <h3>Number of Residents in <%= Res %></h3>
                        <small class="text-muted"><%=memberCount%></small>
                    </div>
                    <h5 class="success"></h5>
                    <h3></h3>
                </div>
            </div>
            <!----------AJOUTER UN NOUVEAU SYNDIC------->
            <div class="item add-product">
                <div>
                    <i class="bx-add"></i>
                    <a href="meeting"><h3>Organize a General Assembly</h3></a>      </div>
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