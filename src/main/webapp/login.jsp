<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Connexion</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background-image: url('images/dent6.png');
      background-size: cover;
      background-position: center;
      height: 100vh;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .container {
      display: flex;
      background: white;
      border-radius: 15px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
      overflow: hidden;
      width: 800px;
      max-width: 90%;
    }

    .image-side {
      width: 50%;
      background-image: url('images/dent3.jpg');
      background-size: cover;
      background-position: center;
    }

    .form-side {
      width: 50%;
      padding: 40px;
    }

    h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #333;
    }

    label {
      display: block;
      margin-bottom: 8px;
      font-weight: 500;
      color: #555;
    }

    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 12px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 6px;
    }

    button {
      width: 100%;
      padding: 12px;
      background-color: #2193b0;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
    }

    button:hover {
      background-color: #176c87;
    }

    .error {
      color: red;
      text-align: center;
      margin-top: 10px;
    }

    .register-link {
      text-align: center;
      margin-top: 15px;
    }

    .register-link a {
      color: #2193b0;
      text-decoration: none;
      font-weight: bold;
    }

    .register-link a:hover {
      text-decoration: underline;
    }

    @media screen and (max-width: 768px) {
      .container {
        flex-direction: column;
      }

      .image-side {
        display: none;
      }

      .form-side {
        width: 100%;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="image-side"></div>
  <div class="form-side">
    <h2>Connexion</h2>
    <form method="post" action="${pageContext.request.contextPath}/login">
      <label>Nom d'utilisateur :</label>
      <input type="text" name="username" required>

      <label>Mot de passe :</label>
      <input type="password" name="password" required>

      <button type="submit">Se connecter</button>
    </form>
    <p class="error">${error}</p>
    <div class="register-link">
      <p>Pas encore inscrit ? <a href="${pageContext.request.contextPath}/register">S'inscrire</a></p>
    </div>
  </div>
</div>
</body>
</html>
