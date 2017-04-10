function _init() {
	// script só roda no site
	// Obs.: Sim, é tosco e fácil de quebrar, mas serve.
	if (!window.location.href.match(/au[r]elio\.n[e]t\/[c]oi[s]in[h]a/)) {
		roda = function(x){ return ''; };
	}
}
// Se editar este arquivo, comente-o em .rsync-exclude
