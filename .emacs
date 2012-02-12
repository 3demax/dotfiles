(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("0174d99a8f1fdc506fa54403317072982656f127" "5600dc0bb4a2b72a613175da54edb4ad770105aa" default)))
 '(show-paren-mode t)
 '(speedbar-use-images nil)
 '(sr-speedbar-max-width 25)
 '(sr-speedbar-right-side nil)
 '(sr-speedbar-width-x 24)
 '(tabbar-separator (quote (0.5))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#2e3436" :foreground "#d3d7cf" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "unknown" :family "Monospace"))))
 '(ido-only-match ((((class color)) (:foreground "#00BE1E" :weight bold))))
 '(linum ((t (:inherit (shadow default) :background "#2e3436" :foreground "#888a85"))))
 '(speedbar-highlight-face ((((class color) (background dark)) (:background "sea green"))))
 '(speedbar-selected-face ((t (:background "#960E10" :foreground "white" :weight bold)))))

;; End of auto-generated bullshit

;; Actual config goes below

;; ============================================================================
;; Themes
;; ============================================================================
(load-file "~/.emacs.d/Themes/oblivion.el")
;; ;; (setq linum-format "%4d ")
(setq linum-format
	  (lambda (line)
		(propertize (format
					 (let ((w (length (number-to-string
									   (count-lines (point-min) (point-max))))))
					   (concat " %" (number-to-string w) "d"))
					 line)
					'face 'linum)))

;; '(linum ((t (:inherit (shadow default) :background "#0A2832" :foreground "#727272"))))
;; '(linum ((t (:inherit (shadow default) :background "#2e3436" :foreground "#d3d7cf"))))
(add-to-list 'custom-theme-load-path "~/.emacs.d/Themes/emacs-color-theme-solarized/")
(add-to-list 'load-path "~/.emacs.d/Themes/emacs-color-theme-solarized/")
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/Themes/")
;; (load-theme 'solarized-dark t)

;; ============================================================================
;; Settings
;; ============================================================================

;; highlight current line
(global-hl-line-mode 1)

;; line numbers
(line-number-mode 1)

;; put scroolbars on right
;; (setq scroll-bar-mode-explicit t)
(set-scroll-bar-mode `right) 
;; (set-scroll-bar-mode `none) 

;; mode-line coloumn number
;; (column-number-mode t)

;; tab width 4
(setq default-tab-width 4)

;; turn of toolbar
(tool-bar-mode 0)

;; y-n instead of yes-no
(defalias 'yes-or-no-p 'y-or-n-p)

;; destop mode (save session)
(desktop-save-mode t)

;; Fullscreen (maximize at start)
;; BEWARE! Could be xserver-specific
(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
)
(toggle-fullscreen)

;; set window title corresponding to current buffer
(setq frame-title-format "%b - emacs")


;; ============================================================================
;; Modes
;; ============================================================================

(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\.md" . markdown-mode) auto-mode-alist))

(add-to-list 'load-path "~/.emacs.d/Modes/")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/")

;;
;; Languages
;;

;; Zencoding mode
(add-to-list 'load-path "~/.emacs.d/Modes/zencoding-mode/")
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)

;; markdown mode
(require 'markdown-mode)

;; python mode
(add-to-list 'load-path "~/.emacs.d/Modes/Python/")
;; (autoload 'python-mode "python-mode.el" "Python mode." t)
;; (setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))

(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

;;lua mode
(autoload 'lua-mode "lua-mode.el" "Lua mode." t)
(setq auto-mode-alist (append '(("/*.\.lua$" . lua-mode)) auto-mode-alist))

;; Pretty mode
(add-to-list 'load-path "~/.emacs.d/Modes/pretty-mode/")
(require 'pretty-mode)


(global-pretty-mode 1)
(add-hook 'python-mode-hook 'turn-on-pretty-mode)

;;
;; Other
;;

;; uniqify buffer names
(require 'uniquify) 
(setq uniquify-buffer-name-style 'forward)
    (setq uniquify-separator "/")
    (setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
    (setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;; line numbers
(require 'linum)
(global-linum-mode)

;; rainbow-delimiters all the way
(setq-default frame-background-mode 'dark)
(when (require 'rainbow-delimiters nil 'noerror) 
  (add-hook 'scheme-mode-hook 'rainbow-delimiters-mode))

;; autopair
(require 'autopair)
   (autopair-global-mode 1)
(setq autopair-autowrap t)

;; NYAN MODE!!!
(add-to-list 'load-path "~/.emacs.d/Modes/nyan-mode/")
(require 'nyan-mode)
(nyan-mode t)

;; ============================================================================
;; Hacks
;; ============================================================================

;; duplicating lines
(defun djcb-duplicate-line (&optional commentfirst)
  "comment line at point; if COMMENTFIRST is non-nil, comment the original" 
  (interactive)
  (beginning-of-line)
  (push-mark)
  (end-of-line)
  (let ((str (buffer-substring (region-beginning) (region-end))))
    (when commentfirst
    (comment-region (region-beginning) (region-end)))
    (insert-string
      (concat (if (= 0 (forward-line 1)) "" "\n") str "\n"))
    (forward-line -1)))
;; duplicate a line
(global-set-key (kbd "C-c y") 'djcb-duplicate-line)
;; duplicate a line and comment the first
(global-set-key (kbd "C-c c") (lambda()(interactive)(djcb-duplicate-line t)))

;;comment current line 
(defun toggle-comment-line ()
  (interactive)
  (save-excursion
    (funcall
     (if (progn (beginning-of-line)
                (looking-at (format "\\s-*%s" (regexp-quote comment-start))))
         (function uncomment-region)
         (function comment-region))
     (progn (beginning-of-line) (point))
     (progn (end-of-line)       (point)))))
;; set keybinding
(global-set-key (kbd "C-;") 'toggle-comment-line)


;; Change cursor color according to mode; inspired by
;; http://www.emacswiki.org/emacs/ChangingCursorDynamically
(setq djcb-read-only-color       "gray")
;; valid values are t, nil, box, hollow, bar, (bar . WIDTH), hbar,
;; (hbar. HEIGHT); see the docs for set-cursor-type
(setq djcb-read-only-cursor-type 'hbar)
(setq djcb-overwrite-color       "red")
(setq djcb-overwrite-cursor-type 'box)
(setq djcb-normal-color          "yellow")
(setq djcb-normal-cursor-type    'bar)
(defun djcb-set-cursor-according-to-mode ()
  "change cursor color and type according to some minor modes."
  (cond
    (buffer-read-only
      ;; (set-cursor-color djcb-read-only-color)
      (setq cursor-type djcb-read-only-cursor-type))
    (overwrite-mode
      ;; (set-cursor-color djcb-overwrite-color)
      (setq cursor-type djcb-overwrite-cursor-type))
    (t 
      ;; (set-cursor-color djcb-normal-color)
      (setq cursor-type djcb-normal-cursor-type))))
(add-hook 'post-command-hook 'djcb-set-cursor-according-to-mode)

;; Moving lines
(defun move-line-down ()
  (interactive)
  (beginning-of-line)
  (kill-line)
  (delete-char 1)
  (end-of-line)
  (newline)
  ;; or (newline-and-indent)
  (yank)					  
)
(global-set-key (kbd "M-n") 'move-line-down)
(defun move-line-up ()
  (interactive)
  (beginning-of-line)
  (kill-line)
  (delete-char 1)
  (previous-line)
  (yank)					  
  (newline)
  ;; or (newline-and-indent)
  (previous-line)
)
(global-set-key (kbd "M-p") 'move-line-up)


;; ============================================================================
;; Toolbars
;; ============================================================================

(add-to-list 'load-path "~/.emacs.d/Toolbars")

;; Tabbar
(require 'tabbar)
;; Tabbar settings
(set-face-attribute
 'tabbar-default nil
 :background "gray20"
 :foreground "gray20"
 :box '(:line-width 1 :color "gray20" :style nil))
(set-face-attribute
 'tabbar-unselected nil
 :background "gray30"
 :foreground "white"
 :box '(:line-width 5 :color "gray30" :style nil))
(set-face-attribute
 'tabbar-selected nil
 :background "gray75"
 :foreground "black"
 :box '(:line-width 5 :color "gray75" :style nil))
(set-face-attribute
 'tabbar-highlight nil
 :background "white"
 :foreground "black"
 :underline nil
 :box '(:line-width 5 :color "white" :style nil))
(set-face-attribute
 'tabbar-button nil
 :box '(:line-width 1 :color "gray20" :style nil))
(set-face-attribute
 'tabbar-separator nil
 :background "gray20"
 :height 0.6)

;; Change padding of the tabs
;; we also need to set separator to avoid overlapping tabs by highlighted tabs
;; so we add spaces
(defun tabbar-buffer-tab-label (tab)
  "Return a label for TAB.
That is, a string used to represent it on the tab bar."
  (let ((label  (if tabbar--buffer-show-groups
                    (format "[%s]  " (tabbar-tab-tabset tab))
                  (format "%s  " (tabbar-tab-value tab)))))
    ;; Unless the tab bar auto scrolls to keep the selected tab
    ;; visible, shorten the tab label to keep as many tabs as possible
    ;; in the visible area of the tab bar.
    (if tabbar-auto-scroll-flag
        label
      (tabbar-shorten
       label (max 1 (/ (window-width)
                       (length (tabbar-view
                                (tabbar-current-tabset)))))))))
(tabbar-mode 1)

;; (defun tabbar-buffer-groups (buffer)
;;    "Return the list of group names BUFFER belongs to.
;;  Return only one group for each buffer."
;;    (with-current-buffer (get-buffer buffer)
;;      (cond
;;       ((string-equal "*" (substring (buffer-name) 0 1))
;;        '("Emacs Buffer"))
;;       ((eq major-mode 'dired-mode)
;;        '("Dired"))
;;       (t
;;        '("User Buffer"))
;;       )))

;; list of opened files/buffers
(require 'sr-speedbar)

;; Minimap
(require 'minimap)

;; ============================================================================
;; Modeline setup
;; by Amit Patel
;; ============================================================================
(setq-default
 mode-line-format
 '(; Position, including warning for 80 columns
   ;; (:propertize "%4l:" face mode-line-position-face)
   ;; (:eval (propertize "%3c" 'face
   ;;                    (if (>= (current-column) 80)
   ;;                        'mode-line-80col-face
   ;;                      'mode-line-position-face)))
   ; emacsclient [default -- keep?]
   ;; mode-line-client
   ;; "  "
   ; read-only or modified status
   (:eval
    (cond (buffer-read-only
           (propertize " RO " 'face 'mode-line-read-only-face))
          ((buffer-modified-p)
           (propertize " ● " 'face 'mode-line-modified-face))
          (t "   ")))
   ;; "    "
   "  "
   (:eval
    (when (buffer-modified-p) (" ") )
   )
   ; directory and buffer/file name
   (:propertize (:eval (shorten-directory default-directory 20))
                face mode-line-folder-face)
   (:propertize "%b"
                face mode-line-filename-face)
   ; narrow [default -- keep?]
   " %n "
   ; mode indicators: vc, recursive edit, major mode, minor modes, process, global
   (vc-mode vc-mode)
   "  %["
   (:propertize mode-name
                face mode-line-mode-face)
   "%] "
   (:eval (propertize (format-mode-line minor-mode-alist)
                      'face 'mode-line-minor-mode-face))
   (:propertize mode-line-process
                face mode-line-process-face)
   (global-mode-string global-mode-string)
   ;; "    "
   "  "
   ; nyan-mode uses nyan cat as an alternative to %p
   (:eval (when nyan-mode (list (nyan-create))))
   ))

;; Helper function
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output))

;; Extra mode line faces
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-80col-face)

(set-face-attribute 'mode-line nil
    :foreground "gray60" :background "#202020";;"gray20"
    :inverse-video nil
    :box '(:line-width 1 :color "black" :style nil))
(set-face-attribute 'mode-line-inactive nil
    :foreground "gray80" :background "gray20";;"#3C3B37";;"gray40"
    :inverse-video nil
    :box '(:line-width 1 :color "gray10" :style nil))

(set-face-attribute 'mode-line-read-only-face nil
    :inherit 'mode-line-face
    :foreground "#4271ae"
    :box '(:line-width 2 :color "#4271ae"))
(set-face-attribute 'mode-line-modified-face nil
    :inherit 'mode-line-face
    :foreground "#c82829"
    :background "#ffffff"
    :box '(:line-width 2 :color "#c82829"))
(set-face-attribute 'mode-line-folder-face nil
    :inherit 'mode-line-face
    :foreground "gray60")
(set-face-attribute 'mode-line-filename-face nil
    :inherit 'mode-line-face
    :foreground "#eab700"
    :weight 'bold)
;; (set-face-attribute 'mode-line-position-face nil
;;     :inherit 'mode-line-face
;;     :family "Menlo" :height 100)
(set-face-attribute 'mode-line-mode-face nil
    :inherit 'mode-line-face
    :foreground "gray80")
(set-face-attribute 'mode-line-minor-mode-face nil
    :inherit 'mode-line-mode-face
    :foreground "gray40"
    ;; :height 110
	)
(set-face-attribute 'mode-line-process-face nil
    :inherit 'mode-line-face
    :foreground "#718c00")
(set-face-attribute 'mode-line-80col-face nil
    :inherit 'mode-line-position-face
    :foreground "black" :background "#eab700")

;; ============================================================================
;; Extensions
;; ============================================================================

(add-to-list 'load-path "~/.emacs.d/Extensions/")

;; deft note taking
(add-to-list 'load-path "~/.emacs.d/Extensions/deft/")
(require 'deft)
(setq deft-text-mode 'markdown-mode)
(global-set-key [f9] 'deft)

;; ido
(add-to-list 'load-path "~/.emacs.d/Extensions/ido/")
(require 'ido)
;; (setq ido-confirm-unique-completion t)
(setq ido-default-buffer-method 'samewindow)
(setq ido-use-filename-at-point t)
(ido-mode t)
(ido-everywhere t)
(set-face-foreground 'ido-first-match "#eab700")
(icomplete-mode 1)

;; start emacsserver
(server-start)
(setq server-kill-new-buffers nil)

;; ============================================================================
;; Macroses
;; ============================================================================

;; move lines by dv5ife
;; up
;; (global-set-key (kbd "M-p") (kbd "C-a C-k C-d C-p C-y C-j C-p TAB"))
;; down
;; (global-set-key (kbd "M-n") (kbd "C-a C-k C-d C-e C-j C-y TAB")) ;; down

(setq load-home-init-file t) ; don't load init file from ~/.xemacs/init.el
