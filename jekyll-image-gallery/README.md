# Simple But Effective Jekyll Lazy-Loaded Image Gallery

For one of my sites, I wanted a simple image gallery which had lazy-loaded images and had a similar look-and-feel to some off-the-shelf image gallery tools. [See a demo of it here](https://www.supertinyhomes.com/tiny-houses/2019/01/10/amazing-amateur-home-roundup.html#little-red-hen-cabin-texas).

The basic steps to include this Jekyll plugin in your own site is to include `jekyll-image-gallery.rb` in your `_plugins` folder, and then ensure the CSS and JS (inside the `assets/` folder) are included in your CSS and JS files.

Then you just need to include the following information in your post's front matter:

```
---
title: Some title
(some other front matter)
image_gallery1_data:
    /path/to/image1.jpg|Some description here for the alt tag.
    /path/to/image2.jpg|Some description here for the alt tag.
    /path/to/image3.jpg|Some description here for the alt tag.
    /path/to/image4.jpg|Some description here for the alt tag.
---
```

Then you just need to reference this when calling the plugin:

```
{% image_gallery page.image_gallery1_data %}
```

You can naturally use this multple times by having multiple gallery-type data in your front matter, then reference the `image_gallery` plugin as required in your post.

One important note is that if your image is in `/path/to/image1.jpg`, it is expected that the thumbnail is stored in `/path/to/thumb/image1.jpg`.

## IntersectionObserver polyfill

The [browser support for IntersectionObserver](https://caniuse.com/#feat=intersectionobserver) is not 100% just yet, so you can also add the following to your site:

```
<script src="https://polyfill.io/v2/polyfill.min.js?features=IntersectionObserver" type="text/javascript"></script>
``` 

Polyfill.io will only load the relevant polyfill code if your visitor's browser does not contain the requested feature, meaning this is a lightweight bit of JS to include in your site.
