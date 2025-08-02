<?php
require_once __DIR__ . '\conexion\conexion.php';

header('Content-Type: application/json');

try{
    
    $sql_bodega="SELECT BOD_ID AS id ,BOD_NOMBRE AS nombre FROM SRP_BODEGA";
    $stmt_bodega=$conn -> prepare($sql_bodega);
    $stmt_bodega->execute();
    $result_bodega= $stmt_bodega -> fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($result_bodega);

}catch(Exception $e){
 echo json_encode("Error");
}

?>