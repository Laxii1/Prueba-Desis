<?php
require  __DIR__ . '\conexion\conexion.php';
header('Content-Type: application/json');

if (!isset($_GET['pro_codigo'])) {
    echo json_encode(["existe" => false]);
    exit;
}

$pro_codigo = trim($_GET['pro_codigo']);

try {
    $stmt = $conn->prepare("SELECT COUNT(*) FROM SRP_PRODUCTO WHERE pro_codigo = :pro_codigo");
    $stmt->bindParam(':pro_codigo', $pro_codigo, PDO::PARAM_STR);
    $stmt->execute();
    $existe = $stmt->fetchColumn() > 0;
    echo json_encode(["existe" => $existe]);

} catch (Exception $e) {
    echo json_encode(["existe" => false, "error" => "Error en la consulta"]);
}

?>