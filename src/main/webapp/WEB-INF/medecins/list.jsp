<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lama.gestion_rendez_vous.Models.User" %>
<%
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des Médecins</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 40px;
            position: relative;
            min-height: 100vh;
            overflow-x: hidden;


            background: url('${pageContext.request.contextPath}/images/dent3.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        body::before {
            content: "";
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: url('${pageContext.request.contextPath}/images/dent3.jpg') no-repeat center center fixed;
            background-size: cover;
            filter: blur(6px) brightness(0.6);
            z-index: -1;
        }


        .container {
            background: #fff;
            max-width: 800px;
            margin: auto;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
        }

        th {
            background-color: #f1f1f1;
        }

        tr:hover {
            background-color: #f9f9f9;
        }

        .no-data {
            text-align: center;
            color: #999;
            padding: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <a class="back-link" href="${pageContext.request.contextPath}/dashboard">← Retour au Dashboard</a>

    <h1>Liste des Médecins</h1>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom d'utilisateur</th>
            <th>Rôle</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<User> medecins = (List<User>) request.getAttribute("medecins");
            if (medecins != null && !medecins.isEmpty()) {
                for (User m : medecins) {
        %>
        <tr>
            <td><%= m.getId() %></td>
            <td><%= m.getUsername() %></td>
            <td><%= m.getRole() %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="3" class="no-data">Aucun médecin trouvé.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

</body>
</html>
