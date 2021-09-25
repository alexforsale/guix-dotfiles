(define-module (home modules shell)
  #:use-module (guix gexp)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (gnu home-services)
  #:use-module (gnu home-services-utils)
  #:use-module (gnu home-services shells)
  #:use-module (gnu home-services shellutils))

(define-public zsh-services
  (list
   (service home-zsh-service-type
	    (home-zsh-configuration
	     (xdg-flavor? #t)
	     (environment-variables
	      '(("EDITOR" . "\"emacsclient -a ''\"")
		("XCURSOR_THEME" . "Nordzy-cursors")
		("GUIX_LOCPATH" . "$HOME/.guix-profile/lib/locale")
		("SSL_CERT_DIR" . "$HOME/.guix-home/profile/etc/ssl/certs")
		("SSL_CERT_FILE" . "$HOME/.guix-home/profile/etc/ssl/certs/ca-certificates.crt")
		("GIT_SSL_CAINFO" . "$SSL_CERT_FILE")
		("GEM_PATH" . "$HOME/.local/share/gem")
		("_JAVA_AWT_WM_NONREPARENTING" . "1")))
	     (zshrc
	      (list (slurp-file-gexp (local-file "../files/zshrc"))))))
   (service home-zsh-autosuggestions-service-type)
   (service home-zsh-direnv-service-type)
   (simple-service 'login-variables
		   home-environment-variables-service-type
		   `(;; ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:/usr/local/share/:/usr/share/")
		     ;; ("XDG_CONFIG_DIRS" . "$XDG_CONFIG_DIRS:/etc/xdg/")
		     ;; ("XDG_DATA_DIRS" . "$HOME/.guix-home/profile/share:$XDG_DATA_DIRS")
		     ;; ("XDG_CONFIG_DIRS" . "$HOME/.guix-home/profile/etc/xdg:$XDG_CONFIG_DIRS")
		     ("GUILE_LOAD_PATH" . "$XDG_CONFIG_HOME/guix/current/share/guile/site/3.0:$GUILE_LOAD_PATH")
		     ("GUILE_LOAD_COMPILED_PATH" . "$XDG_CONFIG_HOME/guix/current/lib/guile/3.0/site-ccache:$GUILE_LOAD_COMPILED_PATH")
		     ("PATH" . "$HOME/.local/bin/:$PATH")
		     ;; ("GUIX_PROFILE=\"$HOME/.guix-profile\"" . #f)
		     ;; [ -f "$GUIX_PROFILE/etc/profile" ] && . "$GUIX_PROFILE/etc/profile"
		     ))))
