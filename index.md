## Welcome to gavlock

### Tags

<ul>
  {% for tag in site.tags %}
    <li>
		<a href="/tags/{{ tag[0] }}/">{{ tag[0] }}</a>
		{{ tag[1] | size}}
		{% if tag[1].size == 1 %}
			post
		{% else %}
			posts
		{% endif %}
    </li>
  {% endfor %}
</ul>

### Posts

<ul>
  {% for post in site.posts %}
  {%   include post-stub.snippet.md %}
  {% endfor %}
</ul>
