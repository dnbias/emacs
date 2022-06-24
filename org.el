;;; org.el -*- lexical-binding: t; -*-


(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "DOING(d)" "TBR(r)" "READING(e)"
                    "|" "READ(R)" "DONE(D)"))))

(setq org-superstar-special-todo-items t)
(setq org-superstar-todo-bullet-alist '(
                                         "❏"
                                         ))
(use-package org
  :hook
  (org-mode . company-latex-commands))

(add-hook 'org-mode-hook 'org-superstar-mode)
(setq org-directory "~/git/org/")
(setq org-roam-directory "~/git/org/roam")
(defvar-local journal-file-path "~/git/org/roam/BulletJournal.org")

(add-hook 'lisp-mode-hook 'my-buffer-face-mode-variable)

(after! org
  (setq org-capture-templates
  '(("t" "Todo" entry (file+headline todo-file-path "Tasks")
     "\n* TODO %?  %^G \nSCHEDULED: %^t\n  %U")
    ("r" "To Be Read" entry (file "~/Documents/Dropbox/Org/roam/Letture.org")
     "\n* TBR %?  %^G \n%U")
    ("j" "Bullet Journal" entry (file+olp+datetree journal-file-path)
     "** %<%H:%M> %?\n")
    ("r" "Roam"  entry (file org-roam-find-file) ;;capture-new-file non funge per qualche motivo
     "")
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
        org-appear-autolinks nil)
  ;; for proper first-time setup, `org-appear--set-elements'
  ;; needs to be run after other hooks have acted.
  (run-at-time nil nil #'org-appear--set-elements))
