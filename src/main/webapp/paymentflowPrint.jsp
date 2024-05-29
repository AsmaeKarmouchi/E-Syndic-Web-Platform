<%@ page import="com.syndic.beans.PaymentFlow" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    // Récupérer les paramètres de filtrage de l'URL
    String flowType = request.getParameter("Id");
    String date = request.getParameter("date");

    // Récupérer la liste de flows de paiement depuis la session
    List<PaymentFlow> listPaymentsFlow = (List<PaymentFlow>) session.getAttribute("paymentsflow");

    // Si les paramètres de filtrage sont présents, filtrer la liste de paiements
    if (flowType != null && date != null && !flowType.isEmpty() && !date.isEmpty()) {
        List<PaymentFlow> filteredPaymentsFlow = new ArrayList<>();
        for (PaymentFlow pf : listPaymentsFlow) {
            // Comparaison des critères de filtrage
            if (String.valueOf(pf.getFlowType()).equals(flowType) && String.valueOf(pf.getTransactionDate()).equals(date)) {
                filteredPaymentsFlow.add(pf);
            }
        }
        listPaymentsFlow = filteredPaymentsFlow;
    }
%>

<!-- Payment Flow Receipt -->
<div class="max-w-[85rem] px-4 sm:px-6 lg:px-8 mx-auto my-4 sm:my-10 print-container">
    <div class="sm:w-11/12 lg:w-3/4 mx-auto">
        <div id="contentToPrintOrDownload">
            <% if (listPaymentsFlow != null && !listPaymentsFlow.isEmpty()) { %>
            <!-- Card -->
            <div class="flex flex-col p-4 sm:p-10 bg-white shadow-md rounded-xl dark:bg-neutral-800">
                <!-- Grid -->
                <div class="flex justify-between">
                    <div>
                        <img src="image/logo2.png" alt="Logo" class="size-20" width="46" height="46">

                        <h1 class="mt-2 text-lg md:text-xl font-semibold text-blue-600 dark:text-white">Ensias_Syndic</h1>
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
                        <h3 class="text-lg font-semibold text-gray-800 dark:text-neutral-200">Flow Details:</h3>
                        <h3 class="text-lg font-semibold text-gray-800 dark:text-neutral-200">Type: <%= flowType %></h3>
                        <h3 class="text-lg font-semibold text-gray-800 dark:text-neutral-200">Date: <%= date %></h3>
                    </div>
                </div>
                <!-- End Grid -->
                <!-- Table -->
                <div class="mt-6">
                    <div class="border border-gray-200 p-4 rounded-lg space-y-4 dark:border-neutral-700">
                        <div class="hidden sm:grid sm:grid-cols-5">
                            <div class="sm:col-span-2 text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">Description</div>
                            <div class="text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">Amount</div>
                            <div class="text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">Transaction Date</div>
                        </div>

                        <div class="hidden sm:block border-b border-gray-200 dark:border-neutral-700"></div>

                        <% for (PaymentFlow pf : listPaymentsFlow) { %>
                        <div class="grid grid-cols-3 sm:grid-cols-5 gap-2">
                            <div class="col-span-full sm:col-span-2">
                                <h5 class="sm:hidden text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">Description</h5>
                                <p class="font-medium text-gray-800 dark:text-neutral-200"><%= pf.getDescription() %></p>
                            </div>
                            <div>
                                <h5 class="sm:hidden text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">Amount</h5>
                                <p class="text-gray-800 dark:text-neutral-200"><%= pf.getAmount() %> dh</p>
                            </div>
                            <div>
                                <h5 class="sm:hidden text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">Transaction Date</h5>
                                <p class="text-gray-800 dark:text-neutral-200"><%= pf.getTransactionDate() %></p>
                            </div>
                        </div>

                        <div class="sm:hidden border-b border-gray-200 dark:border-neutral-700"></div>

                        <% } %>

                    </div>
                </div>
                <!-- End Table -->

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
            </div>
            <% } else { %>
            <div class="text-center mt-4">No payment flows available.</div>
            <% } %>
        </div>
    </div>
    <div class="mt-8 sm:mt-12">
        <h4 class="text-lg font-semibold text-gray-800 dark:text-neutral-200">Thank you!</h4>
        <p class="text-gray-500 dark:text-neutral-500">If you have any questions concerning this receipt, use the following contact information:</p>
        <div class="mt-2">
            <p class="block text-sm font-medium text-gray-800 dark:text-neutral-200">example@site.com</p>
            <p class="block text-sm font-medium text-gray-800 dark:text-neutral-200">+1 (062) 109-9222</p>
        </div>
    </div>
</div>

<script>
    // JavaScript code for printing the page
    window.onload = () => {
        window.print();
    };
</script>

</body>
</html>
