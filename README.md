# Jekyll Useful Snippets

I have two Jekyll-powered sites ([Green Car Future](https://www.greencarfuture.com) and [Super Tiny Homes](https://www.supertinyhomes.com)) which use a lot of images, and I didn't want to slow them down by having articles with lots of images/image galleries loading all images the moment the page loads.

Hence the folders `jekyll-image-gallery` and `jekyll-lazy-images` which contain Jekyll plugins and some JS/CSS which can add simple-yet-effective lazy-loaded images/image galleries to your Jekyll sites (each folder have their own README files with further install information).

`sitemap.xml` is also a simple way of adding a [sitemap.xml](https://www.sitemaps.org/protocol.html) to your site, and this file should be included in the root of your Jekyll site.

The `isresourcepage` is a way of me ignoring some resource pages like contact us, copyright/disclaimer, privacy policy (etc) from the sitemap file. The resource page I want to skip should therefore simply have `isresourcepage: true` in its front matter.
