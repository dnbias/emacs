;;; evil.el -*- lexical-binding: t; -*-

(global-set-key (kbd "C-x C-h") help-map)
(global-set-key (kbd "C-h") 'previous-line)
(map! :leader "," #'+workspace/switch-left)
(map! :leader "." #'+workspace/swap-right)
(map! :leader ";" #'comment-line)
(map! :leader "<escape>" #'next-window-any-frame)

(map! :after evil
      :map evil-visual-state-map
      "h"       #'evil-backward-char
      "t"       #'evil-next-line
      "n"       #'evil-previous-line
      "s"       #'evil-forward-char
      "u"       #'evil-end-of-line
      "a"       #'evil-first-non-blank
      )
(map! :after evil
      :map evil-motion-state-map
      "h"       #'evil-backward-char
      "t"       #'evil-next-line
      "n"       #'evil-previous-line
      "s"       #'evil-forward-char
      "c"       #'evil-find-char-to
      "C"       #'evil-find-char-to-backward
      )
(map! :after evil
      :map evil-normal-state-map
      "h"       #'evil-backward-char
      "t"       #'evil-next-line
      "n"       #'evil-previous-line
      "s"       #'evil-forward-char
      "k"       #'kill-line
      "K"       #'(lambda () (interactive)
                    "kill from point to the beginning of the line"
                    (kill-line 0))
      )

(defun +doom-dashboard-setup-modified-keymap ()
  (setq +doom-dashboard-mode-map (make-sparse-keymap))
  (map! :map +doom-dashboard-mode-map
        :desc "Find file" "f" #'find-file
        :desc "Recent files" "r" #'consult-recent-file
        :desc "Config dir" "C" #'doom/open-private-config
        :desc "Open config.org" "c" (cmd! (find-file (expand-file-name "config.el" doom-user-dir)))
        :desc "Open dotfile" "." (cmd! (doom-project-find-file "~/.config/"))
        :desc "Notes (roam)" "n" #'org-roam-node-find
        :desc "Switch buffer" "b" #'+vertico/switch-workspace-buffer
        :desc "Switch buffers (all)" "B" #'consult-buffer
        :desc "IBuffer" "i" #'ibuffer
        :desc "Previous buffer" "p" #'previous-buffer
        :desc "Set theme" "t" #'consult-theme
        :desc "Quit" "Q" #'save-buffers-kill-terminal
        :desc "Show keybindings" "h" (cmd! (which-key-show-keymap '+doom-dashboard-mode-map))))

(map! :leader :desc "Dashboard" "d" #'+doom-dashboard/open)
(add-transient-hook! #'+doom-dashboard-mode (+doom-dashboard-setup-modified-keymap))
                                        ;(add-transient-hook! #'+doom-dashboard-mode :append (+doom-dashboard-setup-modified-keymap))
