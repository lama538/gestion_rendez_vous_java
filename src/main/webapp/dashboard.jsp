<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.lama.gestion_rendez_vous.Models.User" %>
<%
  if (session == null || session.getAttribute("user") == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
  }

  User user = (User) session.getAttribute("user");
  String role = user.getRole().toLowerCase();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <title>Dashboard - <%= role.toUpperCase() %></title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <style>

    * {
      margin: 0; padding: 0; box-sizing: border-box;
    }
    body, html {
      height: 100%;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: url('${pageContext.request.contextPath}/images/dent4.jpg') no-repeat center center fixed;
      background-size: cover;
      color: #333;
      position: relative;
      min-height: 100vh;
    }

    body::before {
      content: "";
      position: fixed;
      top: 0; left: 0; right: 0; bottom: 0;
      background: rgba(52, 152, 219, 0.75);
      z-index: -1;
    }


    .header {
      background-color: rgba(44, 62, 80, 0.85);
      color: white;
      padding: 1rem 2rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 3px 10px rgba(0,0,0,0.3);
      position: sticky;
      top: 0;
      z-index: 10;
      backdrop-filter: blur(5px);
      border-bottom: 2px solid #2980b9;
    }
    .logo {
      display: flex;
      align-items: center;
      gap: 12px;
      font-size: 1.7rem;
      font-weight: 900;
      letter-spacing: 2px;
    }
    .logo i {
      color: #1abc9c;
      font-size: 2.2rem;
      text-shadow: 0 0 8px #1abc9c;
    }
    .user-info {
      display: flex;
      align-items: center;
      gap: 22px;
      font-weight: 600;
      font-size: 1rem;
    }
    .user-role {
      background-color: #2980b9;
      padding: 6px 20px;
      border-radius: 25px;
      font-size: 0.95rem;
      text-transform: uppercase;
      box-shadow: 0 0 8px #2980b9;
      letter-spacing: 1px;
    }
    .logout-btn {
      background-color: #e74c3c;
      padding: 9px 18px;
      border-radius: 6px;
      color: white;
      font-weight: 700;
      text-decoration: none;
      display: flex;
      align-items: center;
      gap: 8px;
      transition: background-color 0.3s ease;
      box-shadow: 0 0 10px #e74c3c;
    }
    .logout-btn:hover {
      background-color: #c0392b;
      box-shadow: 0 0 15px #c0392b;
    }


    .container {
      max-width: 1100px;
      margin: 3rem auto 4rem;
      padding: 0 1.5rem;
    }


    .welcome {
      background-color: rgba(255,255,255,0.95);
      padding: 2.5rem 2rem;
      border-radius: 14px;
      box-shadow: 0 8px 30px rgba(0,0,0,0.12);
      margin-bottom: 3rem;
      text-align: center;
      font-weight: 600;
      color: #34495e;
      letter-spacing: 0.04em;
    }
    .welcome h1 {
      font-size: 2.8rem;
      margin-bottom: 1rem;
      font-weight: 900;
      color: #2980b9;
      text-shadow: 0 1px 3px rgba(41, 128, 185, 0.8);
    }
    .welcome p {
      font-size: 1.3rem;
      max-width: 700px;
      margin: 0 auto;
      color: #34495e;
      line-height: 1.5;
    }


    .actions {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 2rem;
    }
    .action-card {
      background-color: rgba(255,255,255,0.95);
      border-radius: 16px;
      padding: 2rem 1.5rem;
      box-shadow: 0 10px 25px rgba(0,0,0,0.15);
      text-align: center;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
      user-select: none;
    }
    .action-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 20px 40px rgba(0,0,0,0.25);
    }
    .action-card i {
      font-size: 4rem;
      color: #2980b9;
      margin-bottom: 1.3rem;
      filter: drop-shadow(0 0 3px #2980b9);
    }
    .action-card h3 {
      color: #2c3e50;
      margin-bottom: 0.8rem;
      font-size: 1.5rem;
      font-weight: 800;
      letter-spacing: 0.03em;
    }
    .action-card p {
      color: #555;
      margin-bottom: 1.4rem;
      font-size: 1.1rem;
      min-height: 60px;
    }
    .btn {
      background-color: #2980b9;
      color: white;
      padding: 12px 28px;
      border-radius: 30px;
      text-decoration: none;
      font-weight: 700;
      font-size: 1.05rem;
      box-shadow: 0 5px 15px rgba(41, 128, 185, 0.6);
      transition: background-color 0.3s ease, box-shadow 0.3s ease;
      display: inline-block;
      user-select: none;
    }
    .btn:hover {
      background-color: #1f618d;
      box-shadow: 0 8px 25px rgba(31, 97, 141, 0.8);
    }


    @media (max-width: 768px) {
      .header {
        flex-direction: column;
        gap: 12px;
        text-align: center;
      }
      .user-info {
        flex-direction: column;
        gap: 10px;
      }
      .welcome h1 {
        font-size: 2rem;
      }
      .welcome p {
        font-size: 1.1rem;
      }
      .actions {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>

<div class="header">
  <div class="logo">
    <i class="fas fa-heartbeat"></i> MediDental
  </div>
  <div class="user-info">
    <span>Bonjour, <%= user.getUsername() %></span>
    <span class="user-role"><%= role %></span>
    <a href="<%= request.getContextPath() %>/logout" class="logout-btn" title="Déconnexion">
      <i class="fas fa-sign-out-alt"></i> Déconnexion
    </a>
  </div>
</div>

<div class="container">
  <div class="welcome">
    <h1>Tableau de bord</h1>
    <p>
      <% if ("admin".equals(role)) { %>
      Gérez les utilisateurs et supervisez le système.
      <% } else if ("medecin".equals(role)) { %>
      Consultez votre planning, vos rendez-vous et vos patients.
      <% } else if ("secretaire".equals(role)) { %>
      Organisez les rendez-vous, gérez les patients et consultez la liste des médecins.
      <% } else if ("patient".equals(role)) { %>
      Prenez rendez-vous et consultez vos informations.
      <% } %>
    </p>
  </div>

  <div class="actions">
    <% if ("admin".equals(role)) { %>

    <div class="action-card">
      <i class="fas fa-users"></i>
      <h3>Utilisateurs</h3>
      <p>Gérer tous les utilisateurs du système</p>
      <a href="<%= request.getContextPath() %>/users/list" class="btn">Voir la liste</a>
    </div>

    <div class="action-card">
      <i class="fas fa-user-md"></i>
      <h3>Médecins</h3>
      <p>Gérer les comptes médecins</p>
      <a href="<%= request.getContextPath() %>/medecins/list" class="btn">Voir la liste</a>
    </div>

    <div class="action-card">
      <i class="fas fa-user-injured"></i>
      <h3>Patients</h3>
      <p>Gérer les comptes patients</p>
      <a href="<%= request.getContextPath() %>/patients/list" class="btn">Voir la liste</a>
    </div>

    <div class="action-card">
      <i class="fas fa-calendar-check"></i>
      <h3>Rendez-vous</h3>
      <p>Voir tous les rendez-vous</p>
      <a href="<%= request.getContextPath() %>/rdvs/list" class="btn">Voir le planning</a>
    </div>

    <% } else if ("medecin".equals(role)) { %>

    <div class="action-card">
      <i class="fas fa-calendar-check"></i>
      <h3>Mes Rendez-vous</h3>
      <p>Consulter vos rendez-vous</p>
      <a href="<%= request.getContextPath() %>/rdvs/list" class="btn">Voir mes RDV</a>
    </div>

    <div class="action-card">
      <i class="fas fa-user-injured"></i>
      <h3>Mes Patients</h3>
      <p>Consulter la liste de vos patients</p>
      <a href="<%= request.getContextPath() %>/patients/list" class="btn">Voir les patients</a>
    </div>

    <div class="action-card">
      <i class="fas fa-calendar-day"></i>
      <h3>Mon Agenda</h3>
      <p>Gérer votre planning</p>
      <a href="<%= request.getContextPath() %>/agenda/list" class="btn">Mon planning</a>
    </div>

    <% } else if ("secretaire".equals(role)) { %>

    <div class="action-card">
      <i class="fas fa-calendar-check"></i>
      <h3>Rendez-vous</h3>
      <p>Voir tous les rendez-vous</p>
      <a href="<%= request.getContextPath() %>/rdvs/list" class="btn">Voir les RDV</a>
    </div>

    <div class="action-card">
      <i class="fas fa-user-injured"></i>
      <h3>Patients</h3>
      <p>Consulter la liste des patients</p>
      <a href="<%= request.getContextPath() %>/patients/list" class="btn">Voir les patients</a>
    </div>

    <div class="action-card">
      <i class="fas fa-user-md"></i>
      <h3>Médecins</h3>
      <p>Consulter la liste des médecins</p>
      <a href="<%= request.getContextPath() %>/medecins/list" class="btn">Voir les médecins</a>
    </div>

    <% } %>
  </div>
</div>

</body>
</html>
