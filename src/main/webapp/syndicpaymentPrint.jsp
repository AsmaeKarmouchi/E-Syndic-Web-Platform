<%@ page import="java.util.List" %>
<%@ page import="com.syndic.beans.Payment" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.syndic.beans.Member" %>
<%@ page import="com.syndic.beans.Syndic" %>

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
    String startDateStr = request.getParameter("startDate");
    String endDateStr = request.getParameter("endDate");

    // Récupérer la liste de paiements depuis la session
    List<Payment> listPayments = (List<Payment>) session.getAttribute("payments");
    List<Member> membersList = (List<Member>) session.getAttribute("list_members");
    Syndic syndic = (Syndic) session.getAttribute("syndic");

    // Convertir les chaînes de dates en objets Date
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date startDate = null;
    Date endDate = null;
    try {
        if (startDateStr != null && !startDateStr.isEmpty()) {
            startDate = dateFormat.parse(startDateStr);
        }
        if (endDateStr != null && !endDateStr.isEmpty()) {
            endDate = dateFormat.parse(endDateStr);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Si les paramètres de filtrage sont présents, filtrer la liste de paiements
    if ((memberId != null && !memberId.isEmpty()) || startDate != null || endDate != null) {
        List<Payment> filteredPayments = new ArrayList<>();
        for (Payment payment : listPayments) {
            boolean match = true;

            // Filtrer par membre ID
            if (memberId != null && !memberId.isEmpty() && !String.valueOf(payment.getMember_id()).equals(memberId)) {
                match = false;
            }

            // Filtrer par date
            try {
                Date paymentDate = dateFormat.parse(payment.getDate());
                if (startDate != null && paymentDate.before(startDate)) {
                    match = false;
                }
                if (endDate != null && paymentDate.after(endDate)) {
                    match = false;
                }
            } catch (Exception e) {
                e.printStackTrace();
                match = false; // Si la conversion échoue, exclure ce paiement
            }

            if (match) {
                filteredPayments.add(payment);
            }
        }
        listPayments = filteredPayments;
    }

    // Trouver le nom du membre en fonction de l'ID fourni
    String memberName = "Unknown Member";
    Member member = membersList.get(1);
    if (memberId != null && !memberId.isEmpty() && membersList != null) {
        for (Member member1 : membersList) {
            if (String.valueOf(member1.getId()).equals(memberId)) {
                member=member1;
                memberName = member1.getFirstName() +" "+ member1.getLastName();
                break;
            }
        }
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
                            Avenue des FAR<br>
                            Hay Riad, Rabat<br>
                            10000, Maroc<br>
                        </address>
                    </div>
                    <!-- Col -->
                </div>
                <!-- End Grid -->

                <!-- Grid -->
                <div class="mt-8 grid sm:grid-cols-2 gap-3">
                    <div>
                        <h3 class="text-lg font-semibold text-gray-800 dark:text-neutral-200">Invoice to:</h3>
                        <h3 class="text-lg font-semibold text-gray-800 dark:text-neutral-200"><%= memberName %></h3>
                        <address class="mt-2 not-italic text-gray-500 dark:text-neutral-500">
                            <%= member.getPhoneNumber() %> <br>
                            <%= member.getMail() %><br>
                            <%= member.getPropertyAddress() %><br>
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
                            <dl class="grid sm:grid-cols-5 gap-x-3">
                                <dt class="col-span-3 font-semibold text-gray-800 dark:text-neutral-200"> Residence Name:</dt>
                                <dd class="col-span-2 text-gray-500 dark:text-neutral-500"><%= syndic.getResidenceName() %></dd>
                            </dl>
                            <dl class="grid sm:grid-cols-5 gap-x-3">
                                <dt class="col-span-3 font-semibold text-gray-800 dark:text-neutral-200"> Syndic:</dt>
                                <dd class="col-span-2 text-gray-500 dark:text-neutral-500"><%= syndic.getFirstName() %> <%= syndic.getLastName() %></dd>
                            </dl>
                            <dl class="grid sm:grid-cols-5 gap-x-3">
                                <dt class="col-span-3 font-semibold text-gray-800 dark:text-neutral-200"></dt>
                                <dd class="col-span-2 text-gray-500 dark:text-neutral-500"><%= syndic.getMail() %> </dd>
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
                            <div class="sm:col-span-1 text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">P-code</div>
                            <div class="sm:col-span-1 text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">P-Date</div>
                            <div class="sm:col-span-1 text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">P-Type</div>
                            <div class="sm:col-span-1 text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">P-status</div>
                            <div class="sm:col-span-1 text-xs font-medium text-gray-500 uppercase dark:text-neutral-500 text-end">Amount</div>
                        </div>

                        <div class="hidden sm:block border-b border-gray-200 dark:border-neutral-700"></div>

                        <% for (Payment payment : listPayments) { %>
                        <div class="grid grid-cols-3 sm:grid-cols-5 gap-2">
                            <div class="sm:col-span-1">
                                <h5 class="sm:hidden text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">P-code</h5>
                                <p class="text-gray-800 dark:text-neutral-200"><%= payment.getCode() %></p>
                            </div>

                            <div class="sm:col-span-1">
                                <h5 class="sm:hidden text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">P-Date</h5>
                                <p class="text-gray-800 dark:text-neutral-200"><%= payment.getDate() %></p>
                            </div>

                            <div class="sm:col-span-1">
                                <h5 class="sm:hidden text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">P-Type</h5>
                                <p class="font-medium text-gray-800 dark:text-neutral-200"><%= payment.getType() %></p>
                            </div>

                            <div class="sm:col-span-1">
                                <h5 class="sm:hidden text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">P-status</h5>
                                <p class="text-gray-800 dark:text-neutral-200"><%= payment.getStatus() %></p>
                            </div>

                            <div class="sm:col-span-1">
                                <h5 class="sm:hidden text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">Amount</h5>
                                <p class="sm:text-end text-gray-800 dark:text-neutral-200"><%= payment.getAmount() %> dh</p>
                            </div>
                        </div>
                        <div class="sm:hidden border-b border-gray-200 dark:border-neutral-700"></div>
                        <% } %>
                    </div>
                </div>
                <!-- End Table -->

                <%
                    double subtotal = 0.0;
                    for (Payment payment : listPayments) {
                        subtotal += payment.getAmount(); // Supposons que getAmount() renvoie le montant du paiement
                    }

                %>
                <!-- Flex -->
                <div class="mt-8 flex sm:justify-end">
                    <div class="w-full max-w-2xl sm:text-end space-y-2">
                        <!-- Grid -->
                        <div class="grid grid-cols-2 sm:grid-cols-1 gap-3 sm:gap-2">
                            <dl class="grid sm:grid-cols-5 gap-x-3">
                                <dt class="col-span-3 font-semibold text-gray-800 dark:text-neutral-200">Total:</dt>
                                <dd class="col-span-2 text-gray-500 dark:text-neutral-500"><%= subtotal %> dh</dd>
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
                <p class="block text-sm font-medium text-gray-800 dark:text-neutral-200">ensiassyndic@gmail.com</p>
                <p class="block text-sm font-medium text-gray-800 dark:text-neutral-200">+212 (0)5 37 77 77 77</p>
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
