<li class="post">
	<a class="title" href="{{ post.url }}">{{ post.title }}</a>
	<time datetime="{{ post.date | date: '%F' }}">{{ post.date | date_to_long_string }}</time>
	<abstract>{{ post.abstract }}</abstract>
	<p>
		{{ post.content | markdownify | strip_html | truncatewords: 40 }}
		<a class="read-more"  href="{{ post.url }}">read more</a>
	</p>
	{% if forloop.last == false %}
	<hr/>
	{% endif %}
</li>