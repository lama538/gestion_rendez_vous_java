<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Accueil</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-image: url('images/dent7.jpg');
            background-size: cover;
            background-position: center;
            height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .content {
            background-color: rgba(255, 255, 255, 0.85);
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        h1 {
            font-size: 36px;
            color: #333;
            margin-bottom: 30px;
        }

        a {
            display: inline-block;
            margin: 10px;
            padding: 12px 24px;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            color: white;
            background-color: #2193b0;
            border-radius: 8px;
            transition: background-color 0.3s;
        }

        a:hover {
            background-color: #176c87;
        }
    </style>
</head>
<body>
<div class="content">
    <h1>Bienvenue A MediCare!</h1>
    <a href="register.jsp">Inscription</a>
    <a href="login.jsp">Connexion</a>
</div>
</body>
</html>
