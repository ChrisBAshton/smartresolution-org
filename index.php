<?php
require_once __DIR__ . '/vendor/autoload.php';

$f3 = \Base::instance();
$f3->config('f3_config.ini');

require __DIR__ . '/routes.php';

$f3->run();