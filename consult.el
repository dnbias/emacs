;;; consult.el -*- lexical-binding: t; -*-

(require 'org-roam)
(require 'consult)
(require 'vertico)
(require 'vertico-multiform)
(require 'vertico-posframe)

(use-package! vertico
  :custom
  (vertico-multiform-mode 1)
  (vertico-resize t)
  (vertico-count 8))
(use-package! vertico-posframe
  :after vertico
  :custom
  vertico-posframe-parameters
      '((left-fringe . 8)
        (right-fringe . 8)))

(use-package! consult
   :config
   (consult-customize
        consult-project-buffer :preview-key "M-.")
   :custom
   (vertico-resize t)
   (vertico-count 10))

(map! :leader :desc "Search man" "s M" 'consult-man
      :leader :desc "Search buffer" "s s" 'consult-line
      :leader :desc "Search outline" "s o" 'consult-outline
      :leader :desc "Search heading" "s O" 'consult-org-heading
      :leader :desc "Search project files" "SPC" 'consult-project-buffer
      :leader :desc "Search for buffers" "f b" 'consult-buffer)

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
        consult-org-roam-forward-links :preview-key "M-."
        consult-org-roam-file-find
            :preview-key "M-."
            :prompt "Search the brain: "))

(add-to-list 'consult-preview-allowed-hooks 'global-org-modern-mode-check-buffers)
(add-to-list 'consult-preview-allowed-hooks 'global-org-mode-check-buffers)
(add-to-list 'consult-preview-allowed-hooks 'org-num-mode-check-buffers)
(add-to-list 'consult-preview-allowed-hooks 'global-mixed-pitch-mode-check-buffers)
(add-to-list 'consult-preview-allowed-hooks 'global-olivetti-mode-check-buffers)
(add-to-list 'consult-preview-allowed-hooks 'global-hl-todo-mode-check-buffers)

(map! :leader :desc "Search roam entry" "s n f" 'consult-org-roam-file-find
      :leader :desc "Search roam backlink" "s n b" 'consult-org-roam-backlinks
      :leader :desc "Search roam forward-link" "s n l" 'consult-org-roam-forward-links
      :leader :desc "Search roam" "s n s" 'consult-org-roam-search)

(defun my/find-file-in-journal ()
  (interactive)
  (consult-find "~/personal/brain/roam/journal"))

(defun my/find-file-in-config ()
  (interactive)
  (consult-find dotfiles-directory))

(defun my/find-in-doom-dir ()
  (interactive)
  (consult-find doom-user-dir))

(map! :leader :desc "Find file in journal" "f j" 'my/find-file-in-journal
      :leader :desc "Find file in config" "f t" 'org-roam-dailies-goto-today
      :leader :desc "Find file in config" "f p" 'my/find-in-doom-dir
      :leader :desc "Find file in config" "f c" 'my/find-file-in-config)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

(setq! vertico-multiform-commands
      '((consult-org-roam-file-find buffer)
        (execute-extended-command posframe)
        (consult-outline buffer ,(lambda (_) (text-scale-set -1)))
        (consult-bookmark posframe)
        (consult-project-buffer posframe)
        (consult-line posframe)))

(setq vertico-multiform-categories
      '((file posframe)))
