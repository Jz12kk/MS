<?php
session_start();
require_once 'config.php';
$casa_id = $_GET['id'];
// Checa se o usuario está logado
if (isset($_SESSION['user_id'])) {
    $user_id = $_SESSION['user_id'];
    $username = $_SESSION['username'];
    $email = $_SESSION['email'];
    $admin = $_SESSION['admin'];
    $image = $_SESSION['image'];
}else {
    $user_id = null;
    $username = null;
    $_SESSION['admin'] = null;
    $_SESSION['email'] = null;
    $_SESSION['image'] = null;
}
if (isset($_GET['id'])) {
    $sql = "SELECT casa.id, casa.endereco, casa.preco, casa.acombinar, casa.dormitorios, casa.casa, casa.bairro , casa.banheiros, casa.venda, casa.cidade, casa.area, casa.estado
    FROM casa
    WHERE casa.id = $casa_id";
$result = mysqli_query($conn, $sql);
if ($result) {
if (mysqli_num_rows($result) > 0) {
    $casas = mysqli_fetch_all($result, MYSQLI_ASSOC);
} else {
    // Não há resultados na consulta
    $casas = array();
}
} else {
// Tratar o erro da consulta SQL
die(mysqli_error($conn));
}
    foreach ($casas as $casa) {
        $tipo = $casa['casa'];
        echo $tipo;
        }
    }
?>
<!DOCTYPE html>
<html>
<head>
    <title>Casas</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <nav>
        <div class="navbar-header">
            <img src="logosalles.png" width="76px" height="9%" onclick="toggleimage()" class="navbar-toggle">
            <button type="button" class="navbar-toggle" id="navbar-toggle2" onclick="toggleMenu()">
                <span class="menu-icon"></span>
                <span class="menu-icon"></span>
                <span class="menu-icon"></span>
            </button>
        </div>
        <ul class="navbar-menu" id="navbar-menu">
            <li><img src="logosalles.png" class="image-logo"></li>
            <li><a href="index.php" id="backgroundblack">Home</a></li>
            <li><a href="chat.php">Chat</a></li>
            <?php
            if ($user_id) { 
            echo '<li><a href="perfil.php?id='.$user_id.'">Perfil</a></li>';
            }
            else {
                echo '<li><a href="login.php">Logar</a></li>
                <li><a href="register.php">Registrar</a></li>';
            }
            ?>
            <li><a href="contato.php">Contate-nos</a></li>
        </ul>
    </nav>

    <main>
    <a href="index.php"><img src="X.png" class="X"></a>
    <?php
    $sql = "SELECT image_path FROM Imagem WHERE id_imovel = $_GET[id]";
    $result = mysqli_query($conn, $sql);
    
    if (!$result) {
        die("Error retrieving images: " . mysqli_error($conn));
    }
    
    while ($row = mysqli_fetch_assoc($result)) {
        if (isset($row['image_paths'])) {
            $serializedImagePaths = $row['image_paths'];
            if (!empty($serializedImagePaths)) {
                $imagePaths = unserialize($serializedImagePaths);
                if (is_array($imagePaths)) {
                    foreach ($imagePaths as $imagePath) {
                        echo "<img src='$imagePath' alt='Image'>";
                    }
                } else {
                    echo "Invalid image paths data.";
                }
            } else {
                echo "Empty image paths.";
            }
        } else {
            echo "Image paths not found.";
        }
    }
    ?>
    </main>

    <footer>
        <p>&copy; 2010 Salles Corretoria. Todos os direitos reservados.</p>
    </footer>

    <script src="script.js"></script>
</body>
</html>
</html>