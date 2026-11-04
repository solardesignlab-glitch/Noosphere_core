<?php
require 'vendor/autoload.php';
\ = new \Espo\Core\Application();
\->run();
\ = \->getContainer()->get('entityManager');
\ = \->getDefs();
foreach (['Session','Specialist','Offer'] as \) {
    echo \ . ': ' . (\->hasEntity(\) ? 'EXISTS' : 'MISSING') . PHP_EOL;
}
