(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(use-package exec-path-from-shell
  :ensure t
  :defer nil
  :config (exec-path-from-shell-initialize))

(set-frame-font "Iosevka Emacs Plain-12:weight=semibold:width=expanded")

(defun remove-bold-faces ()
  (interactive)
  (mapc
   (lambda (face)
     (set-face-attribute face nil :weight 'medium))
   (face-list)))

(defun remove-italic-faces ()
  (interactive)
  (mapc
   (lambda (face)
     (set-face-attribute face nil :slant 'normal))
   (face-list)))

(defun switch-to-retina ()
  (interactive)
  (set-frame-font "Iosevka Emacs Plain-12:weight=semibold:width=expanded")
  (load-theme 'dorkula))

(defun switch-to-bitmap ()
  (interactive)
  (set-frame-font "tewi tall-11:antialias=0")
  (remove-bold-faces)
  (remove-italic-faces))

(setq dorkula-enlarge-headings nil)
(load-theme 'dorkula)

(tool-bar-mode -1)
(scroll-bar-mode -1)

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config (setq doom-modeline-height 10
		doom-modeline-icon nil
		doom-modeline-env-version nil
		doom-modeline-buffer-encoding nil))

(use-package persistent-scratch
  :ensure t
  :defer nil
  :init (persistent-scratch-setup-default))

(setq backup-directory-alist `(("." . "~/.emacs.d/saves"))
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(setq mac-option-modifier 'super
      mac-command-modifier 'meta)

(defalias 'yes-or-no-p 'y-or-n-p)

(use-package conda
  :ensure t
  :defer t
  :init (setq conda-anaconda-home "/Users/mscholz/.micromamba/")
  :disabled t)

(use-package micromamba
  :ensure t
  :defer t)

(use-package docker
  :ensure t
  :defer t
  :bind ("C-c d" . docker))

(use-package dockerfile-mode
  :ensure t
  :defer t)

(setq org-directory "~/Developer/Org/"
      org-structure-template-alist '(("a" . "export ascii")
				     ("c" . "center")
				     ("C" . "comment")
				     ("e" . "src emacs-lisp")
				     ("E" . "export")
				     ("h" . "export html")
				     ("l" . "export latex")
				     ("q" . "quote")
				     ("s" . "src")
				     ("v" . "verse"))
      org-agenda-files (directory-files-recursively org-directory "\\.org$"))
(require 'org-tempo)

(use-package yaml-mode
  :defer t
  :ensure t)

(use-package vterm
  :ensure t
  :defer t)

(use-package vertico
  :ensure t
  :defer t
  :init (vertico-mode))

(use-package consult
  :ensure t
  :defer t
  :bind (("C-x b" . consult-buffer))
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :config (recentf-mode 1))

(use-package magit
  :ensure t
  :defer t)

(use-package eglot
  :ensure t
  :defer t)

(use-package hl-todo
  :ensure t
  :defer t
  :config (global-hl-todo-mode +1))

(use-package savehist
  :ensure t
  :defer nil
  :init
  (savehist-mode))

(use-package orderless
  :ensure t
  :defer t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :ensure t
  :defer t
  :init (marginalia-mode))

(use-package rainbow-mode
  :ensure t
  :defer t)

(use-package format-all
  :ensure t
  :defer t
  :hook ((python-mode . format-all-mode)
	 (format-all-mode-hook . format-all-ensure-formatter))
  :config (custom-set-variables
	   '(format-all-formatters (quote (("Python" black))))))

(use-package treesit-auto
  :ensure t
  :demand t
  :config
  (setq treesit-auto-install 'prompt)
  (global-treesit-auto-mode))

(use-package projectile
  :ensure t
  :defer nil
  :config (progn
	    (projectile-mode 1)
	    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)))

(use-package eshell-prompt-extras
  :ensure t
  :config (eval-after-load 'esh-opt
	    (progn
	      (autoload 'epe-theme-lambda "eshell-prompt-extras")
	      (setq eshell-highlight-prompt nil
		    eshell-prompt-function 'epe-theme-lambda))))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
	      ("C-c C-e" . markdown-do)))

;; Highlight as much as possible with tree-sitter
(setq treesit-font-lock-level 4)
