---
layout: post
title: Multiple Choice Images
date: 2012-03-29 14:15
category: Development
---

Have you ever taken a survey that used images for answer options? Not only have I, but I have also built those same surveys. They look horrible.

![Before](/imgs/iac-before.png)

Which image corresponds to which checkbox? Once I scroll down a little, I have no idea. Luckily we are using label tags around the images so that all a respondent needs to do is click the image to select a checkbox.

Epiphany. If the user is clicking the image to trigger the checkbox anyway, why not make the image the checkbox too?

Thinking about it this way, a colleague and I developed some JavaScript code to handle transforming the existing layout and overlaying semi transparent check images on top. The first prototype used overlay images that were the exact size of the images getting overlaid, so it needed some further working, but we showed that not only it worked, but that it made image options more intuitive to end users.

We spent some additional time and fleshed out variable image sizes and their overlay siblings, grid layouts, and exclusive options. With that done we completed version 2:

![After, with nothing checked](/imgs/iac-after-precheck.png)

⇑ With nothing checked.

⇓ With some things checked.

![After, with some things checked](/imgs/iac-after-postcheck.png)

And here is the code:

{% gist 7472615 images_as_checkboxes.coffee %}
