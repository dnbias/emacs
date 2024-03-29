;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
(package! org-superstar)
;; (package! auto-activating-snippets
;;   :recipe
;;   (:host github
;;    :repo "ymarco/auto-activating-snippets"))

;; (package! LaTeX-auto-activating-snippets
;;   :recipe
;;   (:host github
;;    :repo "tecosaur/LaTeX-auto-activating-snippets"))

(package! company-org-roam
  :recipe (:host github :repo "jethrokuan/company-org-roam"))
(package! org-download)
(package! org-roam-server
  :recipe (:host github :repo "org-roam/org-roam-server"))
(package! pdf-tools)
(package! nov)
(package! justify-kp
  :recipe (:host github
           :repo "Fuco1/justify-kp"))
(package! mixed-pitch)
(package! olivetti)
(package! org-ol-tree
  :recipe (
           :host github
           :repo "Townk/org-ol-tree"
           ))
(package! org-roam-ui)
;; (package! eww)
(package! org-modern)
(package! org-appear)
(package! rainbow-mode)
(package! sublimity)
;; (package! eradio)
(package! perfect-margin)
;; (package! vuiet)
;; (package! edit-server)
(package! centered-cursor-mode)
(package! consult)
(package! consult-org-roam)
(package! orderless)
(package! info-colors :pin "47ee73cc19b1049eef32c9f3e264ea7ef2aaf8a5")
(package! org-fragtog :pin "680606189d5d28039e6f9301b55ec80517a24005")

;; org-roam-bibtex stuff
;; https://github.com/org-roam/org-roam-bibtex
(package! org-roam-bibtex
  :recipe (:host github :repo "org-roam/org-roam-bibtex"))
;; When using org-roam via the `+roam` flag
(unpin! org-roam)
;; When using bibtex-completion via the `biblio` module
(unpin! bibtex-completion helm-bibtex ivy-bibtex)
(unpin! org-mode)
(unpin! org)

(package! evil-snipe)
(package! evil-quickscope)

(package! beacon)
(package! vertico-posframe)
(package! spacious-padding)
