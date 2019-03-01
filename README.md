# SmartResolution.org

This repository contains the website for [smartresolution.org](http://smartresolution.org).

This README is intended for private use.

## @TODO

Populate the modules.json directly from the index.php of the modules in question. Right now, it's a manual process.

## Setup locally

Install dependencies, e.g. PHPDocumentor so we can generate up-to-date-documentation.

```
composer install
```

## Setup on server

Two options:

1) Site with live demo - VPS based provider required (e.g. AWS)
2) Site without live demo - cloud PHP provider is suitable

Between 2015 and 2019 I went for option 1 but given the lack of traffic, and the expense in running it on AWS, I opted to strip back to option 2. It's a shame to lose the live demo but you get a good feel for the software by watching the embedded video on the website, and you can always try out the software locally.

### Option 2 setup

In `httpdocs`, upload everything except `private` and `.git`.

(The `private` folder is for option 1 only and is concerned with the live demo setup).

Update any paths in that `index.php` and you may also need to replicate the contents of `f3_config.ini` if your VPS doesn't allow local `.ini` files.
