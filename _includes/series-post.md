{% if page.series %}

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
	
	<div class="debug">
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
	</div>
{% endif %}
