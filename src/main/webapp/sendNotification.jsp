<%--
  Created by IntelliJ IDEA.
  User: amine
  Date: 26/05/2024
  Time: 11:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Send Notification</title>
</head>
<body>
<h2>Send Notification to All Users</h2>
<form action="sendNotification" method="post">
    <label for="subject">Subject:</label>
    <input type="text" id="subject" name="subject" required>
    <br><br>
    <label for="message">Message:</label>
    <textarea id="message" name="message" rows="4" cols="50" required></textarea>
    <br><br>
    <input type="submit" value="Send Notification">
</form>
</body>
</html>
