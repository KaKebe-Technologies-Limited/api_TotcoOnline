<?php

include '../dbConfig.php';
include '../sanitizer.php';

$response['success'] = 0;

if (isset($_REQUEST['raw_data'])  && $_REQUEST['raw_data'] !== "") {
    $jsonData = $_REQUEST['raw_data'];
    $PHPobj = json_decode($jsonData);

    if ($userName = $PHPobj->username) {

        if ($orders = $PHPobj->order_data) {
            //handle cleaning here
            clean_input($userName);
            $response['user'] = $userName;

            $sql = "SELECT * FROM  tbl_user WHERE username = '$userName' LIMIT 1";
            // $sql = "INSERT INTO tbl_sales_order ( createdBy ) VALUES ('$createdBy')";

            if ($result = $conn->query($sql)) {
                if ($result->num_rows > 0) {
                    $row = $result->fetch_assoc();
                    $userId = $row["user_id"];

                    $sql1 = "INSERT INTO tbl_sales_order ( createdBy ) VALUES ('$createdBy')";

                    if ($conn->query($sql1) === TRUE) {
                        $order_id = $conn->insert_id;

                        for ($i = 0; $i < count($orders); $i++) {
                            $each_order = $orders[$i];
                            $pdtID = clean_input($each_order->product_id);
                            $qnty = clean_input($each_order->quantity);
                            $selling_price = clean_input($each_order->selling_price);

                            $sql2 = "INSERT INTO tbl_order_vs_product (sales_order_id, product_id, quantity, selling_price) VALUES ('$order_id', '$pdtID', '$qnty', '$selling_price')";

                            if ($conn->query($sql2) === TRUE) {
                                $response['status'] = "ok";
                                if ($i == count($orders) - 1) {
                                    $response['success'] = 1;
                                    $response['message'] = "New Order created successfully";
                                }
                            } else {
                                $response['status'] = "Error Occurred";
                                $response['message'] = "Query Failed";
                                $response['Error'] = $conn->error;
                                break;
                            }
                        }
                    } else {
                        $response['message'] = "Query Failed";
                        $response['Error'] = $conn->error;
                    }
                } else {
                    $response['message'] = "Incorrect username or password";
                }
            } else {
                $response['message'] = "Server didn't respond, please try again!";
            }
        } else {
            $response['message'] = "No data submitted";
        }
    } else {
        $response['message'] = "Unseriousness!!";
    }
} else {
    $response['message'] = "You are just unserious. That's All!";
}

echo json_encode($response);

$conn->close();
