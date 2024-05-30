<%@ page import="com.syndic.dao.UserDAO" %>
<%@ page import="com.syndic.dao.UserDAOImpl" %>
<%@ page import="com.syndic.connection.Syndic_con" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.syndic.dao.TaskDAO" %>
<%@ page import="com.syndic.dao.TaskDAOImpl" %>
<%@ page import="com.syndic.dao.IncidentDAO" %>
<%@ page import="com.syndic.dao.IncidentDAOImpl" %>
<%@ page import="com.syndic.dao.SupplierDAO" %>
<%@ page import="com.syndic.dao.SupplierDAOImpl" %>
<%@ page import="com.syndic.dao.PaymentDAO" %>
<%@ page import="com.syndic.dao.PaymentDAOImpl" %>
<%@ page import="com.syndic.dao.MemberProfileDAO" %>
<%@ page import="com.syndic.dao.MemberProfileDAOImpl" %>
<%@ page import="com.syndic.beans.Syndic" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.syndic.beans.Payment" %>
<%@ page import="java.util.List" %>
<%@ page import="com.syndic.beans.Charge" %>
<%@ page import="com.syndic.beans.Task" %>
<%
    int userCount = 0;
    int taskCount=0;
    int incidentCount=0;
    int supplierCount=0;
    float sumpayment=0;
    int memberCount = 0;

    Connection connection = null;
    Syndic syndic = (Syndic) session.getAttribute("syndic");
    int syndicid = ((Syndic) session.getAttribute("syndic")).getId();

        try {
            connection = Syndic_con.getConnection();


            UserDAO userDao = new UserDAOImpl(connection);
            userCount = userDao.getUserCount();

            TaskDAO taskDAO = new TaskDAOImpl(connection);
            taskCount = taskDAO.getTaskCount();

            IncidentDAO incidentDAO = new IncidentDAOImpl(connection);
            incidentCount = incidentDAO.getIncidentCount();

            SupplierDAO supplierDAO = new SupplierDAOImpl(connection);
            supplierCount = supplierDAO.getSupplierCount();

            PaymentDAO paymentDAO = new PaymentDAOImpl(connection);
            sumpayment = paymentDAO.getPaymentSum();

            MemberProfileDAO memberProfileDAO = new MemberProfileDAOImpl(connection);
            memberCount = memberProfileDAO.getMemberCount();

        } catch (SQLException e) {
            e.printStackTrace();
        }

%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Tailwind Admin Starter Template : Tailwind Toolbox</title>
    <meta name="author" content="name">
    <meta name="description" content="description here">
    <meta name="keywords" content="keywords,here">

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
    <link rel="stylesheet" href="https://unpkg.com/tailwindcss@2.2.19/dist/tailwind.min.css"/> <!--Replace with your tailwind.css once created-->
    <link href="https://afeld.github.io/emoji-css/emoji.css" rel="stylesheet"> <!--Totally optional :) -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js" integrity="sha256-xKeoJ50pzbUGkpQxDYHD7o7hxe0LaOGeguUidbq6vis=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- Inclure Moment.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

    <!-- Inclure un adaptateur de date pour Chart.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/adapters/moment.min.js"></script>
</head>

<body >

<div class="flex">
    <!-- Side Nav -->
    <div class="w-1/7 m-4">
        <jsp:include page="templates/syndic_sidenav.jsp" />
    </div>
    <div class="w-6/7">
<main>
    <% List<Payment> payments = (List<Payment>) session.getAttribute("payments"); %>
    <% List<Charge> charges = (List<Charge>) session.getAttribute("list_Charges"); %>
    <% List<Task> tasks = (List<Task>) session.getAttribute("list_Tasks"); %>
    <div class="flex flex-col md:flex-row">

        <section>
            <div id="main" class="main-content flex-1  mt-12 md:mt-2 pb-24 md:pb-5">

                <div class="flex justify-between items-center p-6 bg-blue-200 shadow-md border rounded-md">
                    <h1 class="text-3xl font-bold text-gray-800">Dashboard</h1>
                    <div class="text-lg text-gray-600"><%=java.time.LocalDate.now()%></div>
                </div>
                <div class="date m-4 text-3xl">
                    Welcome <b><%= ((Syndic) session.getAttribute("syndic")).getFirstName() %>
                </div>

                <div class="flex flex-wrap">
                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Metric Card-->
                        <div class="bg-gradient-to-b from-green-200 to-green-100 border-b-4 border-green-600 rounded-lg shadow-xl p-5">
                            <div class="flex flex-row items-center">
                                <div class="flex-shrink pr-4">
                                    <div class="rounded-full p-5 bg-green-600"><i class="fa fa-wallet fa-2x fa-inverse"></i></div>
                                </div>
                                <div class="flex-1 text-right md:text-center">
                                    <h2 class="font-bold uppercase text-gray-600">Total Revenue</h2>
                                    <p class="font-bold text-3xl"><%=sumpayment%> <span class="text-green-500"><i class="fas fa-caret-up"></i></span></p>
                                </div>
                            </div>
                        </div>
                        <!--/Metric Card-->
                    </div>
                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Metric Card-->
                        <div class="bg-gradient-to-b from-pink-200 to-pink-100 border-b-4 border-pink-500 rounded-lg shadow-xl p-5">
                            <div class="flex flex-row items-center">
                                <div class="flex-shrink pr-4">
                                    <div class="rounded-full p-5 bg-pink-600"><i class="fas fa-users fa-2x fa-inverse"></i></div>
                                </div>
                                <div class="flex-1 text-right md:text-center">
                                    <h2 class="font-bold uppercase text-gray-600">Total Users</h2>
                                    <p class="font-bold text-3xl"><%= userCount %> <span class="text-pink-500"><i class="fas fa-exchange-alt"></i></span></p>
                                </div>
                            </div>
                        </div>
                        <!--/Metric Card-->
                    </div>
                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Metric Card-->
                        <div class="bg-gradient-to-b from-yellow-200 to-yellow-100 border-b-4 border-yellow-600 rounded-lg shadow-xl p-5">
                            <div class="flex flex-row items-center">
                                <div class="flex-shrink pr-4">
                                    <div class="rounded-full p-5 bg-yellow-600"><i class="fas fa-exclamation-triangle fa-2x fa-inverse"></i></div>
                                </div>
                                <div class="flex-1 text-right md:text-center">
                                    <h2 class="font-bold uppercase text-gray-600">Total Incidents</h2>
                                    <p class="font-bold text-3xl"><%= incidentCount %> <span class="text-yellow-600"><i class="fas fa-caret-up"></i></span></p>
                                </div>
                            </div>
                        </div>
                        <!--/Metric Card-->
                    </div>
                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Metric Card-->
                        <div class="bg-gradient-to-b from-blue-200 to-pink-100 border-b-4 border-blue-500 rounded-lg shadow-xl p-5">
                            <div class="flex flex-row items-center">
                                <div class="flex-shrink pr-4">
                                    <div class="rounded-full p-5 bg-red-600"><i class="fas fa-users fa-2x fa-inverse"></i></div>
                                </div>
                                <div class="flex-1 text-right md:text-center">
                                    <h2 class="font-bold uppercase text-gray-600">Total Members</h2>
                                    <p class="font-bold text-3xl"><%= memberCount %></p>
                                </div>
                            </div>
                        </div>
                        <!--/Metric Card-->
                    </div>
                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Metric Card-->
                        <div class="bg-gradient-to-b from-indigo-200 to-indigo-100 border-b-4 border-indigo-500 rounded-lg shadow-xl p-5">
                            <div class="flex flex-row items-center">
                                <div class="flex-shrink pr-4">
                                    <div class="rounded-full p-5 bg-indigo-600"><i class="fas fa-tasks fa-2x fa-inverse"></i></div>
                                </div>
                                <div class="flex-1 text-right md:text-center">
                                    <h2 class="font-bold uppercase text-gray-600">To Do List</h2>
                                    <p class="font-bold text-3xl"><%= taskCount %> tasks</p>
                                </div>
                            </div>
                        </div>
                        <!--/Metric Card-->
                    </div>
                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Metric Card-->
                        <div class="bg-gradient-to-b from-yellow-200 to-blue-100 border-b-4 border-blue-600 rounded-lg shadow-xl p-5">
                            <div class="flex flex-row items-center">
                                <div class="flex-shrink pr-4">
                                    <div class="rounded-full p-5 bg-blue-600"><i class="fas fa-user-plus fa-2x fa-inverse"></i></div>
                                </div>
                                <div class="flex-1 text-right md:text-center">
                                    <h2 class="font-bold uppercase text-gray-600">Total Suppliers</h2>
                                    <p class="font-bold text-3xl"><%= supplierCount %> <span class="text-yellow-600"><i class="fas fa-caret-up"></i></span></p>
                                </div>
                            </div>
                        </div>
                        <!--/Metric Card-->
                    </div>
                </div>



                <div class="flex flex-row flex-wrap flex-grow mt-2">

                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Graph Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">
                            <div class="bg-gradient-to-b from-gray-300 to-gray-100 uppercase text-gray-800 border-b-2 border-gray-300 rounded-tl-lg rounded-tr-lg p-2">
                                <h class="font-bold uppercase text-gray-600">Graph</h>
                            </div>
                            <div class="p-5">
                                <canvas id="paymentsChart" class="chartjs" width="undefined" height="undefined"></canvas>
                                <script>

                                    var paymentsData = <%= new Gson().toJson(payments) %>;

                                    // Données pour le graphique de paiements
                                    // Création d'un objet pour stocker les paiements par mois
                                    var monthlyPayments = {};

                                    // Remplissage de l'objet monthlyPayments avec les montants des paiements pour chaque mois
                                    paymentsData.forEach(function(payment) {
                                        var date = new Date(payment.date);
                                        var month = date.getMonth() + 1; // Les mois vont de 0 à 11, donc on ajoute 1 pour obtenir les mois de 1 à 12
                                        var year = date.getFullYear(); // On obtient l'année

                                        // Créer une clé de mois unique incluant l'année
                                        var monthYear = month + '-' + year;

                                        // Vérifier si le mois existe déjà dans l'objet monthlyPayments
                                        if (monthlyPayments[monthYear]) {
                                            monthlyPayments[monthYear] += payment.amount;
                                        } else {
                                            monthlyPayments[monthYear] = payment.amount;
                                        }
                                    });

                                    // Création de tableaux pour les labels (mois) et les montants des paiements
                                    var paymentMonths = [];
                                    var paymentAmounts = [];

                                    // Boucle pour obtenir les données des 12 derniers mois
                                    var currentDate = new Date();
                                    var month = 0;
                                    for (var i = 0; i < 12; i++) {
                                        var month = month + 1; // Les mois vont de 0 à 11, donc on ajoute 1 pour obtenir les mois de 1 à 12
                                        var year = currentDate.getFullYear(); // On obtient l'année

                                        // Créer une clé de mois unique incluant l'année
                                        var monthYear = month + '-' + year;
                                        paymentMonths.unshift(monthYear); // Ajouter le mois et l'année au début du tableau (pour avoir les mois du plus récent au plus ancien)

                                        // Vérifier si le mois existe dans les paiements, sinon le montant sera 0
                                        paymentAmounts.unshift(monthlyPayments[monthYear] || 0);

                                        // Passer au mois précédent
                                        currentDate.setMonth(currentDate.getMonth() - 1);
                                    }

                                    // Création du graphique des paiements
                                    var paymentsChartCtx = document.getElementById('paymentsChart').getContext('2d');
                                    var paymentsChart = new Chart(paymentsChartCtx, {
                                        type: 'bar',
                                        data: {
                                            labels: paymentMonths,
                                            datasets: [{
                                                label: 'Payments',
                                                data: paymentAmounts,
                                                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                                borderColor: 'rgba(54, 162, 235, 1)',
                                                borderWidth: 1
                                            }]
                                        },
                                        options: {
                                            scales: {
                                                y: {
                                                    beginAtZero: true
                                                }
                                            }
                                        }
                                    });


                                </script>
                            </div>
                        </div>
                        <!--/Graph Card-->
                    </div>

                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Graph Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">
                            <div class="bg-gradient-to-b from-gray-300 to-gray-100 uppercase text-gray-800 border-b-2 border-gray-300 rounded-tl-lg rounded-tr-lg p-2">
                                <h class="font-bold uppercase text-gray-600">Graph</h>
                            </div>
                            <div class="p-5">
                                <canvas id="chargesByCategoryChart" class="chartjs" width="undefined" height="undefined"></canvas>
                                <script>
                                    const charges = <%= new Gson().toJson(charges) %>;
                                    var chargesByCategory = {};
                                    charges.forEach(function(charge) {
                                        var category = charge.chargeCategory;
                                        chargesByCategory[category] = (chargesByCategory[category] || 0) + charge.chargeAmount;
                                    });

                                    var categories = Object.keys(chargesByCategory);
                                    var chargeAmountsByCategory = Object.values(chargesByCategory);

                                    var barColors = [
                                        'rgba(255, 99, 132, 0.8)',
                                        'rgba(54, 162, 235, 0.8)',
                                        'rgba(255, 206, 86, 0.8)',
                                        'rgba(75, 192, 192, 0.8)',
                                        'rgba(153, 102, 255, 0.8)'
                                        // Ajoutez plus de couleurs si nécessaire
                                    ];

                                    var chargesByCategoryChartCtx = document.getElementById('chargesByCategoryChart').getContext('2d');
                                    var chargesByCategoryChart = new Chart(chargesByCategoryChartCtx, {
                                        type: 'bar',
                                        data: {
                                            labels: categories,
                                            datasets: [{
                                                label: 'Montant des Charges par Catégorie',
                                                data: chargeAmountsByCategory,
                                                backgroundColor: barColors,
                                                borderColor: barColors,
                                                borderWidth: 1
                                            }]
                                        },
                                        options: {
                                            responsive: true,
                                        }
                                    });


                                </script>
                            </div>
                        </div>
                        <!--/Graph Card-->
                    </div>

                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Graph Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">
                            <div class="bg-gradient-to-b from-gray-300 to-gray-100 uppercase text-gray-800 border-b-2 border-gray-300 rounded-tl-lg rounded-tr-lg p-2">
                                <h2 class="font-bold uppercase text-gray-600">Graph</h2>
                            </div>
                            <div class="p-5">
                                <canvas id="chargesByDateChart" class="chartjs" width="undefined" height="undefined"></canvas>
                                <script>
                                    var chargesByDate = {};
                                    charges.forEach(function(charge) {
                                        var date = charge.chargeDate;
                                        chargesByDate[date] = (chargesByDate[date] || 0) + charge.chargeAmount;
                                    });

                                    var dates = Object.keys(chargesByDate);
                                    var chargeAmountsByDate = Object.values(chargesByDate);

                                    var lineColor = 'rgba(75, 192, 192, 1)';

                                    var chargesByDateChartCtx = document.getElementById('chargesByDateChart').getContext('2d');
                                    var chargesByDateChart = new Chart(chargesByDateChartCtx, {
                                        type: 'line',
                                        data: {
                                            labels: dates,
                                            datasets: [{
                                                label: 'Évolution des Montants des Charges dans le Temps',
                                                data: chargeAmountsByDate,
                                                fill: false,
                                                borderColor: lineColor,
                                                borderWidth: 2
                                            }]
                                        },
                                        options: {
                                            responsive: true,
                                        }
                                    });




                                </script>
                            </div>
                        </div>
                        <!--/Graph Card-->
                    </div>


                    </div>




                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Table Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">

                        </div>
                        <!--/table Card-->
                    </div>

                </div>




                <div class="flex flex-row flex-wrap flex-grow mt-2">

                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Graph Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">
                            <div class="bg-gradient-to-b from-gray-300 to-gray-100 uppercase text-gray-800 border-b-2 border-gray-300 rounded-tl-lg rounded-tr-lg p-2">
                                <h2 class="font-bold uppercase text-gray-600">Graph</h2>
                            </div>
                            <div class="p-5">
                                <canvas id="paymentsByTypeChart" class="chartjs" width="undefined" height="undefined"></canvas>
                                <script>

                                    var paymentsData = <%= new Gson().toJson(payments) %>;

                                    // Données pour le graphique par type
                                    var paymentTypes = {};
                                    paymentsData.forEach(function(payment) {
                                        if (payment.type in paymentTypes) {
                                            paymentTypes[payment.type] += payment.amount;
                                        } else {
                                            paymentTypes[payment.type] = payment.amount;
                                        }
                                    });

                                    var paymentTypesLabels = Object.keys(paymentTypes);
                                    var paymentTypesData = Object.values(paymentTypes);

                                    var paymentsByTypeChartCtx = document.getElementById('paymentsByTypeChart').getContext('2d');
                                    var paymentsByTypeChart = new Chart(paymentsByTypeChartCtx, {
                                        type: 'pie',
                                        data: {
                                            labels: paymentTypesLabels,
                                            datasets: [{
                                                label: 'Payments by Type',
                                                data: paymentTypesData,
                                                backgroundColor: [
                                                    'rgba(255, 99, 132, 0.4)',
                                                    'rgba(54, 162, 235, 0.4)',
                                                    'rgba(255, 206, 86, 0.4)',
                                                    'rgba(75, 192, 192, 0.4)',
                                                    'rgba(153, 102, 255, 0.4)',
                                                    'rgba(255, 159, 64, 0.4)'
                                                ],
                                                borderColor: [
                                                    'rgba(255, 99, 132, 1)',
                                                    'rgba(54, 162, 235, 1)',
                                                    'rgba(255, 206, 86, 1)',
                                                    'rgba(75, 192, 192, 1)',
                                                    'rgba(153, 102, 255, 1)',
                                                    'rgba(255, 159, 64, 1)'
                                                ],
                                                borderWidth: 1
                                            }]
                                        },
                                        options: {
                                            responsive: true
                                        }
                                    });

                                </script>
                            </div>
                        </div>
                        <!--/Graph Card-->
                    </div>

                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Graph Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">
                            <div class="bg-gradient-to-b from-gray-300 to-gray-100 uppercase text-gray-800 border-b-2 border-gray-300 rounded-tl-lg rounded-tr-lg p-2">
                                <h2 class="font-bold uppercase text-gray-600">Graph</h2>
                            </div>
                            <div class="p-5">
                                <canvas id="paymentsByMethodChart" class="chartjs" width="undefined" height="undefined"></canvas>
                                <script>

                                    var paymentsData = <%= new Gson().toJson(payments) %>;
                                    // Données pour le graphique par méthode
                                    var paymentMethods = {};
                                    paymentsData.forEach(function(payment) {
                                        if (payment.method in paymentMethods) {
                                            paymentMethods[payment.method] += payment.amount;
                                        } else {
                                            paymentMethods[payment.method] = payment.amount;
                                        }
                                    });

                                    var paymentMethodsLabels = Object.keys(paymentMethods);
                                    var paymentMethodsData = Object.values(paymentMethods);

                                    var paymentsByMethodChartCtx = document.getElementById('paymentsByMethodChart').getContext('2d');
                                    var paymentsByMethodChart = new Chart(paymentsByMethodChartCtx, {
                                        type: 'doughnut',
                                        data: {
                                            labels: paymentMethodsLabels,
                                            datasets: [{
                                                label: 'Payments by Method',
                                                data: paymentMethodsData,
                                                backgroundColor: [
                                                    'rgba(255, 99, 132, 0.4)',
                                                    'rgba(54, 162, 235, 0.4)',
                                                    'rgba(255, 206, 86, 0.4)',
                                                    'rgba(75, 192, 192, 0.4)',
                                                    'rgba(153, 102, 255, 0.4)',
                                                    'rgba(255, 159, 64, 0.4)'
                                                ],
                                                borderColor: [
                                                    'rgba(255, 99, 132, 1)',
                                                    'rgba(54, 162, 235, 1)',
                                                    'rgba(255, 206, 86, 1)',
                                                    'rgba(75, 192, 192, 1)',
                                                    'rgba(153, 102, 255, 1)',
                                                    'rgba(255, 159, 64, 1)'
                                                ],
                                                borderWidth: 1
                                            }]
                                        },
                                        options: {
                                            responsive: true
                                        }
                                    });

                                </script>
                            </div>
                        </div>
                        <!--/Graph Card-->
                    </div>


                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Graph Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">
                            <div class="bg-gradient-to-b from-gray-300 to-gray-100 uppercase text-gray-800 border-b-2 border-gray-300 rounded-tl-lg rounded-tr-lg p-2">
                                <h2 class="font-bold uppercase text-gray-600">Graph</h2>
                            </div>
                            <div class="p-5">
                                <canvas id="chargesByFrequencyChart" class="chartjs" width="undefined" height="undefined"></canvas>
                                <script>
                                    var chargesByFrequency = {};
                                    charges.forEach(function(charge) {
                                        var frequency = charge.chargeFrequency;
                                        chargesByFrequency[frequency] = (chargesByFrequency[frequency] || 0) + 1;
                                    });

                                    var frequencies = Object.keys(chargesByFrequency);
                                    var chargeCountsByFrequency = Object.values(chargesByFrequency);

                                    var pieColors = [
                                        'rgba(255, 99, 132, 0.8)',
                                        'rgba(54, 162, 235, 0.8)',
                                        'rgba(255, 206, 86, 0.8)'
                                        // Ajoutez plus de couleurs si nécessaire
                                    ];

                                    var chargesByFrequencyChartCtx = document.getElementById('chargesByFrequencyChart').getContext('2d');
                                    var chargesByFrequencyChart = new Chart(chargesByFrequencyChartCtx, {
                                        type: 'pie',
                                        data: {
                                            labels: frequencies,
                                            datasets: [{
                                                label: 'Répartition des Charges par Fréquence',
                                                data: chargeCountsByFrequency,
                                                backgroundColor: pieColors,
                                                borderColor: pieColors,
                                                borderWidth: 1
                                            }]
                                        },
                                        options: {
                                            responsive: true,
                                            plugins: {
                                                legend: {
                                                    position: 'top',
                                                },
                                                title: {
                                                    display: true,
                                                    text: 'Charges by frequency'
                                                }
                                            }
                                        }
                                    });

                                </script>
                            </div>
                        </div>
                        <!--/Graph Card-->
                    </div>


                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Table Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">

                        </div>
                        <!--/table Card-->
                    </div>

                </div>




                <div class="flex flex-row flex-wrap flex-grow mt-2">

                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Graph Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">
                            <div class="bg-gradient-to-b from-gray-300 to-gray-100 uppercase text-gray-800 border-b-2 border-gray-300 rounded-tl-lg rounded-tr-lg p-2">
                                <h class="font-bold uppercase text-gray-600">Graph</h>
                            </div>
                            <div class="p-5">
                                <canvas id="tasksByStatusChart" class="chartjs" width="undefined" height="undefined"></canvas>
                                <script>
                                    const tasks = <%= new Gson().toJson(tasks) %>;
                                    // Préparer les données pour le diagramme des tâches par statut
                                    const taskStatuses = ['Pending', 'Completed', 'Scheduled'];
                                    const taskStatusCounts = taskStatuses.map(status =>
                                        tasks.filter(task => task.taskStatus === status).length
                                    );

                                    // Créer le diagramme des tâches par statut
                                    const tasksByStatusCtx = document.getElementById('tasksByStatusChart').getContext('2d');
                                    const tasksByStatusChart = new Chart(tasksByStatusCtx, {
                                        type: 'bar',
                                        data: {
                                            labels: taskStatuses,
                                            datasets: [{
                                                label: '# of Tasks',
                                                data: taskStatusCounts,
                                                backgroundColor: ['#ff6384', '#36a2eb', '#ffce56']
                                            }]
                                        },
                                        options: {
                                            responsive: true,

                                        }
                                    });



                                </script>
                            </div>
                        </div>
                        <!--/Graph Card-->
                    </div>


                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Graph Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">
                            <div class="bg-gradient-to-b from-gray-300 to-gray-100 uppercase text-gray-800 border-b-2 border-gray-300 rounded-tl-lg rounded-tr-lg p-2">
                                <h2 class="font-bold uppercase text-gray-600">Graph</h2>
                            </div>
                            <div class="p-5">
                                <canvas id="tasksByAmountChart" class="chartjs" width="undefined" height="undefined"></canvas>
                                <script>
                                    // Récupération des noms de tâches et des montants pour le diagramme par montant
                                    var taskNamesByAmount = tasks.map(function(task) {
                                        return task.taskName;
                                    });
                                    var taskAmounts = tasks.map(function(task) {
                                        return task.taskamount;
                                    });

                                    // Création du diagramme par montant avec plusieurs couleurs
                                    var tasksByAmountChartCtx = document.getElementById('tasksByAmountChart').getContext('2d');
                                    var tasksByAmountChart = new Chart(tasksByAmountChartCtx, {
                                        type: 'bar',
                                        data: {
                                            labels: taskNamesByAmount,
                                            datasets: [{
                                                label: 'Montant',
                                                data: taskAmounts,
                                                backgroundColor: [
                                                    'rgba(255, 99, 132, 0.6)',
                                                    'rgba(54, 162, 235, 0.6)',
                                                    'rgba(255, 206, 86, 0.6)',
                                                    'rgba(75, 192, 192, 0.6)',
                                                    'rgba(153, 102, 255, 0.6)'
                                                    // Ajoutez autant de couleurs que nécessaire
                                                ],
                                                borderColor: [
                                                    'rgba(255, 99, 132, 1)',
                                                    'rgba(54, 162, 235, 1)',
                                                    'rgba(255, 206, 86, 1)',
                                                    'rgba(75, 192, 192, 1)',
                                                    'rgba(153, 102, 255, 1)'
                                                    // Correspondance des couleurs de bordure si nécessaire
                                                ],
                                                borderWidth: 1
                                            }]
                                        },
                                        options: {
                                            scales: {
                                                y: {
                                                    beginAtZero: true,
                                                    position: 'left',
                                                    type: 'linear',
                                                    display: true
                                                }
                                            }
                                        }
                                    });





                                </script>
                            </div>
                        </div>
                        <!--/Graph Card-->
                    </div>

                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Graph Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">
                            <div class="bg-gradient-to-b from-gray-300 to-gray-100 uppercase text-gray-800 border-b-2 border-gray-300 rounded-tl-lg rounded-tr-lg p-2">
                                <h2 class="font-bold uppercase text-gray-600">Graph</h2>
                            </div>
                            <div class="p-5">
                                <canvas id="tasksByMonthChart" class="chartjs" width="undefined" height="undefined"></canvas>
                                <script>
                                    // Récupération des dates de tâches pour le diagramme par mois
                                    var taskDates = tasks.map(function(task) {
                                        return task.taskDueDate;
                                    });

                                    // Comptage des tâches par mois
                                    var tasksByMonth = {};
                                    taskDates.forEach(function(date) {
                                        var month = date.split('-')[1];
                                        tasksByMonth[month] = (tasksByMonth[month] || 0) + 1;
                                    });

                                    // Création du tableau de données pour le diagramme
                                    var months = Object.keys(tasksByMonth);
                                    var taskCounts = Object.values(tasksByMonth);

                                    // Définir des couleurs pour chaque barre du diagramme
                                    var barColors = [
                                        'rgba(255, 99, 132, 0.8)',
                                        'rgba(54, 162, 235, 0.8)',
                                        'rgba(255, 206, 86, 0.8)',
                                        'rgba(75, 192, 192, 0.8)',
                                        'rgba(153, 102, 255, 0.8)',
                                        'rgba(255, 159, 64, 0.8)'
                                    ];

                                    // Création du tableau de datasets pour le diagramme par mois
                                    var datasets = [{
                                        label: 'Nombre de Tâches (Barres)',
                                        data: taskCounts,
                                        backgroundColor: barColors,
                                        borderColor: barColors,
                                        borderWidth: 1
                                    }, {
                                        label: 'Nombre de Tâches (Courbe)',
                                        data: taskCounts,
                                        fill: false,
                                        borderColor: 'rgba(75, 192, 192, 1)',
                                        borderWidth: 2,
                                        type: 'line'
                                    }];

                                    // Création du diagramme par mois avec des barres et une courbe
                                    var tasksByMonthChartCtx = document.getElementById('tasksByMonthChart').getContext('2d');
                                    var tasksByMonthChart = new Chart(tasksByMonthChartCtx, {
                                        type: 'bar',
                                        data: {
                                            labels: months,
                                            datasets: datasets
                                        },
                                        options: {
                                            scales: {
                                                y: {
                                                    beginAtZero: true,
                                                    stepSize: 1
                                                }
                                            }
                                        }
                                    });
                                </script>
                            </div>
                        </div>
                        <!--/Graph Card-->
                    </div>


                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Table Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">

                        </div>
                        <!--/table Card-->
                    </div>

                </div>










                <div class="flex flex-row flex-wrap flex-grow mt-2">

                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Graph Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">
                            <div class="bg-gradient-to-b from-gray-300 to-gray-100 uppercase text-gray-800 border-b-2 border-gray-300 rounded-tl-lg rounded-tr-lg p-2">
                                <h class="font-bold uppercase text-gray-600">Graph</h>
                            </div>
                            <div class="p-5">
                                <canvas id="chartjs-7" class="chartjs" width="undefined" height="undefined"></canvas>
                                <script>
                                    new Chart(document.getElementById("chartjs-7"), {
                                        "type": "bar",
                                        "data": {
                                            "labels": ["January", "February", "March", "April"],
                                            "datasets": [{
                                                "label": "Page Impressions",
                                                "data": [10, 20, 30, 40],
                                                "borderColor": "rgb(255, 99, 132)",
                                                "backgroundColor": "rgba(255, 99, 132, 0.2)"
                                            }, {
                                                "label": "Adsense Clicks",
                                                "data": [5, 15, 10, 30],
                                                "type": "line",
                                                "fill": false,
                                                "borderColor": "rgb(54, 162, 235)"
                                            }]
                                        },
                                        "options": {
                                            "scales": {
                                                "yAxes": [{
                                                    "ticks": {
                                                        "beginAtZero": true
                                                    }
                                                }]
                                            }
                                        }
                                    });
                                </script>
                            </div>
                        </div>
                        <!--/Graph Card-->
                    </div>

                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Graph Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">
                            <div class="bg-gradient-to-b from-gray-300 to-gray-100 uppercase text-gray-800 border-b-2 border-gray-300 rounded-tl-lg rounded-tr-lg p-2">
                                <h2 class="font-bold uppercase text-gray-600">Graph</h2>
                            </div>
                            <div class="p-5">
                                <canvas id="chartjs-0" class="chartjs" width="undefined" height="undefined"></canvas>
                                <script>
                                    new Chart(document.getElementById("chartjs-0"), {
                                        "type": "line",
                                        "data": {
                                            "labels": ["January", "February", "March", "April", "May", "June", "July"],
                                            "datasets": [{
                                                "label": "Views",
                                                "data": [65, 59, 80, 81, 56, 55, 40],
                                                "fill": false,
                                                "borderColor": "rgb(75, 192, 192)",
                                                "lineTension": 0.1
                                            }]
                                        },
                                        "options": {}
                                    });
                                </script>
                            </div>
                        </div>
                        <!--/Graph Card-->
                    </div>

                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Graph Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">
                            <div class="bg-gradient-to-b from-gray-300 to-gray-100 uppercase text-gray-800 border-b-2 border-gray-300 rounded-tl-lg rounded-tr-lg p-2">
                                <h2 class="font-bold uppercase text-gray-600">Graph</h2>
                            </div>
                            <div class="p-5">
                                <canvas id="chartjs-1" class="chartjs" width="undefined" height="undefined"></canvas>
                                <script>
                                    new Chart(document.getElementById("chartjs-1"), {
                                        "type": "bar",
                                        "data": {
                                            "labels": ["January", "February", "March", "April", "May", "June", "July"],
                                            "datasets": [{
                                                "label": "Likes",
                                                "data": [65, 59, 80, 81, 56, 55, 40],
                                                "fill": false,
                                                "backgroundColor": ["rgba(255, 99, 132, 0.2)", "rgba(255, 159, 64, 0.2)", "rgba(255, 205, 86, 0.2)", "rgba(75, 192, 192, 0.2)", "rgba(54, 162, 235, 0.2)", "rgba(153, 102, 255, 0.2)", "rgba(201, 203, 207, 0.2)"],
                                                "borderColor": ["rgb(255, 99, 132)", "rgb(255, 159, 64)", "rgb(255, 205, 86)", "rgb(75, 192, 192)", "rgb(54, 162, 235)", "rgb(153, 102, 255)", "rgb(201, 203, 207)"],
                                                "borderWidth": 1
                                            }]
                                        },
                                        "options": {
                                            "scales": {
                                                "yAxes": [{
                                                    "ticks": {
                                                        "beginAtZero": true
                                                    }
                                                }]
                                            }
                                        }
                                    });
                                </script>
                            </div>
                        </div>
                        <!--/Graph Card-->
                    </div>








                    <div class="w-full md:w-1/2 xl:w-1/3 p-6">
                        <!--Table Card-->
                        <div class="bg-white border-transparent rounded-lg shadow-xl">

                        </div>
                        <!--/table Card-->
                    </div>

                </div>



        </section>

    </div>
</main>
    </div>
</div>


<script>
    document.getElementById("dashboard").classList.add("active");
</script>


<script>
    /*Toggle dropdown list*/
    function toggleDD(myDropMenu) {
        document.getElementById(myDropMenu).classList.toggle("invisible");
    }
    /*Filter dropdown options*/
    function filterDD(myDropMenu, myDropMenuSearch) {
        var input, filter, ul, li, a, i;
        input = document.getElementById(myDropMenuSearch);
        filter = input.value.toUpperCase();
        div = document.getElementById(myDropMenu);
        a = div.getElementsByTagName("a");
        for (i = 0; i < a.length; i++) {
            if (a[i].innerHTML.toUpperCase().indexOf(filter) > -1) {
                a[i].style.display = "";
            } else {
                a[i].style.display = "none";
            }
        }
    }
    // Close the dropdown menu if the user clicks outside of it
    window.onclick = function(event) {
        if (!event.target.matches('.drop-button') && !event.target.matches('.drop-search')) {
            var dropdowns = document.getElementsByClassName("dropdownlist");
            for (var i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (!openDropdown.classList.contains('invisible')) {
                    openDropdown.classList.add('invisible');
                }
            }
        }
    }
</script>
<script>
    document.getElementById("s_dashboard").classList.add("active");
</script>

</body>

</html>