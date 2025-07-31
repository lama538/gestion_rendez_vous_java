<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Liste des utilisateurs</title>
    <style>
        * {
            margin: 0; padding: 0; box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: url('${pageContext.request.contextPath}/images/dent3.jpg') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            position: relative;
            padding: 20px;
        }

        body::before {
            content: "";
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: inherit;
            filter: blur(6px) brightness(0.6);
            z-index: -1;
        }

        .container {
            max-width: 700px;
            margin: 40px auto;
            background: rgba(255, 255, 255, 0.95);
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        h1 {
            font-size: 28px;
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 12px 15px;
            text-align: left;
            font-size: 16px;
        }

        th {
            background-color: #f0f0f0;
            font-weight: 700;
            color: #333;
        }

        tr:nth-child(even) {
            background-color: #fafafa;
        }

        .btn {
            display: inline-block;
            padding: 12px 22px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-right: 15px;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
            border: none;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .button-container {
            text-align: left;
            margin-top: 10px;
        }

        @media (max-width: 600px) {
            h1 {
                font-size: 22px;
            }

            th, td {
                font-size: 14px;
                padding: 10px;
            }

            .btn {
                font-size: 14px;
                padding: 10px 16px;
                margin-bottom: 10px;
                display: block;
                width: 100%;
                text-align: center;
            }

            .button-container {
                text-align: center;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Liste des utilisateurs</h1>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom d'utilisateur</th>
            <th>Rôle</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.id}</td>
                <td>${user.username}</td>
                <td>${user.role}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="button-container">
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">← Retour au Dashboard</a>
        <a href="${pageContext.request.contextPath}/users/create" class="btn btn-primary">+ Ajouter un utilisateur</a>
    </div>
</div>

</body>
</html>
