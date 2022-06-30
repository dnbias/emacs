;;; spellcheck.el -*- lexical-binding: t; -*-

(add-hook 'spell-fu-mode-hook
  (lambda ()
    (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary "it"))
    (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary "en"))
    (spell-fu-dictionary-add
      (spell-fu-get-personal-dictionary "it-personal" "/home/dnbias/.aspell.de.pws"))
    (spell-fu-dictionary-add
      (spell-fu-get-personal-dictionary "en-personal" "/home/dnbias/.aspell.fr.pws"))))
