;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
(package! evil-snipe :disable t) ;; conflicts with rebindings to s
(package! org-superstar)
(package! auto-activating-snippets
  :recipe
  (:host github
   :repo "ymarco/auto-activating-snippets"))
(package! LaTeX-auto-activating-snippets
  :recipe
  (:host github
   :repo "tecosaur/LaTeX-auto-activating-snippets"))
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
(package! visual-fill-column)
(package! mixed-pitch)
(package! olivetti)
(package! org-ol-tree
  :recipe (
           :host github
           :repo "Townk/org-ol-tree"
           ))
(package! org-roam-ui)
(package! eww)
(package! org-modern)
(package! org-appear)
(package! rainbow-mode)
(package! sublimity)
(package! eradio)
(package! perfect-margin)
(package! vuiet)
(package! edit-server)
(package! centered-cursor-mode)
