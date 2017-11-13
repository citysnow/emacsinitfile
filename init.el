;; load-pathを追加
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos")

;; package.elを有効化
(require 'package)

;; パッケージリポジトリにMarmaladeとMELPAを追加
(add-to-list
 'package-archives
 '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list
 'package-archives
 '("melpa" . "https://melpa.org/packages/"))

;; インストール済みのElispを読み込む
(package-initialize) 

;; スタートアップメッセージを非表示
(setq inhibit-startup-screen t)

;; 文法チェックを実行
(add-hook 'after-init-hook #'global-flycheck-mode)

;; multi-termの設定
(when (require 'multi-term nil t)

;; 使用するシェルを指定
(setq multi-term-program "/bin/bash"))

;; C-hをバックスペースにする
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;; 別のキーにヘルプを割り当てる
(define-key global-map (kbd "C-x ?") 'help-command)

;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")

;; paren-mode：対応する括弧を強調して表示する
(setq show-paren-delay 0) ; 表示までの秒数。初期値は0.125
(show-paren-mode t) ; 有効化
;; parenのスタイル: expressionは括弧内も強調表示
(setq show-paren-style 'expression)

;; バックアップとオートセーブファイルを~/.emacs.d/backups/へ集める
(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))

;; cua-modeの設定
(cua-mode t) ; cua-modeをオン
(setq cua-enable-cua-keys nil) ; CUAキーバインドを無効にする

;; js-modeインデント幅2
(add-hook 'js-mode-hook
					(lambda ()
					(make-local-variable 'js-indent-level)
					(setq js-indent-level 2)))

;; tuareg-mode
(add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
(autoload 'tuareg-mode "tuareg" "Major mode for editing OCaml code" t)
(autoload 'tuareg-run-ocaml "tuareg" "Run an inferior OCaml process." t)
(autoload 'ocamldebug "ocamldebug" "Run the OCaml debugger" t)

;; SBCLをデフォルトのCommon Lisp処理系に設定
(setq inferior-lisp-program "clisp")
;; ~/.emacs.d/slimeをload-pathに追加
(add-to-list 'load-path (expand-file-name "~/.emacs.d/slime"))
;; SLIMEのロード
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner)) 
