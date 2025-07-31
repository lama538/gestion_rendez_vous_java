<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Créer un rendez-vous</title>
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
      max-width: 700px;
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

    .form-group {
      margin-bottom: 20px;
    }

    label {
      display: block;
      margin-bottom: 8px;
      font-weight: bold;
      color: #333;
    }

    input,
    select {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 16px;
    }

    input:focus,
    select:focus {
      outline: none;
      border-color: #007bff;
      background-color: #f0f8ff;
    }

    button[type="submit"] {
      display: block;
      width: 100%;
      padding: 12px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    button[type="submit"]:hover {
      background-color: #0056b3;
    }

    .back-link {
      display: inline-block;
      margin-top: 20px;
      color: #007bff;
      text-decoration: none;
      padding: 8px 14px;
      border-radius: 5px;
      background-color: #e7f0ff;
    }

    .back-link:hover {
      background-color: #d0e7ff;
    }

    @media (max-width: 600px) {
      input,
      select {
        font-size: 14px;
      }

      button {
        font-size: 14px;
      }
    }
  </style>
</head>
<body>

<div class="container">
  <h1>Créer un rendez-vous</h1>

  <form action="${pageContext.request.contextPath}/rdvs/create" method="post">

    <div class="form-group">
      <label for="patientId">Patient</label>
      <select id="patientId" name="patientId" required>
        <option value="">Sélectionner un patient</option>
        <c:forEach var="patient" items="${patients}">
          <option value="${patient.id}">${patient.nom} ${patient.prenom}</option>
        </c:forEach>
      </select>
    </div>


    <div class="form-group">
      <label for="medecinId">Médecin</label>
      <select id="medecinId" name="medecinId" required>
        <option value="">Sélectionner un médecin</option>
        <c:forEach var="medecin" items="${medecins}">
          <option value="${medecin.id}">${medecin.username}</option>
        </c:forEach>
      </select>
    </div>


    <div class="form-group">
      <label for="dateRdv">Date du rendez-vous</label>
      <input type="date" id="dateRdv" name="dateRdv" required />
    </div>


    <div class="form-group">
      <label for="heureRdv">Heure du rendez-vous</label>
      <input type="time" id="heureRdv" name="heureRdv" required />
    </div>


    <div class="form-group">
      <label for="statut">Statut</label>
      <select id="statut" name="statut" required>
        <option value="">Sélectionner un statut</option>
        <option value="en_attente">En attente</option>
        <option value="confirme">Confirmé</option>
        <option value="annule">Annulé</option>
      </select>
    </div>

    <button type="submit">Créer le rendez-vous</button>
  </form>

  <a href="${pageContext.request.contextPath}/rdvs/list" class="back-link">← Retour à la liste</a>
</div>

</body>
</html>
