;;; latex.el -*- lexical-binding: t; -*-
(require 'ox-latex)

(setq org-latex-classes
             '(("my_thesis"  ;; use with: #+LaTeX_CLASS: my_thesis
                      "\\input{my_thesis.tex}"
                      ("\\section{%s}" . "\\section*{%s}")
                      ("\\subsection{%s}" . "\\subsection*{%s}")
                      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                      ("\\paragraph{%s}" . "\\paragraph*{%s}")
                      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))


(setq org-latex-pdf-process '("latexmk -shell-escape -f -pdf -%latex -interaction=nonstopmode -output-directory=%o %f"
                              "latexmk -shell-escape -f -pdf -%latex -interaction=nonstopmode -output-directory=%o %f"))
(setq org-latex-src-block-backend 'minted)
;; https://github.com/kaushalmodi/.emacs.d/blob/42831e8997f7a3c90bf4bd37ae9f03c48277781d/setup-files/setup-org.el#L413-L584
;; (use-package ox-latex
;;           :config
;;           (progn
;;             (defvar modi/ox-latex-use-minted t
;;               "Use `minted' package for listings.")

;;             (setq org-latex-compiler "pdflatex") ; introduced in org 9.0

;;             (setq org-latex-prefer-user-labels t) ; org-mode version 8.3+

;;             ;; ox-latex patches
;;             ;; (load (expand-file-name
;;             ;;        "ox-latex-patches.el"
;;             ;;        (concat user-emacs-directory "elisp/patches/"))
;;             ;;       nil :nomessage)

;;             ;; Previewing latex fragments in org mode
;;             ;; http://orgmode.org/worg/org-tutorials/org-latex-preview.html
;;             ;; (setq org-latex-create-formula-image-program 'dvipng) ; NOT Recommended
;;             (setq org-latex-create-formula-image-program 'imagemagick) ; Recommended

;;             ;; Controlling the order of loading certain packages w.r.t. `hyperref'
;;             ;; http://tex.stackexchange.com/a/1868/52678
;;             ;; ftp://ftp.ctan.org/tex-archive/macros/latex/contrib/hyperref/README.pdf
;;             ;; Remove the list element in `org-latex-default-packages-alist'.
;;             ;; that has '("hyperref" nil) as its cdr.
;;             ;; http://stackoverflow.com/a/9813211/1219634
;;             (setq org-latex-default-packages-alist
;;                   (delq (rassoc '("hyperref" nil) org-latex-default-packages-alist)
;;                         org-latex-default-packages-alist))
;;             ;; `hyperref' will be added again later in `org-latex-packages-alist'
;;             ;; in the correct order.

;;             ;; The `org-latex-packages-alist' will output tex files with
;;             ;;   \usepackage[FIRST STRING IF NON-EMPTY]{SECOND STRING}
;;             ;; It is a list of cells of the format:
;;             ;;   ("options" "package" SNIPPET-FLAG COMPILERS)
;;             ;; If SNIPPET-FLAG is non-nil, the package also needs to be included
;;             ;; when compiling LaTeX snippets into images for inclusion into
;;             ;; non-LaTeX output (like when previewing latex fragments using the
;;             ;; "C-c C-x C-l" binding.
;;             ;; COMPILERS is a list of compilers that should include the package,
;;             ;; see `org-latex-compiler'.  If the document compiler is not in the
;;             ;; list, and the list is non-nil, the package will not be inserted
;;             ;; in the final document.

;;             (defconst modi/org-latex-packages-alist-pre-hyperref
;;               '(("letterpaper,margin=1.0in" "geometry")
;;                 ;; Prevent an image from floating to a different location.
;;                 ;; http://tex.stackexchange.com/a/8633/52678
;;                 ("" "float")
;;                 ;; % 0 paragraph indent, adds vertical space between paragraphs
;;                 ;; http://en.wikibooks.org/wiki/LaTeX/Paragraph_Formatting
;;                 ("" "parskip"))
;;               "Alist of packages that have to be loaded before `hyperref'
;; package is loaded.
;; ftp://ftp.ctan.org/tex-archive/macros/latex/contrib/hyperref/README.pdf ")

;;             (defconst modi/org-latex-packages-alist-post-hyperref
;;               '(;; Prevent tables/figures from one section to float into another section
;;                 ;; http://tex.stackexchange.com/a/282/52678
;;                 ("section" "placeins")
;;                 ;; Graphics package for more complicated figures
;;                 ("" "tikz")
;;                 ("" "caption")
;;                 ;;
;;                 ;; Packages suggested to be added for previewing latex fragments
;;                 ;; http://orgmode.org/worg/org-tutorials/org-latex-preview.html
;;                 ("mathscr" "eucal")
;;                 ("" "latexsym"))
;;               "Alist of packages that have to (or can be) loaded after `hyperref'
;; package is loaded.")

;;             ;; The "H" option (`float' package) prevents images from floating around.
;;             (setq org-latex-default-figure-position "H") ; figures are NOT floating
;;             ;; (setq org-latex-default-figure-position "htb") ; default - figures are floating

;;             ;; `hyperref' package setup
;;             (setq org-latex-hyperref-template
;;                   (concat "\\hypersetup{\n"
;;                           "pdfauthor={%a},\n"
;;                           "pdftitle={%t},\n"
;;                           "pdfkeywords={%k},\n"
;;                           "pdfsubject={%d},\n"
;;                           "pdfcreator={%c},\n"
;;                           "pdflang={%L},\n"
;;                           ;; Get rid of the red boxes drawn around the links
;;                           "colorlinks,\n"
;;                           "citecolor=black,\n"
;;                           "filecolor=black,\n"
;;                           "linkcolor=blue,\n"
;;                           "urlcolor=blue\n"
;;                           "}"))

;;             (if modi/ox-latex-use-minted
;;                 ;; using minted
;;                 ;; https://github.com/gpoore/minted
;;                 (progn
;;                   (setq org-latex-listings 'minted) ; default nil
;;                   ;; The default value of the `minted' package option `cachedir'
;;                   ;; is "_minted-\jobname". That clutters the working dirs with
;;                   ;; _minted* dirs. So instead create them in temp folders.
;;                   (defvar latex-minted-cachedir (concat temporary-file-directory
;;                                                         (getenv "USER")
;;                                                         "/.minted/\\jobname"))
;;                   ;; `minted' package needed to be loaded AFTER `hyperref'.
;;                   ;; http://tex.stackexchange.com/a/19586/52678
;;                   (add-to-list 'modi/org-latex-packages-alist-post-hyperref
;;                                `(,(concat "cachedir=" ; options
;;                                           latex-minted-cachedir)
;;                                  "minted" ; package
;;                                  ;; If `org-latex-create-formula-image-program'
;;                                  ;; is set to `dvipng', minted package cannot be
;;                                  ;; used to show latex previews.
;;                                  ,(not (eq org-latex-create-formula-image-program 'dvipng)))) ; snippet-flag

;;                   ;; minted package options (applied to embedded source codes)
;;                   (setq org-latex-minted-options
;;                         '(("linenos")
;;                           ("numbersep" "5pt")
;;                           ("frame"     "none") ; box frame is created by `mdframed' package
;;                           ("framesep"  "2mm")
;;                           ;; minted 2.0+ required for `breaklines'
;;                           ("breaklines"))) ; line wrapping within code blocks
;;                   ;; (when (equal org-latex-compiler "pdflatex")
;;                     ;; (add-to-list 'org-latex-minted-options '(("fontfamily"  "zi4"))))
;;                 )
;;               ;; not using minted
;;               (progn
;;                 ;; Commented out below because it clashes with `placeins' package
;;                 ;; (add-to-list 'modi/org-latex-packages-alist-post-hyperref '("" "color"))
;;                 (add-to-list 'modi/org-latex-packages-alist-post-hyperref '("" "listings"))))

;;             (setq org-latex-packages-alist
;;                   (append modi/org-latex-packages-alist-pre-hyperref
;;                           '(("" "hyperref" nil))
;;                           modi/org-latex-packages-alist-post-hyperref))

;;             ;; `-shell-escape' is required when using the `minted' package

;;             ;; http://orgmode.org/worg/org-faq.html#using-xelatex-for-pdf-export
;;             ;; latexmk runs pdflatex/xelatex (whatever is specified) multiple times
;;             ;; automatically to resolve the cross-references.
;;             ;; (setq org-latex-pdf-process '("latexmk -xelatex -quiet -shell-escape -f %f"))

;;             ;; Below value of `org-latex-pdf-process' with %latex will work in org 9.0+
;;             ;; (setq org-latex-pdf-process
;;             ;;       '("%latex -interaction nonstopmode -shell-escape -output-directory %o %f"
;;             ;;         "%latex -interaction nonstopmode -shell-escape -output-directory %o %f"
;;             ;;         "%latex -interaction nonstopmode -shell-escape -output-directory %o %f"))

;;             ;; Run xelatex multiple times to get the cross-references right
;;             ;; (setq org-latex-pdf-process '("xelatex -shell-escape %f"
;;             ;;                               "xelatex -shell-escape %f"
;;             ;;                               "xelatex -shell-escape %
;;             (setq org-latex-pdf-process "pdflatex -shell-escape %f")

;;             ;; Override `Org-latex-format-headline-default-function' definition
;;             ;; so that the TODO keyword in TODO marked headings is exported in
;;             ;; bold red.
;;             (defun org-latex-format-headline-default-function
;;                 (todo _todo-type priority text tags info)
;;               "Default format function for a headline.
;; See `org-latex-format-headline-function' for details."
;;               (concat
;;                ;; Tue Jan 19 16:00:58 EST 2016 - kmodi
;;                ;; My only change to the original function was to add \\color{red}
;;                (and todo (format "{\\color{red}\\bfseries\\sffamily %s} " todo))
;;                (and priority (format "\\framebox{\\#%c} " priority))
;;                text
;;                (and tags
;;                     (format "\\hfill{}\\textsc{%s}"
;;                             (mapconcat (lambda (tag) (org-latex-plain-text tag info))
;;                                        tags ":")))))))
