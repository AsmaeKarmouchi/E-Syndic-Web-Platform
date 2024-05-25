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

        <a href="syndics.jsp" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-file text-2xl'></i>
            <h3 class="ml-4">Syndic</h3>
        </a>

        <a href="members.jsp" id="members" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-file text-2xl'></i>
            <h3 class="ml-4">Members</h3>
        </a>

        <a href="displayaccounts" id="displayaccounts" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-line-chart-down text-2xl'></i>
            <h3 class="ml-4">Display Accounts</h3>
        </a>

        <a href="#" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-paper-plane bx-tada text-2xl'></i>
            <h3 class="ml-4">Messages</h3><span class="ml-auto bg-red-500 text-white rounded-full px-2 py-1 text-xs">24</span>
        </a>

        <a href="addpayment" id="addpayment" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='fas fa-money-bill-wave text-2xl'></i>
            <h3 class="ml-4">Payment</h3>
        </a>

        <a href="addsupplier" id="addsupplier" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bxs-group text-2xl'></i>
            <h3 class="ml-4">Suppliers</h3>
        </a>

        <a href="addtask" id="addtask" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-task text-2xl'></i>
            <h3 class="ml-4">Tasks</h3>
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
