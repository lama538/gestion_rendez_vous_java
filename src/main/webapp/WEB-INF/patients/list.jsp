<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Liste des Patients</title>
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
      top: 0; left: 0; right: 0; bottom: 0;
      background: inherit;
      filter: blur(6px) brightness(0.6);
      z-index: -1;
    }

    .container {
      max-width: 1000px;
      margin: 40px auto;
      padding: 30px;
      background: rgba(255, 255, 255, 0.95);
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    }

    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
      gap: 10px;
      margin-bottom: 25px;
    }

    .header h1 {
      font-size: 26px;
      color: #333;
    }

    .actions {
      display: flex;
      gap: 10px;
      flex-wrap: wrap;
    }

    .btn {
      padding: 8px 16px;
      border: none;
      border-radius: 5px;
      text-decoration: none;
      font-size: 14px;
      transition: 0.3s;
      cursor: pointer;
    }

    .btn-primary {
      background-color: #007bff;
      color: white;
    }

    .btn-primary:hover {
      background-color: #0056b3;
    }

    .btn-secondary {
      background-color: #6c757d;
      color: white;
    }

    .btn-secondary:hover {
      background-color: #545b62;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
    }

    thead {
      background-color: #007bff;
      color: white;
    }

    th, td {
      padding: 12px;
      text-align: left;
      border: 1px solid #ddd;
    }

    tbody tr:hover {
      background-color: #f1f9ff;
    }

    @media (max-width: 768px) {
      table, thead, tbody, th, td, tr {
        display: block;
      }

      thead tr {
        display: none;
      }

      tr {
        margin-bottom: 15px;
        background: #fff;
        border-radius: 8px;
        padding: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      }

      td {
        position: relative;
        padding-left: 50%;
        border: none;
        border-bottom: 1px solid #eee;
      }

      td::before {
        content: attr(data-label);
        position: absolute;
        left: 10px;
        top: 12px;
        font-weight: bold;
        color: #555;
      }
    }
  </style>
</head>
<body>

<div class="container">
  <div class="header">
    <h1>Liste des Patients</h1>
    <div class="actions">
      <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">← Retour</a>
      <a href="${pageContext.request.contextPath}/patients/create" class="btn btn-primary">+ Ajouter un patient</a>
    </div>
  </div>

  <table>
    <thead>
    <tr>
      <th>ID</th>
      <th>Nom</th>
      <th>Prénom</th>
      <th>Date de naissance</th>
      <th>Téléphone</th>
      <th>Email</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="patient" items="${patients}">
      <tr>
        <td data-label="ID">${patient.id}</td>
        <td data-label="Nom">${patient.nom}</td>
        <td data-label="Prénom">${patient.prenom}</td>
        <td data-label="Date de naissance">${patient.dateNaissance}</td>
        <td data-label="Téléphone">${patient.telephone}</td>
        <td data-label="Email">${patient.email}</td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>

</body>
</html>
