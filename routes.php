<?php

function renderMarkdown($markdownFile) {
    global $f3;
    $f3->set('markdownFile', $markdownFile);
    $f3->set('content', 'markdown.html');
    echo View::instance()->render('layout.html');
}

$routes = array(

    'GET  /' => function ($f3, $params) {
        $f3->set('content', 'index.html');
        echo View::instance()->render('layout.html');
    },

    'GET /about' => function($f3, $params) {
        renderMarkdown(__DIR__ . '/view/about.md');
    },

    'GET /workflow' => function($f3, $params) {
        renderMarkdown(__DIR__ . '/view/workflow.md');
    },

    'GET /installation' => function($f3, $params) {
        renderMarkdown(__DIR__ . '/view/installation.md');
    },

    'GET /download' => function($f3, $params) {
        renderMarkdown(__DIR__ . '/view/download.md');
    },

    'GET /marketplace' => function($f3, $params) {
        renderMarkdown(__DIR__ . '/view/marketplace.md');
    },

    // this method should be called from a Git WebHook whenever master is updated.
    'GET /update-website' => function($f3, $params) {
        echo "Coming soon";
    }
);

foreach($routes as $request => $handler) {
    $f3->route($request, $handler);
}
