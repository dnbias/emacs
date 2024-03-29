;;; org.el -*- lexical-binding: t; -*-

(setq org-directory "~/personal/brain/"
      ;; file-truename used to follow sym-links
      org-roam-directory (file-truename (expand-file-name "roam/" org-directory))
      org-roam-dailies-directory "journal/")

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
  ;; (org-mode . (lambda()(git-gutter-mode -1)))
  (org-mode . (lambda()(hl-line-mode -1)))
  :custom
  (line-spacing nil))

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
 org-ellipsis " ▾ "

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

(use-package! org-fragtog
  :hook (org-mode . org-fragtog-mode))

(load! "ligatures")
;; (load! "org-latex")
(after! org
  (setq org-format-latex-options
        (plist-put org-format-latex-options :background "Transparent"))
  (setq org-format-latex-options
      (plist-put org-format-latex-options :scale 2.2)))

(use-package! ox-hugo
  :after org)
