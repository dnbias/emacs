;;; biblio.el -*- lexical-binding: t; -*-

;; Create a new node from a bibliographic source. taken from
;; https://jethrokuan.github.io/org-roam-guide/
(defun kb/org-roam-node-from-cite (keys-entries)
  (interactive (list (citar-select-ref :multiple nil :rebuild-cache t)))
  (let ((title (citar--format-entry-no-widths (cdr keys-entries)
                                              "${author editor}${date urldate} :: ${title}")))
    (org-roam-capture- :templates
                       '(("r" "reference" plain
                          "%?"
                          :if-new (file+head "references/${citekey}.org"
                                             ":properties:
:roam_refs: [cite:@${citekey}]
:end:
#+title: ${title}
#+filetags: %(kb/insert-lit-category)\n")
                          :immediate-finish t
                          :unnarrowed t))
                       :info (list :citekey (car keys-entries))
                       :node (org-roam-node-create :title title)
                       :props '(:finalize find-file))))


;; https://kristofferbalintona.me/posts/202206141852/#configuration
;; Use `citar' with `org-cite'
(use-package! citar
  :after oc
  ;; The `:straight' keyword is not necessary. However, I do this to set a value
  ;; for the `:includes' keyword. This keyword tells use-package that those
  ;; package(s) are provided by this package, and not to search for them on
  ;; Melpa for download. Alternatively, you can set the `:straight' keyword to
  ;; nil in those package(s) use-package declaration.
  ;; :straight (citar :type git :host github :repo "emacs-citar/citar" :includes (citar-org))
  :bind
  (:map org-mode-map :package org ("C-c b" . #'org-cite-insert))
  :custom
  (org-cite-global-bibliography '("~/Documents/bib/references.bib"))
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar)
  (citar-bibliography org-cite-global-bibliography)
  (citar-notes-paths (list org-roam-directory)) ; List of directories for reference nodes
  (citar-open-note-function 'orb-citar-edit-note) ; Open notes in `org-roam'
  (citar-templates
   '((main . "${author editor:30}   ${date year issued:4}    ${title:110}")
     (suffix . "     ${=type=:20}    ${tags keywords keywords:*}")
     (preview . "${author editor} (${year issued date}) ${title}, ${journal journaltitle publisher container-title collection-title}.\n")
     (note . "#+title: Notes on ${author editor}, ${title}") ; For new notes
     ))
  ;; Configuring all-the-icons. From
  ;; https://github.com/bdarcus/citar#rich-ui
  (citar-symbols
   `((file ,(all-the-icons-faicon "file-o" :face 'all-the-icons-green :v-adjust -0.1) .
           ,(all-the-icons-faicon "file-o" :face 'kb/citar-icon-dim :v-adjust -0.1) )
     (note ,(all-the-icons-material "speaker_notes" :face 'all-the-icons-blue :v-adjust -0.3) .
           ,(all-the-icons-material "speaker_notes" :face 'kb/citar-icon-dim :v-adjust -0.3))
     (link ,(all-the-icons-octicon "link" :face 'all-the-icons-orange :v-adjust 0.01) .
           ,(all-the-icons-octicon "link" :face 'kb/citar-icon-dim :v-adjust 0.01))))
  (citar-symbol-separator "  ")
  :init
  ;; Here we define a face to dim non 'active' icons, but preserve alignment.
  ;; Change to your own theme's background(s)
  ;; (defface kb/citar-icon-dim
  ;;   ;; Change these colors to match your theme. Using something like
  ;;   ;; `face-attribute' to get the value of a particular attribute of a face might
  ;;   ;; be more convenient.
  ;;   '((((background dark)) :foreground (face-attribute 'default :foreground))
  ;;     (((background light)) :foreground (face-attribute 'default :foreground)))
  ;;   "Face for having icons' color be identical to the theme
  ;; background when \"not shown\"."))
  )

(map! :desc "Citar-capture" "C-c c" #'kb/org-roam-node-from-cite)
