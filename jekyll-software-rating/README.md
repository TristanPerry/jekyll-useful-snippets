# A schema-based software rating block for Jekyll powered pages

Rich data is known to be good for SEO, which includes including software reviews on your site that show up with rating stars on the Google search results.

This plugin works by including the following block in your Jekyll post:

```
{%rating SketchUp|https://www.sketchup.com/|9|0-299|n/a (Online software)|A versatile and powerful piece of software which has an initial learning curve, but is well worth getting used to. There are free and paid for plans with different levels of features. %}
```

This will generate the following rich data to your page, which you can then style as needed with CSS:

```html
<section class="review" itemscope="" itemtype="http://schema.org/Review">
<h1>SketchUp -  <span class="reviewRating" itemprop="reviewRating" itemscope="" itemtype="http://schema.org/Rating">
                    <span itemprop="ratingValue">9</span>/<span itemprop="bestRating">10</span>
                </span></h1>
<div class="softwaresummary" itemprop="itemReviewed" itemscope="" itemtype="http://schema.org/SoftwareApplication">
    <link itemprop="applicationCategory" href="https://schema.org/DesignApplication" />
    <ul>
        <li><strong>Software:</strong> <span itemprop="name"><a href="https://www.sketchup.com/" title="Go to website for SketchUp" target="_blank">SketchUp</a></span></li>
        <li><strong>OS:</strong> <span itemprop="operatingSystem">n/a (Online software)</span></li>
        <li itemprop="offers" itemscope="" itemtype="https://schema.org/Offer">
            <strong>Price:</strong> $<span itemprop="price">0-299</span>
            <meta itemprop="priceCurrency" content="USD" />
        </li>
    </ul>
</div>
<p class="author" itemprop="author" itemscope="" itemtype="http://schema.org/Person">
    <strong>Reviewer:</strong> <span itemprop="name">Tristan Perry</span>
</p>
<p class="reviewsummary" itemprop="reviewBody">
    A versatile and powerful piece of software which has an initial learning curve, but is well worth getting used to. There are free and paid for plans with different levels of features.
</p>
</section>
```

You can see an example of this on [one of my website's](https://www.supertinyhomes.com/tiny-houses/design-software) which has a software review round-up.

The parameters for this `{% rating ... %}` plugin are:

```
{%rating Software Name|Software URL|Rating (out of 10)|Price|Operating System|Review of software. %}
```
 