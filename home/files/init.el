(require 'use-package)

					; Misc

(column-number-mode)

(setq backup-directory-alist
      '(("." . "~/.local/share/emacs/saves/")))


(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)

(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "C-z") 'ignore)
(global-set-key (kbd "C-x C-z") 'ignore)

(setq inhibit-startup-screen t)

;; (setq pop-up-frames t)

					; Server

(defun server-new-frame-buffer ()
  "Get the buffer to be used when making a new frame for the emacs
server."
  (let* ((oldframe (selected-frame))
	 (oldwindow (frame-selected-window oldframe))
	 (oldbuffer (window-buffer oldwindow)))
    (cond
     ((null oldbuffer) (get-buffer-create "*scratch*"))
     (t oldbuffer))))

(defun server-new-terminal-file ()
  "Get the file to be used when making a new terminal while using
the emacs server."
  (let* ((oldframe (selected-frame))
	 (oldwindow (frame-selected-window oldframe))
	 (oldbuffer (window-buffer oldwindow))
	 (dir (cdr (assq 'default-directory
			 (buffer-local-variables oldbuffer)))))
    (cond
     ((stringp dir) (expand-file-name dir))
     (t "/home/tassos"))))

					; Utility

(use-package ivy
  :config
  (ivy-mode 1))

(use-package which-key
  :config
  (which-key-mode 1))

(use-package wucuo
  :config
  (add-hook 'prog-mode-hook #'wucuo-start)
  (add-hook 'text-mode-hook #'wucuo-start))

(use-package dired
  :config
  (setq dired-listing-switches "--group-directories-first -al")
  (setq dired-auto-revert-buffer t
        dired-dwim-target t)
  (add-hook 'dired-mode-hook 'dired-hide-details-mode))

(use-package magit
  :bind
  ("C-x g" . magit-status))

(use-package projectile
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package company
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2))

;; (use-package company-posframe
;;   :config
;;   (setq company-posframe-quickhelp-delay nil)
;;   (company-posframe-mode 1))

(use-package pdf-tools
  :hook (doc-view-mode . pdf-view-mode))

					; Appearance

(setq-default truncate-lines t)
(setq-default fill-column 80)

;; (use-package all-the-icons)

(if (daemonp)
    (add-hook 'after-make-frame-functions
        (lambda (frame)
            (select-frame frame)
            (load-theme 'nord)))
    (load-theme 'nord))

					; Text Editing

(use-package aggressive-indent
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'org-mode))

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

(use-package multiple-cursors
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this))

(use-package ws-butler
  :config
  (ws-butler-global-mode 1))

(use-package yasnippet
  :config
  (yas-global-mode 1))

					; Markup

(use-package org
  :config
  (setq org-startup-indented t)
  (setq org-agenda-files '("~/org/school.org"
                           "~/org/projects.org"
                           "~/org/personal.org"))
  (setq org-todo-keywords
        '((sequence "TODO" "INPROG" "|" "DONE" "KILL" "FAIL")))
  :bind
  ("C-c a" . org-agenda)
  ("C-c l" . org-agenda-list))

(use-package org-journal
  :config
  (setq org-journal-dir "~/org/diary")
  :bind
  ("C-c j" . org-journal-new-entry))

					; Programming

;;(use-package dante
;;  :after haskell-mode
;;  :commands 'dante-mode
;;  :init
;;  (add-hook 'haskell-mode-hook 'flymake-mode)
;;  (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
;;  (add-hook 'haskell-mode-hook 'dante-mode))
