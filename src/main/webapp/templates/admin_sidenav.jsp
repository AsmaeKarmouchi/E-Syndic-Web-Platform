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
            <i class='bx bx-x text-2xl text-gray-600'></i>
        </div>
    </div>

    <!----------SIDEBAR---------->
    <div class="sidebar">
        <a href="admin.jsp" id="dashboard" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bxs-dashboard text-2xl'></i>
            <h3 class="ml-4">Dashboard</h3>
        </a>

        <a href="addsyndic" id="addsyndic" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-user-plus text-2xl'></i>
            <h3 class="ml-4">Add Syndic</h3>
        </a>

        <a href="addmember" id="addmember" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-user-plus text-2xl'></i>
            <h3 class="ml-4">Add Members</h3>
        </a>

        <a href="syndics.jsp" id="syndics" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-file text-2xl'></i>
            <h3 class="ml-4">Syndic</h3>
        </a>

        <a href="members.jsp" id="members" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-file text-2xl'></i>
            <h3 class="ml-4">Members</h3>
        </a>


        <a href="#" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-paper-plane bx-tada text-2xl'></i>
            <h3 class="ml-4">Messages</h3><span class="ml-auto bg-red-500 text-white rounded-full px-2 py-1 text-xs">24</span>
        </a>
        <a href="paymentsflows.jsp" id="paymentflow" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-money text-2xl'></i>
            <h3 class="ml-4">Payments flows</h3>
        </a>
        <a href="displayaccounts" id="displayaccounts" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-line-chart-down text-2xl'></i>
            <h3 class="ml-4">Display Accounts</h3>
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
