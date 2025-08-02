<?php
require  __DIR__ . '\conexion\conexion.php';
header('Content-Type: application/json');

$data = json_decode(file_get_contents("php://input"), true);

$campos = ['codigo', 'nombre', 'bodega', 'sucursal', 'moneda', 'precio', 'descripcion', 'materiales'];
foreach ($campos as $campo) {
    if (!isset($data[$campo]) || empty($data[$campo])) {
        echo json_encode(["success" => false, "error" => "Falta el campo: $campo"]);
        exit;
    }
}

$codigo      = trim($data['codigo']);
$nombre      = trim($data['nombre']);
$bodega_id   = (int) $data['bodega'];
$sucursal_id = (int) $data['sucursal'];
$moneda_id   = (int) $data['moneda'];
$precio      = (float) $data['precio'];
$descripcion = trim($data['descripcion']);
$materiales  = $data['materiales'];

if (!is_array($materiales) || count($materiales) < 2) {
    echo json_encode(["success" => false, "error" => "Debe seleccionar al menos dos materiales"]);
    exit;
}

try {
    $conn->beginTransaction();

    $stmt = $conn->prepare("INSERT INTO SRP_PRODUCTO (pro_codigo, pro_nombre, bod_id, suc_id, mon_id, pro_precio, pro_descripcion)
                            VALUES (:codigo, :nombre, :bodega_id, :sucursal_id, :moneda_id, :precio, :descripcion)");
    $stmt->execute([
        ':codigo' => $codigo,
        ':nombre' => $nombre,
        ':bodega_id' => $bodega_id,
        ':sucursal_id' => $sucursal_id,
        ':moneda_id' => $moneda_id,
        ':precio' => $precio,
        ':descripcion' => $descripcion
    ]);

    $producto_id = $conn->lastInsertId("srp_producto_pro_id_seq");

    $stmtMat = $conn->prepare("INSERT INTO SRP_MAT_PRO (pro_id, mat_id) VALUES (:producto_id, :material_id)");

    foreach ($materiales as $material_id) {
        $stmtMat->execute([
            ':producto_id' => $producto_id,
            ':material_id' => $material_id
        ]);
    }

    $conn->commit();
    echo json_encode(["success" => true]);

} catch (PDOException $e) {
    $conn->rollBack();
    echo json_encode(["success" => false, "error" => "Error al guardar el producto: " . $e->getMessage()]);
}


?>