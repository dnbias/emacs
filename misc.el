;;; misc.el -*- lexical-binding: t; -*-

(use-package! eradio
  :ensure t
  :custom
  (eradio-player '("mpv" "--no-video" "--no-terminal")))

(map! :leader (:prefix ("r" . "eradio") :desc "Play a radio channel" "p" 'eradio-play))
(map! :leader (:prefix ("r" . "eradio") :desc "Stop the radio player" "s" 'eradio-stop))
(map! :leader (:prefix ("r" . "eradio") :desc "Toggle the radio player" "t" 'eradio-toggle))

(setq eradio-channels '(("def con - soma fm" . "https://somafm.com/defcon256.pls")          ;; electronica with defcon-speaker bumpers
                        ("metal - soma fm"   . "https://somafm.com/metal130.pls")           ;; \m/
                        ("cyberia - lainon"  . "https://lainon.life/radio/cyberia.ogg.m3u") ;; cyberpunk-esque electronica
                        ("cafe - lainon"     . "https://lainon.life/radio/cafe.ogg.m3u")))  ;; boring ambient, but with lain
