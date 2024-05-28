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
    String memberId = request.getParameter("memberId");

    // Récupérer la liste de paiements depuis la session
    List<Payment> listPayments = (List<Payment>) session.getAttribute("payments");

    // Si les paramètres de filtrage sont présents, filtrer la liste de paiements
    if (memberId != null &&  !memberId.isEmpty()) {
        List<Payment> filteredPayments = new ArrayList<>();
        for (Payment payment : listPayments) {
            // Convertir les identifiants en chaînes de caractères avant de les comparer
            if ( String.valueOf(payment.getMember_id()).equals(memberId)) {
                filteredPayments.add(payment);
            }
        }
        listPayments = filteredPayments;
    }
%>

<!-- Payment Receipt -->
<div class="max-w-[85rem] px-4 sm:px-6 lg:px-8 mx-auto my-4 sm:my-10 print-container">
    <div class="sm:w-11/12 lg:w-3/4 mx-auto">
        <div id="contentToPrintOrDownload">
            <% if (listPayments != null && !listPayments.isEmpty()) { %>
            <!-- Card -->
            <div class="flex flex-col p-4 sm:p-10 bg-white shadow-md rounded-xl dark:bg-neutral-800">
                <!-- Grid -->
                <div class="flex justify-between">
                    <div>
                        <img src="image/logo2.png" alt="Logo" class="size-20" width="46" height="46" viewBox="0 0 46 46">


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
                                <dt class="col-span-3 font-semibold text-gray-800 dark:text-neutral-200">Member ID:</dt>
                                <dd class="col-span-2 text-gray-500 dark:text-neutral-500"><%= memberId %></dd>
                            </dl>
                        </div>
                        <!-- End Grid -->
                    </div>
                    <!-- Col -->
                </div>
                <!-- End Grid -->
                <!-- Table -->
                <div class="mt-6">
                    <div class="border border-gray-200 p-4 rounded-lg space-y-4 dark:border-neutral-700">
                        <div class="hidden sm:grid sm:grid-cols-5">
                            <div class="sm:col-span-2 text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">Item</div>
                            <div class="text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">Qty</div>
                            <div class="text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">Rate</div>
                            <div class="text-end text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">Amount</div>
                        </div>

                        <div class="hidden sm:block border-b border-gray-200 dark:border-neutral-700"></div>

                        <% for (Payment payment : listPayments) { %>
                        <div class="grid grid-cols-3 sm:grid-cols-5 gap-2">
                            <div class="col-span-full sm:col-span-2">
                                <h5 class="sm:hidden text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">Item</h5>
                                <p class="font-medium text-gray-800 dark:text-neutral-200"><%= payment.getType() %></p>
                            </div>
                            <div>
                                <h5 class="sm:hidden text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">Qty</h5>
                                <p class="text-gray-800 dark:text-neutral-200"><%= payment.getCode() %></p>
                            </div>
                            <div>
                                <h5 class="sm:hidden text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">Rate</h5>
                                <p class="text-gray-800 dark:text-neutral-200"><%= payment.getStatus() %></p>
                            </div>
                            <div>
                                <h5 class="sm:hidden text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">Amount</h5>
                                <p class="sm:text-end text-gray-800 dark:text-neutral-200"><%= payment.getAmount() %> dh</p>
                            </div>
                        </div>


                        <div class="sm:hidden border-b border-gray-200 dark:border-neutral-700"></div>

                        <% } %>

                    </div>
                </div>
                <!-- End Table -->
                <!-- Flex -->
                <div class="mt-8 flex sm:justify-end">
                    <div class="w-full max-w-2xl sm:text-end space-y-2">
                        <!-- Grid -->
                        <div class="grid grid-cols-2 sm:grid-cols-1 gap-3 sm:gap-2">
                            <dl class="grid sm:grid-cols-5 gap-x-3">
                                <dt class="col-span-3 font-semibold text-gray-800 dark:text-neutral-200">Subtotal:</dt>
                                <dd class="col-span-2 text-gray-500 dark:text-neutral-500">2750.00 dh</dd>
                            </dl>

                            <dl class="grid sm:grid-cols-5 gap-x-3">
                                <dt class="col-span-3 font-semibold text-gray-800 dark:text-neutral-200">Total:</dt>
                                <dd class="col-span-2 text-gray-500 dark:text-neutral-500">2750.00 dh</dd>
                            </dl>

                            <dl class="grid sm:grid-cols-5 gap-x-3">
                                <dt class="col-span-3 font-semibold text-gray-800 dark:text-neutral-200">Tax:</dt>
                                <dd class="col-span-2 text-gray-500 dark:text-neutral-500">39.00 dh</dd>
                            </dl>

                            <dl class="grid sm:grid-cols-5 gap-x-3">
                                <dt class="col-span-3 font-semibold text-gray-800 dark:text-neutral-200">Amount paid:</dt>
                                <dd class="col-span-2 text-gray-500 dark:text-neutral-500">2789.00 dh</dd>
                            </dl>

                            <dl class="grid sm:grid-cols-5 gap-x-3">
                                <dt class="col-span-3 font-semibold text-gray-800 dark:text-neutral-200">Due balance:</dt>
                                <dd class="col-span-2 text-gray-500 dark:text-neutral-500">0.00 dh</dd>
                            </dl>
                        </div>
                        <!-- End Grid -->
                    </div>
                </div>
                <!-- End Flex -->

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
        <div class="text-center mt-4">No payments available.</div>
        <% } %>
    </div>
    <div class="mt-8 sm:mt-12">
        <h4 class="text-lg font-semibold text-gray-800 dark:text-neutral-200">Thank you!</h4>
        <p class="text-gray-500 dark:text-neutral-500">If you have any questions concerning this invoice, use the following contact information:</p>
        <div class="mt-2">
            <p class="block text-sm font-medium text-gray-800 dark:text-neutral-200">example@site.com</p>
            <p class="block text-sm font-medium text-gray-800 dark:text-neutral-200">+1 (062) 109-9222</p>
        </div>
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
