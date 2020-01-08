// autoscroll a page and when the end of page is reached reload the page

var scrollTable = undefined;
var scrollTimer;
var scrollAmount = 1; // scroll by 100 pixels each time
var documentYposition = 0;
var scrollPause = 3000; // amount of time, in milliseconds, to pause between
// scrolls

// http://www.evolt.org/article/document_body_doctype_switching_and_more/17/30655/index.html
function getScrollPosition() {
	if (window.pageYOffset) {
		return window.pageYOffset;
	} else if (document.documentElement && document.documentElement.scrollTop) {
		return document.documentElement.scrollTop;
	} else if (document.body) {
		return document.body.scrollTop;
	}
}

function myScroll() {
	if ($("#body-scoreboard").height() > $(window).height() - 300) { // wait 300 pixels
		documentYposition += scrollAmount;
		scrollTable.find("tbody tr:visible:first").hide();
    }else{
		// until we refresh
		//window.clearInterval(scrollTimer);
		//window.scroll(0, 0); // scroll back to top and then refresh
		scrollTable.find("tbody tr:hidden").show();
		//location.href = location.href;
	}
}

function startScrolling() {
	scrollTable = $("table.scroll");
	scrollTimer = window.setInterval('myScroll()', scrollPause);
}
