<?php

$serverName = getenv("DB_SERVER"); // update me
$connectionOptions = array(
    "Database" => getenv("DB_HOST"), // update me
    "Uid" => getenv("DB_USERNAME"), // update me
    "PWD" => getenv("DB_PASSWORD") // update me
);
//Establishes the connection
$conn = sqlsrv_connect($serverName, $connectionOptions);
$tsql= "SELECT TOP 20 pc.Name as CategoryName, p.name as ProductName
     FROM [SalesLT].[ProductCategory] pc
     JOIN [SalesLT].[Product] p
     ON pc.productcategoryid = p.productcategoryid";
$getResults= sqlsrv_query($conn, $tsql);
echo ("Reading data from table" . PHP_EOL);
if ($getResults == FALSE)
    echo (sqlsrv_errors());
while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
 echo ($row['CategoryName'] . " " . $row['ProductName'] . PHP_EOL);
}
sqlsrv_free_stmt($getResults);

// require __DIR__ . "/inc/bootstrap.php";
 
// $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
// $uri = explode( '/', $uri );
 
// if ((isset($uri[2]) && $uri[2] != 'index') || !isset($uri[3])) {
//     header("HTTP/1.1 404 Not Found");
//     exit();
// }
 
// require PROJECT_ROOT_PATH . "/Controller/Api/IndexController.php";
 
// $objFeedController = new IndexController();
// $strMethodName = $uri[3] . 'Action';
// $objFeedController->{$strMethodName}();
?>