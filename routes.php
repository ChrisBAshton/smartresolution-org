<?php

function renderMarkdown($markdownFile) {
    global $f3;
    $f3->set('markdownFile', $markdownFile);
    $f3->set('content', 'markdown.html');
    echo View::instance()->render('layout.html');
}

$routes = array(

    'GET  /' => function ($f3, $params) {
        renderMarkdown(__DIR__ . '/view/index.md');
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

    'GET  /aws' => function ($f3, $params) {
        renderMarkdown(__DIR__ . '/view/aws.md');
    },

    'GET /download' => function($f3, $params) {
        renderMarkdown(__DIR__ . '/view/download.md');
    },

    // this method should be called from a Git WebHook whenever master is updated.
    // @TODO - add security
    'GET /update-zip' => function($f3, $params) {
        require shell_exec(__DIR__ . '/website-update.sh');
    }
);

foreach($routes as $request => $handler) {
    $f3->route($request, $handler);
}
