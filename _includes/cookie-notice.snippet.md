<script>

$(function () {

    let getCookiesNotice = function () {
	return (localStorage.getItem("cookies-notice") != null)
    };

    let setCookiesNotice = function () {
	localStorage.setItem("cookies-notice", "ok");
    };

    if ( ! getCookiesNotice() ) {
	let notice = $("<div>")
	    .addClass("cookie-notice")
	    .html('<div class="notice balance-text">This site uses cookies related to Github, Disqus and Google Analytics.</div><div style="links"><a href="/privacy-policy">More&nbsp;info&hellip;</a><button>OK</button></div>');
	notice.find("button").click(function () {
	    setCookiesNotice();
	    notice.remove();
	});
	$("body").append(notice);
    }
});

</script>
