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
            <h2>E-<span class="danger">Syndic</span></h2>
        </div>
        <div class="close" id="close-btn">
            <i class='bx bx-x'></i>
        </div>
    </div>

    <!----------SIDEBAR---------->
    <div class="sidebar">
        <a href="admin.jsp" id ="dashboard">
            <i class='bx bxs-dashboard' ></i>
            <h3>Dashboard</h3>
        </a>

        <a href="addsyndic" id="addsyndic" >
            <i class='bx bx-user' ></i>
            <h3>Add Syndic</h3>
        </a>

        <a href="addmember" id="addmember">
            <i class='bx bx-user' ></i>
            <h3>Add Members</h3>
        </a>

        <a href="syndics.jsp">
            <i class='bx bx-file'></i>
            <h3>Syndic</h3>
        </a>

        <a href="members.jsp" id="members">
            <i class='bx bx-file'></i>
            <h3>Members</h3>
        </a>

        <a href="displayaccounts" id="displayaccounts">
            <i class='bx bx-line-chart-down'></i>
            <h3>displayaccounts</h3>
        </a>

        <a href="#">
            <i class='bx bx-paper-plane bx-tada' ></i>
            <h3>Messages</h3><span class="message-count">24</span>
        </a>

        <a href="addpayment" id="addpayment">
            <i class='fas fa-money-bill-wave'></i>
            <h3>Payment</h3>
        </a>

        <a href="addsupplier" id="addsupplier">
            <i class='bx bxs-group'></i>
            <h3>Suppliers</h3>
        </a>
        <a href="addtask" id="addtask">
            <i class='bx bx-task'></i>
            <h3>Tasks</h3>
        </a>


        <a href="login" id="logout-link">
            <i class='bx bx-log-out-circle'></i>
            <h3>Log Out</h3>
        </a>

    </div>
</aside>
<!---------END OF ASIDE--------->
</body>
</html>
