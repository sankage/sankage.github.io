---
layout: post
title: Website Rebuild
date: 2013-08-27 23:33
category: development
---

It all started as a spare time project. We had moved the blogging features of BKV.com into a Wordpress site, but left everything else to exist in a CMS. As working in the CMS was proving to be more problematic day to day, I decided to see what it would take to move the remaining site (almost entirely static content) into a static site generator. Its time to start mixing chemicals Dr. Jekyll.

I started by doing an inventory of all the site's current pages to see exactly what was going to be needed to be rebuilt. I noticed that we had some distinct clusters of data and decided to use Jekyll's built-in blogging features to handle them. By setting specific categories to groups of posts I am able to loop through just that category for index views.

```html
{% raw %}{% assign services = site.categories['service'] | order_by:'title' %}
{% for service in services %}{% endraw %}
  <li class="service_entry">
    <a href="{{ service.url }}">
      <div class="{% raw %}{% cycle 'green', 'red', 'purple', 'orange', 'gray' %}{% endraw %}">
        {% raw %}{{ service.title | upcase }}{% endraw %}
      </div>
    </a>
  </li>
{% raw %}{% endfor %}{% endraw %}
```

![BKV services](/imgs/bkv.services.png)

As posts are by default ordered by their creation date, I added a [plugin](link to github) to allow ordering posts by any string value set in their YAML Front Matter. In the case of the services I wanted them alphabetized by title.


## Content

To prevent myself from accepting any leftover cruft from multiple developers of varying skill working on previous revisions, I set myself to only grab the content directly from an end-user's perspective. Instead of pulling it out of the CMS, I visited each page and copied out the raw content. As a result of looking purely at the content, I was able to make some layout decisions without having the restrictions of the templating of the CMS.

By using YAML Front Matter on posts, I was able to seperate the text content from layout specifics. As a result of this change, future layout changes shouldn't need to modify the content.

```yaml
---
layout: project
title: Dell SecureWorks
permalink: /direct-marketing/projects/dell-secureworks/
category: project
portfolio_image: dell-secureworks.jpg
images:
  - dell-secureworks_01.jpg
  - dell-secureworks_02.jpg
---
```

```html
<section class="project">
  <div class="grid">
    <div class="unit half images">
      <div class="cycle-pager"></div>
      <div class="cycle-slideshow"
          data-cycle-timeout=4000
          data-cycle-pause-on-hover="true"
          data-cycle-fx=scrollHorz
          data-cycle-pager=".cycle-pager">
        {% raw %}{% for image in page.images %}{% endraw %}
          <img src="{% raw %}{{ image | prepend:'projects/' | asset_path }}{% endraw %}">
        {% raw %}{% endfor %}{% endraw %}
      </div>
    </div>
    <div class="unit half">
      <div class="boxed details">
        {% raw %}{{ content }}{% endraw %}
      </div>
      {% raw %}{% if page.related_services != empty %}{% endraw %}
        <div class="unboxed top-spaced">
          <h2>Related Services</h2>
          <ul class="inline x4">
            {% raw %}{% for service in page.related_services %}{% endraw %}
              <li>
                <a href="{% raw %}{{ service.url }}{% endraw %}">
                  <div class="related_service {% raw %}{% cycle 'red', 'purple', 'orange', 'green', 'gray' %}{% endraw %}">
                    {% raw %}{{ service.title }}{% endraw %}
                  </div>
                </a>
              </li>
            {% raw %}{% endfor %}{% endraw %}
          </ul>
        </div>
      {% raw %}{% endif %}{% endraw %}
    </div>
  </div>
</section>
```

![BKV project view](/imgs/bkv.project.png)


## Layout

I decided to use Coby Chapple's [Gridism](http://cobyism.com/gridism/) for my grid system after seeing it in action on the new [Jekyll site](http://jekyllrb.com/). The simplicity of thinking of the grid in human terms (one-third) instead of number of spans and offsets (span-4 offset-3) of a twelve column grid makes more sense to me and hopefully the next developer.

![BKV new footer](/imgs/bkv.footer.after.png)


## The Future

Knowing that new case-studies, clients, people, and services would need to be added in the future led me to build a Rakefile with tasks to create new entries. Each task would build out the required YAML Front Matter for a new entry.

```ruby
desc "Add a new employee"
task :new_person, :name do |t, args|
  if args.name
    name = args.name
  else
    name = get_stdin("Enter a person's name: ")
  end
  filename = "_posts/people/#{Time.now.strftime('%Y-%m-%d')}-people-#{name.to_url}.md"
  if File.exist?(filename)
    abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
  end
  puts "Creating new person: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "layout:    person"
    post.puts "title:     #{name}"
    post.puts "date:      #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"
    post.puts "permalink: /advertising-marketing-agency/people/#{name.to_url}/"
    post.puts "category:  people"
    post.puts "image:     #{name.to_url}.jpg"
    post.puts "worked_on: []"
    post.puts "---"
    post.puts "\n# #{name}"
    post.puts "\n<dl>"
    post.puts "  <dt>Title:</dt>\n  <dd></dd>"
    post.puts "  <dt>Industry Experience:</dt>\n  <dd></dd>"
    post.puts "  <dt>Time at BKV:</dt>\n  <dd></dd>"
    post.puts "  <dt>Twitter Handle:</dt>\n  <dd></dd>"
    post.puts "  <dt>Services:</dt>\n  <dd></dd>"
    post.puts "</dl>"
  end
end
```

```
➜ rake new_person
Enter a person's name: Testy McTesterton
Creating new person: _posts/people/2013-08-23-people-testy-mctesterton.md
```

