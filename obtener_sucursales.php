<?php
require __DIR__ . '\conexion\conexion.php';
header('Content-Type: application/json');

if (!isset($_GET['bod_id'])) {
    echo json_encode([]);
    exit;
}

$bod_id = $_GET['bod_id'];

try {
    $stmt = $conn->prepare("SELECT SUC_ID AS id , SUC_nombre as nombre FROM SRP_SUCURSAL WHERE bod_id = :bod_id ORDER BY nombre");
    $stmt->bindParam(':bod_id', $bod_id, PDO::PARAM_INT);
    $stmt->execute();
    $sucursales = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($sucursales);

} catch (Exception $e) {
    echo json_encode(["error" => "Error al obtener sucursales"]);
}

?>