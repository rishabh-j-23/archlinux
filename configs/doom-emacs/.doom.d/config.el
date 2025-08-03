;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 14))

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! lsp-mode
  (setq lsp-gopls-server-path "~/.local/share/nvim/mason/bin/gopls"))

(after! lsp-java
  (setq lsp-java-java-path "/usr/bin/java") ;; or wherever your Java is
  (setq lsp-java-server-install-dir "~/.local/share/nvim/mason/packages/jdtls/")
  (require 'dap-java)
  (setq dap-auto-configure-mode t))

;; Optional: DAP keybindings for Java
(map! :after dap-mode
      ;; F5: Continue/Start Debugging
      "<f5>" #'dap-continue
      ;; F9: Toggle Breakpoint
      "<f9>" #'dap-breakpoint-toggle
      ;; F10: Step Over
      "<f10>" #'dap-next
      ;; F11: Step Into
      "<f11>" #'dap-step-in
      ;; Shift+F11: Step Out
      "S-<f11>" #'dap-step-out
      ;; F8: Debug (start new session)
      "<f8>" #'dap-debug
      ;; F12: Open DAP UI REPL
      "<f12>" #'dap-ui-repl
      ;; SPC d r: Run dap-debug (launch.json)
      :leader
      :desc "DAP Run launch.json" "d r" (lambda () (interactive) (dap-debug)))

;; --- Window/Buffer/Tab Management ---
(map! :n "<leader>qq" #'kill-this-buffer)
(map! :n "<leader>qq" #'save-buffers-kill-terminal)
(map! :n "<leader>bb" #'mode-line-other-buffer)
(map! :n "<leader>`" #'mode-line-other-buffer)
(map! :n "<leader>bD" #'kill-buffer-and-window)
(map! :n "<S-h>" #'previous-buffer)
(map! :n "<S-l>" #'next-buffer)
(map! :n "[b" #'previous-buffer)
(map! :n "]b" #'next-buffer)

;; --- File Operations ---
(map! :n "<leader>x" #'eval-buffer)
(map! :n "<leader>fn" #'evil-buffer-new)
(map! :n "<C-s>" #'save-buffer)
(map! :i "<C-s>" #'save-buffer)
(map! :v "<C-s>" #'save-buffer)

;; --- Window Navigation ---
(map! :n "C-h" #'evil-window-left)
(map! :n "C-j" #'evil-window-down)
(map! :n "C-k" #'evil-window-up)
(map! :n "C-l" #'evil-window-right)
(map! :n "<leader>-" #'evil-window-split)
(map! :n "<leader>|" #'evil-window-vsplit)
(map! :n "<leader>wd" #'evil-window-delete)

;; --- Window Resizing ---
(map! :n "C-<up>"    #'evil-window-increase-height)
(map! :n "C-<down>"  #'evil-window-decrease-height)
(map! :n "C-<left>"  #'evil-window-decrease-width)
(map! :n "C-<right>" #'evil-window-increase-width)

;; --- Tab Management ---
(map! :n "<leader><tab>l" #'tab-last)
(map! :n "<leader><tab>o" #'tab-close-other)
(map! :n "<leader><tab>f" #'tab-first)
(map! :n "<leader><tab><tab>" #'tab-new)
(map! :n "<leader><tab>]" #'tab-next)
(map! :n "<leader><tab>d" #'tab-close)
(map! :n "<leader><tab>[" #'tab-previous)

;; --- Move Lines ---
(map! :n "M-j" #'drag-stuff-down)
(map! :n "M-k" #'drag-stuff-up)
(map! :i "M-j" #'drag-stuff-down)
(map! :i "M-k" #'drag-stuff-up)
(map! :v "M-j" #'drag-stuff-down)
(map! :v "M-k" #'drag-stuff-up)

;; --- Indenting in Visual Mode ---
(map! :v "<" #'evil-shift-left)
(map! :v ">" #'evil-shift-right)

;; --- Yank/Delete Whole File ---
(map! :n "yag" (lambda () (interactive) (evil-yank (point-min) (point-max))))
(map! :n "dag" (lambda () (interactive) (evil-delete (point-min) (point-max))))

;; --- Diagnostics (LSP) ---
(map! :n "<leader>xx" #'lsp-treemacs-errors-list)
(map! :n "<leader>cd" #'lsp-ui-doc-glance)
(map! :n "]d" #'flycheck-next-error)
(map! :n "[d" #'flycheck-previous-error)
(map! :n "grn" #'lsp-rename)
(map! :n "grr" #'lsp-find-references)

;; --- Search/Highlight ---
(map! :n "<esc>" #'evil-ex-nohighlight)
(map! :i "<esc>" #'evil-ex-nohighlight)
(map! :n "<leader>ur" (lambda () (interactive) (progn (evil-ex-nohighlight) (redraw-display))))
(map! :n "n" #'evil-search-next)
(map! :n "N" #'evil-search-previous)

;; --- Centering on Movement ---
(map! :n "j" (lambda () (interactive) (evil-next-line) (recenter)))
(map! :n "k" (lambda () (interactive) (evil-previous-line) (recenter)))
(map! :n "C-d" (lambda () (interactive) (evil-scroll-down nil) (recenter)))
(map! :n "C-u" (lambda () (interactive) (evil-scroll-up nil) (recenter)))

;; --- Disable Arrow Keys in Normal Mode ---
(map! :n "<left>" #'ignore)
(map! :n "<right>" #'ignore)
(map! :n "<up>" #'ignore)
(map! :n "<down>" #'ignore)

;; --- Commenting (requires evil-nerd-commenter or similar) ---
(map! :n "gco" #'evilnc-comment-or-uncomment-lines)
(map! :n "gcO" (lambda () (interactive) (evil-previous-line) (evilnc-comment-or-uncomment-lines)))

;; --- Undo Tree ---
(map! :n "<leader>ut" #'undo-tree-visualize)

;; --- Oil (file explorer) ---
;; (map! :n "-" #'oil) ; If you have an Oil equivalent in Emacs

;; --- Misc ---
(map! :n "<leader>K" #'man-follow)
(map! :n "<leader>l" #'list-packages)
(map! :n "<leader>xq" #'quickfix)
(map! :n "<leader>xl" #'locate-list)
(map! :n "<leader>ui" #'what-cursor-position)
(map! :n "<leader>uI" #'lsp-treemacs-symbols)
(map! :n "<leader>ur" (lambda () (interactive) (evil-ex-nohighlight) (redraw-display)))
(map! :n "<leader>wd" #'evil-window-delete)
(map! :n "<leader>- " #'evil-window-split)
(map! :n "<leader>|" #'evil-window-vsplit)

;; --- Save file in all modes ---
(map! :i "C-s" #'save-buffer)
(map! :n "C-s" #'save-buffer)
(map! :v "C-s" #'save-buffer)

;; --- Terminal mappings ---
;; (map! :t "C-/" #'kill-this-buffer) ; If you use vterm or eat

