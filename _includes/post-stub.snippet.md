<li class="post">
	<a class="title" href="{{ post.url }}">{{ post.title }}</a>
	<time datetime="{{ post.date | date: '%F' }}">{{ post.date | date_to_long_string }}</time>
	{% if site.show_disqus_comment_counts %}
	<a class="comment-count" href="{{ post.url }}" data-disqus-identifier="{{ post.id }}"></a>
	{% endif %}
	<a class="read-more"  href="{{ post.url }}">
		{% if post.image %}
			<img src="/assets/{{ post.image }}"/>
		{% endif %}
	</a>
	<teaser>{{ post.teaser }}</teaser>
	<p class="excerpt">
		{% if post.stub %}
			{{ post.stub | markdownify | strip_html }} &nbsp;&hellip;
		{% else %}
			{{ post.content | markdownify | strip_html | truncatewords: 40, "&nbsp;&hellip;" }}
		{% endif %}
	</p>
	<a class="read-more"  href="{{ post.url }}">read more</a>
	{% if forloop.last == false %}
	<hr/>
	{% endif %}
</li>
