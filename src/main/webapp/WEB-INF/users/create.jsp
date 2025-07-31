<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Créer un utilisateur</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
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
            max-width: 600px;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        h1 {
            font-size: 26px;
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        input, select {
            padding: 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        input:focus, select:focus {
            outline: none;
            border-color: #007bff;
            background-color: #f0f8ff;
        }

        button {
            padding: 14px;
            background-color: #007bff;
            border: none;
            color: white;
            font-size: 18px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        .button-container {
            margin-top: 25px;
            text-align: left;
        }

        a.button-link {
            text-decoration: none;
            color: white;
            background-color: #6c757d;
            padding: 12px 18px;
            border-radius: 8px;
            font-size: 16px;
            display: inline-block;
            transition: background-color 0.3s ease;
        }

        a.button-link:hover {
            background-color: #5a6268;
        }

        @media (max-width: 600px) {
            input, select, button {
                font-size: 14px;
                padding: 12px;
            }

            h1 {
                font-size: 22px;
            }

            .button-container {
                text-align: center;
            }

            a.button-link {
                width: 100%;
                display: block;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Créer un utilisateur</h1>

    <form action="${pageContext.request.contextPath}/users/create" method="post">
        <input type="text" name="username" placeholder="Nom d'utilisateur" required />
        <input type="password" name="password" placeholder="Mot de passe" required />
        <select name="role" required>
            <option value="">-- Sélectionner un rôle --</option>
            <option value="admin">Admin</option>
            <option value="secretaire">Secrétaire</option>
            <option value="medecin">Médecin</option>
        </select>
        <button type="submit">Créer</button>
    </form>

    <div class="button-container">
        <a href="${pageContext.request.contextPath}/users/list" class="button-link">← Retour à la liste</a>
    </div>
</div>

</body>
</html>
