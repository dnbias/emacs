;;; org.el -*- lexical-binding: t; -*-
(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "DOING(d)" "TBR(r)" "READING(e)"
                    "|" "READ(R)" "DONE(D)"))))

(setq org-superstar-special-todo-items t)
(setq org-superstar-todo-bullet-alist '("❏"))
(setq org-modern-star '("" "" "")
      org-modern-hide-stars t)
(use-package org
  :hook
  (org-mode . global-org-modern-mode)
  (org-mode . (lambda()(org-num-mode 1)))
  (org-mode . (lambda()(display-line-numbers-mode -1)))
  (org-mode . (lambda()(org-indent-mode -1))))
(setq line-spacing 0.5)
(add-hook 'lisp-mode-hook 'my-buffer-face-mode-variable)
(modify-all-frames-parameters
 '((right-divider-width . 5)
   (internal-border-width . 40)))
(dolist (face '(window-divider
                window-divider-first-pixel
                window-divider-last-pixel))
  (face-spec-reset-face face)
  (set-face-foreground face (face-attribute 'default :background)))
(set-face-background 'fringe (face-attribute 'default :background))

(let* ((variable-tuple
        (cond ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
              ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
              ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
              ((x-list-fonts "Verdana")         '(:font "Verdana"))
              ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
              (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
       (base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

  (custom-theme-set-faces
   'user
   `(org-block ((t (:background (face-attribute 'default :background)))))
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


(setq org-directory "~/Documents/brain/"
      org-roam-directory (expand-file-name "roam/" org-directory))
(defvar-local journal-file-path (expand-file-name "journal.org" org-roam-directory))
;; (defvar-local TBR-file-path (expand-file-name "TBR.org" org-roam-directory))

(after! org
  (setq org-capture-templates
  '(("t" "Todo" entry (file+headline todo-file-path "Tasks")
     "\n* TODO %?  %^G \nSCHEDULED: %^t\n  %U")
    ("r" "To Be Read" entry (file "~/Documents/Dropbox/Org/roam/Letture.org")
     "\n* TBR %?  %^G \n%U")
    ("j" "Bullet Journal" entry (file+olp+datetree journal-file-path)
     "** %<%H:%M> %?\n")
    ("r" "Roam"  entry (file org-roam-find-file) ;;capture-new-file non funge per qualche motivo
     ""))))

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
        org-appear-autolinks nil)
  ;; for proper first-time setup, `org-appear--set-elements'
  ;; needs to be run after other hooks have acted.
  (run-at-time nil nil #'org-appear--set-elements))


(after! org-roam
  ;; Offer completion for #tags and @areas separately from notes.
  (add-to-list 'org-roam-completion-functions #'org-roam-complete-tag-at-point)
  ;; Automatically update the slug in the filename when #+title: has changed.
  ;; (add-hook 'org-roam-find-file-hook #'org-roam-update-slug-on-save-h)
  ;; Make the backlinks buffer easier to peruse by folding leaves by default.
  (add-hook 'org-roam-buffer-postrender-functions #'magit-section-show-level-2)
  ;; List dailies and zettels separately in the backlinks buffer.
  (advice-add #'org-roam-backlinks-section :override #'org-roam-grouped-backlinks-section)
  ;; Open in focused buffer, despite popups
  (advice-add #'org-roam-node-visit :around #'+popup-save-a)
  ;; Make sure tags in vertico are sorted by insertion order, instead of
  ;; arbitrarily (due to the use of group_concat in the underlying SQL query).
  (advice-add #'org-roam-node-list :filter-return #'org-roam-restore-insertion-order-for-tags-a)
  ;; Add ID, Type, Tags, and Aliases to top of backlinks buffer.
  (advice-add #'org-roam-buffer-set-header-line-format :after #'org-roam-add-preamble-a))
