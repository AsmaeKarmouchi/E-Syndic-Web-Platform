<%@ page import="com.syndic.beans.Meeting" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meeting_Report</title>
    <link rel="shortcut icon" href="/Assets/images/logo.png" type="image/x-icon">
    <!---BOX ICON CDN-->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    <!----STYLESHEET---->
    <link rel="stylesheet" href="css/style.css">
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body>

<%
    // Récupérer l'ID de la réunion depuis les paramètres de la requête
    String meetingId = request.getParameter("meetingId");
    // Récupérer la liste de réunions depuis la session
    List<Meeting> listMeetings = (List<Meeting>) session.getAttribute("list_Meetings");
    // Parcourir la liste de réunions pour trouver celle avec l'ID correspondant
    if (listMeetings != null) {
        for (Meeting meeting : listMeetings) {
            // Convertir l'ID de réunion en entier
            int id = Integer.parseInt(meetingId);
            // Comparer l'ID de la réunion avec celui de la boucle
            if (meeting.getMeetingId() == id) {
%>
<!-- Invoice -->
<div class="max-w-[85rem] px-4 sm:px-6 lg:px-8 mx-auto my-4 sm:my-10">
    <div class="sm:w-11/12 lg:w-3/4 mx-auto">
        <div id="contentToPrintOrDownload">
        <!-- Card -->
        <div class="flex flex-col p-4 sm:p-10 bg-white shadow-md rounded-xl dark:bg-neutral-800">
            <!-- Grid -->
            <div class="flex justify-between">
                <div>
                    <svg class="size-10" width="26" height="26" viewBox="0 0 26 26" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M1 26V13C1 6.37258 6.37258 1 13 1C19.6274 1 25 6.37258 25 13C25 19.6274 19.6274 25 13 25H12" class="stroke-blue-600 dark:stroke-white" stroke="currentColor" stroke-width="2"/>
                        <path d="M5 26V13.16C5 8.65336 8.58172 5 13 5C17.4183 5 21 8.65336 21 13.16C21 17.6666 17.4183 21.32 13 21.32H12" class="stroke-blue-600 dark:stroke-white" stroke="currentColor" stroke-width="2"/>
                        <circle cx="13" cy="13.0214" r="5" fill="currentColor" class="fill-blue-600 dark:fill-white"/>
                    </svg>

                    <h1 class="mt-2 text-lg md:text-xl font-semibold text-blue-600 dark:text-white">Preline Inc.</h1>
                </div>
                <!-- Col -->

                <div class="text-end">
                    <h2 class="text-2xl md:text-3xl font-semibold text-gray-800 dark:text-neutral-200">PV-Meeting N° <%= meeting.getMeetingId() %></h2>
                    <span class="mt-1 block text-gray-500 dark:text-neutral-500">3682303</span>

                    <address class="mt-4 not-italic text-gray-800 dark:text-neutral-200">
                        45 Roker Terrace<br>
                        Latheronwheel<br>
                        KW5 8NW, London<br>
                        United Kingdom<br>
                    </address>
                </div>
                <!-- Col -->
            </div>
            <!-- End Grid -->

            <!-- Grid -->
            <div class="mt-8 grid sm:grid-cols-2 gap-3">
                <div>
                    <h3 class="text-lg font-semibold text-gray-800 dark:text-neutral-200">Bill to:</h3>
                    <h3 class="text-lg font-semibold text-gray-800 dark:text-neutral-200">Sara Williams</h3>
                    <address class="mt-2 not-italic text-gray-500 dark:text-neutral-500">
                        280 Suzanne Throughway,<br>
                        Breannabury, OR 45801,<br>
                        United States<br>
                    </address>
                </div>


                <!-- Col -->

                <div class="sm:text-end space-y-2">
                    <!-- Grid -->
                    <div class="grid grid-cols-2 sm:grid-cols-1 gap-3 sm:gap-2">
                        <dl class="grid sm:grid-cols-5 gap-x-3">
                            <dt class="col-span-3 font-semibold text-gray-800 dark:text-neutral-200">Meeting date:</dt>
                            <dd class="col-span-2 text-gray-500 dark:text-neutral-500"><%= meeting.getMeetingDate() %></dd>
                        </dl>
                        <dl class="grid sm:grid-cols-5 gap-x-3">
                            <dt class="col-span-3 font-semibold text-gray-800 dark:text-neutral-200">Meeting time:</dt>
                            <dd class="col-span-2 text-gray-500 dark:text-neutral-500"><%= meeting.getMeetingTime() %></dd>
                        </dl>
                    </div>
                    <!-- End Grid -->
                </div>
                <!-- Col -->
            </div>
            <!-- End Grid -->

            <div  >

                <div class="max-w-2xl mx-auto bg-white p-4 rounded-lg shadow-md border border-gray-300">
                    <div class="text-lg leading-relaxed space-y-4">
                        <div class="overflow-x-auto">
                            <table class="min-w-full bg-white border border-gray-200">
                                <tbody class="divide-y divide-gray-200">
                                <tr class="border-t">
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-semibold text-gray-700">Meeting ID</td>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500"><%= meeting.getMeetingId() %></td>
                                </tr>
                                <tr class="border-t">
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-semibold text-gray-700">Location</td>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500"><%= meeting.getMeetingLocation() %></td>
                                </tr>
                                <tr class="border-t">
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-semibold text-gray-700">Time</td>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500"><%= meeting.getMeetingTime() %></td>
                                </tr>
                                <tr class="border-t">
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-semibold text-gray-700">Topic</td>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500"><%= meeting.getMeetingTopic() %></td>
                                </tr>
                                <tr class="border-t">
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-semibold text-gray-700">Residence</td>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500"><%= meeting.getMeetingResidence() %></td>
                                </tr>
                                <tr class="border-t">
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-semibold text-gray-700">Type</td>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500"><%= meeting.getMeetingType() %></td>
                                </tr>

                                </tbody>
                            </table>
                        </div>
                        <div>
                            <span class="font-semibold block mb-2 text-center">Conclusion</span>
                            <div class="bg-gray-50 p-4 border rounded-md">
                                <%= meeting.getMeetingConclusion() %>
                            </div>
                        </div>
                    </div>
                    <footer class="mt-8 text-center text-sm text-gray-600">
                        Generated on <%= new java.util.Date() %>
                    </footer>
                </div>

            </div>


            <div class="mt-8 sm:mt-12">
                <h4 class="text-lg font-semibold text-gray-800 dark:text-neutral-200">Thank you!</h4>
                <p class="text-gray-500 dark:text-neutral-500">If you have any questions concerning this invoice, use the following contact information:</p>
                <div class="mt-2">
                    <p class="block text-sm font-medium text-gray-800 dark:text-neutral-200">example@site.com</p>
                    <p class="block text-sm font-medium text-gray-800 dark:text-neutral-200">+1 (062) 109-9222</p>
                </div>
            </div>

            <p class="mt-5 text-sm text-gray-500 dark:text-neutral-500">© 2022 Preline.</p>
        </div>
        <!-- End Card -->
        </div>


        <!-- Buttons -->
        <!--<div class="mt-6 flex justify-end gap-x-3">
            <a class="py-2 px-3 inline-flex justify-center items-center gap-2 rounded-lg border font-medium bg-white text-gray-700 shadow-sm align-middle hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-white focus:ring-blue-600 transition-all text-sm dark:bg-neutral-800 dark:hover:bg-neutral-800 dark:border-neutral-700 dark:text-neutral-400 dark:hover:text-white dark:focus:ring-offset-gray-800" href="#">
                <svg class="flex-shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" x2="12" y1="15" y2="3"/></svg>
                Invoice PDF
            </a>
            <a class="py-2 px-3 inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent bg-blue-600 text-white hover:bg-blue-700 disabled:opacity-50 disabled:pointer-events-none" href="#">
                <svg class="flex-shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 6 2 18 2 18 9"/><path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"/><rect width="12" height="8" x="6" y="14"/></svg>
                Print
            </a>
        </div>
         End Buttons -->
    </div>
</div>
<!-- End Invoice -->

<%
            }
        }
    }
%>
<script>
    window.print();
</script>
</body>
<script src="javascript/main.js"></script>
</html>
