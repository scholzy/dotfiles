;;; dorkula-theme.el --- Dorkula Theme

;; Copyright 2015-present, All rights reserved
;;
;; Code licensed under the MIT license

;; Maintainer: Étienne Deparis <etienne@depar.is>
;; Author: film42
;; Version: 1.8.1
;; Package-Requires: ((emacs "24.3"))
;; URL: https://github.com/dorkula/emacs

;;; Commentary:

;; A dark color theme available for a number of editors.
;; This theme tries as much as possible to follow the consensual
;; specification (see URL `https://spec.dorkulatheme.com/').

;;; News:

;;;; Version next

;; Fix ansi-color definition

;;;; Version 1.8.1

;; Fix missing 1.8.0 docstring...

;;;; Version 1.8.0

;; New package support:
;;
;; - Add support for ansi-color-names-vector
;; - Add support for bookmark-face
;; - Add support for (e)diff-mode. Add dark-red and dark-green new colors
;; - Add support for eldoc-box
;; - Add support for elfeed
;; - Add support for gemini-mode and elpher
;; - Add support for go-test
;; - Add support for header-line
;; - Add support for ivy
;; - Add support for lsp-ui
;; - Add support for neotree
;; - Add support for perspective and mini-modeline
;; - Add support for reStructuredText
;; - Add support for selectrum-mode
;; - Add support for shadow-face
;; - Add support for speedbar
;; - Add support for telephone-line
;; - Add support for tooltip-face
;; - Add support for tree-sitter and add missing font-lock faces
;; - Add support for web-mode-css-property-name-face
;; - Add support for which-key-mode
;;
;; - Fix ‘message-cited-text-*’ colors
;; - Use same color for gnus than message mode and old mu4e-view mode
;; - Follow dorkula color specs for Markdown and Org mode
;; - Improve readability of company colors
;; - Improve default mode-line colors
;; - Set powerline active and inactive dorkula colors
;; - Improve completions (from minibuffer.el) colors
;;
;; Terminal related things:
;;
;; - Try a new 256 colors palette
;; - Add a setting to force 24bit colors on 256 colors terms
;; - Do not advertize dorkula-use-24-bit-colors-on-256-colors-terms in README
;; - Avoid black and black text for TUI applications
;; - Use a dark menubar on terminals
;;
;; Tests related things:
;;
;; - Improve a little test script
;; - Avoid auto-save-default folder creation in test profile
;; - Remove test profile from melpa package content
;;
;; README related things:
;;
;; - Remove outdated homebrew instructions
;; - Update screenshot
;; - Update install instruction to advertize NonGNU Elpa
;; - Update README configure section with correct names.
;; - 📃 Standardize docs with other dorkula repositories
;;
;; Others:
;;
;; - Fix comment before color listing
;; - Use unspecified-bg/-fg instead of nil color spec
;; - Use inherit highlight for two matching company faces
;; - Remove useless , in front of inherited faces
;; - Remove cl-lib dependency
;; - Reduce eval call scope
;; - Little change to file metadata
;; - Remove some unspecified color specifications
;; - Alphabetically sort basic faces settings
;; - Move mode-line faces in basic faces section
;; - Little adjustments for eglot package
;; - Remove bg3 as it was very similar to dorkula-current
;; - Rename other-blue to dark-blue
;; - Colorize shr title as in the other markup modes
;; - Improve magit faces
;;

;;; Code:
(deftheme dorkula)


;;;; Configuration options:

(defgroup dorkula nil
  "Dorkula theme options.

The theme has to be reloaded after changing anything in this group."
  :group 'faces)

(defcustom dorkula-enlarge-headings t
  "Use different font sizes for some headings and titles."
  :type 'boolean
  :group 'dorkula)

(defcustom dorkula-height-title-1 1.3
  "Font size 100%."
  :type 'number
  :group 'dorkula)

(defcustom dorkula-height-title-2 1.1
  "Font size 110%."
  :type 'number
  :group 'dorkula)

(defcustom dorkula-height-title-3 1.0
  "Font size 130%."
  :type 'number
  :group 'dorkula)

(defcustom dorkula-height-doc-title 1.44
  "Font size 144%."
  :type 'number
  :group 'dorkula)

(defcustom dorkula-alternate-mode-line-and-minibuffer nil
  "Use less bold and pink in the minibuffer."
  :type 'boolean
  :group 'dorkula)

(defvar dorkula-use-24-bit-colors-on-256-colors-terms nil
  "Use true colors even on terminals announcing less capabilities.

Beware the use of this variable.  Using it may lead to unwanted
behavior, the most common one being an ugly blue background on
terminals, which don't understand 24 bit colors.  To avoid this
blue background, when using this variable, one can try to add the
following lines in their config file after having load the
Dorkula theme:

    (unless (display-graphic-p)
      (set-face-background \\='default \"black\" nil))

There is a lot of discussion behind the 256 colors theme (see URL
`https://github.com/dorkula/emacs/pull/57').  Please take time to
read it before opening a new issue about your will.")


;;;; Theme definition:

;; Assigment form: VARIABLE COLOR [256-COLOR [TTY-COLOR]]
(let ((colors '(;; Upstream theme color
                (dorkula-bg      "#282a36" "unspecified-bg" "unspecified-bg") ; official background
                (dorkula-fg      "#f8f8f2" "#ffffff" "brightwhite") ; official foreground
                (dorkula-current "#44475a" "#303030" "brightblack") ; official current-line/selection
                (dorkula-comment "#6272a4" "#5f5faf" "blue")        ; official comment
                (dorkula-cyan    "#8be9fd" "#87d7ff" "brightcyan")  ; official cyan
                (dorkula-green   "#50fa7b" "#5fff87" "green")       ; official green
                (dorkula-orange  "#ffb86c" "#ffaf5f" "brightred")   ; official orange
                (dorkula-pink    "#ff79c6" "#ff87d7" "magenta")     ; official pink
                (dorkula-purple  "#bd93f9" "#af87ff" "brightmagenta") ; official purple
                (dorkula-red     "#ff5555" "#ff8787" "red")         ; official red
                (dorkula-yellow  "#f1fa8c" "#ffff87" "yellow")      ; official yellow
                ;; Other colors
                (bg2             "#373844" "#121212" "brightblack")
                (bg3             "#565761" "#444444" "brightblack")
                (fg2             "#e2e2dc" "#e4e4e4" "brightwhite")
                (fg3             "#ccccc7" "#c6c6c6" "white")
                (fg4             "#b6b6b2" "#b2b2b2" "white")
                (dark-red        "#880000" "#870000" "red") ; 40% darker
                (dark-green      "#037a22" "#00af00" "green") ; 40% darker
                (dark-blue       "#0189cc" "#0087ff" "brightblue")))
      (faces '(;; default / basic faces
               (cursor :background ,fg3)
               (default :background ,dorkula-bg :foreground ,dorkula-fg :weight semibold)
               (default-italic :slant italic)
               (error :foreground ,dorkula-red)
               (ffap :foreground ,fg4)
               (fringe :background ,dorkula-bg :foreground ,fg4)
               (header-line :inherit 'mode-line)
               (highlight :foreground ,fg3 :background ,dorkula-current)
               (hl-line :background ,dorkula-current :extend t)
               (info-quoted-name :foreground ,dorkula-orange)
               (info-string :foreground ,dorkula-yellow)
               (lazy-highlight :foreground ,fg2 :background ,bg2)
               (link :foreground ,dorkula-cyan :underline t)
               (linum :slant italic :foreground ,bg3 :background ,dorkula-bg)
               (line-number :slant italic :foreground ,bg3 :background ,dorkula-bg)
               (match :background ,dorkula-yellow :foreground ,dorkula-bg)
               (menu :background ,dorkula-current :inverse-video nil
                     ,@(if dorkula-alternate-mode-line-and-minibuffer
                           (list :foreground fg3)
                         (list :foreground dorkula-fg)))
               (minibuffer-prompt
                ,@(if dorkula-alternate-mode-line-and-minibuffer
                      (list :weight 'semibold :foreground dorkula-fg)
                    (list :weight 'bold :foreground dorkula-pink)))
               (mode-line :background ,dorkula-current
                          :box ,dorkula-current :inverse-video nil
                          ,@(if dorkula-alternate-mode-line-and-minibuffer
                                (list :foreground fg3)
                              (list :foreground dorkula-fg)))
               (mode-line-inactive
                :background ,dorkula-bg :inverse-video nil
                ,@(if dorkula-alternate-mode-line-and-minibuffer
                      (list :foreground dorkula-comment :box dorkula-bg)
                    (list :foreground fg4 :box bg2)))
               (read-multiple-choice-face :inherit completions-first-difference)
               (region :inherit match :extend t)
               (shadow :foreground ,dorkula-comment)
               (success :foreground ,dorkula-green)
               (tooltip :foreground ,dorkula-fg :background ,dorkula-current)
               (trailing-whitespace :background ,dorkula-orange)
               (vertical-border :foreground ,bg2)
               (warning :foreground ,dorkula-orange)
               ;; syntax / font-lock
               (font-lock-builtin-face :foreground ,dorkula-cyan :slant italic)
               (font-lock-comment-face :inherit shadow :slant italic)
               (font-lock-comment-delimiter-face :inherit shadow)
               (font-lock-constant-face :foreground ,dorkula-purple)
               (font-lock-doc-face :foreground ,dorkula-yellow)
               (font-lock-function-call-face :inherit font-lock-function-name-face :weight semibold)
               (font-lock-function-name-face :foreground ,dorkula-green :weight bold)
               (font-lock-keyword-face :foreground ,dorkula-pink :weight semibold)
               (font-lock-negation-char-face :foreground ,dorkula-cyan)
               (font-lock-number-face :foreground ,dorkula-purple)
               (font-lock-operator-face :foreground ,dorkula-pink)
               (font-lock-preprocessor-face :foreground ,dorkula-orange)
               (font-lock-property-use-face :foreground ,dorkula-orange :weight semibold)
               (font-lock-reference-face :inherit font-lock-constant-face) ;; obsolete
               (font-lock-regexp-grouping-backslash :foreground ,dorkula-cyan)
               (font-lock-regexp-grouping-construct :foreground ,dorkula-purple)
               (font-lock-string-face :foreground ,dorkula-yellow)
               (font-lock-type-face :inherit font-lock-builtin-face)
               (font-lock-variable-name-face :foreground ,dorkula-fg :weight semibold)
               (font-lock-warning-face :inherit warning :background ,bg2)
               ;; auto-complete
               (ac-completion-face :underline t :foreground ,dorkula-pink)
               ;; ansi-color
               (ansi-color-black :foreground ,dorkula-bg :background ,dorkula-bg)
               (ansi-color-bright-black :foreground "black" :background "black")
               (ansi-color-red :foreground ,dorkula-red :background ,dorkula-red)
               (ansi-color-bright-red :foreground ,dorkula-red
                                      :background ,dorkula-red
                                      :weight bold)
               (ansi-color-green :foreground ,dorkula-green :background ,dorkula-green)
               (ansi-color-bright-green :foreground ,dorkula-green
                                        :background ,dorkula-green
                                        :weight bold)
               (ansi-color-yellow :foreground ,dorkula-yellow :background ,dorkula-yellow)
               (ansi-color-bright-yellow :foreground ,dorkula-yellow
                                         :background ,dorkula-yellow
                                         :weight bold)
               (ansi-color-blue :foreground ,dorkula-comment :background ,dorkula-comment)
               (ansi-color-bright-blue :foreground ,dorkula-comment
                                       :background ,dorkula-comment
                                       :weight bold)
               (ansi-color-magenta :foreground ,dorkula-pink :background ,dorkula-pink)
               (ansi-color-bright-magenta :foreground ,dorkula-pink
                                          :background ,dorkula-pink
                                          :weight bold)
               (ansi-color-cyan :foreground ,dorkula-cyan :background ,dorkula-cyan)
               (ansi-color-bright-cyan :foreground ,dorkula-cyan
                                       :background ,dorkula-cyan
                                       :weight bold)
               (ansi-color-white :foreground ,dorkula-fg :background ,dorkula-fg)
               (ansi-color-bright-white :foreground "white" :background "white")
               ;; bookmarks
               (bookmark-face :foreground ,dorkula-pink)
               ;; company
               (company-echo-common :foreground ,dorkula-bg :background ,dorkula-fg)
               (company-preview :background ,dorkula-current :foreground ,dark-blue)
               (company-preview-common :inherit company-preview
                                       :foreground ,dorkula-pink)
               (company-preview-search :inherit company-preview
                                       :foreground ,dorkula-green)
               (company-scrollbar-bg :background ,dorkula-comment)
               (company-scrollbar-fg :foreground ,dark-blue)
               (company-tooltip :inherit tooltip)
               (company-tooltip-search :foreground ,dorkula-green
                                       :underline t)
               (company-tooltip-search-selection :background ,dorkula-green
                                                 :foreground ,dorkula-bg)
               (company-tooltip-selection :inherit match)
               (company-tooltip-mouse :background ,dorkula-bg)
               (company-tooltip-common :foreground ,dorkula-pink :weight bold)
               ;;(company-tooltip-common-selection :inherit company-tooltip-common)
               (company-tooltip-annotation :foreground ,dorkula-cyan)
               ;;(company-tooltip-annotation-selection :inherit company-tooltip-annotation)
               ;; completions (minibuffer.el)
               (completions-annotations :inherit font-lock-comment-face)
               (completions-common-part :foreground ,dorkula-green)
               (completions-first-difference :foreground ,dorkula-pink :weight bold)
               ;; diff
               (diff-added :background ,dark-green :foreground ,dorkula-fg :extend t)
               (diff-removed :background ,dark-red :foreground ,dorkula-fg :extend t)
               (diff-refine-added :background ,dorkula-green
                                  :foreground ,dorkula-bg)
               (diff-refine-removed :background ,dorkula-red
                                    :foreground ,dorkula-fg)
               (diff-indicator-added :foreground ,dorkula-green)
               (diff-indicator-removed :foreground ,dorkula-red)
               (diff-indicator-changed :foreground ,dorkula-orange)
               (diff-error :foreground ,dorkula-red, :background ,dorkula-bg
                           :weight bold)
               ;; diff-hl
               (diff-hl-change :foreground ,dorkula-orange :background ,dorkula-orange)
               (diff-hl-delete :foreground ,dorkula-red :background ,dorkula-red)
               (diff-hl-insert :foreground ,dorkula-green :background ,dorkula-green)
               ;; dired
               (dired-directory :foreground ,dorkula-green :weight semibold)
               (dired-flagged :foreground ,dorkula-pink)
               (dired-header :foreground ,fg3 :background ,dorkula-bg)
               (dired-ignored :inherit shadow)
               (dired-mark :foreground ,dorkula-fg :weight bold)
               (dired-marked :foreground ,dorkula-orange :weight bold)
               (dired-perm-write :foreground ,fg3 :underline t)
               (dired-symlink :foreground ,dorkula-yellow :weight semibold :slant italic)
               (dired-warning :foreground ,dorkula-orange :underline t)
               (diredp-compressed-file-name :foreground ,fg3)
               (diredp-compressed-file-suffix :foreground ,fg4)
               (diredp-date-time :foreground ,dorkula-fg)
               (diredp-deletion-file-name :foreground ,dorkula-pink :background ,dorkula-current)
               (diredp-deletion :foreground ,dorkula-pink :weight bold)
               (diredp-dir-heading :foreground ,fg2 :background ,bg3)
               (diredp-dir-name :inherit dired-directory)
               (diredp-dir-priv :inherit dired-directory)
               (diredp-executable-tag :foreground ,dorkula-orange)
               (diredp-file-name :foreground ,dorkula-fg)
               (diredp-file-suffix :foreground ,fg4)
               (diredp-flag-mark-line :foreground ,fg2 :slant italic :background ,dorkula-current)
               (diredp-flag-mark :foreground ,fg2 :weight bold :background ,dorkula-current)
               (diredp-ignored-file-name :foreground ,dorkula-fg)
               (diredp-mode-line-flagged :foreground ,dorkula-orange)
               (diredp-mode-line-marked :foreground ,dorkula-orange)
               (diredp-no-priv :foreground ,dorkula-fg)
               (diredp-number :foreground ,dorkula-cyan)
               (diredp-other-priv :foreground ,dorkula-orange)
               (diredp-rare-priv :foreground ,dorkula-orange)
               (diredp-read-priv :foreground ,dorkula-purple)
               (diredp-write-priv :foreground ,dorkula-pink)
               (diredp-exec-priv :foreground ,dorkula-yellow)
               (diredp-symlink :foreground ,dorkula-orange)
               (diredp-link-priv :foreground ,dorkula-orange)
               (diredp-autofile-name :foreground ,dorkula-yellow)
               (diredp-tagged-autofile-name :foreground ,dorkula-yellow)
               ;; doom-modeline
               (doom-modeline :weight semibold)
               ;; ediff
               (ediff-current-diff-A :background ,dark-red)
               (ediff-fine-diff-A :background ,dorkula-red :foreground ,dorkula-fg)
               (ediff-current-diff-B :background ,dark-green)
               (ediff-fine-diff-B :background ,dorkula-green :foreground ,dorkula-bg)
               (ediff-current-diff-C :background ,dark-blue)
               (ediff-fine-diff-C :background ,dorkula-cyan :foreground ,dorkula-bg)
               ;; eglot
               (eglot-diagnostic-tag-unnecessary-face :inherit warning)
               (eglot-diagnostic-tag-deprecated-face :inherit warning :strike-through t)
               (eglot-highlight-symbol-face :underline t)
               ;; eldoc-box
               (eldoc-box-border :background ,dorkula-current)
               (eldoc-box-body :background ,dorkula-current)
               ;; elfeed
               (elfeed-search-date-face :foreground ,dorkula-comment)
               (elfeed-search-title-face :foreground ,dorkula-fg)
               (elfeed-search-unread-title-face :foreground ,dorkula-pink :weight bold)
               (elfeed-search-feed-face :foreground ,dorkula-fg :weight bold)
               (elfeed-search-tag-face :foreground ,dorkula-green)
               (elfeed-search-last-update-face :weight bold)
               (elfeed-search-unread-count-face :foreground ,dorkula-pink)
               (elfeed-search-filter-face :foreground ,dorkula-green :weight bold)
               ;;(elfeed-log-date-face :inherit font-lock-type-face)
               (elfeed-log-error-level-face :foreground ,dorkula-red)
               (elfeed-log-warn-level-face :foreground ,dorkula-orange)
               (elfeed-log-info-level-face :foreground ,dorkula-cyan)
               (elfeed-log-debug-level-face :foreground ,dorkula-comment)
               ;; elpher
               (elpher-gemini-heading1 :inherit bold :foreground ,dorkula-pink
                                       ,@(when dorkula-enlarge-headings
                                           (list :height dorkula-height-title-1)))
               (elpher-gemini-heading2 :inherit bold :foreground ,dorkula-purple
                                       ,@(when dorkula-enlarge-headings
                                           (list :height dorkula-height-title-2)))
               (elpher-gemini-heading3 :weight semibold :foreground ,dorkula-green
                                       ,@(when dorkula-enlarge-headings
                                           (list :height dorkula-height-title-3)))
               (elpher-gemini-preformatted :inherit fixed-pitch
                                           :foreground ,dorkula-orange)
               ;; enh-ruby
               (enh-ruby-heredoc-delimiter-face :foreground ,dorkula-yellow)
               (enh-ruby-op-face :foreground ,dorkula-pink)
               (enh-ruby-regexp-delimiter-face :foreground ,dorkula-yellow)
               (enh-ruby-string-delimiter-face :foreground ,dorkula-yellow)
               ;; epe-eshell
               (epe-dir-face :foreground ,dorkula-green :weight semibold)
               ;; flyspell
               (flyspell-duplicate :underline (:style wave :color ,dorkula-orange))
               (flyspell-incorrect :underline (:style wave :color ,dorkula-red))
               ;; font-latex
               (font-latex-bold-face :foreground ,dorkula-purple)
               (font-latex-italic-face :foreground ,dorkula-pink :slant italic)
               (font-latex-match-reference-keywords :foreground ,dorkula-cyan)
               (font-latex-match-variable-keywords :foreground ,dorkula-fg)
               (font-latex-string-face :foreground ,dorkula-yellow)
               ;; gemini
               (gemini-heading-face-1 :inherit bold :foreground ,dorkula-pink
                                      ,@(when dorkula-enlarge-headings
                                          (list :height dorkula-height-title-1)))
               (gemini-heading-face-2 :inherit bold :foreground ,dorkula-purple
                                      ,@(when dorkula-enlarge-headings
                                          (list :height dorkula-height-title-2)))
               (gemini-heading-face-3 :weight semibold :foreground ,dorkula-green
                                      ,@(when dorkula-enlarge-headings
                                          (list :height dorkula-height-title-3)))
               (gemini-heading-face-rest :weight semibold :foreground ,dorkula-yellow)
               (gemini-quote-face :foreground ,dorkula-purple)
               ;; go-test
               (go-test--ok-face :inherit success)
               (go-test--error-face :inherit error)
               (go-test--warning-face :inherit warning)
               (go-test--pointer-face :foreground ,dorkula-pink)
               (go-test--standard-face :foreground ,dorkula-cyan)
               ;; gnus-group
               (gnus-group-mail-1 :foreground ,dorkula-pink :weight bold)
               (gnus-group-mail-1-empty :inherit gnus-group-mail-1 :weight semibold)
               (gnus-group-mail-2 :foreground ,dorkula-cyan :weight bold)
               (gnus-group-mail-2-empty :inherit gnus-group-mail-2 :weight semibold)
               (gnus-group-mail-3 :foreground ,dorkula-comment :weight bold)
               (gnus-group-mail-3-empty :inherit gnus-group-mail-3 :weight semibold)
               (gnus-group-mail-low :foreground ,dorkula-current :weight bold)
               (gnus-group-mail-low-empty :inherit gnus-group-mail-low :weight semibold)
               (gnus-group-news-1 :foreground ,dorkula-pink :weight bold)
               (gnus-group-news-1-empty :inherit gnus-group-news-1 :weight semibold)
               (gnus-group-news-2 :foreground ,dorkula-cyan :weight bold)
               (gnus-group-news-2-empty :inherit gnus-group-news-2 :weight semibold)
               (gnus-group-news-3 :foreground ,dorkula-comment :weight bold)
               (gnus-group-news-3-empty :inherit gnus-group-news-3 :weight semibold)
               (gnus-group-news-4 :inherit gnus-group-news-low)
               (gnus-group-news-4-empty :inherit gnus-group-news-low-empty)
               (gnus-group-news-5 :inherit gnus-group-news-low)
               (gnus-group-news-5-empty :inherit gnus-group-news-low-empty)
               (gnus-group-news-6 :inherit gnus-group-news-low)
               (gnus-group-news-6-empty :inherit gnus-group-news-low-empty)
               (gnus-group-news-low :foreground ,dorkula-current :weight bold)
               (gnus-group-news-low-empty :inherit gnus-group-news-low :weight semibold)
               (gnus-header-content :foreground ,dorkula-purple)
               (gnus-header-from :foreground ,dorkula-fg)
               (gnus-header-name :foreground ,dorkula-green)
               (gnus-header-subject :foreground ,dorkula-pink :weight bold)
               (gnus-summary-markup-face :foreground ,dorkula-cyan)
               (gnus-summary-high-unread :foreground ,dorkula-pink :weight bold)
               (gnus-summary-high-read :inherit gnus-summary-high-unread :weight semibold)
               (gnus-summary-high-ancient :inherit gnus-summary-high-read)
               (gnus-summary-high-ticked :inherit gnus-summary-high-read :underline t)
               (gnus-summary-semibold-unread :foreground ,dark-blue :weight bold)
               (gnus-summary-semibold-read :foreground ,dorkula-comment :weight semibold)
               (gnus-summary-semibold-ancient :inherit gnus-summary-semibold-read :weight light)
               (gnus-summary-semibold-ticked :foreground ,dorkula-pink :weight bold)
               (gnus-summary-low-unread :foreground ,dorkula-comment :weight bold)
               (gnus-summary-low-read :inherit gnus-summary-low-unread :weight semibold)
               (gnus-summary-low-ancient :inherit gnus-summary-low-read)
               (gnus-summary-low-ticked :inherit gnus-summary-low-read :underline t)
               (gnus-summary-selected :inverse-video t)
               ;; haskell-mode
               (haskell-operator-face :foreground ,dorkula-pink)
               (haskell-constructor-face :foreground ,dorkula-purple)
               ;; helm
               (helm-bookmark-w3m :foreground ,dorkula-purple)
               (helm-buffer-not-saved :foreground ,dorkula-purple :background ,dorkula-bg)
               (helm-buffer-process :foreground ,dorkula-orange :background ,dorkula-bg)
               (helm-buffer-saved-out :foreground ,dorkula-fg :background ,dorkula-bg)
               (helm-buffer-size :foreground ,dorkula-fg :background ,dorkula-bg)
               (helm-candidate-number :foreground ,dorkula-bg :background ,dorkula-fg)
               (helm-ff-directory :foreground ,dorkula-green :background ,dorkula-bg :weight bold)
               (helm-ff-dotted-directory :foreground ,dorkula-green :background ,dorkula-bg :weight semibold)
               (helm-ff-executable :foreground ,dark-blue :background ,dorkula-bg :weight semibold)
               (helm-ff-file :foreground ,dorkula-fg :background ,dorkula-bg :weight semibold)
               (helm-ff-invalid-symlink :foreground ,dorkula-pink :background ,dorkula-bg :weight bold)
               (helm-ff-prefix :foreground ,dorkula-bg :background ,dorkula-pink :weight semibold)
               (helm-ff-symlink :foreground ,dorkula-pink :background ,dorkula-bg :weight bold)
               (helm-grep-cmd-line :foreground ,dorkula-fg :background ,dorkula-bg)
               (helm-grep-file :foreground ,dorkula-fg :background ,dorkula-bg)
               (helm-grep-finish :foreground ,fg2 :background ,dorkula-bg)
               (helm-grep-lineno :foreground ,dorkula-fg :background ,dorkula-bg)
               (helm-grep-match :inherit match)
               (helm-grep-running :foreground ,dorkula-green :background ,dorkula-bg)
               (helm-header :foreground ,fg2 :background ,dorkula-bg :underline nil :box nil)
               (helm-moccur-buffer :foreground ,dorkula-green :background ,dorkula-bg)
               (helm-selection :background ,bg2 :underline nil)
               (helm-selection-line :background ,bg2)
               (helm-separator :foreground ,dorkula-purple :background ,dorkula-bg)
               (helm-source-go-package-godoc-description :foreground ,dorkula-yellow)
               (helm-source-header :foreground ,dorkula-pink :background ,dorkula-bg :underline nil :weight bold)
               (helm-time-zone-current :foreground ,dorkula-orange :background ,dorkula-bg)
               (helm-time-zone-home :foreground ,dorkula-purple :background ,dorkula-bg)
               (helm-visible-mark :foreground ,dorkula-bg :background ,dorkula-current)
               ;; highlight-indentation minor mode
               (highlight-indentation-face :background ,bg2)
               ;; icicle
               (icicle-whitespace-highlight :background ,dorkula-fg)
               (icicle-special-candidate :foreground ,fg2)
               (icicle-extra-candidate :foreground ,fg2)
               (icicle-search-main-regexp-others :foreground ,dorkula-fg)
               (icicle-search-current-input :foreground ,dorkula-pink)
               (icicle-search-context-level-8 :foreground ,dorkula-orange)
               (icicle-search-context-level-7 :foreground ,dorkula-orange)
               (icicle-search-context-level-6 :foreground ,dorkula-orange)
               (icicle-search-context-level-5 :foreground ,dorkula-orange)
               (icicle-search-context-level-4 :foreground ,dorkula-orange)
               (icicle-search-context-level-3 :foreground ,dorkula-orange)
               (icicle-search-context-level-2 :foreground ,dorkula-orange)
               (icicle-search-context-level-1 :foreground ,dorkula-orange)
               (icicle-search-main-regexp-current :foreground ,dorkula-fg)
               (icicle-saved-candidate :foreground ,dorkula-fg)
               (icicle-proxy-candidate :foreground ,dorkula-fg)
               (icicle-mustmatch-completion :foreground ,dorkula-purple)
               (icicle-multi-command-completion :foreground ,fg2 :background ,bg2)
               (icicle-msg-emphasis :foreground ,dorkula-green)
               (icicle-mode-line-help :foreground ,fg4)
               (icicle-match-highlight-minibuffer :foreground ,dorkula-orange)
               (icicle-match-highlight-Completions :foreground ,dorkula-green)
               (icicle-key-complete-menu-local :foreground ,dorkula-fg)
               (icicle-key-complete-menu :foreground ,dorkula-fg)
               (icicle-input-completion-fail-lax :foreground ,dorkula-pink)
               (icicle-input-completion-fail :foreground ,dorkula-pink)
               (icicle-historical-candidate-other :foreground ,dorkula-fg)
               (icicle-historical-candidate :foreground ,dorkula-fg)
               (icicle-current-candidate-highlight :foreground ,dorkula-orange :background ,dorkula-current)
               (icicle-Completions-instruction-2 :foreground ,fg4)
               (icicle-Completions-instruction-1 :foreground ,fg4)
               (icicle-completion :foreground ,dorkula-fg)
               (icicle-complete-input :foreground ,dorkula-orange)
               (icicle-common-match-highlight-Completions :foreground ,dorkula-purple)
               (icicle-candidate-part :foreground ,dorkula-fg)
               (icicle-annotation :foreground ,fg4)
               ;; icomplete
               (icompletep-determined :foreground ,dorkula-orange)
               ;; ido
               (ido-first-match
                ,@(if dorkula-alternate-mode-line-and-minibuffer
                      (list :weight 'semibold :foreground dorkula-green)
                    (list :weight 'bold :foreground dorkula-pink)))
               (ido-only-match :foreground ,dorkula-orange)
               (ido-subdir :foreground ,dorkula-yellow)
               (ido-virtual :foreground ,dorkula-cyan)
               (ido-incomplete-regexp :inherit font-lock-warning-face)
               (ido-indicator :foreground ,dorkula-fg :background ,dorkula-pink)
               ;; ivy
               (ivy-current-match
                ,@(if dorkula-alternate-mode-line-and-minibuffer
                      (list :weight 'semibold :background dorkula-current :foreground dorkula-green)
                    (list :weight 'bold :background dorkula-current :foreground dorkula-pink)))
               ;; Highlights the background of the match.
               (ivy-minibuffer-match-face-1 :background ,dorkula-current)
               ;; Highlights the first matched group.
               (ivy-minibuffer-match-face-2 :background ,dorkula-green
                                            :foreground ,dorkula-bg)
               ;; Highlights the second matched group.
               (ivy-minibuffer-match-face-3 :background ,dorkula-yellow
                                            :foreground ,dorkula-bg)
               ;; Highlights the third matched group.
               (ivy-minibuffer-match-face-4 :background ,dorkula-pink
                                            :foreground ,dorkula-bg)
               (ivy-confirm-face :foreground ,dorkula-orange)
               (ivy-match-required-face :foreground ,dorkula-red)
               (ivy-subdir :foreground ,dorkula-yellow)
               (ivy-remote :foreground ,dorkula-pink)
               (ivy-virtual :foreground ,dorkula-cyan)
               ;; isearch
               (isearch :inherit match :weight bold)
               (isearch-fail :foreground ,dorkula-bg :background ,dorkula-orange)
               ;; jde-java
               (jde-java-font-lock-constant-face :foreground ,dorkula-cyan)
               (jde-java-font-lock-modifier-face :foreground ,dorkula-pink)
               (jde-java-font-lock-number-face :foreground ,dorkula-fg)
               (jde-java-font-lock-package-face :foreground ,dorkula-fg)
               (jde-java-font-lock-private-face :foreground ,dorkula-pink)
               (jde-java-font-lock-public-face :foreground ,dorkula-pink)
               ;; js2-mode
               (js2-external-variable :foreground ,dorkula-purple)
               (js2-function-param :foreground ,dorkula-cyan)
               (js2-jsdoc-html-tag-delimiter :foreground ,dorkula-yellow)
               (js2-jsdoc-html-tag-name :foreground ,dark-blue)
               (js2-jsdoc-value :foreground ,dorkula-yellow)
               (js2-private-function-call :foreground ,dorkula-cyan)
               (js2-private-member :foreground ,fg3)
               ;; js3-mode
               (js3-error-face :underline ,dorkula-orange)
               (js3-external-variable-face :foreground ,dorkula-fg)
               (js3-function-param-face :foreground ,dorkula-pink)
               (js3-instance-member-face :foreground ,dorkula-cyan)
               (js3-jsdoc-tag-face :foreground ,dorkula-pink)
               (js3-warning-face :underline ,dorkula-pink)
               ;; lsp
               (lsp-ui-peek-peek :background ,dorkula-bg)
               (lsp-ui-peek-list :background ,bg2)
               (lsp-ui-peek-filename :foreground ,dorkula-pink :weight bold)
               (lsp-ui-peek-line-number :foreground ,dorkula-fg)
               (lsp-ui-peek-highlight :inherit highlight :distant-foreground ,dorkula-bg)
               (lsp-ui-peek-header :background ,dorkula-current :foreground ,fg3, :weight bold)
               (lsp-ui-peek-footer :inherit lsp-ui-peek-header)
               (lsp-ui-peek-selection :inherit match)
               (lsp-ui-sideline-symbol :foreground ,fg4 :box (:line-width -1 :color ,fg4) :height 0.99)
               (lsp-ui-sideline-current-symbol :foreground ,dorkula-fg :weight ultra-bold
                                               :box (:line-width -1 :color dorkula-fg) :height 0.99)
               (lsp-ui-sideline-code-action :foreground ,dorkula-yellow)
               (lsp-ui-sideline-symbol-info :slant italic :height 0.99)
               (lsp-ui-doc-background :background ,dorkula-bg)
               (lsp-ui-doc-header :foreground ,dorkula-bg :background ,dorkula-cyan)
               ;; magit
               (magit-branch-local :foreground ,dorkula-cyan)
               (magit-branch-remote :foreground ,dorkula-green)
               (magit-filename :slant italic :weight semibold)
               (magit-refname :foreground ,dark-blue)
               (magit-tag :foreground ,dorkula-orange)
               (magit-hash :foreground ,dorkula-comment)
               (magit-dimmed :foreground ,dorkula-comment)
               (magit-section-heading :foreground ,dorkula-pink :weight bold)
               (magit-section-highlight :background ,dorkula-current :extend t)
               (magit-diff-context :foreground ,fg3 :extend t)
               (magit-diff-context-highlight :inherit magit-section-highlight
                                             :foreground ,dorkula-fg)
               (magit-diff-revision-summary :foreground ,dorkula-orange
                                            :background ,dorkula-bg
                                            :weight bold)
               (magit-diff-revision-summary-highlight :inherit magit-section-highlight
                                                      :foreground ,dorkula-orange
                                                      :weight bold)
               (magit-diff-added :background ,dorkula-bg :foreground ,dorkula-green)
               (magit-diff-added-highlight :background ,dorkula-current
                                           :foreground ,dorkula-green)
               (magit-diff-removed :background ,dorkula-bg :foreground ,dorkula-red)
               (magit-diff-removed-highlight :background ,dorkula-current
                                             :foreground ,dorkula-red)
               (magit-diff-file-heading :foreground ,dorkula-fg)
               (magit-diff-file-heading-highlight :inherit magit-section-highlight
                                                  :weight bold)
               (magit-diff-file-heading-selection
                :inherit magit-diff-file-heading-highlight
                :foreground ,dorkula-pink)
               (magit-diff-hunk-heading :inherit magit-diff-context
                                        :background ,bg3)
               (magit-diff-hunk-heading-highlight
                :inherit magit-diff-context-highlight
                :weight bold)
               (magit-diff-hunk-heading-selection
                :inherit magit-diff-hunk-heading-highlight
                :foreground ,dorkula-pink)
               (magit-diff-lines-heading
                :inherit magit-diff-hunk-heading-highlight
                :foreground ,dorkula-pink)
               (magit-diff-lines-boundary :background ,dorkula-pink)
               (magit-diffstat-added :foreground ,dorkula-green)
               (magit-diffstat-removed :foreground ,dorkula-red)
               (magit-log-author :foreground ,dorkula-comment)
               (magit-log-date :foreground ,dorkula-comment)
               (magit-log-graph :foreground ,dorkula-yellow)
               (magit-process-ng :foreground ,dorkula-orange :weight bold)
               (magit-process-ok :foreground ,dorkula-green :weight bold)
               (magit-signature-good :foreground ,dorkula-green)
               (magit-signature-bad :foreground ,dorkula-red :weight bold)
               (magit-signature-untrusted :foreground ,dorkula-cyan)
               (magit-signature-expired :foreground ,dorkula-orange)
               (magit-signature-revoked :foreground ,dorkula-purple)
               (magit-signature-error :foreground ,dorkula-cyan)
               (magit-cherry-unmatched :foreground ,dorkula-cyan)
               (magit-cherry-equivalent :foreground ,dorkula-purple)
               ;; markdown
               (markdown-blockquote-face :foreground ,dorkula-yellow
                                         :slant italic)
               (markdown-code-face :foreground ,dorkula-orange)
               (markdown-footnote-face :foreground ,dark-blue)
               (markdown-header-face :weight semibold)
               (markdown-header-face-1
                :inherit bold :foreground ,dorkula-pink
                ,@(when dorkula-enlarge-headings
                    (list :height dorkula-height-title-1)))
               (markdown-header-face-2
                :inherit bold :foreground ,dorkula-purple
                ,@(when dorkula-enlarge-headings
                    (list :height dorkula-height-title-2)))
               (markdown-header-face-3
                :foreground ,dorkula-green
                ,@(when dorkula-enlarge-headings
                    (list :height dorkula-height-title-3)))
               (markdown-header-face-4 :foreground ,dorkula-yellow)
               (markdown-header-face-5 :foreground ,dorkula-cyan)
               (markdown-header-face-6 :foreground ,dorkula-orange)
               (markdown-header-face-7 :foreground ,dark-blue)
               (markdown-header-face-8 :foreground ,dorkula-fg)
               (markdown-inline-code-face :foreground ,dorkula-green)
               (markdown-plain-url-face :inherit link)
               (markdown-pre-face :foreground ,dorkula-orange)
               (markdown-table-face :foreground ,dorkula-purple)
               (markdown-list-face :foreground ,dorkula-cyan)
               (markdown-language-keyword-face :foreground ,dorkula-comment)
               ;; message
               (message-header-to :foreground ,dorkula-fg :weight bold)
               (message-header-cc :foreground ,dorkula-fg :bold bold)
               (message-header-subject :foreground ,dorkula-orange)
               (message-header-newsgroups :foreground ,dorkula-purple)
               (message-header-other :foreground ,dorkula-purple)
               (message-header-name :foreground ,dorkula-green)
               (message-header-xheader :foreground ,dorkula-cyan)
               (message-separator :foreground ,dorkula-cyan :slant italic)
               (message-cited-text :foreground ,dorkula-purple)
               (message-cited-text-1 :foreground ,dorkula-purple)
               (message-cited-text-2 :foreground ,dorkula-orange)
               (message-cited-text-3 :foreground ,dorkula-comment)
               (message-cited-text-4 :foreground ,fg2)
               (message-mml :foreground ,dorkula-green :weight semibold)
               ;; mini-modeline
               (mini-modeline-mode-line :inherit mode-line :height 0.1 :box nil)
               ;; mu4e
               (mu4e-unread-face :foreground ,dorkula-pink :weight semibold)
               (mu4e-view-url-number-face :foreground ,dorkula-purple)
               (mu4e-highlight-face :background ,dorkula-bg
                                    :foreground ,dorkula-yellow
                                    :extend t)
               (mu4e-header-highlight-face :background ,dorkula-current
                                           :foreground ,dorkula-fg
                                           :underline nil :weight bold
                                           :extend t)
               (mu4e-header-key-face :inherit message-mml)
               (mu4e-header-marks-face :foreground ,dorkula-purple)
               (mu4e-cited-1-face :foreground ,dorkula-purple)
               (mu4e-cited-2-face :foreground ,dorkula-orange)
               (mu4e-cited-3-face :foreground ,dorkula-comment)
               (mu4e-cited-4-face :foreground ,fg2)
               (mu4e-cited-5-face :foreground ,fg3)
               ;; neotree
               (neo-banner-face :foreground ,dorkula-orange :weight bold)
               ;;(neo-button-face :underline nil)
               (neo-dir-link-face :foreground ,dorkula-purple)
               (neo-expand-btn-face :foreground ,dorkula-fg)
               (neo-file-link-face :foreground ,dorkula-cyan)
               (neo-header-face :background ,dorkula-bg
                                :foreground ,dorkula-fg
                                :weight bold)
               (neo-root-dir-face :foreground ,dorkula-purple :weight bold)
               (neo-vc-added-face :foreground ,dorkula-orange)
               (neo-vc-conflict-face :foreground ,dorkula-red)
               (neo-vc-default-face :inherit neo-file-link-face)
               (neo-vc-edited-face :foreground ,dorkula-orange)
               (neo-vc-ignored-face :foreground ,dorkula-comment)
               (neo-vc-missing-face :foreground ,dorkula-red)
               (neo-vc-needs-merge-face :foreground ,dorkula-red
                                        :weight bold)
               ;;(neo-vc-needs-update-face :underline t)
               ;;(neo-vc-removed-face :strike-through t)
               (neo-vc-unlocked-changes-face :foreground ,dorkula-red)
               ;;(neo-vc-unregistered-face nil)
               (neo-vc-up-to-date-face :foreground ,dorkula-green)
               (neo-vc-user-face :foreground ,dorkula-purple)
               ;; org
               (org-agenda-date :foreground ,dorkula-cyan :underline nil)
               (org-agenda-dimmed-todo-face :foreground ,dorkula-comment)
               (org-agenda-done :foreground ,dorkula-green)
               (org-agenda-structure :foreground ,dorkula-purple)
               (org-block :foreground ,dorkula-orange)
               (org-code :foreground ,dorkula-green)
               (org-column :background ,bg3)
               (org-column-title :inherit org-column :weight bold :underline t)
               (org-date :foreground ,dorkula-cyan :underline t)
               (org-document-info :foreground ,dark-blue)
               (org-document-info-keyword :foreground ,dorkula-comment)
               (org-document-title :weight bold :foreground ,dorkula-orange
                                   ,@(when dorkula-enlarge-headings
                                       (list :height dorkula-height-doc-title)))
               (org-done :foreground ,dorkula-green)
               (org-ellipsis :foreground ,dorkula-comment)
               (org-footnote :foreground ,dark-blue)
               (org-formula :foreground ,dorkula-pink)
               (org-headline-done :foreground ,dorkula-comment
                                  :weight semibold :strike-through t)
               (org-hide :foreground ,dorkula-bg :background ,dorkula-bg)
               (org-level-1 :inherit bold :foreground ,dorkula-pink
                            ,@(when dorkula-enlarge-headings
                                (list :height dorkula-height-title-1)))
               (org-level-2 :inherit bold :foreground ,dorkula-purple
                            ,@(when dorkula-enlarge-headings
                                (list :height dorkula-height-title-2)))
               (org-level-3 :weight semibold :foreground ,dorkula-green
                            ,@(when dorkula-enlarge-headings
                                (list :height dorkula-height-title-3)))
               (org-level-4 :weight semibold :foreground ,dorkula-yellow)
               (org-level-5 :weight semibold :foreground ,dorkula-cyan)
               (org-level-6 :weight semibold :foreground ,dorkula-orange)
               (org-level-7 :weight semibold :foreground ,dark-blue)
               (org-level-8 :weight semibold :foreground ,dorkula-fg)
               (org-link :foreground ,dorkula-cyan :underline t)
               (org-priority :foreground ,dorkula-cyan)
               (org-quote :foreground ,dorkula-yellow :slant italic)
               (org-scheduled :foreground ,dorkula-green)
               (org-scheduled-previously :foreground ,dorkula-yellow)
               (org-scheduled-today :foreground ,dorkula-green)
               (org-sexp-date :foreground ,fg4)
               (org-special-keyword :foreground ,dorkula-yellow)
               (org-table :foreground ,dorkula-purple)
               (org-tag :foreground ,dorkula-pink :weight bold :background ,bg2)
               (org-todo :foreground ,dorkula-orange :weight bold :background ,bg2)
               (org-upcoming-deadline :foreground ,dorkula-yellow)
               (org-verbatim :inherit org-quote)
               (org-warning :weight bold :foreground ,dorkula-pink)
               ;; outline
               (outline-1 :foreground ,dorkula-pink)
               (outline-2 :foreground ,dorkula-purple)
               (outline-3 :foreground ,dorkula-green)
               (outline-4 :foreground ,dorkula-yellow)
               (outline-5 :foreground ,dorkula-cyan)
               (outline-6 :foreground ,dorkula-orange)
               ;; perspective
               (persp-selected-face :weight bold :foreground ,dorkula-pink)
               ;; powerline
               (powerline-active1 :background ,dorkula-bg :foreground ,dorkula-pink)
               (powerline-active2 :background ,dorkula-bg :foreground ,dorkula-pink)
               (powerline-inactive1 :background ,bg2 :foreground ,dorkula-purple)
               (powerline-inactive2 :background ,bg2 :foreground ,dorkula-purple)
               (powerline-evil-base-face :foreground ,bg2)
               (powerline-evil-emacs-face :inherit powerline-evil-base-face :background ,dorkula-yellow)
               (powerline-evil-insert-face :inherit powerline-evil-base-face :background ,dorkula-cyan)
               (powerline-evil-motion-face :inherit powerline-evil-base-face :background ,dorkula-purple)
               (powerline-evil-semibold-face :inherit powerline-evil-base-face :background ,dorkula-green)
               (powerline-evil-operator-face :inherit powerline-evil-base-face :background ,dorkula-pink)
               (powerline-evil-replace-face :inherit powerline-evil-base-face :background ,dorkula-red)
               (powerline-evil-visual-face :inherit powerline-evil-base-face :background ,dorkula-orange)
               ;; rainbow-delimiters
               (rainbow-delimiters-depth-1-face :foreground ,dorkula-fg)
               (rainbow-delimiters-depth-2-face :foreground ,dorkula-cyan)
               (rainbow-delimiters-depth-3-face :foreground ,dorkula-purple)
               (rainbow-delimiters-depth-4-face :foreground ,dorkula-pink)
               (rainbow-delimiters-depth-5-face :foreground ,dorkula-orange)
               (rainbow-delimiters-depth-6-face :foreground ,dorkula-green)
               (rainbow-delimiters-depth-7-face :foreground ,dorkula-yellow)
               (rainbow-delimiters-depth-8-face :foreground ,dark-blue)
               (rainbow-delimiters-unmatched-face :foreground ,dorkula-orange)
               ;; rpm-spec
               (rpm-spec-dir-face :foreground ,dorkula-green)
               (rpm-spec-doc-face :foreground ,dorkula-pink)
               (rpm-spec-ghost-face :foreground ,dorkula-purple)
               (rpm-spec-macro-face :foreground ,dorkula-yellow)
               (rpm-spec-obsolete-tag-face :inherit font-lock-warning-face)
               (rpm-spec-package-face :foreground ,dorkula-purple)
               (rpm-spec-section-face :foreground ,dorkula-yellow)
               (rpm-spec-tag-face :foreground ,dorkula-cyan)
               (rpm-spec-var-face :foreground ,dorkula-orange)
               ;; rst (reStructuredText)
               (rst-level-1 :foreground ,dorkula-pink :weight bold)
               (rst-level-2 :foreground ,dorkula-purple :weight bold)
               (rst-level-3 :foreground ,dorkula-green)
               (rst-level-4 :foreground ,dorkula-yellow)
               (rst-level-5 :foreground ,dorkula-cyan)
               (rst-level-6 :foreground ,dorkula-orange)
               (rst-level-7 :foreground ,dark-blue)
               (rst-level-8 :foreground ,dorkula-fg)
               ;; selectrum-mode
               (selectrum-current-candidate :weight bold)
               (selectrum-primary-highlight :foreground ,dorkula-pink)
               (selectrum-secondary-highlight :foreground ,dorkula-green)
               ;; show-paren
               (show-paren-match-face :background unspecified
                                      :foreground ,dorkula-cyan
                                      :weight bold)
               (show-paren-match :background unspecified
                                 :foreground ,dorkula-cyan
                                 :weight bold)
               (show-paren-match-expression :inherit match)
               (show-paren-mismatch :inherit font-lock-warning-face)
               ;; shr
               (shr-h1 :foreground ,dorkula-pink :weight bold :height 1.3)
               (shr-h2 :foreground ,dorkula-purple :weight bold)
               (shr-h3 :foreground ,dorkula-green :slant italic)
               (shr-h4 :foreground ,dorkula-yellow)
               (shr-h5 :foreground ,dorkula-cyan)
               (shr-h6 :foreground ,dorkula-orange)
               ;; slime
               (slime-repl-inputed-output-face :foreground ,dorkula-purple)
               ;; spam
               (spam :inherit gnus-summary-semibold-read :foreground ,dorkula-orange
                     :strike-through t :slant oblique)
               ;; speedbar (and sr-speedbar)
               (speedbar-button-face :foreground ,dorkula-green)
               (speedbar-file-face :foreground ,dorkula-cyan)
               (speedbar-directory-face :foreground ,dorkula-purple)
               (speedbar-tag-face :foreground ,dorkula-yellow)
               (speedbar-selected-face :foreground ,dorkula-pink)
               (speedbar-highlight-face :inherit match)
               (speedbar-separator-face :background ,dorkula-bg
                                        :foreground ,dorkula-fg
                                        :weight bold)
               ;; tab-bar & tab-line (since Emacs 27.1)
               (tab-bar :foreground ,dorkula-purple :background ,dorkula-current
                        :inherit variable-pitch)
               (tab-bar-tab :foreground ,dorkula-pink :background ,dorkula-bg
                            :box (:line-width 2 :color ,dorkula-bg :style nil))
               (tab-bar-tab-inactive :foreground ,dorkula-purple :background ,bg2
                                     :box (:line-width 2 :color ,bg2 :style nil))
               (tab-line :foreground ,dorkula-purple :background ,dorkula-current
                         :height 0.9 :inherit variable-pitch)
               (tab-line-tab :foreground ,dorkula-pink :background ,dorkula-bg
                             :box (:line-width 2 :color ,dorkula-bg :style nil))
               (tab-line-tab-inactive :foreground ,dorkula-purple :background ,bg2
                                      :box (:line-width 2 :color ,bg2 :style nil))
               (tab-line-tab-current :inherit tab-line-tab)
               (tab-line-close-highlight :foreground ,dorkula-red)
               ;; telephone-line
               (telephone-line-accent-active :background ,dorkula-bg :foreground ,dorkula-pink)
               (telephone-line-accent-inactive :background ,bg2 :foreground ,dorkula-purple)
               (telephone-line-unimportant :background ,dorkula-bg :foreground ,dorkula-comment)
               ;; term
               (term :foreground ,dorkula-fg :background ,dorkula-bg)
               (term-color-black :foreground ,dorkula-bg :background ,dorkula-comment)
               (term-color-blue :foreground ,dorkula-purple :background ,dorkula-purple)
               (term-color-cyan :foreground ,dorkula-cyan :background ,dorkula-cyan)
               (term-color-green :foreground ,dorkula-green :background ,dorkula-green)
               (term-color-magenta :foreground ,dorkula-pink :background ,dorkula-pink)
               (term-color-red :foreground ,dorkula-red :background ,dorkula-red)
               (term-color-white :foreground ,dorkula-fg :background ,dorkula-fg)
               (term-color-yellow :foreground ,dorkula-yellow :background ,dorkula-yellow)
               ;; tree-sitter
               (tree-sitter-hl-face:attribute :inherit font-lock-constant-face)
               (tree-sitter-hl-face:comment :inherit font-lock-comment-face)
               (tree-sitter-hl-face:constant :inherit font-lock-constant-face)
               (tree-sitter-hl-face:constant.builtin :inherit font-lock-builtin-face)
               (tree-sitter-hl-face:constructor :inherit font-lock-constant-face)
               (tree-sitter-hl-face:escape :foreground ,dorkula-pink)
               (tree-sitter-hl-face:function :inherit font-lock-function-name-face)
               (tree-sitter-hl-face:function.builtin :inherit font-lock-builtin-face)
               (tree-sitter-hl-face:function.call :inherit font-lock-function-name-face
                                                  :weight semibold)
               (tree-sitter-hl-face:function.macro :inherit font-lock-preprocessor-face)
               (tree-sitter-hl-face:function.special :inherit font-lock-preprocessor-face)
               (tree-sitter-hl-face:keyword :inherit font-lock-keyword-face)
               (tree-sitter-hl-face:punctuation :foreground ,dorkula-pink)
               (tree-sitter-hl-face:punctuation.bracket :foreground ,dorkula-fg)
               (tree-sitter-hl-face:punctuation.delimiter :foreground ,dorkula-fg)
               (tree-sitter-hl-face:punctuation.special :foreground ,dorkula-pink)
               (tree-sitter-hl-face:string :inherit font-lock-string-face)
               (tree-sitter-hl-face:string.special :foreground ,dorkula-red)
               (tree-sitter-hl-face:tag :inherit font-lock-keyword-face)
               (tree-sitter-hl-face:type :inherit font-lock-type-face)
               (tree-sitter-hl-face:type.parameter :foreground ,dorkula-pink)
               (tree-sitter-hl-face:variable :inherit font-lock-variable-name-face)
               (tree-sitter-hl-face:variable.parameter :inherit tree-sitter-hl-face:variable
                                                       :weight semibold)
               ;; undo-tree
               (undo-tree-visualizer-current-face :foreground ,dorkula-orange)
               (undo-tree-visualizer-default-face :foreground ,fg2)
               (undo-tree-visualizer-register-face :foreground ,dorkula-purple)
               (undo-tree-visualizer-unmodified-face :foreground ,dorkula-fg)
               ;; web-mode
               (web-mode-builtin-face :inherit font-lock-builtin-face)
               (web-mode-comment-face :inherit font-lock-comment-face)
               (web-mode-constant-face :inherit font-lock-constant-face)
               (web-mode-css-property-name-face :inherit font-lock-constant-face)
               (web-mode-doctype-face :inherit font-lock-comment-face)
               (web-mode-function-name-face :inherit font-lock-function-name-face)
               (web-mode-html-attr-name-face :foreground ,dorkula-purple)
               (web-mode-html-attr-value-face :foreground ,dorkula-green)
               (web-mode-html-tag-face :foreground ,dorkula-pink :weight bold)
               (web-mode-keyword-face :foreground ,dorkula-pink)
               (web-mode-string-face :foreground ,dorkula-yellow)
               (web-mode-type-face :inherit font-lock-type-face)
               (web-mode-warning-face :inherit font-lock-warning-face)
               ;; which-func
               (which-func :inherit font-lock-function-name-face)
               ;; which-key
               (which-key-key-face :inherit font-lock-builtin-face)
               (which-key-command-description-face :inherit default)
               (which-key-separator-face :inherit font-lock-comment-delimiter-face)
               (which-key-local-map-description-face :foreground ,dorkula-green)
               ;; whitespace
               (whitespace-big-indent :background ,dorkula-red :foreground ,dorkula-red)
               (whitespace-empty :background ,dorkula-orange :foreground ,dorkula-red)
               (whitespace-hspace :background ,dorkula-current :foreground ,dorkula-comment)
               (whitespace-indentation :background ,dorkula-orange :foreground ,dorkula-red)
               (whitespace-line :background ,dorkula-bg :foreground ,dorkula-pink)
               (whitespace-newline :foreground ,dorkula-comment)
               (whitespace-space :background ,dorkula-bg :foreground ,dorkula-comment)
               (whitespace-space-after-tab :background ,dorkula-orange :foreground ,dorkula-red)
               (whitespace-space-before-tab :background ,dorkula-orange :foreground ,dorkula-red)
               (whitespace-tab :background ,bg2 :foreground ,dorkula-comment)
               (whitespace-trailing :inherit trailing-whitespace)
               ;; yard-mode
               (yard-tag-face :inherit font-lock-builtin-face)
               (yard-directive-face :inherit font-lock-builtin-face))))

  (apply #'custom-theme-set-faces
         'dorkula
         (let ((expand-with-func
                (lambda (func spec)
                  (let (reduced-color-list)
                    (dolist (col colors reduced-color-list)
                      (push (list (car col) (funcall func col))
                            reduced-color-list))
                    (eval `(let ,reduced-color-list
                             (backquote ,spec))))))
               whole-theme)
           (pcase-dolist (`(,face . ,spec) faces)
             (push `(,face
                     ((((min-colors 16777216)) ; fully graphical envs
                       ,(funcall expand-with-func 'cadr spec))
                      (((min-colors 256))      ; terminal withs 256 colors
                       ,(if dorkula-use-24-bit-colors-on-256-colors-terms
                            (funcall expand-with-func 'cadr spec)
                          (funcall expand-with-func 'caddr spec)))
                      (t                       ; should be only tty-like envs
                       ,(funcall expand-with-func 'cadddr spec))))
                   whole-theme))
           whole-theme)))


;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'dorkula)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; dorkula-theme.el ends here
