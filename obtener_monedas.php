<?php
require_once __DIR__ . '\conexion\conexion.php';

header('Content-Type: application/json');

try{
    $sql_moneda="SELECT MON_ID AS id,MON_NOMBRE AS nombre FROM SRP_MONEDA";
    $stmt_moneda=$conn -> prepare($sql_moneda);
    $stmt_moneda->execute();
    $result_moneda= $stmt_moneda -> fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($result_moneda);


}catch(Exception $e){
 echo json_encode("Error");
}

?>