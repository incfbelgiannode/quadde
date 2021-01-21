;;; Maxima interface to double exponential integration
; (c) Dimiter Prodanov
; 2021
(in-package :maxima)

(defvar *debug-quadde*
  nil
  "Set to non-NIL to enable printing of the error object when the
  intde routines throw an error.")

;; error checking similar to that done by $defint
(defun quadde_argument_check (exp var ll ul) 
  (setq exp (ratdisrep exp))
  (setq var (ratdisrep var))
  (setq ll (ratdisrep ll))
  (setq ul (ratdisrep ul))
  (cond (($constantp var)
	 (merror "Variable of integration not a variable: ~M"
		 var)))
  (cond ((not (or ($subvarp var) (atom var)))
	 (merror "Improper variable of integration: ~M" var))
	((or (among var ul)
	     (among var ll))
	 (merror "Limit contains variable of integration: ~M" var))))  
  

(defun quad-intde (fun var a b &key
		 (epsrel 1e-8)
		 (epsabs 0.0))
  (quadde_argument_check fun var a b) 
  
	(handler-case
	(multiple-value-bind ( i err )
		(quadde::intde (float-integrand-or-lose '$quad_intde fun var)
			 (float-or-lose a)
			 (float-or-lose b)
			 (float-or-lose epsrel)
			 (float-or-lose epsabs)
		)

	  (list '(mlist) i err))
	  (error (e)
	(when *debug-quadde*
	  (format t "~S" e))
	`(($quad_intde) ,fun ,var ,a ,b 
	  ((mequal) $epsrel ,epsrel)
	  ((mequal) $epsabs ,epsabs)
	 )
	  ))
)

(defun quad-intdei (fun var a  &key
		 (epsrel 1e-8)
		 (epsabs 0.0))
  (quadde_argument_check fun var a a) 
  
	(handler-case
	(multiple-value-bind ( i err )
		(quadde::intdei (float-integrand-or-lose '$quad_intdei fun var)
			 (float-or-lose a)
			 (float-or-lose epsrel)
			 (float-or-lose epsabs)
		)

	  (list '(mlist) i err))
	  (error (e)
	(when *debug-quadde*
	  (format t "~S" e))
	`(($quad_intdei) ,fun ,var ,a 
	  ((mequal) $epsrel ,epsrel)
	  ((mequal) $epsabs ,epsabs)
	 )
	  ))
)


(defun quad-intdeo (fun var a omega &key
		 (epsrel 1e-8)
		 (epsabs 0.0))
  (quadde_argument_check fun var a omega) 
  
	(handler-case
	(multiple-value-bind ( i err )
		(quadde::intdeo (float-integrand-or-lose '$quad_intdeo fun var)
			 (float-or-lose a)
			 (float-or-lose omega)
			 (float-or-lose epsrel)
			 (float-or-lose epsabs)
		)

	  (list '(mlist) i err))
	  (error (e)
	(when *debug-quadde*
	  (format t "~S" e))
	`(($quad_intdeo) ,fun ,var ,a ,omega 
	  ((mequal) $epsrel ,epsrel)
	  ((mequal) $epsabs ,epsabs)
	 )
	  ))
)	  
	  
(macrolet
    ((frob (mname iname args valid-keys)
       `(defun-checked ,mname ((,@args) ,@valid-keys)
	  ;; BIND EVIL SPECIAL VARIABLE *PLOT-REALPART* HERE ...
	  (let ((*plot-realpart* nil))
	    (declare (special *plot-realpart*))
	    (apply ',iname ,@args keylist)))))
  (frob $quad_intde quad-intde (fun var a b) ($epsrel $epsabs))
  (frob $quad_intdei quad-intdei (fun var a ) ($epsrel  $epsabs))
  (frob $quad_intdeo quad-intdeo (fun var a omega) ($epsrel  $epsabs))

 )