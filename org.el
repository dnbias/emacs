;;; org.el -*- lexical-binding: t; -*-

(setq org-directory "~/Documents/brain/"
      org-roam-directory (expand-file-name "roam/" org-directory)
      org-roam-dailies-directory (expand-file-name "other/journal/" org-directory))
(defvar-local journal-file-path (expand-file-name "journal.org" org-roam-dailies-directory))
(defvar-local inbox-file-path (expand-file-name "other/inbox.org" org-directory))

(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "DOING(d)" "TBR(r)" "READING(e)"
                    "|" "READ(R)" "DONE(D)"))))

(setq org-superstar-special-todo-items t)
(setq org-superstar-todo-bullet-alist '("❏"))
(setq org-modern-star '("" "" "")
      org-modern-hide-stars t)

(use-package org
  :bind
  ("C-c r" . org-roam-node-find)
  ("C-c i" . org-roam-node-insert)
  ("C-c j" . org-roam-dailies-capture-today)
  :hook
  (org-mode . global-org-modern-mode)
  (org-mode . (lambda()(org-num-mode 1)))
  (org-mode . (lambda()(display-line-numbers-mode -1)))
  (org-mode . (lambda()(perfect-margin-mode -1)))
  (org-mode . (lambda()(org-indent-mode -1)))
  (org-mode . (lambda()(set-fringe-style nil)))
  :custom
  (line-spacing 4))

(let* ((variable-tuple '(:font "SF Pro"))
       (base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

  (custom-theme-set-faces
   'user
   ;; `(org-block ((t (:background (face-attribute 'default :background)))))
   `(org-level-8 ((t (,@headline ,@variable-tuple))))
   `(org-level-7 ((t (,@headline ,@variable-tuple))))
   `(org-level-6 ((t (,@headline ,@variable-tuple))))
   `(org-level-5 ((t (,@headline ,@variable-tuple))))
   `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
   `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
   `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
   `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
   `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))

;; (use-package mixed-pitch
  ;; :hook
  ;; (org-mode . mixed-pitch-mode))

(setq
 ;; Edit settings
 org-auto-align-tags nil
 org-tags-column 0
 org-fold-catch-invisible-edits 'show-and-error
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t

 ;; Org styling, hide markup etc.
 org-hide-emphasis-markers t
 org-pretty-entities t
 org-ellipsis "…"

 ;; Agenda styling
 org-agenda-tags-column 0
 org-agenda-block-separator ?─
 org-agenda-time-grid
 '((daily today require-timed)
   (800 1000 1200 1400 1600 1800 2000)
   " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
 org-agenda-current-time-string
 "⭠ now ─────────────────────────────────────────────────")


(after! org
  (setq org-capture-templates
  '(("t" "Todo" entry (file+headline inbox-file-path "Tasks")
     "\n* TODO %?  %^G \nSCHEDULED: %^t\n  %U")
    ("j" "journal" entry (file+olp+datetree journal-file-path)
     "** %<%H:%M> %?\n")
    )))

(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
   "/DONE" 'agenda))

(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks t)
  ;; for proper first-time setup, `org-appear--set-elements'
  ;; needs to be run after other hooks have acted.
  (run-at-time nil nil #'org-appear--set-elements))
