;;; development.el -*- lexical-binding: t; -*-

(defvar-local dotfiles-directory "/home/dnbias/.config/")
(global-subword-mode 1)                           ; Iterate through CamelCase words
(setq display-line-numbers-type 'relative)
(use-package vterm
  :bind
  ("C-c `" . vterm))

(map! "C-c C-c z" #'+zen/toggle)

(use-package company
  :hook
  ('after-init-hook . global-company-mode)
  (rust-mode . company-mode)
  :custom
  (add-to-list 'company-backends 'company-dabbrev-code)
  (add-to-list 'company-backends 'company-capf)
  (add-to-list 'company-backends 'company-files)
  (global-set-key (kbd "<tab>") #'company-indent-or-complete-common)
  (company-idle-delay 0.2) ;; how long to wait until popup
  (company-minimum-prefix-length 2)
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
	      ("C-n". company-select-next)
	      ("C-p". company-select-previous)
	      ("M-<". company-select-first)
	      ("M->". company-select-last)))

(use-package yasnippet
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

(use-package lsp-mode
  :commands lsp
  :bind (:map lsp-mode-map
         ("C-c C-c r" . lsp-rename)
         ("C-c C-c d" . lsp-find-definition)
         ("C-c C-c r" . lsp-find-references)
         ("C-c C-c l" . flycheck-list-errors)
         ("C-c C-c a" . lsp-execute-code-action)
         ("C-c C-c q" . lsp-workspace-restart)
         ("C-c C-c Q" . lsp-workspace-shutdown))
  :hook
  (prog-mode . 'lsp-deferred)
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-warn-no-matched-clients nil) ;; no chit-chat
  (lsp-auto-guess-root nil)
  (lsp-rust-analyzer-cargo-watch-command "check")
  (lsp-eldoc-render-all nil)
  (lsp-idle-delay 0.6)
  ;; enable / disable the hints as you prefer:
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :commands lsp-ui-mode
  :custom
  (lsp-ui-sideline-delay 0.2)
  (lsp-ui-doc-enable nil)
  (lsp-ui-doc-use-childframe nil)
  (lsp-ui-peek-always-show nil)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-symbol t)
  (lsp-eldoc-hook nil))

(use-package dap-mode
  :config
  (dap-ui-mode)
  (dap-ui-controls-mode 1)
  (require 'dap-cpptools)
  (require 'dap-lldb)
  (require 'dap-gdb-lldb)
  ;; installs .extension/vscode
  (dap-gdb-lldb-setup)
  (dap-register-debug-template
   "Rust::LLDB Run Configuration"
   (list :type "lldb"
         :request "launch"
         :name "LLDB::Run"
	 :gdbpath "rust-lldb"
         :target nil
         :cwd nil))
  (dap-register-debug-template
   "Rust::GDB Run Configuration"
   (list :type "gdb"
         :request "launch"
         :name "GDB::Run"
	 :gdbpath "rust-gdb"
         :target nil
         :cwd nil)))

(use-package dap-ui
        :config
        (dap-ui-mode 1))

(use-package rustic
  :bind (:map rustic-mode-map
          ("C-c C-c r" . lsp-rename)
          ("C-c C-c d" . lsp-find-definitions)
          ("C-c C-c r" . lsp-find-references)
          ("C-c C-c l" . flycheck-list-errors)
          ("C-c C-c a" . lsp-execute-code-action)
          ("C-c C-c q" . lsp-workspace-restart)
          ("C-c C-c Q" . lsp-workspace-shutdown)
          ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  (setq lsp-enable-symbol-highlighting t)
  (setq lsp-signature-auto-activate t)
  (setq rustic-format-on-save nil))

;; (use-package lsp-python-ms
;;   :ensure t
;;   :init (setq lsp-python-ms-auto-install-server t)
;;   :hook (python-mode . (lambda ()
;;                           (require 'lsp-python-ms)
;;                           (lsp-deferred)))
;;   :init
;;   (setq lsp-python-ms-executable (executable-find "python-language-server")))

(use-package! rainbow-mode)

(setq +zen-text-scale 1.1)

(use-package! sublimity
  :hook
  (text-mode . sublimity-mode)
  :config
  (require 'sublimity-scroll)
  :custom
  (sublimity-scroll-hide-cursor nil)
  (sublimity-scroll-weight 8)
  (sublimity-scroll-drift-length 1)
  (sublimity-scroll-vertical-frame-delay 0.006))
