<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Liste des Agendas</title>
  <style>
    /* Styles globaux simplifiés */
    * {
      margin: 0; padding: 0; box-sizing: border-box;
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
      max-width: 1200px;
      margin: 40px auto;
      padding: 20px;
      background: rgba(255, 255, 255, 0.95);
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    }

    .header {
      padding: 20px 0;
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
      gap: 15px;
    }

    .header h1 {
      color: #333;
    }

    .header-actions {
      display: flex;
      gap: 10px;
      align-items: center;
      flex-wrap: wrap;
    }

    .btn {
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      text-decoration: none;
      cursor: pointer;
      font-size: 14px;
      transition: background-color 0.3s ease;
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

    .search-box {
      padding: 8px 12px;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 14px;
      width: 200px;
    }

    .content {
      margin-top: 20px;
    }

    .table-container {
      overflow-x: auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
    }

    th, td {
      padding: 12px;
      text-align: left;
      border-bottom: 1px solid #ddd;
    }

    th {
      background-color: #f8f9fa;
      font-weight: bold;
      color: #333;
    }

    tbody tr:hover {
      background-color: #f1f1f1;
    }


    .date-badge {
      display: inline-block;
      padding: 4px 10px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: bold;
      color: #333;
      background-color: #e9ecef;
      min-width: 90px;
      text-align: center;
      font-family: monospace;
    }

    .time-display {
      font-family: monospace;
      font-weight: bold;
      color: #495057;
    }

    .empty-message {
      text-align: center;
      padding: 40px;
      color: #666;
    }

    .empty-message h3 {
      margin-bottom: 10px;
    }

    @media (max-width: 768px) {
      .header {
        flex-direction: column;
        align-items: stretch;
      }

      .header-actions {
        justify-content: space-between;
      }

      .search-box {
        width: 100%;
        margin-bottom: 10px;
      }

      table, thead, tbody, th, td, tr {
        display: block;
      }

      thead tr {
        display: none;
      }

      tr {
        border: 1px solid #ccc;
        margin-bottom: 10px;
        padding: 10px;
        border-radius: 5px;
        background: #fff;
      }

      td {
        border: none;
        position: relative;
        padding: 8px 0;
      }

      td:before {
        content: attr(data-label) ": ";
        font-weight: bold;
        display: inline-block;
        width: 120px;
      }
    }
  </style>
</head>
<body>

<div class="container">
  <div class="header">
    <h1>Liste des Agendas</h1>
    <div class="header-actions">
      <input type="text" class="search-box" placeholder="Rechercher..." id="searchInput" />
      <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">← Retour</a>
      <a href="${pageContext.request.contextPath}/agenda/create" class="btn btn-primary">+ Nouvel Agenda</a>
    </div>
  </div>

  <div class="content">
    <c:choose>
      <c:when test="${empty agendas}">
        <div class="empty-message">
          <h3>Aucun agenda trouvé</h3>
          <p>Commencez par créer votre premier agenda.</p>
          <a href="${pageContext.request.contextPath}/agenda/create" class="btn btn-primary">Créer un agenda</a>
        </div>
      </c:when>
      <c:otherwise>
        <div class="table-container">
          <table id="agendaTable">
            <thead>
            <tr>
              <th>ID</th>
              <th>Médecin</th>
              <th>Date</th>
              <th>Heure de début</th>
              <th>Heure de fin</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="agenda" items="${agendas}">
              <tr>
                <td data-label="ID">${agenda.id}</td>
                <td data-label="Médecin">Dr. ${agenda.medecin.username}</td>
                <td data-label="Date">
                  <span class="date-badge">${agenda.dateAgenda}</span>
                </td>
                <td data-label="Heure de début">
                  <span class="time-display">${agenda.heureDebut}</span>
                </td>
                <td data-label="Heure de fin">
                  <span class="time-display">${agenda.heureFin}</span>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<script>
  document.getElementById('searchInput').addEventListener('input', function () {
    const searchValue = this.value.toLowerCase();
    const rows = document.querySelectorAll('#agendaTable tbody tr');
    rows.forEach(row => {
      row.style.display = row.textContent.toLowerCase().includes(searchValue) ? '' : 'none';
    });
  });
</script>

</body>
</html>
