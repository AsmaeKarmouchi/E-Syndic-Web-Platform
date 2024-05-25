<%@ page import="java.util.List" %>
<%@ page import="com.syndic.beans.Payment" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Receipt</title>
    <link rel="shortcut icon" href="/Assets/images/logo.png" type="image/x-icon">
    <!---BOX ICON CDN-->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    <!----STYLESHEET---->
    <link rel="stylesheet" href="css/style.css">
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body>

<%
    // Récupérer les paramètres de filtrage de l'URL
    String accountId = request.getParameter("accountId");
    String memberId = request.getParameter("memberId");

    // Récupérer la liste de paiements depuis la session
    List<Payment> listPayments = (List<Payment>) session.getAttribute("payments");

    // Si les paramètres de filtrage sont présents, filtrer la liste de paiements
    if (accountId != null && memberId != null && !accountId.isEmpty() && !memberId.isEmpty()) {
        List<Payment> filteredPayments = new ArrayList<>();
        for (Payment payment : listPayments) {
            // Convertir les identifiants en chaînes de caractères avant de les comparer
            if (String.valueOf(payment.getAccount_id()).equals(accountId) && String.valueOf(payment.getMember_id()).equals(memberId)) {
                filteredPayments.add(payment);
            }
        }
        listPayments = filteredPayments;
    }
%>

<!-- Payment Receipt -->
<div class="max-w-[85rem] px-4 sm:px-6 lg:px-8 mx-auto my-4 sm:my-10">
    <div class="sm:w-11/12 lg:w-3/4 mx-auto">
        <div id="contentToPrintOrDownload">
            <% if (listPayments != null && !listPayments.isEmpty()) { %>
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
                                <dt class="col-span-3 font-semibold text-gray-800 dark:text-neutral-200">Account ID:</dt>
                                <dd class="col-span-2 text-gray-500 dark:text-neutral-500"><%= accountId %></dd>
                            </dl>
                            <dl class="grid sm:grid-cols-5 gap-x-3">
                                <dt class="col-span-3 font-semibold text-gray-800 dark:text-neutral-200">Member ID:</dt>
                                <dd class="col-span-2 text-gray-500 dark:text-neutral-500"><%= memberId %></dd>
                            </dl>
                        </div>
                        <!-- End Grid -->
                    </div>
                    <!-- Col -->
                </div>
                <!-- End Grid -->
                <div>
                    <h1 class="text-lg font-semibold text-gray-800 dark:text-neutral-200 mt-8">Payment Details</h1>
                    <div class="overflow-x-auto">
                        <table class="w-full table-auto text-sm text-left">
                            <thead class="bg-gray-50 text-gray-600 font-medium border-b">
                            <tr>
                                <th class="py-3 px-6">Code</th>
                                <th class="py-3 px-6">Date</th>
                                <th class="py-3 px-6">Amount</th>
                                <th class="py-3 px-6">Method</th>
                                <th class="py-3 px-6">Type</th>
                                <th class="py-3 px-6">Status</th>
                            </tr>
                            </thead>
                            <tbody class="text-gray-600 divide-y">
                            <% for (Payment payment : listPayments) { %>
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap"><%= payment.getCode() %></td>
                                <td class="px-6 py-4 whitespace-nowrap"><%= payment.getDate() %></td>
                                <td class="px-6 py-4 whitespace-nowrap"><%= payment.getAmount() %></td>
                                <td class="px-6 py-4 whitespace-nowrap"><%= payment.getMethod() %></td>
                                <td class="px-6 py-4 whitespace-nowrap"><%= payment.getType() %></td>
                                <td class="px-6 py-4 whitespace-nowrap"><%= payment.getStatus() %></td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- Col -->

                <div class="sm:text-end space-y-2 mt-4">
                    <!-- Grid -->
                    <div class="grid grid-cols-2 sm:grid-cols-1 gap-3 sm:gap-2">
                        <dl class="grid sm:grid-cols-5 gap-x-3">
                            <dt class="col-span-3 font-semibold text-gray-800 dark:text-neutral-200">Receipt Date:</dt>
                            <dd class="col-span-2 text-gray-500 dark:text-neutral-500"><%= new java.util.Date() %></dd>
                        </dl>
                    </div>
                    <!-- End Grid -->
                </div>
                <!-- Col -->
            </div>
            <!-- End Grid -->
        </div>
        <% } else { %>
        <div class="text-center mt-4">No payments available.</div>
        <% } %>
    </div>
</div>

<script>
    // JavaScript code for printing the page
    window.print();
</script>

</body>
</html>
