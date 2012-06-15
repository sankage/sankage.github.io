---
layout: post
title: Infosurv Concept Exchange
date: 2011-10-13 14:22
category: Design
---

I helped Infosurv develop the Infosurv Concept Exchange (iCE). iCE is a prediction market system that depends on the influences of crowd mentality to predict outcomes in the real world.

![Market](/imgs/ice-market.png)

It was developed using PHP and MySQL and was integrated into our survey system using javascript and iframes. Key learning points during the development process was getting an iframe to communicate with its parent from a different domain, as well as using differential calculus to formulate some of the math run on the backend. The system was built to be entirely reusable and running multiple instances of various markets simultaneously.

Inspired by a recent blog post about [feature suggestion](http://tutorialzine.com/2010/08/ajax-suggest-vote-jquery-php-mysql/), I adapted and optimized the idea into an optimization tool for the concepts.

![Optimization](/imgs/ice-optimization.png)

