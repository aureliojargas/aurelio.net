/* tagmenu-diet.js
   Script que monta o menu de tags do site AURELIO.NET
   
   Nota:
 	O banco de links e tags esta em tagmenu-urls.js.
	Usei um arquivo separado por causa do cache, pois
	este arquivo aqui raramente sera atualizado.

   Importante:
 	Inclua o banco de links DEPOIS de incluir este arquivo.

*/

var currentTag = 'eu';
var linkFgColor = '#07f';
var linkBgColor = '#fff';
var tagTitles = {};
var allLinks = [];
var linksLoaded = false;

function sortLinkArray(a,b) {  // sort by name (2nd column)
	a = a[1].toLowerCase(); b = b[1].toLowerCase();
	try { // IE6...
		if (a < b) { return -1; } else if (a > b) { return 1; }
	} catch(e) { }
	return 0;
}

if (!Array.prototype.push) { // IE5...
	Array.prototype.push = function(item) {
		this[this.length] = item; return this.length; }
}

if(!Array.indexOf){ // IE6, Safari 2 & friends
	Array.prototype.indexOf = function(obj, start){
		for(var i=(start||0); i<this.length; i++){
			if(this[i]==obj){ return i; }
		}
		return -1;
	}
}

// Find all 'on' tags. Returns a list of tag names.
function getActiveTags() {
	var menuTags = getAllMenuTags();
	var activeTags = new Array();

	for (var i = 0; i < menuTags.length; i++) {
		var thisTag = menuTags[i];
		if (thisTag.className == 'on') {
			activeTags.push(thisTag.innerHTML);
		}
	}
	return activeTags;
}

// If ALL element classes are active, show it
function showorNot(element, activeTags) {
	var classes = ' ' + element.className + ' ';
	if (activeTags.length == 0) return false; // no tag
	for (var i = 0; i < activeTags.length; i++) {
		if (classes.indexOf(' '+activeTags[i]+' ') == -1) {
			return false; // One failed, abort
		}
	}
	return true;
}

// Get all links for the cloud DIV
function getAllMenuTags() {
	return document.getElementById('menutags').getElementsByTagName('a');
}
function getAllMenuLinks() {
	return document.getElementById('menulinks').getElementsByTagName('a');
}

// Exclusive tag selection
function singleTag(link) {
	// Turn all tags OFF, then clicked tag ON
	var menuTags = getAllMenuTags();
	for (var i = 0; i < menuTags.length; i++) {
		menuTags[i].className = 'off';
	}
	link.className = 'on';
	// Show links for the clicked tag, hide others
	var activeTag = [link.innerHTML];
	var menuLinks = getAllMenuLinks();
	for (var i = 0; i < menuLinks.length; i++) {
		menuLinks[i].style.display = (
			showorNot(menuLinks[i], activeTag)) ? 'block' : 'none';
	}
}

function clicked() {
	clickedTag = this.innerHTML;
	var linksArea = document.getElementById('menulinks');
	// Clicking again, toggle menu appearance
	if (currentTag == clickedTag) {
		if (linksArea.style.display == 'none') {
			linksArea.style.display = 'block'
			this.className = 'on';
		} else {
			linksArea.style.display = 'none'
			this.className = 'off';			
		}
	// First click always shows menu
	} else 	{
		linksArea.style.display = 'block';
		if (!linksLoaded) {
			createLinkCloud();
			linksLoaded = true;
		}
		singleTag(this);		
	}
	currentTag = clickedTag;
	return false;
}

function createLinkCloud() {
	var linksArea = document.getElementById('menulinks');
	allLinks.sort(sortLinkArray);
	for (var i = 0; i < allLinks.length ; i++) { // Weight,Name,URL,class

		var el = document.createElement('a');
		el.href = allLinks[i][2];
		el.className = allLinks[i][3];
     	  	el.appendChild(document.createTextNode(allLinks[i][1]));

		// Using one weight level (bold) instead multi (font-size)
		//if (allLinks[i][0] > 0) { el.style.fontWeight = 'bold'; }
		// Shows only the default tag links
		//el.style.display = (showorNot(el, [currentTag])
		//	) ? 'block' : 'none';

    		linksArea.appendChild(el);
        	linksArea.appendChild(document.createTextNode('\n')); //sep
	}
}

function init() {

	// Get unique tags from link bank
	var allTags = new Array();
	var tagCount = new Object();
	for (var i = 0; i < allLinks.length ; i++) {
		var theTags = allLinks[i][3].split(' ');
		for (var j = 0; j < theTags.length ; j++) {
			var thisTag = theTags[j];
			if (tagCount[thisTag]) {
				tagCount[thisTag] += 1;
			} else {
				tagCount[thisTag] = 1;
				allTags.push(thisTag);
			}
		}
	}
	allTags.sort();

	// Create tag cloud
	var tagsArea = document.getElementById('menutags');
	for (var i = 0; i < allTags.length ; i++) {

		// The tag count
		el = document.createElement('span');
		el.className = 'menutagcount';
        	el.appendChild(document.createTextNode(
			tagCount[allTags[i]]+'.'));
		tagsArea.appendChild(el);

		// The tag link
		var el = document.createElement('a');
		el.href = '#';
        	el.appendChild(document.createTextNode(allTags[i]));
		el.onclick = clicked;
		el.title = tagTitles[allTags[i]] || '';
		// Auto selects current tag
		//if (allTags[i] == currentTag) el.className = "on"
		currentTag = '';
    		tagsArea.appendChild(el);
        	tagsArea.appendChild(document.createTextNode('\n')); //sep
	}
}
window.onload = init;