<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Créer un patient</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: Arial, sans-serif;
      background: url('${pageContext.request.contextPath}/images/dent3.jpg') no-repeat center center fixed;
      background-size: cover;
    }
    body::before {
      content: "";
      position: fixed;
      top: 0; left: 0; right: 0; bottom: 0;
      background: inherit;
      filter: blur(6px) brightness(0.6);
      z-index: -1;
    }

    .overlay {
      backdrop-filter: blur(10px);
      background-color: rgba(255, 255, 255, 0.6);
      min-height: 100vh;
      padding: 40px;
    }

    h2 {
      text-align: center;
      margin-bottom: 20px;
    }

    .form-container {
      max-width: 500px;
      margin: 0 auto;
      background: rgba(255, 255, 255, 0.85);
      padding: 25px;
      border-radius: 12px;
      box-shadow: 0 8px 24px rgba(0,0,0,0.2);
    }

    .form-container label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }

    .form-container input {
      width: 100%;
      padding: 8px;
      margin-bottom: 15px;
      border: 1px solid #ccc;
      border-radius: 6px;
    }

    .form-container button {
      width: 100%;
      padding: 10px;
      background: #007bff;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }

    .form-container button:hover {
      background: #0056b3;
    }

    .retour {
      display: block;
      text-align: center;
      margin-bottom: 25px;
      color: #007bff;
      text-decoration: none;
    }

    .retour:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<div class="overlay">
  <a href="${pageContext.request.contextPath}/patients/list" class="retour">← Retour à la liste des patients</a>

  <h2>Créer un patient</h2>

  <div class="form-container">
    <form action="${pageContext.request.contextPath}/patients/create" method="post">
      <label for="nom">Nom</label>
      <input type="text" name="nom" id="nom" required>

      <label for="prenom">Prénom</label>
      <input type="text" name="prenom" id="prenom" required>

      <label for="dateNaissance">Date de naissance</label>
      <input type="date" name="dateNaissance" id="dateNaissance" required>

      <label for="telephone">Téléphone</label>
      <input type="text" name="telephone" id="telephone">

      <label for="email">Email</label>
      <input type="text" name="email" id="email" required>

      <button type="submit">Enregistrer</button>
    </form>
  </div>
</div>

</body>
</html>
