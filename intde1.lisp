;	Courtesy to Prof. Takuya Ooura
; 	Library for computation of speial functions
; 	and numerical integration
; 	
; The code is based mostly on
; http://www.kurims.kyoto-u.ac.jp/~ooura/intde.html
;  for the tanh-sinh (double exponential) method
;  
; Bibliography
; M.Mori, Developments in the double exponential formula for numerical integration, Proceedings of the International Congress of Mathematicians, Kyoto 1990, 1991, Springer-Verlag, 1585-1594.
; H.Takahasi and M.Mori, Double exponential formulas for numerical integration, Pub. RIMS Kyoto Univ. 9, 1974, 721-741
; T.Ooura and M.Mori, The Double exponential formula for oscillatory functions over the half infinite interval, Journal of Computational and Applied Mathematics 38, 1991, 353-360
; M.Mori and T.Ooura, Double exponential formulas for Fourier type integrals with a divergent integrand, Contributions in Numerical Mathematics, ed. R.P.Agarwal, World Scientific Series in Applicable Analysis, 2, 1993, 301-308
; H.Toda and H.Ono, Some remarks for efficient usage of the double exponential formulas(in Japanese), Kokyuroku, RIMS, Kyoto Univ. 339, 1978, 74-109.
 


;;; Compiled by f2cl version:
;;; ("f2cl1.l,v 95098eb54f13 2013/04/01 00:45:16 toy $"
;;;  "f2cl2.l,v 95098eb54f13 2013/04/01 00:45:16 toy $"
;;;  "f2cl3.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl4.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl5.l,v 95098eb54f13 2013/04/01 00:45:16 toy $"
;;;  "f2cl6.l,v 1d5cbacbb977 2008/08/24 00:56:27 rtoy $"
;;;  "macros.l,v 1409c1352feb 2013/03/24 20:44:50 toy $")

;;; Using Lisp SBCL 1.3.13
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format single-float))


(defpackage :quadde
   (:use :common-lisp :maxima)
   (:export :intde :intdei :intdeo :isnan)
)

(in-package :quadde)

(defun isnan (x)  (and (not (=   x  x))  ( typep x 'double-float) ))

; intde computes the  integral of f(x) over (a,b)
;
(defun intde (f a b eps err)
  (declare (type (double-float) err eps b a))
  (prog ((pi2 0.0d0) (epsln 0.0d0) (epsh 0.0d0) (h0 0.0d0) (ehp 0.0d0)
         (ehm 0.0d0) (epst 0.0d0) (ba 0.0d0) (ir 0.0d0) (h 0.0d0) (iback 0.0d0)
         (irback 0.0d0) (t$ 0.0d0) (ep 0.0d0) (em 0.0d0) (xw 0.0d0) (xa 0.0d0)
         (wg 0.0d0) (fa 0.0d0) (fb 0.0d0) (errt 0.0d0) (errh 0.0d0)
         (errd 0.0d0) (m 0) (efs 0.0d0) (hoff 0.0d0) (mmax 0) ( i 0.0d0))
    (declare (type (f2cl-lib:integer4) mmax m)
             (type (double-float) hoff efs errd errh errt fb fa wg xa xw em ep
              t$ irback iback h ir ba epst ehm ehp h0 epsh epsln pi2))
	
    (setf mmax 256)
    (setf efs 0.1d0)
    (setf hoff 8.5d0)
    (setf pi2 (* 2 (atan 1.0d0 1.0d0)))
    (setf epsln (- 1 (f2cl-lib:flog (* efs eps))))
    (setf epsh (f2cl-lib:fsqrt (* efs eps)))
    (setf h0 (/ hoff epsln))
    (setf ehp (exp h0))
    (setf ehm (/ 1 ehp))
    (setf epst (exp (* (- ehm) epsln)))
    (setf ba (- b a))
    (setf ir (* (funcall f (* (+ a b) 0.5d0)) (* ba 0.25d0)))
    (setf i (* ir (* 2 pi2)))
    (setf err (* (abs i) epst))
    (setf h (* 2 h0))
    (setf m 1)
   label10
    (setf iback i)
    (setf irback ir)
    (setf t$ (* h 0.5d0))
   label20
    (setf em (exp t$))
    (setf ep (* pi2 em))
    (setf em (/ pi2 em))
   label30
    (setf xw (/ 1 (+ 1 (exp (- ep em)))))
    (setf xa (* ba xw))
    (setf wg (* xa (- 1 xw)))
    (setf fa (* (funcall f (+ a xa)) wg))
    (setf fb (* (funcall f (- b xa)) wg))
	; check for nan
	(if (isnan fa)
		(setf fa 0.0d0))
	(if (isnan fb)
		(setf fb 0.0d0))
;	(cond ( (or (isnan fp) (isnan fm) )
;	  (maxima::merror "Terminal not a number ~M , ~M" fp fm)))
    (setf ir (+ ir (+ fa fb)))
    (setf i (+ i (* (+ fa fb) (+ ep em))))
    (setf errt (* (+ (abs fa) (abs fb)) (+ ep em)))
    (if (= m 1)
        (setf err (+ err (* errt epst))))
    (setf ep (* ep ehp))
    (setf em (* em ehm))
    (if (or (> errt err) (> xw epsh))
        (go label30))
    (setf t$ (+ t$ h))
    (if (< t$ h0)
        (go label20))
    (cond
     ((= m 1) (setf errh (* (/ err epst) epsh h0))
      (setf errd (+ 1 (* 2 errh))))
     (t
      (setf errd
              (* h
                 (+ (abs (- i (* 2 iback)))
                    (* 4 (abs (- ir (* 2 irback)))))))))
    (setf h (* h 0.5d0))
    (setf m (f2cl-lib:int-mul m 2))
    (if (and (> errd errh) (< m mmax))
        (go label10))
    (setf i (* i h))
    (cond ((> errd errh) (setf err (* (- errd) m)))
          (t (setf err (/ (* errh epsh m) (* 2 efs)))))
   end_label
    (return (values  i err))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::intde fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '(t (double-float) (double-float)
                                              (double-float) 
                                              (double-float))
                                            :return-values
                                            '(
                                              fortran-to-lisp::i
                                              fortran-to-lisp::err)
                                            :calls 'nil)))

;;; Compiled by f2cl version:
;;; ("f2cl1.l,v 95098eb54f13 2013/04/01 00:45:16 toy $"
;;;  "f2cl2.l,v 95098eb54f13 2013/04/01 00:45:16 toy $"
;;;  "f2cl3.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl4.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl5.l,v 95098eb54f13 2013/04/01 00:45:16 toy $"
;;;  "f2cl6.l,v 1d5cbacbb977 2008/08/24 00:56:27 rtoy $"
;;;  "macros.l,v 1409c1352feb 2013/03/24 20:44:50 toy $")

;;; Using Lisp SBCL 1.3.13
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format single-float))

(in-package :quadde)

;intdei computes the integral of f(x) over (a,infinity), 
;	            f(x) has no oscillatory factor!
;	f(x) needs to be analytic over (a,infinity).
	
(defun intdei (f a eps err)
  (declare (type (double-float) err eps a))
  (prog ((pi4 0.0d0) (epsln 0.0d0) (epsh 0.0d0) (h0 0.0d0) (ehp 0.0d0)
         (ehm 0.0d0) (epst 0.0d0) (ir 0.0d0) (h 0.0d0) (iback 0.0d0)
         (irback 0.0d0) (t$ 0.0d0) (ep 0.0d0) (em 0.0d0) (xp 0.0d0) (xm 0.0d0)
         (fp 0.0d0) (fm 0.0d0) (errt 0.0d0) (errh 0.0d0) (errd 0.0d0) (m 0)
         (efs 0.0d0) (hoff 0.0d0) (mmax 0) (i 0.0d0) )
    (declare (type (f2cl-lib:integer4) mmax m)
             (type (double-float) hoff efs errd errh errt fm fp xm xp em ep t$
              irback iback h ir epst ehm ehp h0 epsh epsln pi4))
    (setf mmax 256)
    (setf efs 0.1d0)
    (setf hoff 11.0d0)
    (setf pi4 (atan 1.0d0 1.0d0))
    (setf epsln (- 1 (f2cl-lib:flog (* efs eps))))
    (setf epsh (f2cl-lib:fsqrt (* efs eps)))
    (setf h0 (/ hoff epsln))
    (setf ehp (exp h0))
    (setf ehm (/ 1 ehp))
    (setf epst (exp (* (- ehm) epsln)))
    (setf ir (funcall f (+ a 1)))
    (setf i (* ir (* 2 pi4)))
    (setf err (* (abs i) epst))
    (setf h (* 2 h0))
    (setf m 1)
   label10
    (setf iback i)
    (setf irback ir)
    (setf t$ (* h 0.5d0))
   label20
    (setf em (exp t$))
    (setf ep (* pi4 em))
    (setf em (/ pi4 em))
   label30
    (setf xp (exp (- ep em)))
    (setf xm (/ 1 xp))
    (setf fp (* (funcall f (+ a xp)) xp))
    (setf fm (* (funcall f (+ a xm)) xm))
		; check for nan
	(if (isnan fp)
		(setf fp 0.0d0))
	(if (isnan fm)
		(setf fm 0.0d0))
;	(cond ( (or (isnan fp) (isnan fm) )
;	  (maxima::merror "Terminal not a number ~M , ~M" fp fm)))
    (setf ir (+ ir (+ fp fm)))
    (setf i (+ i (* (+ fp fm) (+ ep em))))
    (setf errt (* (+ (abs fp) (abs fm)) (+ ep em)))
    (if (= m 1)
        (setf err (+ err (* errt epst))))
    (setf ep (* ep ehp))
    (setf em (* em ehm))
    (if (or (> errt err) (> xm epsh))
        (go label30))
    (setf t$ (+ t$ h))
    (if (< t$ h0)
        (go label20))
    (cond
     ((= m 1) (setf errh (* (/ err epst) epsh h0))
      (setf errd (+ 1 (* 2 errh))))
     (t
      (setf errd
              (* h
                 (+ (abs (- i (* 2 iback)))
                    (* 4 (abs (- ir (* 2 irback)))))))))
    (setf h (* h 0.5d0))
    (setf m (f2cl-lib:int-mul m 2))
    (if (and (> errd errh) (< m mmax))
        (go label10))
    (setf i (* i h))
    (cond ((> errd errh) (setf err (* (- errd) m)))
          (t (setf err (/ (* errh epsh m) (* 2 efs)))))
   end_label
    (return (values i err))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::intdei
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '(t (double-float) 
                                              (double-float) (double-float))
                                            :return-values
                                            '(fortran-to-lisp::i
                                              fortran-to-lisp::err)
                                            :calls 'nil)))

;;; Compiled by f2cl version:
;;; ("f2cl1.l,v 95098eb54f13 2013/04/01 00:45:16 toy $"
;;;  "f2cl2.l,v 95098eb54f13 2013/04/01 00:45:16 toy $"
;;;  "f2cl3.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl4.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl5.l,v 95098eb54f13 2013/04/01 00:45:16 toy $"
;;;  "f2cl6.l,v 1d5cbacbb977 2008/08/24 00:56:27 rtoy $"
;;;  "macros.l,v 1409c1352feb 2013/03/24 20:44:50 toy $")

;;; Using Lisp SBCL 1.3.13
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format single-float))

(in-package :quadde)

;intdeo computes the integral of f(x) over (a, infinity), 
;            f(x) has an oscillatory factor :
;            f(x) = g(x) * sin(omega * x + theta) as x -> infinity.
			
(defun intdeo (f a omega eps err)
  (declare (type (double-float) err eps omega a))
  (prog ((pi4 0.0d0) (epsln 0.0d0) (epsh 0.0d0) (frq4 0.0d0) (per2 0.0d0)
         (pp 0.0d0) (pq 0.0d0) (ehp 0.0d0) (ehm 0.0d0) (ir 0.0d0) (h 0.0d0)
         (iback 0.0d0) (irback 0.0d0) (t$ 0.0d0) (ep 0.0d0) (em 0.0d0)
         (tk 0.0d0) (xw 0.0d0) (wg 0.0d0) (xa 0.0d0) (fp 0.0d0) (fm 0.0d0)
         (errh 0.0d0) (tn 0.0d0) (errd 0.0d0) (n 0) (m 0) (l 0) (k 0)
         (efs 0.0d0) (enoff 0.0d0) (pqoff 0.0d0) (ppoff 0.0d0) (mmax 0)
         (lmax 0) (i 0.0d0))
    (declare (type (f2cl-lib:integer4) lmax mmax k l m n)
             (type (double-float) ppoff pqoff enoff efs errd tn errh fm fp xa
              wg xw tk em ep t$ irback iback h ir ehm ehp pq pp per2 frq4 epsh
              epsln pi4))
    (setf mmax 256)
    (setf lmax 5)
    (setf efs 0.1d0)
    (setf enoff 0.4d0)
    (setf pqoff 2.9d0)
    (setf ppoff -0.72d0)
    (setf pi4 (atan 1.0d0 1.0d0))
    (setf epsln (- 1 (f2cl-lib:flog (* efs eps))))
    (setf epsh (f2cl-lib:fsqrt (* efs eps)))
    (setf n (f2cl-lib:int (* enoff epsln)))
    (setf frq4 (/ (abs omega) (* 2 pi4)))
    (setf per2 (/ (* 4 pi4) (abs omega)))
    (setf pq (/ pqoff epsln))
    (setf pp (- ppoff (f2cl-lib:flog (* pq pq frq4))))
    (setf ehp (exp (* 2 pq)))
    (setf ehm (/ 1 ehp))
    (setf xw (exp (- pp (* 2 pi4))))
    (setf i (funcall f (+ a (f2cl-lib:fsqrt (* xw (* per2 0.5d0))))))
    (setf ir (* i xw))
    (setf i (* i (* per2 0.5d0)))
    (setf err (abs i))
    (setf h (coerce (the f2cl-lib:integer4 2) 'double-float))
    (setf m 1)
   label10
    (setf iback i)
    (setf irback ir)
    (setf t$ (* h 0.5d0))
   label20
    (setf em (exp (* 2 pq t$)))
    (setf ep (* pi4 em))
    (setf em (/ pi4 em))
    (setf tk t$)
   label30
    (setf xw (exp (- pp ep em)))
    (setf wg (f2cl-lib:fsqrt (+ (* frq4 xw) (* tk tk))))
    (setf xa (/ xw (+ tk wg)))
    (setf wg (/ (+ (* pq xw (- ep em)) xa) wg))
    (setf fm (funcall f (+ a xa)))
    (setf fp (funcall f (+ a xa (* per2 tk))))
	; check for nan
	(if (isnan fp)
		(setf fp 0.0d0))
	(if (isnan fm)
		(setf fm 0.0d0))
;	(cond ( (or (isnan fp) (isnan fm) )
;	  (maxima::merror "Function does not return a number ~M , ~M" fp fm)))
		
    (setf ir (+ ir (* (+ fp fm) xw)))
    (setf fm (* fm wg))
    (setf fp (* fp (- per2 wg)))
    (setf i (+ i (+ fp fm)))
    (if (= m 1)
        (setf err (+ err (+ (abs fp) (abs fm)))))
    (setf ep (* ep ehp))
    (setf em (* em ehm))
    (setf tk (+ tk 1))
    (if (< ep epsln)
        (go label30))
    (cond ((= m 1) (setf errh (* err epsh)) (setf err (* err eps))))
    (setf tn tk)
   label100000
    (if (not (> (abs fm) err))
        (go label100001))
    (setf xw (exp (- pp ep em)))
    (setf xa (* (/ xw tk) 0.5d0))
    (setf wg (* xa (+ (/ 1 tk) (* 2 pq (- ep em)))))
    (setf fm (funcall f (+ a xa)))
    (setf ir (+ ir (* fm xw)))
    (setf fm (* fm wg))
    (setf i (+ i fm))
    (setf ep (* ep ehp))
    (setf em (* em ehm))
    (setf tk (+ tk 1))
    (go label100000)
   label100001
    (setf fm (funcall f (+ a (* per2 tn))))
    (setf em (* per2 fm))
    (setf i (+ i em))
    (cond
     ((or (> (abs fp) err) (> (abs em) err))
      (tagbody
        (setf l 0)
       label40
        (setf l (f2cl-lib:int-add l 1))
        (setf tn (+ tn n))
        (setf em fm)
        (setf fm (funcall f (+ a (* per2 tn))))
        (setf xa fm)
        (setf ep fm)
        (setf em (+ em fm))
        (setf xw (coerce (the f2cl-lib:integer4 1) 'double-float))
        (setf wg (coerce (the f2cl-lib:integer4 1) 'double-float))
        (f2cl-lib:fdo (k 1 (f2cl-lib:int-add k 1))
                      ((> k (f2cl-lib:int-add n (f2cl-lib:int-sub 1))) nil)
          (tagbody
            (setf xw (/ (* xw (f2cl-lib:int-sub (f2cl-lib:int-add n 1) k)) k))
            (setf wg (+ wg xw))
            (setf fp (funcall f (+ a (* per2 (- tn k)))))
            (setf xa (+ xa fp))
            (setf ep (+ ep (* fp wg)))
            (setf em (+ em (* fp xw)))
           label100002))
        (setf wg (/ (* per2 n) (+ (* wg n) xw)))
        (setf em (* wg (abs em)))
        (if (or (<= em err) (>= l lmax))
            (go label50))
        (setf i (+ i (* per2 xa)))
        (go label40)
       label50
        (setf i (+ i (* wg ep)))
        (if (> em err)
            (setf err em)))))
    (setf t$ (+ t$ h))
    (if (< t$ 1)
        (go label20))
    (cond ((= m 1) (setf errd (+ 1 (* 2 errh))))
          (t
           (setf errd
                   (* h
                      (+ (abs (- i (* 2 iback)))
                         (* pq (abs (- ir (* 2 irback)))))))))
    (setf h (* h 0.5d0))
    (setf m (f2cl-lib:int-mul m 2))
    (if (and (> errd errh) (< m mmax))
        (go label10))
    (setf i (* i h))
    (cond ((> errd errh) (setf err (- errd)))
          (t (setf err (* err (* m 0.5d0)))))
   end_label
    (return (values  i err))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::intdeo
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '(t (double-float) (double-float)
                                              (double-float) 
                                              (double-float))
                                            :return-values
                                            '(
                                              fortran-to-lisp::i
                                              fortran-to-lisp::err)
                                            :calls 'nil)))
