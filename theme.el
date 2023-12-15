;;; theme.el -*- lexical-binding: t; -*-
(setq which-key-idle-delay 0.3)

(set-frame-parameter (selected-frame) 'alpha-background 95)
(add-to-list 'default-frame-alist '(alpha-background . 95))
(add-to-list 'default-frame-alist '(alpha . 95))

(setq doom-theme 'rougee)
;; (custom-set-faces!
;;   ;; `(doom-color 'bg "#111116")
;;   ;; `(default :background "#111116")
;;   `(orderless-match-face-0 :foreground ,(doom-color 'red))
;;   `(orderless-match-face-1 :foreground ,(doom-color 'red))
;;   `(orderless-match-face-2 :foreground ,(doom-color 'red))
;;   `(orderless-match-face-3 :foreground ,(doom-color 'red))
;;   `(minibuffer-prompt
;;     :foreground ,(doom-color 'fg)
;;     :background ,(face-background 'default))
;;   `(doom-modeline :background ,(face-background 'default))
;;   `(org-code :background  "#111116")
;;   `(org-block :background  "#111116")
;;   `(font-latex-math-face :background  "#111116")
;;   `(vertico-current
;;     :background  "#111116"
;;     :foreground ,(doom-color 'red)))

;; (after! org-mode
;;   (custom-set-faces!
;;     `(fringe :background ,(face-background 'default))
;;     `(org-block-begin-line :background ,(face-background 'default))))

;; (defun my/set-backgrounds ()
;;   (set-face-background 'default "#111116")
;;   (set-face-background 'minibuffer-prompt (face-attribute 'default :background))
;;   (set-face-background 'fringe (face-attribute 'default :background))
;;   (set-face-background 'org-block-begin-line (face-attribute 'default :background)))

;; (setq evil-normal-state-cursor '("#819cd6" hollow))

;; (defun load-doom-wilmersdorf-theme (frame)
;;   (select-frame frame)
;;   (load-theme 'doom-wilmersdorf t))

;; (if (daemonp)
;;     (add-hook 'after-make-frame-functions #'load-doom-wilmersdorf-theme)
;;   (load-theme 'doom-wilmersdorf t))

(defun custom-modeline-mode-icon ()
  (format " %s"
    (propertize icon
                'help-echo (format "Major-mode: `%s`" major-mode)
                'face `(:height 1.0 :family ,(all-the-icons-icon-family-for-buffer)))))

(setq doom-modeline-icon (display-graphic-p))(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon t)
(setq doom-modeline-buffer-encoding nil)
(setq doom-modeline-height 15)


(setq doom-font (font-spec :family "Iosevka Comfy" :size 17 :height 0.9)
      doom-big-font (font-spec :family "Iosevka Comfy" :size 25)
      doom-symbol-font (font-spec :family "Fira Code")
      doom-variable-pitch-font (font-spec :family "Quattrocento" :size 17)
      ;; doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :size 17)
      ;; doom-variable-pitch-font (font-spec :family "SF Pro Display" :size 16)
      ;; doom-variable-pitch-font (font-spec :family "Bitter" :size 17)
      ;; doom-variable-pitch-font (font-spec :family "iA Writer Duospace" :size 16)
      ;; doom-variable-pitch-font (font-spec :family "iM Writing Duospace" :size 16)
      ;; doom-variable-pitch-font (font-spec :family "Fira Sans" :weight 'light  :size 16)
      ;; doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 16)
      ;; doom-variable-pitch-font (font-spec :family "SF Pro" :weight 'regular  :size 17)
      ;; doom-variable-pitch-font (font-spec :family "Roboto" :weight 'regular  :size 17)
      ;; doom-variable-pitch-font (font-spec :family "Noto Sans" :weight 'light  :size 18)
      ;;doom-serif-font (font-spec :family "IBM Plex Mono" :weight 'light)
      )

(custom-set-faces!
  '(org-document-title :font "Philosopher" :size 15 :height 2.0 :weight bold)
  '(org-level-1 :font "Adobe Garamond Pro" :height 1.75 :size 20 :weight bold)
  '(org-level-2 :font "Adobe Garamond Pro" :height 1.50 :weight bold)
  '(org-level-3 :font "Adobe Garamond Pro" :height 1.25 :weight bold)
  '(org-level-4 :font "Adobe Garamond Pro" :height 1.00 :weight bold)
  '(org-level-5 :font "Adobe Garamond Pro" :height 1.00 :weight bold)
  '(org-level-6 :font "Adobe Garamond Pro" :height 1.00 :weight bold)
  '(org-code :font "iA Writer Duospace")
  '(org-quote :font "Adobe Garamond Pro" :slant normal :height 1.10 :size 20))

;; (custom-set-faces
;;   '(mode-line ((t (:family "SF Pro Display" :height 1.0))))
;;   '(mode-line-inactive ((t (:family "SF Pro Display" :height 1.0)))))

(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook cursor-type (list nil))

;; (load! "fancy-splash")
(load! "fancy-phrases")
(setq fancy-splash-image "~/.config/doom/misc/splash-images/emacs-e-smallerer.webp")

;; ;; change mode-line color by evil state
;; (lexical-let ((default-color (cons (face-background 'mode-line)
;;                                    (face-foreground 'mode-line))))
;;   (add-hook 'post-command-hook
;;             (lambda ()
;;               (let ((color (cond ((minibufferp) default-color)
;;                                  ((evil-insert-state-p) '("#e80000" . "#ffffff"))
;;                                  ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
;;                                  (t default-color))))
;;                 (set-face-background 'mode-line (car color))
;;                 (set-face-foreground 'mode-line (cdr color))))))

(add-hook 'lisp-mode-hook 'my-buffer-face-mode-variable)
;(add-hook 'after-make-frame-functions
;          #'(lambda(_frame)
;            (modify-all-frames-parameters
;             '((right-divider-width . 5)
;               (internal-border-width . 0)))
;            (dolist (face '(window-divider
;                            window-divider-first-pixel
;                            window-divider-last-pixel))
;              (face-spec-reset-face face)
;              (set-face-foreground face (face-attribute 'default :background)))))


;; (with-eval-after-load 'org-faces (my/set-backgrounds))


(use-package! mixed-pitch
  :after org
  :hook
  (text-mode . mixed-pitch-mode)
  (org-roam-mode . mixed-pitch-mode)
  :custom
  (mixed-pitch-set-height t)
  (set-face-attribute 'variable-pitch
                      nil
                      :size 20)
  :config
  (pushnew! mixed-pitch-fixed-pitch-faces
            'org-date
            'org-special-keyword
            'org-property-value
            'org-drawer
            'org-ref-cite-face
            'org-tag
            'org-todo-keyword-todo
            'org-todo-keyword-habt
            'org-todo-keyword-done
            'org-todo-keyword-wait
            'org-todo-keyword-kill
            'org-todo-keyword-outd
            'org-todo
            'org-done
            'org-code
            'font-lock-comment-face
            'line-number
            'line-number-current-line))

(use-package! perfect-margin
  ;; :hook
  ;; (prog-mode . perfect-margin-mode)
  :custom
  ;; enable perfect-mode
  ;; (perfect-margin-mode 1)
  (perfect-margin-visible-width 140)
  (perfect-margin-hide-fringes nil)
  (fringes-outside-margins nil)
  ;; (perfect-margin-ignore-filters nil)
  ;; (perfect-margin-ignore-regexps nil)
  :config
  (dolist (margin '("<left-margin> " "<right-margin> "))
  (global-set-key (kbd (concat margin "<mouse-1>")) 'ignore)
  (global-set-key (kbd (concat margin "<mouse-3>")) 'ignore)
  (dolist (multiple '("" "double-" "triple-"))
      (global-set-key (kbd (concat margin "<" multiple "wheel-up>")) 'mwheel-scroll)
      (global-set-key (kbd (concat margin "<" multiple "wheel-down>")) 'mwheel-scroll))))

(setq-default fringes-outside-margins nil)
;; (after! git-gutter-fringe
;;   (when +vc-gutter-default-style ;; undefined
;;     (setq-default fringes-outside-margins nil)))

(use-package! olivetti-mode
  :hook
  (org-mode . olivetti-mode)
  (elfeed-show-entry . org-mode)
  :custom
  (olivetti-body-width 60)
  :config
  (olivetti-set-width 60)
  (set-fringe-style 8))
  ;; (git-gutter-mode -1))

;; (setq git-gutter:visual-line t)
;;        git-gutter:added-sign "|"
;;        git-gutter:added-sign "|")

(use-package! info-colors
  :commands (info-colors-fontify-node))

(add-hook 'Info-selection-hook 'info-colors-fontify-node)

;; (use-package! pulsar
;;   :custom
;;   (pulsar-pulse t)
;;   (pulsar-delay 0.055)
;;   (pulsar-iterations 9)
;;   (pulsar-face 'pulsar-blue)
;;   (pulsar-highlight-face 'pulsar-yellow)
;;   (pulsar-global-mode 1))

;; ;; integration with the `consult' package:
;; (add-hook 'consult-after-jump-hook #'pulsar-recenter-top)
;; (add-hook 'consult-after-jump-hook #'pulsar-reveal-entry)

;; never lose your cursor again
(beacon-mode 1)
(add-hook! 'beacon-mode 'recenter)

(spacious-padding-mode 1)
