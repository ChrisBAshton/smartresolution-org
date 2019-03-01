<?php
require_once __DIR__ . '/vendor/autoload.php';

$f3 = \Base::instance();

// $f3->config('f3_config.ini');
// ^ this isn't working, so copy the vars here.
$f3->set('UI', 'view/');
$f3->set('DEBUG', 1);

require __DIR__ . '/routes.php';

$f3->run();