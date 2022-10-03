<?php

$HOST = "localhost";
$USER = "rgxszumy_administrator";
$PASSWORD = "Jps, 18cf3";
$DB_NAME = "rgxszumy_totco";

// Create connection
$conn = new mysqli($HOST, $USER, $PASSWORD, $DB_NAME);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}