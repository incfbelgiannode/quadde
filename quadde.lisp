;;; Maxima interface to double exponential integration
;;  
; (c) Dimiter Prodanov
; version 1.1.1 6 Oct 2022
; - change in quad_intdeo
; version 1.1 13 March 2021
; - change in condition checking
; - compatibilty with Maxima 44
; version 1.0 23 Jan 2021
; updates in quadde_argument_check
; input from Michel Talon
;
; * M.Mori, Developments in the double exponential formula for numerical integration, Proceedings of the International Congress of Mathematicians, Kyoto 1990, 1991, Springer-Verlag, 1585-1594.
; * H.Takahasi and M.Mori, Double exponential formulas for numerical integration, Pub. RIMS Kyoto Univ. 9, 1974, 721-741
; * T.Ooura and M.Mori, The Double exponential formula for oscillatory functions over the half infinite interval, Journal of Computational and Applied Mathematics 38, 1991, 353-360
; * M.Mori and T.Ooura, Double exponential formulas for Fourier type integrals with a divergent integrand, Contributions in Numerical Mathematics, ed. R.P.Agarwal, World Scientific Series in Applicable Analysis, 2, 1993, 301-308
; * H.Toda and H.Ono, Some remarks for efficient usage of the double exponential formulas(in Japanese), Kokyuroku, RIMS, Kyoto Univ. 339, 1978, 74-109.
;
; 2021

(in-package :maxima)

(defvar *debug-quadde*
  NIL
  "Set to non-NIL to enable printing of the error object when the
  intde routines throw an error.")

(defun coerce-float-d (x) 
	 (coerce (maxima::$float (maxima::meval* x)) 'double-float)
)

;; error checking similar to that done by $defint
;; we don't really need to simplify 
(defun quadde_argument_check (expr var ll ul) 
  (cond (($constantp var)
	 (merror "Variable of integration not a variable: ~M"
		 var)))
  (cond (($subvarp var)
	 (merror "Improper variable of integration: ~M"
		 var)))
  (cond ( (not (atom var))
	 (merror "Variable of integration: ~M  not an atom"
		 var)))	
  (cond (($freeof var expr)
	 (merror "Variable ~M not in ~M"
		 var expr)))		  
   (cond ((or (among var ul) (among var ll))
	  (merror "Terminal contains variable of integration: ~M" var)))
   (cond ((not (and ($numberp (coerce-float-d ul)) ($numberp (coerce-float-d ll))))
	  (merror "Terminal not a number ~M , ~M" ll ul)))
)  



;; wrapper around intde
(defmfun $quad_intde (fun var a b &key
		 (epsrel 1e-8)
		 (epsabs 0.0))
  (quadde_argument_check fun var a b) 
  (let
  ( (f (coerce-float-fun fun)))	   
	(handler-case
	(flet ((ff ( x)
          (funcall f x)))
	(multiple-value-bind ( i err )
		(quadde::intde  #'ff
			 (float-or-lose a)
			 (float-or-lose b)
			 (float-or-lose epsrel)
			 (float-or-lose epsabs)
		)
	  (list '(mlist) i err))
	  )
	   (error (e)
	 (when *debug-quadde*
	   (format t "~S" e))
	 `(($quad_intde) ,fun ,var ,a ,b 
	   ((mequal) $epsrel ,epsrel)
	   ((mequal) $epsabs ,epsabs)
	  )
	  ))
	 )
)
 
;; wrapper around intdei
(defmfun $quad_intdei (fun var a  &key
		 (epsrel 1e-8)
		 (epsabs 0.0))
  (quadde_argument_check fun var a a) 
  (let
  ( (f (coerce-float-fun fun)))	   
	(handler-case
	(flet ((ff ( x)
          (funcall f x)))
	(multiple-value-bind ( i err )
		(quadde::intdei  #'ff
			 (float-or-lose a)
			 (float-or-lose epsrel)
			 (float-or-lose epsabs)
		)
	  (list '(mlist) i err))
	  )
	   (error (e)
	 (when *debug-quadde*
	   (format t "~S" e))
	 `(($quad_intdei) ,fun ,var ,a 
	   ((mequal) $epsrel ,epsrel)
	   ((mequal) $epsabs ,epsabs)
	  )
	  ))
	 )
)
 
;; wrapper around intdeo
(defmfun $quad_intdeo (fun var a omega &key
		 (epsrel 1e-8)
		 (epsabs 0.0))
  (quadde_argument_check fun var a omega) 
  (let
  ( (f (coerce-float-fun fun)))	   
	(handler-case
	(flet ((ff ( x)
          (funcall f x)))
	(multiple-value-bind ( i err )
		(quadde::intdeo  #'ff
			 (float-or-lose a)
			 (coerce-float-d omega)
			 (float-or-lose epsrel)
			 (float-or-lose epsabs)
		)
	  (list '(mlist) i err))
	  )
	   (error (e)
	 (when *debug-quadde*
	   (format t "~S" e))
	 `(($quad_intdeo) ,fun ,var ,a ,omega 
	   ((mequal) $epsrel ,epsrel)
	   ((mequal) $epsabs ,epsabs)
	  )
	  ))
	 )
)


	  