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
;; (setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-acario-dark)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")


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
;;
;;

;; avy for leap like action
;; and surrond too in general


;; Info
(setq user-full-name "Alexandru Cara"
      user-mail-address "alexandru.cara.2@gmail.com")

;; kill emacs without confiming
(setq confirm-kill-emacs nil)

;; Just transparency for background
(add-to-list 'default-frame-alist '(alpha-background . 75)) ; For all new frames henceforth make transparent

;; By default turn off line highlight
(setq global-hl-line-modes nil)

;; This shows if text goes over 80 lines
(setq display-fill-column-indicator-column 80)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)











;; This is going to affect garbage collection and might make this faster
(use-package! gcmh
  :init
  (setq gcmh-idle-delay 5
        gcmh-high-cons-threshold (* 256 1024 1024))  ; 256MB during idle
  :config
  (gcmh-mode 1))

(setq gc-cons-threshold 200000000) ; previous 33554432



;; Zen and more stuff
(if (string-match-p "RSVG" system-configuration-features)
  (setq org-latex-preview-default-process 'dvisvgm)
  (setq org-latex-preview-default-process 'dvipng))

(add-hook! 'org-mode-hook #'mixed-pitch-mode)

(after! mixed-pitch
  (setq mixed-pitch-set-height t
        variable-pitch-serif-font doom-variable-pitch-font)

  (pushnew! mixed-pitch-fixed-pitch-faces
            'warning
            'org-drawer 'org-cite-key 'org-list-dt 'org-hide
            'corfu-default 'font-latex-math-face)

  (set-face-attribute 'variable-pitch nil :height 1.2))

(defadvice! +org-indent--reduced-text-prefixes ()
  :after #'org-indent--compute-prefixes
  (setq org-indent--text-line-prefixes
        (make-vector org-indent--deepest-level nil))
  (when (> org-indent-indentation-per-level 0)
    (dotimes (n org-indent--deepest-level)
      (aset org-indent--text-line-prefixes
            n
            (org-add-props
                (concat (make-string (* n (1- org-indent-indentation-per-level))
                                     ?\s)
                        (if (> n 0)
                             (char-to-string org-indent-boundary-char)
                          "\u200b"))
                nil 'face 'org-indent)))))


;; Org latex, taken and might need commented out line??
(setq
      org-use-property-inheritance t ; fix weird issue with src blocks
      org-startup-with-inline-images t
      org-edit-src-content-indentation 0
      org-startup-with-latex-preview t
      org-highlight-latex-and-related '(native script))

(after! org
  (custom-set-faces!
    '(org-link :weight normal :underline nil) ; disable bold and underlined links
    '(org-block-begin-line :inherit default :background nil)))


(after! org
  (custom-set-faces!
    `((org-document-title)
      :foreground ,(face-attribute 'org-document-title :foreground)
      :height 1.3 :weight bold)
    `((org-level-1)
      :foreground ,(face-attribute 'outline-1 :foreground)
      :height 1.1 :weight medium)
    `((org-level-2)
      :foreground ,(face-attribute 'outline-2 :foreground)
      :weight medium)
    `((org-level-3)
      :foreground ,(face-attribute 'outline-3 :foreground)
      :weight medium)
    `((org-level-4)
      :foreground ,(face-attribute 'outline-4 :foreground)
      :weight medium)
    `((org-level-5)
      :foreground ,(face-attribute 'outline-5 :foreground)
      :weight medium)))

(add-hook 'org-src-mode-hook
          (lambda ()
            (when (string= major-mode "latex-mode")
              (evil-tex-mode 1))))

(after! org
  (dolist (pkg '("amsmath" "amssymb" "mathtools" "mathrsfs" "tikz" "pgfplots"))
    (add-to-list 'org-latex-packages-alist `("" ,pkg t))))



(use-package! org-latex-preview
  :after org
  :config
  (plist-put org-latex-preview-appearance-options
             :page-width 0.8)
  (add-hook 'org-mode-hook 'org-latex-preview-auto-mode)
  (setq org-latex-preview-live-preview-fragments t
        org-latex-preview-auto-generate 'live
        org-latex-preview-debounce 0.5
        org-latex-preview-throttle 0.2
org-latex-preview-appearance-options
      '(:foreground default ;; This does not seem to work
        :background "Transparent" ;; This does not seem to work
        :scale 2.0
        :html-foreground "Black"
        :html-background "Transparent"
        :html-scale 1.0
        :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")) ;; This might be the issue?
        org-latex-preview-numbered t
        org-latex-preview-live t
        org-startup-with-latex-preview t
        org-latex-preview-auto-ignored-commands
        '(next-line previous-line mwheel-scroll ultra-scroll
          scroll-up-command scroll-down-command
          evil-scroll-up evil-scroll-down evil-scroll-line-up evil-scroll-line-down)
        ;;live previewing
        )

  ;; code for centering LaTeX previews -- a terrible idea
  (defun my/org-latex-preview-uncenter (ov)
    (overlay-put ov 'before-string nil))
  (defun my/org-latex-preview-recenter (ov)
    (overlay-put ov 'before-string (overlay-get ov 'justify)))
  (defun my/org-latex-preview-center (ov)
    (save-excursion
      (goto-char (overlay-start ov))
      (when-let* ((elem (org-element-context))
                  ((or (eq (org-element-type elem) 'latex-environment)
                       (string-match-p "^\\\\\\[" (org-element-property :value elem))))
                  (img (overlay-get ov 'display))
                  (prop `(space :align-to (- center (0.55 . ,img))))
                  (justify (propertize " " 'display prop 'face 'default)))
        (overlay-put ov 'justify justify)
        (overlay-put ov 'before-string (overlay-get ov 'justify)))))
  (define-minor-mode org-latex-preview-center-mode
    "Center equations previewed with `org-latex-preview'."
    :global nil
    (if org-latex-preview-center-mode
        (progn
          (add-hook 'org-latex-preview-overlay-open-functions
                    #'my/org-latex-preview-uncenter nil :local)
          (add-hook 'org-latex-preview-overlay-close-functions
                    #'my/org-latex-preview-recenter nil :local)
          (add-hook 'org-latex-preview-overlay-update-functions
                    #'my/org-latex-preview-center nil :local))
      (remove-hook 'org-latex-preview-overlay-close-functions
                   #'my/org-latex-preview-recenter)
      (remove-hook 'org-latex-preview-overlay-update-functions
                   #'my/org-latex-preview-center)
      (remove-hook 'org-latex-preview-overlay-open-functions
                   #'my/org-latex-preview-uncenter)))
)


(after! org-src
  (add-to-list 'org-src-block-faces '("latex" (:inherit default :extend t))))
