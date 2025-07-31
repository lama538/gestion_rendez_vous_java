<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Liste des rendez-vous</title>
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
        }

        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: inherit;
            filter: blur(6px) brightness(0.6);
            z-index: -1;
        }

        .container {
            max-width: 1000px;
            margin: 50px auto;
            background-color: rgba(255, 255, 255, 0.95);
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #f0f0f0;
            color: #333;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }

        a.button {
            padding: 10px 20px;
            text-decoration: none;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            font-size: 16px;
            margin: 5px 0;
            transition: background-color 0.3s ease;
        }

        a.button:hover {
            background-color: #0056b3;
        }

        @media (max-width: 600px) {
            table, th, td {
                font-size: 14px;
            }

            h1 {
                font-size: 22px;
            }

            .button-container {
                flex-direction: column;
                gap: 10px;
                align-items: stretch;
            }

            a.button {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="button-container">
        <a href="${pageContext.request.contextPath}/dashboard" class="button">← Retour au Dashboard</a>
        <a href="${pageContext.request.contextPath}/rdvs/create" class="button">+ Ajouter un rendez-vous</a>
    </div>

    <h1>Liste des rendez-vous</h1>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Patient</th>
            <th>Médecin</th>
            <th>Date</th>
            <th>Statut</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="rdv" items="${rdvs}">
            <tr>
                <td>${rdv.id}</td>
                <td>
                    <c:forEach var="p" items="${patients}">
                        <c:if test="${p.id == rdv.patientId}">
                            ${p.nom} ${p.prenom}
                        </c:if>
                    </c:forEach>
                </td>
                <td>
                    <c:forEach var="m" items="${medecins}">
                        <c:if test="${m.id == rdv.medecinId}">
                            ${m.username}
                        </c:if>
                    </c:forEach>
                </td>
                <td>
                    <fmt:formatDate value="${rdv.dateRdv}" pattern="dd/MM/yyyy HH:mm" />
                </td>
                <td>${rdv.statut}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
