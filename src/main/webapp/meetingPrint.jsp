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
    <style>
        @media print {
            @page {
                margin: 0;
            }
            body {
                margin: 0;
                padding: 0;
                width: 100%;
                height: 100%;
            }
            .no-print {
                display: none;
            }
            .print-container {
                width: 100%;
                height: 100%;
                overflow: hidden;
            }
        }
    </style>

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
                    <div>
                        <img src="image/logo2.png" alt="Logo" class="size-20" width="46" height="46" viewBox="0 0 46 46">


                        <h1 class="mt-2 text-lg md:text-xl font-semibold text-blue-600 dark:text-white">Ensias_Syndic</h1>
                    </div>
                </div>
                <!-- Col -->

                <div class="text-end">
                    <h2 class="text-2xl md:text-3xl font-semibold text-gray-800 dark:text-neutral-200">PV-Meeting N° <%= meeting.getMeetingId() %></h2>
                    <span class="mt-1 block text-gray-500 dark:text-neutral-500">3682303</span>

                    <address class="mt-4 not-italic text-gray-800 dark:text-neutral-200">
                        Avenue des FAR<br>
                        Hay Riad, Rabat<br>
                        10000, Maroc<br>
                    </address>
                </div>
                <!-- Col -->
            </div>
            <!-- End Grid -->

            <!-- Grid -->
            <div class=" m-4 mt-8 grid sm:grid-cols-2 gap-3">
                <div>
                    <h3 class="text-lg font-semibold text-gray-800 dark:text-neutral-200">PV Meeting about:</h3>
                    <h3 class="text-lg font-semibold text-gray-800 dark:text-neutral-200"> <%= meeting.getMeetingTopic() %> </h3>
                    <address class="mt-2 not-italic text-gray-500 dark:text-neutral-500">
                        Avenue des FAR<br>
                        Hay Riad, Rabat<br>
                        10000, Maroc<br>
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


                    <div class="text-lg leading-relaxed space-y-4 ">
                        <div class="overflow-x-auto border rounded-md">
                            <table class="min-w-full bg-white border border-gray-200">
                                <tbody class="divide-y divide-gray-200">
                                <tr class="border-t">
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-semibold text-gray-700">Meeting ID</td>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500 text-center"><%= meeting.getMeetingId() %></td>
                                </tr>
                                <tr class="border-t">
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-semibold text-gray-700">Location</td>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500 text-center"><%= meeting.getMeetingLocation() %></td>
                                </tr>
                                <tr class="border-t">
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-semibold text-gray-700">Time</td>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500 text-center"><%= meeting.getMeetingTime() %></td>
                                </tr>
                                <tr class="border-t">
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-semibold text-gray-700">Topic</td>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500 text-center"><%= meeting.getMeetingTopic() %></td>
                                </tr>
                                <tr class="border-t">
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-semibold text-gray-700">Residence</td>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500 text-center"><%= meeting.getMeetingResidence() %></td>
                                </tr>
                                <tr class="border-t">
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-semibold text-gray-700">Type</td>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500 text-center"><%= meeting.getMeetingType() %></td>
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


            <div class="mt-8 sm:mt-12">
                <h4 class="text-lg font-semibold text-gray-800 dark:text-neutral-200">Thank you!</h4>
                <p class="text-gray-500 dark:text-neutral-500">If you have any questions concerning this invoice, use the following contact information:</p>
                <div class="mt-2">
                    <p class="block text-sm font-medium text-gray-800 dark:text-neutral-200">ensiassyndic@gmail.com</p>
                    <p class="block text-sm font-medium text-gray-800 dark:text-neutral-200">+212 (0)5 37 77 77 77</p>
                </div>
            </div>

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
    // JavaScript code for printing the page
    window.onload = () => {
        window.print();
    };
</script>
</body>
<script src="javascript/main.js"></script>
</html>
