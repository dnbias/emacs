;;; theme.el -*- lexical-binding: t; -*-
(setq doom-theme 'doom-wilmersdorf)
(setq display-line-numbers-type t)
(setq which-key-idle-delay 0.5)
;;(setq-default cursor-type '(hbar . 1))
(add-to-list 'default-frame-alist '(alpha . (85 . 50)))

(defun custom-modeline-mode-icon ()
  (format " %s"
    (propertize icon
                'help-echo (format "Major-mode: `%s`" major-mode)
                'face `(:height 1.0 :family ,(all-the-icons-icon-family-for-buffer)))))

(setq doom-modeline-icon (display-graphic-p))
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon t)
(setq doom-modeline-buffer-encoding nil)
(setq doom-modeline-height 15)
(custom-set-faces
  '(mode-line ((t (:family "SF Display" :height 1.0))))
  '(mode-line-inactive ((t (:family "SF Display" :height 1.0)))))


(setq doom-font (font-spec :family "agave" :size 15)
      doom-big-font (font-spec :family "agave" :size 20)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 15)
      ;;doom-unicode-font (font-spec :family "JuliaMono")
      ;;doom-serif-font (font-spec :family "IBM Plex Mono" :weight 'light)
      )


(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook cursor-type (list nil))

(load! "fancy-splash")

;; change mode-line color by evil state
(lexical-let ((default-color (cons (face-background 'mode-line)
                                   (face-foreground 'mode-line))))
  (add-hook 'post-command-hook
            (lambda ()
              (let ((color (cond ((minibufferp) default-color)
                                 ((evil-insert-state-p) '("#e80000" . "#ffffff"))
                                 ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
                                 (t default-color))))
                (set-face-background 'mode-line (car color))
                (set-face-foreground 'mode-line (cdr color))))))
