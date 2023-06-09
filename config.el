;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Daniel Benedict"
      user-mail-address "daniel2501@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'G
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-ir-black)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;

;; Window and buffer switching. Esp useful in exwm.
(map! "s-h"
      (cmd! (windmove-left)))
(map! "s-l"
      (cmd! (windmove-right)))

(map! "s-<left>"
      (cmd! (previous-buffer)))
(map! "s-<right>"
      (cmd! (next-buffer)))

;; Battery level - needs acpi.
(display-battery-mode 1)

;; Zsh
(setq vterm-shell "zsh")

(setq org-roam-directory "~/org")
;; Let deft search files under root org directory.
;; We could use the org-directory variable instead of duplicating values
(setq deft-directory "~/org"
   deft-recursive t
   ;; I don't like any summary, hence catch-all regexp. need to see if
   ;; an option to hide summary is there instead of this one.
   deft-strip-summary-regexp ".*$"
)

(setq window-divider-default-right-width  9
      window-divider-default-bottom-width 9)
(window-divider-mode)

(map! :leader
      "d <left>"
      (cmd! (windmove-delete-left)))
(map! :leader
      "d <right>"
      (cmd! (windmove-delete-right)))
(map! :leader
      "d <up>"
      (cmd! (windmove-delete-up)))
(map! :leader
      "d <down>"
      (cmd! (windmove-delete-down)))

;; Save all org buffers
(map! :leader
      "f a"
      (cmd! (org-save-all-org-buffers)))

;; Save all buffers
(map! :leader
      "f A"
      (cmd! (save-some-buffers)))


;; Roam
(map! :leader
      "r f"
      (cmd! (org-roam-node-find)))
(map! :leader
      "r r"
      (cmd! (org-roam-buffer-toggle)))
(map! :leader
      "r i"
      (cmd! (org-roam-node-insert)))
(map! :leader
      "r b"
      (cmd! (org-roam-buffer-list)))


;; Ibuffer side bar

;; (use-package ibuffer-sidebar
;;   :load-path "~/.emacs.d/fork/ibuffer-sidebar"
;;   :ensure nil
;;   :commands (ibuffer-sidebar-toggle-sidebar)
;;   :config
;;   (setq ibuffer-sidebar-use-custom-font nil)
;;   (setq ibuffer-sidebar-face `(:family "Helvetica" :height 140 :side right)))
;;   (setq ibuffer-sidebar-display-alist `((side . right) (slot . 1)))
;;   (setq ibuffer-sidebar-width 28)

;; ;; Ibuffer side window key binding
;; (map! :leader
;;       "b I"
;;       (cmd! (ibuffer-sidebar-toggle-sidebar)))

(defun org+-buffer-name-to-title ()
  "Rename buffer to value of #+TITLE:."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward "^[[:space:]]*#\\+TITLE:[[:space:]]*\\(.*?\\)[[:space:]]*$" nil t)
      (rename-buffer (match-string 1)))))

(add-hook 'org-mode-hook #'org+-buffer-name-to-title)


;; Buffer navigation
(map! :leader
      "]"
      (cmd! (previous-buffer)))

(map! :leader
      "["
      (cmd! (next-buffer)))

(setq org-roam-buffer-width 0.13)
