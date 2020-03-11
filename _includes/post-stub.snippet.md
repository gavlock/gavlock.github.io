<li>
	<a href="{{ post.url }}">{{ post.title }}</a>
	<p>{{ post.date | date_to_long_string }}</p>
	<abstract>{{ post.abstract }}</abstract>
	<p>
		{{ post.content | markdownify | strip_html | truncatewords: 40 }}
		<a href="{{ post.url }}">read more</a>
	</p>
	<hr/>
</li>
