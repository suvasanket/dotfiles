;; (setq doom-font (font-spec :famiLy "Iosevka Comfy Motion Fixed" :size 18 :weight 'Medium)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 17 :weight 'SemiBold)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 20 :weight 'Bold))

(setq doom-theme 'adwaita-dark)
;; (setq doom-theme 'doom-monokai-pro)

(setq display-line-numbers-type 'relative)

;; set transparency
;; (set-frame-parameter (selected-frame) 'alpha '(98 98))
;; (add-to-list 'default-frame-alist '(alpha 98 98))

(use-package! spacious-padding
  :init
  (spacious-padding-mode 1)
  :config
  (package-initialize)
  (setq spacious-padding-widths
        '( :internal-border-width 15
           :header-line-width 4
           :mode-line-width 8
           :tab-width 4
           :right-divider-width 30
           :scroll-bar-width 8
           :fringe-width 8))
  ;; (setq spacious-padding-subtle-mode-line
  ;;       '(:mode-line-active shadow :mode-line-inactive shadow))
  )

(setq fancy-splash-image "~/.dev/splash_img/meditate.png")
;; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(setq +doom-dashboard-menu-sections (cl-subseq +doom-dashboard-menu-sections 0 1))
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)

(setq centaur-tabs-style "alternate"
      centaur-tabs-height 20
      centaur-tabs-set-bar nil
      centaur-tabs-set-close-button nil)

;; (add-to-list 'default-frame-alist '(undecorated . t))
(setq confirm-kill-emacs nil)
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon nil)

(when (featurep 'ns)
  (defun ns-raise-emacs ()
    "Raise Emacs."
    (ns-do-applescript "tell application \"Emacs\" to activate"))
  (defun ns-raise-emacs-with-frame (frame)
    "Raise Emacs and select the provided frame."
    (with-selected-frame frame
      (when (display-graphic-p)
        (ns-raise-emacs))))
  (add-hook 'after-make-frame-functions 'ns-raise-emacs-with-frame)
  (when (display-graphic-p)
    (ns-raise-emacs)))

;; (after! doom-modeline
;;   (remove-hook 'doom-modeline-mode-hook #'size-indication-mode) ; filesize in modeline
;;   (remove-hook 'doom-modeline-mode-hook #'column-number-mode)   ; cursor column in modeline
;;   (line-number-mode -1)
;;   (setq doom-modeline-buffer-encoding nil)
;;   (setq doom-modeline-modal nil)
;;   (setq doom-modeline-height 40)
;;   ;; (setq doom-modeline-buffer-file-name-style 'file-name)
;;   (setq doom-modeline-bar-width 0)
;;   (setq doom-material-padded-modeline t)
;;   )
;; (custom-set-faces!
;;   '(doom-modeline-bar :inherit modeline-bg))

(use-package! lambda-line
  :custom
  (lambda-line-position 'bottom) ;; Set position of status-line
  (lambda-line-abbrev t) ;; abbreviate major modes
  (lambda-line-hspace "  ")  ;; add some cushion
  (lambda-line-prefix t) ;; use a prefix symbol
  (lambda-line-gui-ro-symbol  " !") ;; symbols
  (lambda-line-gui-mod-symbol " ⬤")
  (lambda-line-gui-rw-symbol  "")
  (lambda-line-vc-symbol "  ")
  (lambda-line-git-diff-mode-line nil)
  (lambda-line-space-top +.15)  ;; padding on top and bottom of line
  (lambda-line-space-bottom -.15)
  (lambda-line-symbol-position 0.0) ;; adjust the vertical placement of symbol
  :config
  ;; activate lambda-line
  (lambda-line-mode)
  ;; set divider line in footer
  (when (eq lambda-line-position 'top)
    (setq-default mode-line-format (list "%_"))
    (setq mode-line-format (list "%_"))))

(after! org
  (setopt org-startup-indented t
          org-ellipsis ""
          org-hide-emphasis-markers t
          org-pretty-entities t
          ;; C-e binding is pretty annoying to me
          org-special-ctrl-a/e '(t . nil)
          org-special-ctrl-k t
          org-src-fontify-natively t
          org-fontify-whole-heading-line t
          org-fontify-quote-and-verse-blocks t
          org-edit-src-content-indentation 2
          org-hide-block-startup nil
          org-src-tab-acts-natively t
          org-src-preserve-indentation nil
          org-cycle-separator-lines 2
          org-hide-leading-stars t
          org-highlight-latex-and-related '(native)
          org-goto-auto-isearch nil)
  )

(map! :after evil-org
      :map evil-org-mode-map
      :n "SPC ." #'org-roam-node-find)

(use-package! org-modern
  :custom
  (org-modern-star "replace")
  (org-modern-label-border 0.4)
  (org-modern-replace-stars "◉○◈◇✳")

  :config
  (global-org-modern-mode)
  )

(setq consult-buffer-filter
    '("\\` " "\\`\\*.*\\'")
    )

(add-hook 'dired-mode-hook
          (lambda ()
            (dired-hide-details-mode)
            (dired-sort-toggle-or-edit)))

(defun kill-dired-buffers ()
  (interactive)
  (mapc (lambda (buffer)
          (when (eq 'dired-mode (buffer-local-value 'major-mode buffer))
            (kill-buffer buffer)))
        (buffer-list)))

(map! :map dired-mode-map
      :gnv "h" 'dired-up-directory
      :gnv "l"  'dired-find-alternate-file)

(setq projectile-switch-project-action #'projectile-dired)
(setq projectile-sort-order 'recentf)
(setq projectile-project-search-path '("~/codes/" ))
(defun cust/vsplit-file-open (f)
  (let ((evil-vsplit-window-right t))
    (+evil/window-vsplit-and-follow)
    (find-file f)))

(define-key minibuffer-mode-map (kbd "C-v") (kbd "C-; o"))
(map! :map minibuffer-mode-map
      "C-a" #'embark-act)

(map! :after evil
      :n "C-s-p" 'previous-buffer
      :n "C-s-n" 'next-buffer
      :n "zx" 'doom/kill-other-buffers
      :n "C-f" 'consult-buffer
      :iv "C-c" 'evil-normal-state
      :n "C-h" 'evil-window-left
      :n "C-j" 'evil-window-down
      :n "C-k" 'evil-window-up
      :n "C-l" 'evil-window-right)

(map! :leader
      :desc "kill dired buffers"
      "b d" #'kill-dired-buffers)

;; (map! :map 'override
;;       :n "SPC b d" #'kill-dired-buffers
;;       )

(setq corfu-preselect 'first)
(map! :map corfu-map
      :gi "C-a" 'corfu-complete)

;;vterm
(map! :after vterm
      :map vterm-mode-map
      :ni "ESC" #'vterm-send-escape)

(setq consult-buffer-filter
      '("\\` " "\\`\\*.*\\'")
      )
