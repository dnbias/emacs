;;; spellcheck.el -*- lexical-binding: t; -*-

;; (add-hook 'spell-fu-mode-hook
;;   (lambda ()
;;     (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary "it"))
;;     (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary "en"))
;;     (spell-fu-dictionary-add
;;       (spell-fu-get-personal-dictionary "it-personal" "/home/dnbias/.aspell.it.pws"))
;;     (spell-fu-dictionary-add
;;       (spell-fu-get-personal-dictionary "en-personal" "/home/dnbias/.aspell.en.pws"))))

(with-eval-after-load "ispell"
  ;; Configure `LANG`, otherwise ispell.el cannot find a 'default
  ;; dictionary' even though multiple dictionaries will be configured
  ;; in next line.
  (setenv "LANG" "en_US.UTF-8")
  (setq ispell-program-name "hunspell")
  ;; Configure German, Swiss German, and two variants of English.
  (setq ispell-dictionary "italiano,en_GB,en_US")
  ;; ispell-set-spellchecker-params has to be called
  ;; before ispell-hunspell-add-multi-dic will work
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "italiano,en_GB,en_US")
  ;; For saving words to the personal dictionary, don't infer it from
  ;; the locale, otherwise it would save to ~/.hunspell_de_DE.
  (setq ispell-personal-dictionary
        (expand-file-name "hunspell_personal" org-directory)))

;; The personal dictionary file has to exist, otherwise hunspell will
;; silently not use it.
<<<<<<< HEAD
;;(unless (file-exists-p ispell-personal-dictionary)
;;  (write-region "" nil ispell-personal-dictionary nil 0))
=======
;; (unless (file-exists-p ispell-personal-dictionary)
;;   (write-region "" nil ispell-personal-dictionary nil 0))
>>>>>>> 98d15fe (various)
