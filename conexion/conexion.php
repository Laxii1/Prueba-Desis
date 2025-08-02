<?php
   $host = "localhost";
   $dbname = "Prueba-Desis";
   $user = "postgres";
   $password = "admin";

   try {
       $conn = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
       $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
       //echo "Conexión exitosa :)";
   } catch (PDOException $e) {
       echo "Error de conexión: " . $e->getMessage();
   }
?>
