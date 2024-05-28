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


        <a href="memberprofile" id="memberprofile" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-user text-2xl'></i>
            <h3 class="ml-4">Profile</h3>
        </a>

        <a href="property" id="property" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bx-file text-2xl'></i>
            <h3 class="ml-4">Property</h3>
        </a>

        <a href="meetingM" id="meetingM" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bxs-crown text-2xl'></i>
            <h3 class="ml-4">Meetings</h3>
        </a>

        <a href="memberpayment.jsp" id="memberpaiment" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bxs-error-circle text-2xl'></i>
            <h3 class="ml-4">My payments</h3>
        </a>

        <a href="membernews.jsp" id="membernews" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bxs-error-circle text-2xl'></i>
            <h3 class="ml-4">Residence News</h3>
        </a>

        <a href="incidentM" id="incidentM" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bxs-error-circle text-2xl'></i>
            <h3 class="ml-4">Report Incident</h3>
        </a>

        <a href="membertask.jsp" id="membertask" class="flex items-center p-4 text-gray-700 hover:bg-indigo-600 hover:text-white transition duration-200">
            <i class='bx bxs-error-circle text-2xl'></i>
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
