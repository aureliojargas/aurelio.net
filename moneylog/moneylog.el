;;; moneylog.el --- Provide a way to enter moneylog logs

;; Copyright (C) 2009  Leslie Harlley Watter

;; Author: Leslie Harlley Watter <leslie@watter.org>
;; Keywords: 

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This file should be used with moneylog (www.aurelio.net/moneylog)

;; pt_BR:

;; Para usar: abrir o buffer e digitar:
;; M-x eval-buffer

;; Ir para o moneylog4.html e digitar

;; M-x i-register
;; funcao para o emacs para incluir um registro (conta)

;; M-x i-reg-ccredit
;; funcao para inserir um registro de cartao de credito (pergunta data de
;; pagamento da fatura e data da compra alem dos demais itens)

;;; Code:



(defun i-register ()
  "Inserts/format an account record. It should be used with moneylog
   2009.08.15	-29.00	visa	| Cicles Radar - Mesa para a bicicleta"
  (interactive)
;; pre-fills the today variable with today's date
  (setq today (format-time-string "%Y-%m-%d"))
  (setq rdata (read-string "Data (2009.06.15): " today ))
  (unless (equal rdata "")
  (setq rvalor (read-string "Valor (110.00 ou -110.00): "))
  (unless (equal rvalor "")
  (setq rtags (read-string "Tags (poupanca,visa,ccred): "))
  (setq rcomentario (read-string "Comentario: "))
  (unless (equal rcomentario "")
    (insert (format "%s\t%s\t%s| %s\n" rdata rvalor rtags rcomentario )) ;
))))



(defun i-reg-ccredit ()
  "Inserts/format an account record. It should be used with moneylog
   2009.08.15	-29.00	visa	| Cicles Radar - Mesa para a bicicleta"
  (interactive)
;; pre-fills the today variable with today's date
  (setq today (format-time-string "%Y-%m-%d"))
  (setq rdata (read-string "Data Vencimento (2009.06.15): " today ))
  (unless (equal rdata "")
  (setq rvalor (read-string "Valor (110.00 ou -110.00): "))
  (unless (equal rvalor "")
  (setq rtags (read-string "Tags (ccred): "))
  (setq bdate (format-time-string "%m.%d"))
  (setq rdatacompra (read-string "Data compra (mm.dd): " bdate))
  (unless (equal rdatacompra "")
  (setq rcomentario (read-string "Comentario: "))
  (unless (equal rcomentario "")
    (insert (format "%s\t%s\t%s| @%s %s\n" rdata rvalor rtags rdatacompra rcomentario )) ;
)))))


(provide 'moneylog)
;;; moneylog.el ends here
