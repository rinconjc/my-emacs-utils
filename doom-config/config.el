;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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
(setq doom-font (font-spec :family "Fira Code" :size 15 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 15)
      doom-big-font (font-spec :family "Fira Code" :size 20 :weight 'bold))
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

;; multiedit bindings
;; (evil-multiedit-default-keybinds)
;; (define-key evil-normal-state-map (kbd "] e") 'flycheck-next-error)

(map! :desc "next flycheck error" :n "] q" #'flycheck-next-error
      :desc "prev flycheck error" :n "[ q" #'flycheck-previous-error
      :desc "jump to word" :n "SPC j w" #'avy-goto-word-1
      :desc "show/copy full error message" :n "SPC e y" #'flycheck-copy-errors-as-kill)

(after! cider
  (setq cider-enrich-classpath t)
  (setq +clojure-load-clj-refactor-with-lsp t))

(after! plantuml-mode
  (setq plantuml-default-exec-mode `jar))

;; A Spacemacs like Lisp state menu (without the transient state)

(map! :leader
      (:prefix ("k". "Smartparens")
       :desc "Slurp forward" "s" #'sp-forward-slurp-sexp
       :desc "Slurp backward" "S" #'sp-backward-slurp-sexp
       :desc "" "$"   #'sp-end-of-sexp
       (:prefix ("`" . "Hybrid"))
       :desc "Kill" "k" #'sp-kill-hybrid-sexp
       :desc "Push" "p" #'sp-push-hybrid-sexp
       :desc "Slurp" "s" #'sp-slurp-hybrid-sexp
       :desc "Transpose" "t" #'sp-transpose-hybrid-sexp
       :desc "Absorb" "a" #'sp-absorb-sexp
       :desc "Barf forward" "b" #'sp-forward-barf-sexp
       :desc "Barf backward" "B" #'sp-backward-barf-sexp
       :desc "Convoluted" "c" #'sp-convolute-sexp
       (:prefix ("d" . "Delete")
        :desc "Symbol" "s" #'sp-kill-symbol
        :desc "Symbol Backward" "S" #'sp-backward-kill-symbol
        :desc "Word" "w" #'sp-kill-word
        :desc "Word Backward" "W" #'sp-backward-kill-word
        :desc "Kill" "x" #'sp-kill-sexp
        :desc "Kill Backward" "X" #'sp-backward-kill-sexp)
       :desc "Splice" "e" #'sp-splice-sexp-killing-forward
       :desc "Splice Backward" "E" #'sp-splice-sexp-killing-backward
       :desc "Symbol Backward" "h" #'sp-backward-symbol
       :desc "Sexp Backward" "H" #'sp-backward-sexp
       :desc "Join" "j" #'sp-join-sexp
       :desc "Sexp Forward" "l" #'sp-forward-sexp
       :desc "Sexp Forward" "L" #'sp-forward-sexp
       :desc "Raise" "r" #'sp-raise-sexp
       :desc "Slurp" "s" #'sp-forward-slurp-sexp
       :desc "Slurp Backward" "S" #'sp-backward-slurp-sexp
       :desc "Transpose" "t" #'sp-transpose-sexp
       :desc "Up Backward" "U" #'sp-backward-up-sexp
       (:prefix ("w" . "Wrap")
        :desc "()" "(" #'sp-wrap-round
        :desc "{}" "{" #'sp-wrap-curly
        :desc "[]" "[" #'sp-wrap-square
        :desc "Round" "w" #'sp-wrap-round
        :desc "Curly" "c" #'sp-wrap-curly
        :desc "Square" "s" #'sp-wrap-square
        :desc "Unwrap" "u" #'sp-unwrap-sexp)
       :desc "Copy sexp" "y" #'sp-copy-sexp))

;; (load! (concat default-directory "../my-utils.el"))
