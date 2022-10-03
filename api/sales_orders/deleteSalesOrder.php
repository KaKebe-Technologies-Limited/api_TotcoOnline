<?php

include '../dbConfig.php';
include '../sanitizer.php';
include '../pepperConfig.php'; //$pepper added..
$response['success'] = 0;

if (isset($_REQUEST['id']) && $_REQUEST['id'] !== "") {
    $id = $_REQUEST['id'];
    //handle cleaning here
    clean_input($id);
    //check if sales_order_id already exists, and already deleted
    $sql1 = "SELECT sales_order_id FROM tbl_sales_order WHERE sales_order_id = '$id' AND isDeleted = '1' LIMIT 1";
    $result = $conn->query($sql1);

    if ($result->num_rows > 0) {
        //at this stage, we got a result from db, meaning: product_name already exists!
        $response['message'] = "Sales Order already deleted!";
    } else {
        $sql = "UPDATE tbl_sales_order SET isDeleted = '1' WHERE sales_order_id = '$id'";
    
        if ($conn->query($sql) === TRUE) {
          $response['success'] = 1;
          $response['message'] = "Sales Order with id: $id deleted successfully";
        } else {
          $response['message'] = "Error deleting Sales Order: " . $conn->error;
        }
    }
} else {
  $response['message'] = "Select Sales Order to delete";
}
echo json_encode($response);

$conn->close();
