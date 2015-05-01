# How to build a SmartResolution Module

## Architecture

### Naming convention
The first thing you'll need to do is come up with a unique identifier for your module, which should be related to what the module title does. For example, the [Maritime Collision module](https://github.com/ChrisBAshton/smartresolution-module-maritime-collision) unique key is `maritime_collision`.

Your module should live in SmartResolution's `webapp/modules` directory, and the subdirectory name should be the module key. For example, if your module's unique key is `my_module`, it should live in a folder called `webapp/modules/my_module/`.

The module declaration should live in that folder in a file called `index.php`. This file can pull in other files using PHP's [require](http://php.net/manual/en/function.require.php) function (or equivalent), but your module declaration must be in `index.php`.

### Declaring your module
Inside `index.php`, your module should be defined as follows:

```php
declare_module(array(
    'key'         => 'unique_key_to_identify_your_module',
    'title'       => 'Name of your module',
    'description' => 'Module description'
), function () {
    // module definition goes here 
});
```

### Defining the module
The module definition contains a series of event subscriptions and other setup functions.

```php
on('event_name', 'function_to_call', 'priority');

// route is at the dispute level, i.e. http://example.com/disputes/1337/custom-route
route('/custom-route', 'SomeModule->customRouteFunction', 'priority');

// top level route is at the top level, i.e. http://example.com/module-test
top_level_route('/module-test', function () {
    // this is an anonymous function
});
```

### Function parameter convention
Almost every function follows a three-parameter structure: event name, handler and priority:

* event name - the event or route to hook into
* handler - can be a string representing a global or class function (e.g. `helloWorld` or `MyClass->helloWord`), or an anonymous function (i.e. `function () { // do something }`).
* priority - either a string ('high', 'medium', 'low') or an integer between 1-100 (where the higher the number, the higher the priority). This parameter is optional and dictates in what order your handler should be called. For example, if handler A has a medium priority and handler B has a high priority, handler B will be executed before handler A when the event happens.

### Dispute-dependent and dispute-independent
In the example above, `route` is a dispute-dependent function and `top_level_route` is a dispute-independent function. The former is only applicable within disputes whereas the latter is applicable site-wide. Special functions such as `dashboard_add_item` can be dispute-dependent or dispute-independent depending on the context in which they are called.

All of this is marked up in the [SmartResolution module API](/module-docs/index.html).

### Database interaction
SmartResolution comes with a collection of useful database interaction functions.

You can define a table like so:

```php
declare_table('my_table', array(
    'a_text_field' => 'TEXT NOT NULL',
    'an_int_field' => 'INTEGER DEFAULT 0',
    'initiated'    => 'BOOLEAN'
));

createRow('my_table', array(
    'a_text_field' => 'some text',
    'an_int_field' => 1337
));

set('my_table.initiated', true);

get('my_table.a_text_field'); // => 'some text'

createRow('my_table', array(
    'a_text_field' => 'some more text',
    'an_int_field' => 9999
));

// now we have multiple rows, we need to be more specific
get('my_table.a_text_field', array(
    'an_int_field' => 9999
)); // => 'some more text'

// or we can get all the rows and handle it manually in our application
get_multiple('my_table.*');
/*
    array(
        array(
            'a_text_field' => 'some text',
            'an_int_field' => '1337' // note that this is NOT cast to int.
        ),
        array(
            'a_text_field' => 'some more text',
            'an_int_field' => '9999'
        )
    )
 */
```

More work needs to be done on this in the future, as this only happens to be the use-cases required by the SmartResolution-developed maritime collision module. In time, we will expand the functions in charge of database interaction.

### Other functions
SmartResolution has a number of additional miscellaneous functions used to interact with the core platform.

```php
get_login_id(); // returns the ID of the current user, e.g. 14.
// Can use this in conjunction with the database interaction to remember user preferences, etc.

dashboard_add_item(array(
    'title' => 'Some Action',
    'image' => get_module_url() . '/images/icon.png',
    'href'  => get_dispute_url() . '/custom-route'
));
```

## Module API
Check out the [SmartResolution module API](/module-docs/index.html) for a full list of functions your module can use.

### Events
The module API is still in its infancy, so there aren't many events you can hook into with the `on` function yet. This is the list so far:

* `homescreen_dashboard` - dispute-independent - the core platform is rendering the homescreen dashboard. You can hook into this event to add your own dashboard items.
* `dispute_dashboard` - dispute-dependent - the core platform is rendering the dispute dashboard. You can hook into this event to add your own dashboard items.

In the future, it is hoped that there will be many more events which enable hooking into the following behaviours:

* dispute created
* lifespan proposed
* agent assigned
* mediator assigned
* message sent
* evidence uploaded
* ...and so on.

## Submitting to SmartResolution

SmartResolution is still in its early stages, so this process is still in its infancy. For the time being, get in touch with [Chris Ashton](http://ashton.codes) and he'll be happy to put your module on the marketplace.