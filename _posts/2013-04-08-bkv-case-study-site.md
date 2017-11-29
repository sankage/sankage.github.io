---
layout: post
title: BKV Case Study Site
date: 2013-04-08 22:07
category: development
---

This is a small site we created for an RFP to BB&T. As its content was meant to be static, I decided to build it using Jekyll.

![Home page](/assets/images/bbt-home.png)

As the possiblity exists to continue to use this design for future uses as well, I decided to use the blogging aspects of Jekyll to hold the case studies.

![Case Study](/assets/images/bbt-case-study.png)

- - -

To keep things DRY between the different case studies, I created a custom layout that utilized yaml attributes for images. In the case the device attribute is an array, it is rendered as a carousel.

```yaml
---
layout: case-study
title: AT&T Creative Optimization
devices:
  imac: [imac-att.jpg, imac-att2.jpg, imac-att3.jpg]
  ipad: ipad-att.jpg
  iphone: iphone-att.jpg
---
```

**_layouts/case-study.html**

```html
...
{% raw %}{% for image in page.devices['imac'] %}{% endraw %}
  <img class="item" src="/assets/images/{{image}}" />
{% raw %}{% endfor %}{% endraw %}
...
```

- - -

The original design of this site was with a fixed width. I didn't like this. Over the weekend I added fluid aspects and a basic set of responsive breakpoints so that it looked better on tablets and phones.

**iPhone**

![view from iphone](/assets/images/bbt-mobile.png)

**iPad**

![view from ipad](/assets/images/bbt-tablet.png)
