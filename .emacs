
(defvar *eli-directory*)
(setq *eli-directory* (expand-file-name "C:/acl10.1express/eli/"))

(if (and (not (string-match "xemacs" emacs-version))
	 (= emacs-major-version 20)
	 (<= emacs-minor-version 2))
    (setq load-path (cons *eli-directory* load-path))
  (push "C:/acl100express/eli" load-path))

(load (format "%sfi-site-init" *eli-directory*))

(setq fi:common-lisp-image-name "C:/acl10.1express/allegro-express")
(setq fi:common-lisp-image-file "C:/acl10.1express/allegro-express.dxl")
(setq fi:common-lisp-directory "C:/acl10.1express")
(setq fi:common-lisp-host (system-name))

;; This function starts up lisp with your defaults.
(defun run-common-lisp ()
  (interactive)
  (fi:common-lisp fi:common-lisp-buffer-name
                  fi:common-lisp-directory
                  fi:common-lisp-image-name
                  fi:common-lisp-image-arguments
                  fi:common-lisp-host
		  ))

;; Set up a keybinding for `run-common-lisp'
(define-key global-map "\C-xl" 'run-common-lisp)


(put 'downcase-region 'disabled nil)


(put 'upcase-region 'disabled nil)
