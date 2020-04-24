{% if page.series %}

	{% assign series_toc = site.pages | where: "layout", "series-toc"
	                                  | where: "series", page.series 
                                      | first %}
										
	{% assign series_posts = site.posts | where: "series", page.series 
                                        | sort: "index" %}
	{% assign series_length = series_posts | size %}

	{% for post in series_posts %}
		{% if post.index == page.index %}
		
			{% if forloop.first == false %}
				{% assign previous_index = forloop.index0 | minus: "1" %}
				{% assign previous_post = series_posts[previous_index] %}
			{% endif %}
			
			{% if forloop.last == false %}
				{% assign next_index = forloop.index0 | plus: "1" %}
				{% assign next_post = series_posts[next_index] %}
			{% endif %}
			
		{% endif %}
	{% endfor %}
	
<div class="series-post-header">
	<div class="series">
		This article is part of the
		<a href="{{ series_toc.url }}">{{ page.series }}</a>
		series.
	</div>
	
	<div class="links">
	
		{% if previous_post %}
		<div class="previous">
			<a href="{{ previous_post.url }}">
				{{ previous_post.title }}
			</a>
		</div>
		{% endif %}
	
		{% if next_post %}
		<div class="next">
			<a href="{{ next_post.url }}">
				{{ next_post.title }}
			</a>
		</div>
		{% endif %}
	
	</div>
	
	<!--
		Series: {{ page.series }}
		<br/>
		Part: {{ page.index }} of {{ series_length }}
		<br/>
		{% if previous_post %}
			Prev: {{ previous_post.title }}
		{% endif %}
		<br/>
		{% if next_post %}
			Next: {{ next_post.title }}
		{% endif %}
	-->
</div>
	
{% endif %}
