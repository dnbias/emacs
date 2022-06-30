;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Daniel Biasiotto"
       user-mail-address "mail@dnbias.dev")

(load! "evil")
(load! "org")
(load! "roam")
(load! "theme")
(load! "nov")
(load! "development")
(load! "deft")
(load! "stuff")
(load! "spellcheck")
;; (load! "biblio") TODO
