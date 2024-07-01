<?php
// Démarrez la session
session_start();

// Définissez les routes de votre application
$routes = array(
    '/' => 'home',
    '/help' => 'help'
);

// Récupérez l'URL demandée
$request_uri = $_SERVER['REQUEST_URI'];

// Trouvez la route correspondante
$route = isset($routes[$request_uri]) ? $routes[$request_uri] : 'home';

$log_file = '../logs/app.log';

// Exécutez la fonction associée à la route
switch ($route) {
    case 'home':
        home();
log_message("Accès à la page help");
        break;
    case 'help':
 log_message("Accès à la page d'aide"); 
       help();
        break;
    default:
log_message("Accès à la page d'accueil (route par défaut)");
        home();
}

// Fonction pour la page d'accueil
function home() {
    echo "Help page from php Elie Tshi";
}

// Fonction pour la page d'aide
function help() {
    echo "This is the help page from php Elie Tshi";
}
// Fonction pour enregistrer un message dans le fichier de log
function log_message($message) {
    global $log_file;
    $timestamp = date('Y-m-d H:i:s');
    $log_entry = "[$timestamp] $message\n";
    file_put_contents($log_file, $log_entry, FILE_APPEND);
}
?>

