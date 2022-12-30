;;; misc.el -*- lexical-binding: t; -*-

(defvar-local elfeed-org-file-path (expand-file-name "elfeed.org" org-directory))

(use-package! eradio
  :custom
  (eradio-player '("mpv" "--no-video" "--no-terminal")))

(map! :leader (:prefix ("r" . "eradio") :desc "Play a radio channel" "p" 'eradio-play))
(map! :leader (:prefix ("r" . "eradio") :desc "Stop the radio player" "s" 'eradio-stop))
(map! :leader (:prefix ("r" . "eradio") :desc "Toggle the radio player" "t" 'eradio-toggle))

(setq eradio-channels '(("def con - soma fm" . "https://somafm.com/defcon256.pls")          ;; electronica with defcon-speaker bumpers
                        ("radio apple" . "http://s2.radioapple.eu:8000/stream/1/")
                        ("bbc - radio 1"   . "http://stream.live.vc.bbcmedia.co.uk/bbc_radio_one")
                        ("bbc - world" . "http://open.live.bbc.co.uk/mediaselector/5/select/mediaset/http-icy-mp3-a/format/pls/proto/http/vpid/bbc_world_service.pls")
                        ("frisky" . "http://stream.friskyradio.com:8000/frisky_aac_hi/")
                        ("frisky - chill" . "http://chill.friskyradio.com/friskychill_mp3_high")
                        ("frisky - deep" . "http://deep.friskyradio.com/friskydeep_aachi")
                        ("caroline"   . "http://sc3.radiocaroline.net:8030/listen.m3u")
                        ("metal - soma fm"   . "https://somafm.com/metal130.pls")           ;; \m/
                        ("cyberia - lainon"  . "https://lainon.life/radio/cyberia.ogg.m3u") ;; cyberpunk-esque electronica
                        ("everything - lainon"  . "https://lainon.life/radio/everything.ogg.m3u") ;; cyberpunk-esque electronica
                        ("cafe - lainon"     . "https://lainon.life/radio/cafe.ogg.m3u")))  ;; boring ambient, but with lain


(map! :leader :desc "Open RSS feed" "e" #'elfeed)

(after! elfeed
  (setq elfeed-search-filter "@1-month-ago +unread"))

(add-hook! 'elfeed-search-mode-hook 'elfeed-update)

;; (use-package! elfeed-org FIXME
;;   :after
;;   (elfeed)
;;   :custom
;;   ;; (rmh-elfeed-org-files '(elfeed-org-file-path))) doesn't work lmao
;;   (rmh-elfeed-org-files '("~/Documents/brain/elfeed.org")))

;; Fix emacsclient -c not having icons in the modeline:
(defun enable-doom-modeline-icons (_frame)
  (setq doom-modeline-icon t))
  
(add-hook 'after-make-frame-functions 
          #'enable-doom-modeline-icons)

;; emacsclient is annoying with all the buffers around
(defun my-kill-buffer-and-frame ()
  "kill the current buffer and the current frame"
  (interactive)
  (when (y-or-n-p "Are you sure you wish to delete the current frame?")
    (kill-buffer)
    (delete-frame)))
(map! :leader :desc "Just close buffer and frame please" "Q" 'my-kill-buffer-and-frame)

;; frames all around me
;; from https://github.com/doomemacs/doomemacs/issues/5876
(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

(defun my/find-file-in-journal ()
  (interactive)
  (doom-project-find-file org-roam-dailies-directory))

(defun my/find-file-in-config ()
  (interactive)
  (doom-project-find-file dotfiles-directory))

(map! :leader :desc "Find file in journal" "f j" 'my/find-file-in-journal
      :leader :desc "Find file in config" "f t" 'org-roam-dailies-goto-today
      :leader :desc "Find file in config" "f c" 'my/find-file-in-config)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))


;; from Tecosaur's config:
;; invisible spaces for niceties in org-mode
(map! :map org-mode-map
      :nie "M-SPC M-SPC" (cmd! (insert "\u200B")))
;; exclude them when exporting
(defun +org-export-remove-zero-width-space (text _backend _info)
  "Remove zero width spaces from TEXT."
  (unless (org-export-derived-backend-p 'org)
    (replace-regexp-in-string "\u200B" "" text)))

(after! ox
  (add-to-list 'org-export-filter-final-output-functions #'+org-export-remove-zero-width-space t))

;; bullets change with depth
(setq org-list-demote-modify-bullet '(
                                      ("+" . "-")
                                      ("-" . "+")
                                      ("*" . "+")
                                      ("1." . "a.")))

;; weird org-mode bug
;; https://github.com/nobiot/org-transclusion/issues/105
(setq warning-suppress-types (append warning-suppress-types '((org-element-cache))))
