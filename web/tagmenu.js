/*

Notes:

	If this script is used as the primary navigation for the site, give
	no-javascript browsers an alternative menu. Put all the links inside
	the #menulinks DIV. Javascript will clear its contents on page load.

	The Tag Cloud (left) is composed automatically from the link bank.
	Just fill the tags for all links and it will appear.

	The Multiple Mode uses AND logic, not OR.

	All links are shown inline on the page load.
*/

var defaultTag = 'eu';

// The background color of the link is used to get its 'activated' state
var linkFgColor = '#07f';
var linkBgColor = '#fff';

// Not using <em> to simplify generated code <a><em><em>Foo</em></em></a>
// and work even without CSS
// Not using pixels because... you know.
var linksWeightSize = [ 1, 1.25, 1.5, 1.75, 2, 2.25, 2.5 ]; // in EM

var tagTitles = {
	'applescript'	: 'Linguagem AppleScript',
	'banda'		: 'Bandas de hardcore',
	'cygwin'	: 'Cygwin - O Linux no Windows',
	'curso'		: 'Cursos e Palestras em eventos e empresas',
	'doc'		: 'Artigos, Textos , Guias, ...',
	'esporte'	: 'Carveboard, surf, bike, escalada',
	'eu'		: 'Sobre mim',
	'forum'		: 'Fórums (Listas de Discussão)',
	'foto'		: 'Minhas fotos',
	'game'		: 'Joguinhos',
	'javascript'	: 'Linguagem Javascript',
	'linux'		: 'Sistema Linux',
	'livro'		: 'Livros que escrevi',
	'mac'		: 'Apple, Mac (Macintosh), Mac OS X',
	'musica'	: 'Música, minhas bandas, bateria, hardcore',
	'php'		: 'Linguagem PHP',
	'python'	: 'Linguagem Python',
	'regex'		: 'Expressões Regulares',
	'sed'		: 'Ferramenta SED',
	'shell'		: 'Shell Script (Bash)',
	'site'		: 'AURELIO.NET',
	'software'	: 'Softwares que escrevi',
	'viagem'	: 'Viagens que fiz',
	'video'		: 'Meus vídeos',
	'vim'		: 'Editor de textos Vim',
	'web'		: 'Tecnologias Web: (X)HTML, CSS, Javascript, SVG, ...'
}

// Format: [ Importance (0-3), 'Link name', 'URL', 'tags' ]
var allLinks = [
// bin
[0, 'txt2regex',	'http://aurelio.net/projects/txt2regex/', 'software shell regex'],
[1, 'Funções ZZ',	'http://funcoeszz.net', 'software shell'],
[2, 'txt2tags',		'http://txt2tags.sf.net/pt', 'software python web site'],
[0, 'Sedsed',		'http://aurelio.net/projects/sedsed/', 'software sed python'],
[1, 'Sed Sokoban',	'sed/sokoban/', 'software sed game'],
[0, 'Sed Arkanoid',	'bin/sed/arkanoid/', 'software sed game'],
[0, 'RAC',		'rac', 'software'],
[0, 'LELOLAB',		'bin/lelolab/', 'software game'],
[0, 'Simulador das Eleições 2002',	'bin/python/urna.py', 'software python'],
[0, 'Importa agenda (CSV) no tocador de MP3 xingue-lingue',	'http://aurelio.net/blog/2005/11/09/contatos-do-csv-para-o-tocador-de-mp3/', 'software python musica'],
[0, 'Site com cores aleatórias',	'bin/php/randbody.phps', 'software php'],
[0, 'Projeto Final da Faculdade - Lojinha Virtual',	'bin/php/ESEEI-proj_final/', 'software php'],
[0, 'OpenOffice Console Search',	'bin/bash/oofind', 'software shell'],
[0, 'Quizz',		'bin/python/quizz/', 'software python'],
[0, 'Sed scripts',	'bin/sed/', 'software sed'],
[1, 'MoneyLog Experience', 	'moneylog', 'software javascript web'],
[0, 'Campo Minado', 		'web/mina/', 'software web javascript game'],

// bin mac
[2, 'Adium Book',	'bin/as/adiumbook', 'software applescript mac'],
[0, 'Import Contacts From Yahoo CSV',	'bin/as/ImportContactsFromYahooCSV.py', 'software applescript python mac'],
[0, 'Export Contacts to MP3 Player',	'http://aureliosoft.wordpress.com/export-contacts-to-mp3-player/', 'software applescript mac'],
[0, 'Export Contacts to Yahoo CSV',	'http://aureliosoft.wordpress.com/export-contacts-to-yahoo-csv/', 'software applescript mac'],
[0, 'iPhoto Set Sequential Title',	'http://aureliosoft.wordpress.com/iphoto-set-sequential-title/', 'software applescript mac'],
[0, 'iTunes Find Artwork-less',	'http://aureliosoft.wordpress.com/itunes-find-artwork-less/', 'software applescript mac'],
[0, 'iTunes Rename Disk File',	'http://aureliosoft.wordpress.com/itunes-rename-disk-file/', 'software applescript mac'],
[0, 'iTunes Search in Lyrics',	'http://aureliosoft.wordpress.com/itunes-search-in-lyrics/', 'software applescript mac'],
[0, 'iTunes SED',	'http://aureliosoft.wordpress.com/itunes-sed/', 'software applescript mac'],
[0, 'AppleScript for Python Programmers',	'doc/as4pp.html', 'doc applescript mac python'],
[1, 'AppleScripts',	'bin/as', 'mac'],

// doc
[1, '*Portal Documentação*',	'doc', 'doc'],
[1, 'Portal Vim',		'doc/vim/', 'doc vim'],
[1, 'Portal Sed',		'sed/', 'doc sed'],
[1, 'Portal Cygwin',		'cygwin/', 'doc cygwin linux'],
[1, 'Portal Mac',		'mac/', 'doc mac'],
[1, 'Portal Shell',		'shell/', 'doc shell'],
[1, 'Portal Programação',	'bin/', 'doc software'],
[1, 'Portal Expressões Regulares',	'er/', 'doc regex'],
[0, 'FAQ VERDE',		'doc/faq.html', 'doc eu'],
[1, 'Faça Você Mesmo', 		'fvm//', 'doc'],
[1, 'DORT - Usando o Computador Sem Se Machucar',	'doc/misc/dort.html', 'doc'],
[0, 'Dotfiles',	'doc/dotfiles/', 'doc linux'],
[0, 'Lista dos jogos terminados',	'doc/videogame.html', 'doc game'],
[0, 'RAMONES',	'doc/misc/ramones.txt', 'doc musica banda'],
[0, '/usr/bin/adventure - Mapa das cavernas',	'doc/misc/adventure-mapa.txt', 'doc linux game'],

[1, 'Sed HOWTO',		'sed/sed-HOWTO', 'doc sed'],
[1, 'Canivete Suíço do Shell',	'shell/canivete.html', 'doc shell'],
[1, 'Dialog --tudo',		'shell/dialog', 'doc shell'],
[2, 'Apostila Programação Shell',	'shell/apostila', 'doc shell livro'],
[0, 'Editando arquivos do OpenOffice.org no VI',	'vim/ooo-vi.html', 'doc vim'],
[0, 'Programas Compatíveis com Python v1.5',	'http://www.pythonbrasil.com.br/moin.cgi/ProgramasCompativeisV15', 'doc python'],
[0, 'Sem Mouse HOWTO',	'doc/sem-mouse-HOWTO.html', 'doc linux'],
[0, 'Morte à tecla CAPS LOCK!',	'doc/CAPSLOCK.txt', 'doc linux'],
[0, 'Fanatismo Digital - A Guerra dos Editores',	'doc/guerra-editores.html', 'doc vim'],
[0, 'Revista LinuxMag #02 - Seleção VI-sual',	'http://www.linuxmagazine.com.br/issue/02/selecao_visual.pdf', 'doc vim'],
[0, 'RdL #03 - O Poder do Modo Texto', 'doc/rdl/poder-modo-texto.html', 'doc linux'],
[0, 'RdL #03 - Expressões Regulares - Parte 1', 'doc/rdl/regex-1.html', 'doc regex'],
[0, 'RdL #04 - Vi, Vim e Venci', 'doc/rdl/vi-vim-venci.html', 'doc vim'],
[0, 'RdL #04 - Áreas Compartilhadas', 'doc/rdl/areas-compartilhadas.html', 'doc linux'],
[0, 'RdL #07 - Expressões Regulares - Parte 2', 'doc/rdl/regex-2.html', 'doc regex'],
[0, 'RdL #47 - Cygwin - O Linux no Windows', 'cygwin/rdl/', 'doc cygwin'],
[0, 'RdL #49 - Pulando com o VI', 'doc/vim/pulando.html', 'doc vim'],
[0, 'Coluna 01 - Introdução', 'doc/coluna/coluna-01.html', 'doc linux'],
[0, 'Coluna 02 - ICQ', 'doc/coluna/coluna-02.html', 'doc linux'],
[0, 'Coluna 03 - Zgv/ImageMagick (manipulação de imagens)', 'doc/coluna/coluna-03.html', 'doc linux web'],
[0, 'Coluna 04 - Pine (e-mails na tela preta)', 'doc/coluna/coluna-04.html', 'doc linux'],
[0, 'Coluna 05 - Jogos (uma viagem ao mundo da diversão)', 'doc/coluna/coluna-05.html', 'doc linux game'],
[0, 'Coluna 06 - Arte Ascii (artistas do teclado)', 'doc/coluna/coluna-06.html', 'doc'],
[0, 'Coluna 07 - Screen (janelizando o modo texto - parte 1)', 'doc/coluna/coluna-07.html', 'doc linux'],
[0, 'Coluna 08 - Screen (janelizando o modo texto - parte 2)', 'doc/coluna/coluna-08.html', 'doc linux'],
[0, 'Coluna 09 - Vim (um vimrc diferente)', 'doc/coluna/coluna-09.html', 'doc vim'],
[0, 'Coluna 10 - Mpage (impressão ágil em postscript)', 'doc/coluna/coluna-10.html', 'doc linux'],
[0, 'Coluna 11 - Caracteres de Controle (não fuja, domine-os)', 'doc/coluna/coluna-11.html', 'doc'],
[0, 'Coluna 12 - Lynx (navegação turbinada)', 'doc/coluna/coluna-12.html', 'doc linux web'],

[2, 'Livro Expressões Regulares',	'er/livro', 'doc livro regex python php javascript sed vim'],
[0, 'Livro Dominando o SED',		'sed/livro/', 'doc livro sed'],
[1, 'Cartilha do Webdesigner Antenado',	'http://aurelio.net/blog/2006/06/01/cartilha-do-webdesigner-antenado/', 'doc web'],
[0, 'CSS: Menu fixo porém líquido',	'http://aurelio.net/blog/2006/06/30/css-menu-fixo-porem-liquido/', 'doc web'],
[0, 'E-book ou livro impresso, como publicar sua obra?',	'http://aurelio.net/blog/2006/05/15/e-book-ou-livro-impresso-como-publicar-sua-obra/', 'doc livro'],

// listas
[0, 'Lista Linux2osx',	'http://br.groups.yahoo.com/group/linux2macosx', 'forum linux mac'],
[0, 'Lista Shell',	'http://br.groups.yahoo.com/group/shell-script', 'forum shell'],
[0, 'Lista Sed',	'http://br.groups.yahoo.com/group/sed-br', 'forum sed'],
[0, 'Lista VI',		'http://br.groups.yahoo.com/group/vi-br', 'forum vim'],
[0, 'Lista Cygwin',	'http://yahoogrupos.com.br/groups/cygwin-br', 'forum cygwin'],
[0, 'Lista ZZ',		'http://br.groups.yahoo.com/group/zztabtab', 'forum'],
[0, 'Lista txt2tags',	'http://br.groups.yahoo.com/group/txt2tags-br', 'forum'],

// musica
[0, 'Valeta',		'valeta/', 'banda musica'],
[1, 'Correria HC',	'http://aurelio.net/correria/', 'banda musica'],
[0, 'Dumbs',		'dumbs/', 'banda musica'],
[0, 'DDD',		'musica/ddd/', 'musica'],
[0, 'Baterna',		'baterna/', 'musica'],
[0, 'Bateria',		'musica/', 'musica'], 
[0, 'Carbona',		'http://aurelio.net/blog/2006/04/30/dica-de-banda-carbona/', 'banda musica'], 
[1, 'Roda de Pogo - A Dança Punk',	'pogo/', 'musica'],

// site
[0, 'Sobre o site',		'sobre.html', 'site'],
[0, 'Página Principal',		'index.html', 'site'],
[1, 'Deixe seu recado',		'recados.php', 'site eu'],
[0, 'Contador de acessos',	'bin/php/counter.phps', 'site software php'],
[0, 'Livro de visitas',		'bin/php/recados.phps', 'site software php'],
[0, 'Registro do domínio',	'http://www.e-dominios.com.br?from=8061', 'site'],
[0, 'Em inglês',		'en/', 'site'],
[0, 'Txt2tags Online',		'http://txt2tags.sourceforge.net/pt/online.php', 'software php'],

// eu
[1, 'Orkut',			'http://www.orkut.com/Profile.aspx?uid=2039382754798085041', 'eu foto'],
[0, 'Blog Feed (RSS)',		'http://aurelio.net/blog/feed/', 'eu site'],
[2, 'Blog',			'http://aurelio.net/blog/', 'eu foto site'],
[0, 'Sobre mim',		'mim.html', 'eu'],
[0, '$$$ Campanha Aurélio Trilhardário $$$',	'1000000000000.html', 'eu'],
[0, 'Blog antigo',		'blog-arquivo.html', 'eu'],
[0, 'Processo de desnerdização',	'http://aurelio.net/blog/2005/11/30/processo-de-desnerdizacao/', 'eu'],
[0, 'Aurélio v2.8',		'http://aurelio.net/blog/2005/10/07/aurelio-v28/', 'eu'],
[0, 'Um ano sem Linux',		'http://aurelio.net/blog/2005/10/02/um-ano-sem-linux/', 'eu linux mac'],
[0, 'Free as in BIRD',		'http://aurelio.net/blog/2005/09/23/free-as-in-bird/', 'eu linux mac'],
[0, 'Currículo',		'doc/cv-aurelio.html', 'eu'],
[0, 'Flickr',			'http://www.flickr.com/photos/aureliojargas', 'eu foto'],
[1, 'Doação Paypal',		'http://sourceforge.net/donate/index.php?user_id=1345338', 'software doc site'],

// curso
[0, '4Linux - SP',		'curso/4linux/', 'curso'],
[0, 'Conectiva - PR',	'curso/conectiva/', 'curso'],
[0, 'Sucesu - PR',		'curso/sucesu/', 'curso'],
[0, 'Congresso Catarinense de Software Livre (CCSL) - SC',		'curso/ccsl/', 'curso'],
[0, 'Semana de Informática da FAC - SP',	'curso/fac/', 'curso'],
[0, 'Fórum Internacional de Software Livre (FISL) - RS',		'curso/fisl/', 'curso'],
[0, 'Encontro Nacional LinuxChix - SP',	'curso/linuxchix/', 'curso'],
[0, 'Seminário de Desenvolvimento em Software Livre (SDSL) - SP/RS',	 'curso/sdsl/', 'curso'],
[0, 'Semana de Software Livre da UFPR - PR', 'curso/ufpr/', 'curso'],
[0, 'Semana de Capacitação e Desenvolvimento em Software Livre (SCSL) - DF', 'curso/scsl/', 'curso'],
[0, 'Apostila Introdução ao Shell Script', 'curso/material/apostila-shell-intro.pdf', 'curso doc shell'],
[0, 'Apostila Conhecendo as Expressões Regulares', 'curso/material/apostila-expressoes-intro.pdf', 'curso doc regex'],
[0, 'Editor VI - Guia de Referência', 'curso/material/vim-ref.html', 'curso doc vim'],
[0, 'Slides: Software Livre - Experiências de um Desenvolvedor', 'curso/material/desenvolvedor', 'curso doc'],

// foto
[0, 'Aurélio Freak Show',	'foto/tosco/', 'foto eu'],
[0, 'Surf - Fotos Aquáticas',	'surf/', 'foto esporte'],
[0, 'Shows com a banda',	'foto/banda/', 'foto banda musica'],
[0, 'Meu pé tatuado',		'foto/pe/', 'foto eu'],
[0, 'Fotos bizarras',		'http://geocities.yahoo.com.br/aureliojargas/biz/', 'foto'],
[0, 'Jacaré do Parque Barigüi',	'http://aurelio.net/blog/2004/09/05/jacare-do-parque-barigui/', 'foto'],

// viagem
[1, 'Portal das Viagens',		'viagem/', 'foto viagem'],
[1, 'Curitiba-Matinhos de bicicleta - PR',	'viagem/matinhos-bike-2004/', 'foto viagem esporte'],
[1, 'Deserto do Atacama (Chile)',	'viagem/atacama/', 'foto viagem'],
[0, 'Farol Sta. Marta e Imbituba - SC', 'viagem/farol-imbituba-2001/', 'viagem foto'],
[0, 'Escalada Pico Marumbi - PR',	'viagem/marumbi-2001/', 'viagem foto esporte'],
[0, 'Trilha do Pinhão - PR',		'viagem/trilha-pinhao-2001/', 'viagem foto'],
[0, 'Férias e Surfe em Matinhos - PR',	'viagem/matinhos-2005/', 'viagem foto esporte'],

// misc
[0, 'Changelog Nerd',	'doc/changelog-nerd.html', 'software doc'],
[0, 'Sed Sokoban Slashdotted',	'http://developers.slashdot.org/article.pl?sid=02/03/21/0217219', 'sed'],
[0, 'Não fazem mais jogos como antigamente',	'http://aurelio.net/blog/2005/12/04/nao-fazem-mais-jogos-como-antigamente/', 'game'],
[0, 'Blog AppleScripts',	'http://aureliosoft.wordpress.com', 'applescript mac'],
[0, 'Blog AppleScripts Feed (RSS)',	'http://aureliosoft.wordpress.com/feed/', 'applescript mac'],
[0, 'Sintaxe txt2tags',	'http://txt2tags.sourceforge.net/tools/txt2tags.vim', 'vim'],
[1, 'Portal Carveboard',		'carve/', 'foto video esporte'],
[0, 'Campeonato de Carveboard', 'http://aurelio.net/blog/2006/08/03/relato-fotos-e-videos-do-campeonato-de-carveboard/', 'foto video esporte']
];

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

// Multiple tag selection
function toggleTag(link) {
	// Toggle clicked tag state
	link.className = (link.className == 'on') ? 'off' : 'on';
	// Show links for all the clicked tags, hide others
	var activeTags = getActiveTags();
	var menuLinks = getAllMenuLinks();
	for (var i = 0; i < menuLinks.length; i++) {
		menuLinks[i].style.display = (
			showorNot(menuLinks[i], activeTags)) ? 'block' : 'none';
	}
}

function clicked() {
	var currentMode = document.getElementById('menumode').firstChild.nodeValue;
	if (currentMode == 'Single Mode') {
		singleTag(this);
	} else {
		toggleTag(this);
	}
	return false;	
}

function toggleMore() {
	if (this.innerHTML == '&gt;') {
		this.innerHTML = '&lt;';
		this.nextSibling.style.display = 'inline';
	} else {
		this.innerHTML = '&gt;';
		this.nextSibling.style.display = 'none';
	}
	return false;	
}
function toggleMode() {
	this.innerHTML = (this.innerHTML == 'Single Mode') ?
		'Multiple Mode' : 'Single Mode';
	return false;	
}
function toggleNumbers() {
	var els = document.getElementById('menutags').getElementsByTagName('span');
	var elDisplay;
	if (this.innerHTML == 'tag') {
		this.innerHTML = '#.tag';
		elDisplay = 'inline';
	} else {
		this.innerHTML = 'tag';
		elDisplay = 'none';
	}
	// Don't know how to change the global style sheet property
	// So let's do it one by one (sux)
	for (var i = 0; i < els.length; i++) {
		if (els[i].className == 'menutagcount') {
			els[i].style.display = elDisplay;
		}
	}
	return false;	
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
		// Auto selects default tag
		if (allTags[i] == defaultTag) el.className = "on"
    		tagsArea.appendChild(el);
        	tagsArea.appendChild(document.createTextNode('\n')); //sep
	}

	// Create the Advanced pane
	extraArea = document.createElement('div');
	extraArea.id = 'menuextra';
	// The '>' button
	el = document.createElement('span');
	el.id = 'menumore';
	el.onclick = toggleMore;
       	el.appendChild(document.createTextNode('>'));
	el.title = 'Show/Hide Options';
    	extraArea.appendChild(el);
	// The 'more' container
	extraAreaMore = document.createElement('div');
	extraAreaMore.id = 'menuextramore';
	// The toggle mode button
       	el = document.createElement('span');
	el.id = 'menumode';
	el.onclick = toggleMode;
	el.title = 'Single Mode (one tag) / Multiple Mode (multi tags, AND logic)';
       	el.appendChild(document.createTextNode('Single Mode'));
    	extraAreaMore.appendChild(el);
	// The toggle number button
       	el = document.createElement('span');
	el.id = 'numbers';
	el.onclick = toggleNumbers;
	el.title = 'Show/Hide tag count';
       	el.appendChild(document.createTextNode('tag'));
    	extraAreaMore.appendChild(el);
	// The stats
       	var stats = ' ('+allTags.length+' tags, '+allLinks.length+' links)';
       	extraAreaMore.appendChild(document.createTextNode(stats));
	// Pack it all
       	extraArea.appendChild(extraAreaMore);
    	tagsArea.appendChild(extraArea);
	
	// Create link cloud
	var linksArea = document.getElementById('menulinks');
	allLinks.sort(sortLinkArray);
	for (var i = 0; i < allLinks.length ; i++) { // Weight,Name,URL,class

		var el = document.createElement('a');
		el.href = allLinks[i][2];
		el.className = allLinks[i][3];
     	  	el.appendChild(document.createTextNode(allLinks[i][1]));
		
		// Using one weight level (bold) instead multi (font-size)
		//el.style.fontSize = linksWeightSize[allLinks[i][0]] + 'em';
		if (allLinks[i][0] > 0) { el.style.fontWeight = 'bold'; }

		// Shows only the default tag links
		el.style.display = (showorNot(el, [defaultTag])
			) ? 'block' : 'none';
		
    		linksArea.appendChild(el);
        	linksArea.appendChild(document.createTextNode('\n')); //sep
	}
}
window.onload = init;
