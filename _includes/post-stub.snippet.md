<li class="post">
	<a class="title" href="{{ post.url }}">{{ post.title }}</a>
	<time datetime="{{ post.date | date: '%F' }}">{{ post.date | date_to_long_string }}</time>
	{% if site.show_disqus_comment_counts %}
	<a class="comment-count" href="{{ post.url }}" data-disqus-identifier="{{ post.id }}"></a>
	{% endif %}
	<abstract>{{ post.excerpt }}</abstract>
	<p>
		{{ post.content | markdownify | strip_html | truncatewords: 40 }}
		<a class="read-more"  href="{{ post.url }}">read more</a>
	</p>
	{% if forloop.last == false %}
	<hr/>
	{% endif %}
</li>
