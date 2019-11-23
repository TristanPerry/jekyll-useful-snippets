# A schema-based FAQ block for Jekyll powered pages

Rich FAQ blocks are known to be good for SEO, with Google showing FAQs in the SERPs below a website's results.

This plugin requires the following information in your post's front matter:

```
---
title: Some title
(some other front matter)
isfaq: true
faqs:
  - Question 1|Answer 1
  - Question 2|Answer 2
  - Question 3|Answer 3|<p>Optional HTML before this FAQ.</p> 
---
```

Then you just need to reference this when calling the plugin:

```
{% faq page.faqs %}
```

Finally, in order for Google to recognise this schema.org-powered data, you need for the page to be flagged as such in the <html> tag:

```
{% if page.isfaq %}
<html lang="{{ page.lang | default: site.lang | default: " en" }}" dir="ltr"  itemscope itemtype="https://schema.org/FAQPage">
{% else %}
<html lang="{{ page.lang | default: site.lang | default: " en" }}" dir="ltr">
{% endif %}
``` 

You can see an example of this on [one of my website's](https://www.supertinyhomes.com/tiny-houses/faqs) which has an FAQ page.

Google's understanding of your page's FAQ [can be tested here](https://search.google.com/test/rich-results).