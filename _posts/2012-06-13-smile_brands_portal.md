---
layout: post
title: Smile Brands Portal
date: 2012-06-13 12:56
category: Portals
---

This is a reporting portal for Smile Brands designed and constructed by Infosurv, Inc.

It has gone through 2 major revisions since its original creation, and is consistantly tweeked and edited to the clients specifications.

### Login

Access to reports is restricted by varying levels of management. To establish this authorization, users are required to login to the system. To allow for a easier user management, login requests are directed through a client-based API. The returned response dictates what levels of access a user is able to have.

![Login](/imgs/sb-login.png)

### Reports

The basic report is a Trending report based on NPS scores.

![Trend](/imgs/sb-trend.png)

The advanced report breaks down and clusters the NPS buckets and the explanations of why a certain score was given.

![Summary](/imgs/sb-summary.png)

### Issue Tracking

For this the client wanted a way to track actions taken to answer customer complaints.

![Issues 1](/imgs/sb-issues-1.png)

Managers and office staff have the ability to log actions they take to ameliorate patient issues.

![Issues 2](/imgs/sb-issues-2.png)

### Redemption Rates

The client wanted to keep track of the response rate to their survey and make it visible to their managers. For this we had to add a good amount of backend architecture (in part due to the limitations of the data available). It turned out well and the client liked it.

![Redemption Rates](/imgs/sb-response.png)