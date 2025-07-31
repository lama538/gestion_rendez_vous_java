<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Inscription - Cabinet Dentaire</title>
  <style>
    body {
      margin: 0;
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      background: #f0f8ff;
      background-image: url('images/dent4.jpg');
      background-size: cover;
      background-position: center;
      color: #333;
    }

    .overlay {
      background-color: rgba(255, 255, 255, 0.92);
      max-width: 500px;
      margin: 5% auto;
      padding: 30px 40px;
      border-radius: 10px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    }

    h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #005f73;
    }

    input, select, button {
      width: 100%;
      padding: 12px;
      margin: 8px 0 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-sizing: border-box;
    }

    button {
      background-color: #008cba;
      color: white;
      font-weight: bold;
      border: none;
      cursor: pointer;
      transition: background 0.3s;
    }

    button:hover {
      background-color: #005f73;
    }

    .message {
      text-align: center;
      font-size: 14px;
      padding: 10px;
    }

    .success {
      color: green;
    }

    .error {
      color: red;
    }

    .img-top {
      width: 100%;
      height: 180px;
      object-fit: cover;
      border-radius: 10px;
      margin-bottom: 20px;
    }

  </style>
</head>
<body>
<div class="overlay">
  <img src="images/Doctors.gif" class="img-top" alt="Dentist illustration">

  <h2>Créer un compte</h2>
  <form method="post" action="${pageContext.request.contextPath}/register">
    <label>Nom d'utilisateur :</label>
    <input type="text" name="username" required>

    <label>Mot de passe :</label>
    <input type="password" name="password" required>

    <label>Rôle :</label>
    <select name="role" required>
      <option value="secretaire" selected>Secrétaire</option>
      <option value="medecin">Médecin</option>
    </select>

    <button type="submit">S’inscrire</button>
  </form>

  <c:if test="${not empty error}">
    <div class="message error">${error}</div>
  </c:if>

  <c:if test="${not empty success}">
    <div class="message success">${success}</div>
  </c:if>

  <div class="message">
    Vous avez déjà un compte ?
    <a href="${pageContext.request.contextPath}/login">Se connecter</a>
  </div>
</div>
</body>
</html>
