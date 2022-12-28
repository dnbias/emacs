;;; consult.el -*- lexical-binding: t; -*-

(setq! vertico-resize t
       vertico-count 8)

(use-package! consult
   :bind
   ("M-s r" . consult-ripgrep)
   ("M-s l" . consult-line)
   ("M-s f" . consult-file)
   ("M-s m" . consult-man)
   ("M-s b" . consult-buffer)
   ("M-s O" . consult-outline)
   ("M-s o" . consult-org-heading))

(use-package! consult-org-roam
   :after org-roam
   :init
   (require 'consult-org-roam)
   ;; Activate the minor mode
   (consult-org-roam-mode 1)
   :custom
   ;; Use `ripgrep' for searching with `consult-org-roam-search'
   (consult-org-roam-grep-func #'consult-ripgrep)
   ;; Configure a custom narrow key for `consult-buffer'
   (consult-org-roam-buffer-narrow-key ?r)
   ;; Display org-roam buffers right after non-org-roam buffers
   ;; in consult-buffer (and not down at the bottom)
   (consult-org-roam-buffer-after-buffers t)
   :config
   ;; Eventually suppress previewing for certain functions
   (consult-customize
    consult-org-roam-forward-links
    :preview-key (kbd "M-."))
   :bind
   ;; Define some convenient keybindings as an addition
   ("M-s n f" . consult-org-roam-file-find)
   ("M-s n b" . consult-org-roam-backlinks)
   ("M-s n l" . consult-org-roam-forward-links)
   ("M-s n r" . consult-org-roam-search))
