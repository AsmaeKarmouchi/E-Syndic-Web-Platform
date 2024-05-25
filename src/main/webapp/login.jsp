<%@ page import="com.syndic.beans.Syndic" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Ensias_Syndic</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <!-- Template Stylesheet -->
    <link href="css/style1.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            position: relative;
        }

        body::before {
            content: "";
            background: url("image/background.jpg") center center fixed; /* Ajouter le chemin correct à votre image */
            background-size: cover;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;

            z-index: -1; /* Placez-le en arrière-plan */
        }

        .form-container {
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .logo {
            max-width: 100%;
        }
    </style>
</head>
<body class="flex items-center justify-center h-screen" >

<div class="bg-white p-8 rounded-lg shadow-md w-96 flex flex-col items-center">
    <img src="image/logo.jpg" alt="Logo" class="mx-auto my-4 w-24">
    <h1 class="text-3xl font-extrabold text-gray-800 mb-6">Se Connecter</h1>

    <form action="login" method="post" class="space-y-4">
        <input type="hidden" name="action" value="login">

        <div>
            <label for="residence" class="text-sm font-medium text-gray-600">Residence</label>
            <select id="residence" name="residence" class="mt-1 p-2 w-full border-2 border-gray-300 rounded-md focus:outline-none focus:border-indigo-500" required>
                <option value="">select a residence</option>
                <%
                    List<Syndic> List_syndics = (List<Syndic>) request.getAttribute("List_syndics");

                    if (List_syndics != null) {
                        for (Syndic syndic : List_syndics) {
                %>
                <option value="<%= syndic.getResidenceName() %>"><%= syndic.getResidenceName() %></option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <div>
            <label for="email" class="text-sm font-medium text-gray-600">Email</label>
            <input type="text" id="email" name="email" class="mt-1 p-2 w-full border-2 border-gray-300 rounded-md focus:outline-none focus:border-indigo-500" required>
        </div>

        <div>
            <label for="password" class="text-sm font-medium text-gray-600">Password</label>
            <input type="password" id="password" name="password" class="mt-1 p-2 w-full border-2 border-gray-300 rounded-md focus:outline-none focus:border-indigo-500" required>
        </div>

        <button type="submit" class="mx-auto block w-48 h-12 bg-gradient-to-r from-blue-200 to-blue-200 text-black p-4 rounded-md hover:opacity-90 focus:outline-none focus:ring focus:border-indigo-500">login</button>

        <p class="text-sm text-gray-600 mt-4">Vous n'avez pas de compte? <a href="register" class="text-blue-500">Créer-en un ici</a>.</p>
    </form>
</div>
</body>
</html>
