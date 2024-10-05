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

(setq doom-font (font-spec :family "NotoMono Nerd Font" :size 18))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'darktooth)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 1)

;; yalinum must be installed
(global-yalinum-mode 't)

(setq standard-indent 2)


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

;; exwm
;; (require 'exwm)
;; (require 'exwm-config)
;; (exwm-config-example)

;; To do priorities
(setq org-lowest-priority 90)

;; Dired auto-revert
(setq dired-auto-revert-buffer 1)

;; Original (doom) org-ascii-bullets
;; ((ascii 42 43 45)
;;  (latin1 167 182)
;;  (utf-8 9674))

;; No numbers when exporting to ascii, html, pdf, etc.
(setq org-export-with-section-numbers nil)
(setq org-export-with-author nil)
(setq org-export-with-toc nil)

;; Todo states
(setq org-todo-keywords '((sequence "TODO" "RLLY" "EXPD" "BLKD" "PROG" "YES" "NO" "|" "DONE")
                          (sequence "[ ]" "[-]" "[?]" "|" "[X]")))
;; Agenda files
(setq org-agenda-files '("~/org" "~/org/daily"))

;; Autosave - org files only
(run-with-idle-timer 3 t #'save-some-buffers t #'(lambda () (eq major-mode 'org-mode)))
(add-hook! 'focus-out-hook (save-some-buffers t #'(lambda () (eq major-mode 'org-mode))))
(add-hook! 'switch-frame (save-some-buffers t #'(lambda () (eq major-mode 'org-mode))))

;; Org table stuff
(map! :leader
      "m b d d"
      'org-table-cut-region)
      ;; For some reason, the leading single quote style is needed for the commend or this gives a wrond number of arguments error.
(map! :leader
      "m b p"
      (cmd! (org-table-paste-rectangle)))
(map! :leader
      "m b y"
      'org-table-copy-region)


(setq org-startup-folded 'show2levels)

(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon nil)
(setq doom-modeline-check-icon t)
(after! doom-modeline
  (doom-modeline-def-modeline 'main
    '(bar matches buffer-info remote-host buffer-position selection-info)
    '(bar misc-info minor-modes input-method buffer-encoding check major-mode process vcs battery "      "))) ; <-- added padding hereA

;; Assembly stuff
(use-package x86-lookup
  :ensure t
  :config
  (setq  x86-lookup-pdf "~/org/pdf/64-iA32-Instruction-set-reference-vol2.pdf")
  )
(use-package nasm-mode
  :ensure t
  :config
  (add-hook 'asm-mode-hook 'nasm-mode)
  )

;; Visidata

;; Babel
(with-eval-after-load 'org
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t))))

;; ejc-sql
(require 'ejc-sql)
(setq ejc-result-table-impl 'orgtbl-mode)
;; (setq ejc-org-mode-show-results nil)
(ejc-create-connection
 "snowflake"
 :classpath "/home/daniel/.m2/repository/com/snowflake/jdbc/snowflake-jdbc-3.19.0.jar"
 :connection-uri (concat "jdbc:snowflake://oojagrk-dev_lab_1.snowflakecomputing.com:443"
                         "?user=admin"
                         "&password=2501Cthia~"
                         "&warehouse=airbyte_compute_wh"
                         "&role=accountadmin"
                         "&db=snowflake"
                         "&authenticator=snowflake"
                         "&JDBC_QUERY_RESULT_FORMAT=JSON"))
