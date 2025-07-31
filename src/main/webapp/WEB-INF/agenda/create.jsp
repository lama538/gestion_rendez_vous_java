<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Créer un Agenda</title>

  <style>

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    html, body {
      height: 100%;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: #333;
      overflow: hidden;
    }

    body {

      background: url('${pageContext.request.contextPath}/images/dent3.jpg');
      background-size: cover;
      position: relative;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }


    body::before {
      content: "";
      position: fixed;
      top: 0; left: 0; right: 0; bottom: 0;
      background: inherit;
      filter: blur(8px) brightness(0.6);
      z-index: -1;
    }

    .container {
      background: rgba(255, 255, 255, 0.95);
      padding: 40px 50px;
      border-radius: 15px;
      max-width: 500px;
      width: 100%;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.25);
      text-align: center;
    }

    .back-link {
      display: inline-block;
      margin-bottom: 30px;
      color: #3498db;
      font-weight: 600;
      text-decoration: none;
      transition: color 0.3s ease;
      font-size: 0.95rem;
    }

    .back-link:hover {
      color: #1d6fa5;
      text-decoration: underline;
    }

    .header h1 {
      font-size: 2.4rem;
      margin-bottom: 10px;
      color: #2c3e50;
      font-weight: 700;
    }

    .header p {
      font-size: 1.1rem;
      color: #555;
      margin-bottom: 30px;
    }

    form {
      text-align: left;
    }

    .form-group {
      margin-bottom: 25px;
    }

    label {
      display: block;
      margin-bottom: 8px;
      font-weight: 600;
      color: #34495e;
      font-size: 1rem;
    }

    select, input[type="time"], input[type="date"] {
      width: 100%;
      padding: 12px 15px;
      font-size: 1rem;
      border: 1.8px solid #ddd;
      border-radius: 8px;
      transition: border-color 0.3s ease;
      background-color: #fff;
      color: #333;
      font-weight: 500;
    }

    select:focus, input[type="time"]:focus, input[type="date"]:focus {
      outline: none;
      border-color: #3498db;
      box-shadow: 0 0 8px rgba(52, 152, 219, 0.5);
      background-color: #fafafa;
    }

    .time-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
    }

    .submit-btn {
      width: 100%;
      padding: 14px 0;
      background-color: #3498db;
      border: none;
      border-radius: 12px;
      color: white;
      font-weight: 700;
      font-size: 1.2rem;
      cursor: pointer;
      transition: background-color 0.3s ease;
      box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
    }

    .submit-btn:hover {
      background-color: #1d6fa5;
      box-shadow: 0 7px 20px rgba(29, 111, 165, 0.6);
    }

    @media (max-width: 480px) {
      .time-row {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>

<div class="container">
  <a href="${pageContext.request.contextPath}/agenda/list" class="back-link">
    ← Retour à la liste
  </a>

  <div class="header">
    <h1>Créer un Agenda</h1>
    <p>Définir les horaires d'un médecin pour une date</p>
  </div>

  <form action="${pageContext.request.contextPath}/agenda/create" method="post">

    <c:choose>
      <c:when test="${currentUser.role == 'admin'}">

        <div class="form-group">
          <label for="medecinUsername">Médecin :</label>
          <select id="medecinUsername" name="medecinUsername" required>
            <option value="">Choisir un médecin</option>
            <c:forEach var="medecin" items="${medecins}">
              <option value="${medecin.username}">${medecin.username}</option>
            </c:forEach>
          </select>
        </div>
      </c:when>
      <c:otherwise>

        <input type="hidden" name="medecinUsername" value="${currentUser.username}" />
        <p><strong>Médecin connecté :</strong> Dr. ${currentUser.username}</p>
      </c:otherwise>
    </c:choose>


    <div class="form-group">
      <label for="dateAgenda">Date :</label>
      <input type="date" id="dateAgenda" name="dateAgenda"
             min="${today}" required />
    </div>

    <div class="time-row">
      <div class="form-group">
        <label for="heureDebut">Heure de début :</label>
        <input type="time" id="heureDebut" name="heureDebut" required />
      </div>

      <div class="form-group">
        <label for="heureFin">Heure de fin :</label>
        <input type="time" id="heureFin" name="heureFin" required />
      </div>
    </div>

    <button type="submit" class="submit-btn">Créer l'Agenda</button>
  </form>
</div>

<script>

  document.querySelector('form').addEventListener('submit', function(e) {
    const heureDebut = document.getElementById('heureDebut').value;
    const heureFin = document.getElementById('heureFin').value;

    if (heureDebut && heureFin && heureFin <= heureDebut) {
      e.preventDefault();
      alert('L\'heure de fin doit être après l\'heure de début');
    }
  });
</script>

</body>
</html>