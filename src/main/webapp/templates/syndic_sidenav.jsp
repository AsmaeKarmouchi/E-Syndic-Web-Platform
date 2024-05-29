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
    <link rel="stylesheet" href="css/style2.css">
</head>

<body>
<!-----------ASIDE------------->
<aside>
    <div class="top">

        <div class="logo">
            <h2>E-<span class="text-red-500">Syndic</span></h2>
        </div>
        <div class="close" id="close-btn">
            <i class='bx bx-x text-xl text-gray-600'></i>
        </div>
    </div>

    <!----------SIDEBAR---------->
    <div class="sidebar">
        <a href="dashboardSyndic.jsp" id="dashboardSyndic" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bxs-dashboard text-2xl'></i>
            <h3 class="ml-4">Dashboard</h3>
        </a>

        <a href="syndicprofile" id="syndicprofile" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-user text-2xl'></i>
            <h3 class="ml-4">Profile</h3>
        </a>
        <a href="membersbysyndic" id="members" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-file text-2xl'></i>
            <h3 class="ml-4">Members</h3>
        </a>
        <a href="Syndicaddpayment" id="addpayment" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='fas fa-money-bill-wave text-2xl'></i>
            <h3 class="ml-4">Payment</h3>
        </a>
        <a href="Syndicaddtask" id="addtask" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='fas fa-money-bill-wave text-2xl'></i>
            <h3 class="ml-4">Task</h3>
        </a>
        <a href="Syndicaddcharge" id="addcharge" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='fas fa-money-bill-wave text-2xl'></i>
            <h3 class="ml-4">Charge</h3>
        </a>
        <a href="paymentflow.jsp" id="paymentflow" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-file text-2xl'></i>
            <h3 class="ml-4">Payments Flows</h3>
        </a>
        <a href="#" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-paper-plane bx-tada text-2xl'></i>
            <h3 class="ml-4">Messages</h3><span class="ml-auto bg-red-500 text-white rounded-full px-2 py-1 text-xs">24</span>
        </a>
        <a href="addsupplier" id="addsupplier" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bxs-group text-2xl'></i>
            <h3 class="ml-4">Suppliers</h3>
        </a>
        <a href="incident" id="incident" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bxs-crown text-2xl'></i>
            <h3 class="ml-4">Incidents</h3>
        </a>
        <a href="meeting" id="meeting" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-calendar text-2xl'></i>
            <h3 class="ml-4">Meetings</h3>
        </a>

        <a href="news" id="news" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-news text-2xl'></i>
            <h3 class="ml-4">News-comm</h3>
        </a>

        <a href="login" id="logout-link" class="flex items-center p-4 text-gray-700 hover:bg-red-600 hover:text-white transition duration-200">
            <i class='bx bx-log-out-circle text-2xl'></i>
            <h3 class="ml-4">Log Out</h3>
        </a>
    </div>
</aside>
<!---------END OF ASIDE--------->
</body>
</html>
