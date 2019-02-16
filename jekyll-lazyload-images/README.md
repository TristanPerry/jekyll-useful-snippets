# Jekyll Lazy-Loaded Images

[One of my sites](https://www.supertinyhomes.com/) is fairly image heavy, so I wanted to ensure that images within my articles were only loaded when they were being viewed (or were close to being viewed). This was achieved fairly easily in the end with the `IntersectionObserver` code seen in `assets/main.js`.

This is achieved by specifying `data-src="..."` on an image tag instead of `src="..."`. Whilst this is easy to write in standard HTML (without a separate Jekyll plugin), I also wanted these images to load if a browser had disabled Javascript (i.e. graceful degradation) - hence a `<noscript>` block. Instead of copying-and-pasting a lot, I created `_plugins/jekyll-lazyload-images.rb` so that it was fairly quick and easy to add lazy-loaded images which gracefully degraded.

To use this code in your Jekyll powered site, include the `jekyll-lazyload-images.rb` file in your site's `_plugin` folder (or create this at the root site level if it doesn't exist), and then include the JS in the `main.js` file in your site's JS file.

Then you can just use the following tag to add a lazy-loaded image:

```
{% lazyload_image /path/to/image.jpg|Image description goes here|image classes here%}
```

This will generate the following HTML:

```
<img data-src="/path/to/image.jpg" alt="Image description goes here" title="Image description goes here" class="image classes here" />
<noscript><img src="/path/to/image.jpg" alt="Image description goes here" title="Image description goes here" class="image classes here" /></noscript>
```

## IntersectionObserver polyfill

The [browser support for IntersectionObserver](https://caniuse.com/#feat=intersectionobserver) is not 100% just yet, so you can also add the following to your site:

```
<script src="https://polyfill.io/v2/polyfill.min.js?features=IntersectionObserver" type="text/javascript"></script>
``` 

Polyfill.io will only load the relevant polyfill code if your visitor's browser does not contain the requested feature, meaning this is a lightweight bit of JS to include in your site.

## Lazy-loaded iframes (YouTube, SoundCloud etc)

The other benefit of the `main.js` code is that it purely looks for a HTML tag with a `data-src` attribute, and switches it to a `src` attribute.

So the following YouTube embed code will _also_ lead to a lazy-loaded YouTube video:

```
<iframe width="560" height="315" data-src="https://www.youtube-nocookie.com/embed/dQw4w9WgXcQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
```

There are other ways of lazy-loading YouTube videos (such as pulling the YouTube thumbnail image from the video ID, and showing this instead of the iframe - until the image is actually clicked), but this particular approach has been working well for me.