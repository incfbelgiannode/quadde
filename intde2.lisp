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

(in-package :common-lisp-user)


(defun intdeini (lenaw tiny eps aw)
  (declare (type (array double-float (*)) aw)
           (type (double-float) eps tiny)
           (type (f2cl-lib:integer4) lenaw))
  (f2cl-lib:with-multi-array-data
      ((aw double-float aw-%data% aw-%offset%))
    (prog ((pi2 0.0d0) (tinyln 0.0d0) (epsln 0.0d0) (h0 0.0d0) (ehp 0.0d0)
           (ehm 0.0d0) (h 0.0d0) (t$ 0.0d0) (ep 0.0d0) (em 0.0d0) (xw 0.0d0)
           (wg 0.0d0) (noff 0) (nk 0) (k 0) (j 0) (efs 0.0d0) (hoff 0.0d0))
      (declare (type (f2cl-lib:integer4) j k nk noff)
               (type (double-float) hoff efs wg xw em ep t$ h ehm ehp h0 epsln
                tinyln pi2))
      (setf efs 0.1d0)
      (setf hoff 8.5d0)
      (setf pi2 (* 2 (atan 1.0d0)))
      (setf tinyln (- (f2cl-lib:flog tiny)))
      (setf epsln (- 1 (f2cl-lib:flog (* efs eps))))
      (setf h0 (/ hoff epsln))
      (setf ehp (exp h0))
      (setf ehm (/ 1 ehp))
      (setf (f2cl-lib:fref aw-%data% (2)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              eps)
      (setf (f2cl-lib:fref aw-%data% (3)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (exp (* (- ehm) epsln)))
      (setf (f2cl-lib:fref aw-%data% (4)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (f2cl-lib:fsqrt (* efs eps)))
      (setf noff 5)
      (setf (f2cl-lib:fref aw-%data% (noff)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              0.5d0)
      (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add noff 1))
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              h0)
      (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add noff 2))
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (* pi2 h0 0.5d0))
      (setf h (coerce (the f2cl-lib:integer4 2) 'double-float))
      (setf nk 0)
      (setf k (f2cl-lib:int-add noff 3))
     label10
      (setf t$ (* h 0.5d0))
     label20
      (setf em (exp (* h0 t$)))
      (setf ep (* pi2 em))
      (setf em (/ pi2 em))
      (setf j k)
     label30
      (setf xw (/ 1 (+ 1 (exp (- ep em)))))
      (setf wg (* xw (- 1 xw) h0))
      (setf (f2cl-lib:fref aw-%data% (j)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              xw)
      (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1))
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (* wg 4))
      (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2))
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (* wg (+ ep em)))
      (setf ep (* ep ehp))
      (setf em (* em ehm))
      (setf j (f2cl-lib:int-add j 3))
      (if (and (< ep tinyln) (<= j (f2cl-lib:int-sub lenaw 3)))
          (go label30))
      (setf t$ (+ t$ h))
      (setf k (f2cl-lib:int-add k nk))
      (if (< t$ 1)
          (go label20))
      (setf h (* h 0.5d0))
      (cond
       ((= nk 0)
        (if (> j (f2cl-lib:int-sub lenaw 6))
            (setf j (f2cl-lib:int-sub j 3)))
        (setf nk (f2cl-lib:int-sub j noff)) (setf k (f2cl-lib:int-add k nk))
        (setf (f2cl-lib:fref aw-%data% (1)
                             ((0
                               (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                             aw-%offset%)
                (coerce (the f2cl-lib:integer4 nk) 'double-float))))
      (if (<= (f2cl-lib:int-sub (f2cl-lib:int-mul 2 k) noff 3) lenaw)
          (go label10))
      (setf (f2cl-lib:fref aw-%data% (0)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (coerce (the f2cl-lib:integer4 (f2cl-lib:int-sub k 3))
                      'double-float))
     end_label
      (return (values nil nil nil nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::intdeini
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (double-float) (double-float)
                                              (array double-float (*)))
                                            :return-values '(nil nil nil nil)
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

(in-package :common-lisp-user)


(defun intde2 (f a b aw i err)
  (declare (type (array double-float (*)) aw)
           (type (double-float) err i b a))
  (f2cl-lib:with-multi-array-data
      ((aw double-float aw-%data% aw-%offset%))
    (prog ((epsh 0.0d0) (ba 0.0d0) (ir 0.0d0) (xa 0.0d0) (fa 0.0d0) (fb 0.0d0)
           (errt 0.0d0) (errh 0.0d0) (errd 0.0d0) (h 0.0d0) (iback 0.0d0)
           (irback 0.0d0) (noff 0) (lenawm 0) (nk 0) (k 0) (j 0) (jtmp 0)
           (jm 0) (m 0) (klim 0))
      (declare (type (f2cl-lib:integer4) klim m jm jtmp j k nk lenawm noff)
               (type (double-float) irback iback h errd errh errt fb fa xa ir
                ba epsh))
      (setf noff 5)
      (setf lenawm
              (f2cl-lib:int
               (+ (f2cl-lib:fref aw-%data% (0) ((0 *)) aw-%offset%) 0.5d0)))
      (setf nk
              (f2cl-lib:int
               (+ (f2cl-lib:fref aw-%data% (1) ((0 *)) aw-%offset%) 0.5d0)))
      (setf epsh (f2cl-lib:fref aw-%data% (4) ((0 *)) aw-%offset%))
      (setf ba (- b a))
      (setf i
              (funcall f
                       (* (+ a b)
                          (f2cl-lib:fref aw-%data% (noff) ((0 *))
                                         aw-%offset%))))
      (setf ir
              (* i
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add noff 1)) ((0 *))
                                aw-%offset%)))
      (setf i
              (* i
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add noff 2)) ((0 *))
                                aw-%offset%)))
      (setf err (abs i))
      (setf k (f2cl-lib:int-add nk noff))
      (setf j noff)
     label10
      (setf j (f2cl-lib:int-add j 3))
      (setf xa (* ba (f2cl-lib:fref aw-%data% (j) ((0 *)) aw-%offset%)))
      (setf fa (funcall f (+ a xa)))
      (setf fb (funcall f (- b xa)))
      (setf ir
              (+ ir
                 (* (+ fa fb)
                    (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1)) ((0 *))
                                   aw-%offset%))))
      (setf fa
              (* fa
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2)) ((0 *))
                                aw-%offset%)))
      (setf fb
              (* fb
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2)) ((0 *))
                                aw-%offset%)))
      (setf i (+ i (+ fa fb)))
      (setf err (+ err (+ (abs fa) (abs fb))))
      (if (and (> (f2cl-lib:fref aw-%data% (j) ((0 *)) aw-%offset%) epsh)
               (< j k))
          (go label10))
      (setf errt (* err (f2cl-lib:fref aw-%data% (3) ((0 *)) aw-%offset%)))
      (setf errh (* err epsh))
      (setf errd (+ 1 (* 2 errh)))
      (setf jtmp j)
     label100000
      (if (not (and (> (abs fa) errt) (< j k)))
          (go label100001))
      (setf j (f2cl-lib:int-add j 3))
      (setf fa
              (funcall f
                       (+ a
                          (* ba
                             (f2cl-lib:fref aw-%data% (j) ((0 *))
                                            aw-%offset%)))))
      (setf ir
              (+ ir
                 (* fa
                    (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1)) ((0 *))
                                   aw-%offset%))))
      (setf fa
              (* fa
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2)) ((0 *))
                                aw-%offset%)))
      (setf i (+ i fa))
      (go label100000)
     label100001
      (setf jm j)
      (setf j jtmp)
     label100002
      (if (not (and (> (abs fb) errt) (< j k)))
          (go label100003))
      (setf j (f2cl-lib:int-add j 3))
      (setf fb
              (funcall f
                       (- b
                          (* ba
                             (f2cl-lib:fref aw-%data% (j) ((0 *))
                                            aw-%offset%)))))
      (setf ir
              (+ ir
                 (* fb
                    (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1)) ((0 *))
                                   aw-%offset%))))
      (setf fb
              (* fb
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2)) ((0 *))
                                aw-%offset%)))
      (setf i (+ i fb))
      (go label100002)
     label100003
      (if (< j jm)
          (setf jm j))
      (setf jm (f2cl-lib:int-sub jm (f2cl-lib:int-add noff 3)))
      (setf h (coerce (the f2cl-lib:integer4 1) 'double-float))
      (setf m 1)
      (setf klim (f2cl-lib:int-add k nk))
     label100004
      (if (not (and (> errd errh) (<= klim lenawm)))
          (go label100005))
      (setf iback i)
      (setf irback ir)
     label20
      (setf jtmp (f2cl-lib:int-add k jm))
      (f2cl-lib:fdo (j (f2cl-lib:int-add k 3) (f2cl-lib:int-add j 3))
                    ((> j jtmp) nil)
        (tagbody
          (setf xa (* ba (f2cl-lib:fref aw-%data% (j) ((0 *)) aw-%offset%)))
          (setf fa (funcall f (+ a xa)))
          (setf fb (funcall f (- b xa)))
          (setf ir
                  (+ ir
                     (* (+ fa fb)
                        (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1))
                                       ((0 *)) aw-%offset%))))
          (setf i
                  (+ i
                     (* (+ fa fb)
                        (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2))
                                       ((0 *)) aw-%offset%))))
         label100006))
      (setf k (f2cl-lib:int-add k nk))
      (setf j jtmp)
     label30
      (setf j (f2cl-lib:int-add j 3))
      (setf fa
              (funcall f
                       (+ a
                          (* ba
                             (f2cl-lib:fref aw-%data% (j) ((0 *))
                                            aw-%offset%)))))
      (setf ir
              (+ ir
                 (* fa
                    (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1)) ((0 *))
                                   aw-%offset%))))
      (setf fa
              (* fa
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2)) ((0 *))
                                aw-%offset%)))
      (setf i (+ i fa))
      (if (and (> (abs fa) errt) (< j k))
          (go label30))
      (setf j jtmp)
     label40
      (setf j (f2cl-lib:int-add j 3))
      (setf fb
              (funcall f
                       (- b
                          (* ba
                             (f2cl-lib:fref aw-%data% (j) ((0 *))
                                            aw-%offset%)))))
      (setf ir
              (+ ir
                 (* fb
                    (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1)) ((0 *))
                                   aw-%offset%))))
      (setf fb
              (* fb
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2)) ((0 *))
                                aw-%offset%)))
      (setf i (+ i fb))
      (if (and (> (abs fb) errt) (< j k))
          (go label40))
      (if (< k klim)
          (go label20))
      (setf errd (* h (+ (abs (- i (* 2 iback))) (abs (- ir (* 2 irback))))))
      (setf h (* h 0.5d0))
      (setf m (f2cl-lib:int-mul m 2))
      (setf klim (f2cl-lib:int-sub (f2cl-lib:int-mul 2 klim) noff))
      (go label100004)
     label100005
      (setf i (* i (* h ba)))
      (cond ((> errd errh) (setf err (* (- errd) (* m (abs ba)))))
            (t
             (setf err
                     (* err (f2cl-lib:fref aw-%data% (2) ((0 *)) aw-%offset%)
                        (* m (abs ba))))))
     end_label
      (return (values nil nil nil nil i err)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::intde fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '(t (double-float) (double-float)
                                              (array double-float (*))
                                              (double-float) (double-float))
                                            :return-values
                                            '(nil nil nil nil
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

(in-package :common-lisp-user)


(defun intdeiini (lenaw tiny eps aw)
  (declare (type (array double-float (*)) aw)
           (type (double-float) eps tiny)
           (type (f2cl-lib:integer4) lenaw))
  (f2cl-lib:with-multi-array-data
      ((aw double-float aw-%data% aw-%offset%))
    (prog ((pi4 0.0d0) (tinyln 0.0d0) (epsln 0.0d0) (h0 0.0d0) (ehp 0.0d0)
           (ehm 0.0d0) (h 0.0d0) (t$ 0.0d0) (ep 0.0d0) (em 0.0d0) (xp 0.0d0)
           (xm 0.0d0) (wp 0.0d0) (wm 0.0d0) (noff 0) (nk 0) (k 0) (j 0)
           (efs 0.0d0) (hoff 0.0d0))
      (declare (type (f2cl-lib:integer4) j k nk noff)
               (type (double-float) hoff efs wm wp xm xp em ep t$ h ehm ehp h0
                epsln tinyln pi4))
      (setf efs 0.1d0)
      (setf hoff 11.0d0)
      (setf pi4 (atan 1.0d0))
      (setf tinyln (- (f2cl-lib:flog tiny)))
      (setf epsln (- 1 (f2cl-lib:flog (* efs eps))))
      (setf h0 (/ hoff epsln))
      (setf ehp (exp h0))
      (setf ehm (/ 1 ehp))
      (setf (f2cl-lib:fref aw-%data% (2)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              eps)
      (setf (f2cl-lib:fref aw-%data% (3)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (exp (* (- ehm) epsln)))
      (setf (f2cl-lib:fref aw-%data% (4)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (f2cl-lib:fsqrt (* efs eps)))
      (setf noff 5)
      (setf (f2cl-lib:fref aw-%data% (noff)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (coerce (the f2cl-lib:integer4 1) 'double-float))
      (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add noff 1))
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (* 4 h0))
      (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add noff 2))
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (* 2 pi4 h0))
      (setf h (coerce (the f2cl-lib:integer4 2) 'double-float))
      (setf nk 0)
      (setf k (f2cl-lib:int-add noff 6))
     label10
      (setf t$ (* h 0.5d0))
     label20
      (setf em (exp (* h0 t$)))
      (setf ep (* pi4 em))
      (setf em (/ pi4 em))
      (setf j k)
     label30
      (setf xp (exp (- ep em)))
      (setf xm (/ 1 xp))
      (setf wp (* xp (* (+ ep em) h0)))
      (setf wm (* xm (* (+ ep em) h0)))
      (setf (f2cl-lib:fref aw-%data% (j)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              xm)
      (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1))
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              xp)
      (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2))
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (* xm (* 4 h0)))
      (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 3))
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (* xp (* 4 h0)))
      (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 4))
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              wm)
      (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 5))
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              wp)
      (setf ep (* ep ehp))
      (setf em (* em ehm))
      (setf j (f2cl-lib:int-add j 6))
      (if (and (< ep tinyln) (<= j (f2cl-lib:int-sub lenaw 6)))
          (go label30))
      (setf t$ (+ t$ h))
      (setf k (f2cl-lib:int-add k nk))
      (if (< t$ 1)
          (go label20))
      (setf h (* h 0.5d0))
      (cond
       ((= nk 0)
        (if (> j (f2cl-lib:int-sub lenaw 12))
            (setf j (f2cl-lib:int-sub j 6)))
        (setf nk (f2cl-lib:int-sub j noff)) (setf k (f2cl-lib:int-add k nk))
        (setf (f2cl-lib:fref aw-%data% (1)
                             ((0
                               (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                             aw-%offset%)
                (coerce (the f2cl-lib:integer4 nk) 'double-float))))
      (if (<= (f2cl-lib:int-sub (f2cl-lib:int-mul 2 k) noff 6) lenaw)
          (go label10))
      (setf (f2cl-lib:fref aw-%data% (0)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (coerce (the f2cl-lib:integer4 (f2cl-lib:int-sub k 6))
                      'double-float))
     end_label
      (return (values nil nil nil nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::intdeiini
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (double-float) (double-float)
                                              (array double-float (*)))
                                            :return-values '(nil nil nil nil)
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

(in-package :common-lisp-user)


(defun intdei2 (f a aw i err)
  (declare (type (array double-float (*)) aw)
           (type (double-float) err i a))
  (f2cl-lib:with-multi-array-data
      ((aw double-float aw-%data% aw-%offset%))
    (prog ((epsh 0.0d0) (ir 0.0d0) (fp 0.0d0) (fm 0.0d0) (errt 0.0d0)
           (errh 0.0d0) (errd 0.0d0) (h 0.0d0) (iback 0.0d0) (irback 0.0d0)
           (noff 0) (lenawm 0) (nk 0) (k 0) (j 0) (jtmp 0) (jm 0) (m 0)
           (klim 0))
      (declare (type (f2cl-lib:integer4) klim m jm jtmp j k nk lenawm noff)
               (type (double-float) irback iback h errd errh errt fm fp ir
                epsh))
      (setf noff 5)
      (setf lenawm
              (f2cl-lib:int
               (+ (f2cl-lib:fref aw-%data% (0) ((0 *)) aw-%offset%) 0.5d0)))
      (setf nk
              (f2cl-lib:int
               (+ (f2cl-lib:fref aw-%data% (1) ((0 *)) aw-%offset%) 0.5d0)))
      (setf epsh (f2cl-lib:fref aw-%data% (4) ((0 *)) aw-%offset%))
      (setf i
              (funcall f
                       (+ a
                          (f2cl-lib:fref aw-%data% (noff) ((0 *))
                                         aw-%offset%))))
      (setf ir
              (* i
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add noff 1)) ((0 *))
                                aw-%offset%)))
      (setf i
              (* i
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add noff 2)) ((0 *))
                                aw-%offset%)))
      (setf err (abs i))
      (setf k (f2cl-lib:int-add nk noff))
      (setf j noff)
     label10
      (setf j (f2cl-lib:int-add j 6))
      (setf fm
              (funcall f
                       (+ a
                          (f2cl-lib:fref aw-%data% (j) ((0 *)) aw-%offset%))))
      (setf fp
              (funcall f
                       (+ a
                          (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1))
                                         ((0 *)) aw-%offset%))))
      (setf ir
              (+ ir
                 (+
                  (* fm
                     (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2)) ((0 *))
                                    aw-%offset%))
                  (* fp
                     (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 3)) ((0 *))
                                    aw-%offset%)))))
      (setf fm
              (* fm
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 4)) ((0 *))
                                aw-%offset%)))
      (setf fp
              (* fp
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 5)) ((0 *))
                                aw-%offset%)))
      (setf i (+ i (+ fm fp)))
      (setf err (+ err (+ (abs fm) (abs fp))))
      (if (and (> (f2cl-lib:fref aw-%data% (j) ((0 *)) aw-%offset%) epsh)
               (< j k))
          (go label10))
      (setf errt (* err (f2cl-lib:fref aw-%data% (3) ((0 *)) aw-%offset%)))
      (setf errh (* err epsh))
      (setf errd (+ 1 (* 2 errh)))
      (setf jtmp j)
     label100000
      (if (not (and (> (abs fm) errt) (< j k)))
          (go label100001))
      (setf j (f2cl-lib:int-add j 6))
      (setf fm
              (funcall f
                       (+ a
                          (f2cl-lib:fref aw-%data% (j) ((0 *)) aw-%offset%))))
      (setf ir
              (+ ir
                 (* fm
                    (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2)) ((0 *))
                                   aw-%offset%))))
      (setf fm
              (* fm
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 4)) ((0 *))
                                aw-%offset%)))
      (setf i (+ i fm))
      (go label100000)
     label100001
      (setf jm j)
      (setf j jtmp)
     label100002
      (if (not (and (> (abs fp) errt) (< j k)))
          (go label100003))
      (setf j (f2cl-lib:int-add j 6))
      (setf fp
              (funcall f
                       (+ a
                          (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1))
                                         ((0 *)) aw-%offset%))))
      (setf ir
              (+ ir
                 (* fp
                    (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 3)) ((0 *))
                                   aw-%offset%))))
      (setf fp
              (* fp
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 5)) ((0 *))
                                aw-%offset%)))
      (setf i (+ i fp))
      (go label100002)
     label100003
      (if (< j jm)
          (setf jm j))
      (setf jm (f2cl-lib:int-sub jm (f2cl-lib:int-add noff 6)))
      (setf h (coerce (the f2cl-lib:integer4 1) 'double-float))
      (setf m 1)
      (setf klim (f2cl-lib:int-add k nk))
     label100004
      (if (not (and (> errd errh) (<= klim lenawm)))
          (go label100005))
      (setf iback i)
      (setf irback ir)
     label20
      (setf jtmp (f2cl-lib:int-add k jm))
      (f2cl-lib:fdo (j (f2cl-lib:int-add k 6) (f2cl-lib:int-add j 6))
                    ((> j jtmp) nil)
        (tagbody
          (setf fm
                  (funcall f
                           (+ a
                              (f2cl-lib:fref aw-%data% (j) ((0 *))
                                             aw-%offset%))))
          (setf fp
                  (funcall f
                           (+ a
                              (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1))
                                             ((0 *)) aw-%offset%))))
          (setf ir
                  (+ ir
                     (+
                      (* fm
                         (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2))
                                        ((0 *)) aw-%offset%))
                      (* fp
                         (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 3))
                                        ((0 *)) aw-%offset%)))))
          (setf i
                  (+ i
                     (+
                      (* fm
                         (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 4))
                                        ((0 *)) aw-%offset%))
                      (* fp
                         (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 5))
                                        ((0 *)) aw-%offset%)))))
         label100006))
      (setf k (f2cl-lib:int-add k nk))
      (setf j jtmp)
     label30
      (setf j (f2cl-lib:int-add j 6))
      (setf fm
              (funcall f
                       (+ a
                          (f2cl-lib:fref aw-%data% (j) ((0 *)) aw-%offset%))))
      (setf ir
              (+ ir
                 (* fm
                    (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2)) ((0 *))
                                   aw-%offset%))))
      (setf fm
              (* fm
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 4)) ((0 *))
                                aw-%offset%)))
      (setf i (+ i fm))
      (if (and (> (abs fm) errt) (< j k))
          (go label30))
      (setf j jtmp)
     label40
      (setf j (f2cl-lib:int-add j 6))
      (setf fp
              (funcall f
                       (+ a
                          (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1))
                                         ((0 *)) aw-%offset%))))
      (setf ir
              (+ ir
                 (* fp
                    (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 3)) ((0 *))
                                   aw-%offset%))))
      (setf fp
              (* fp
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 5)) ((0 *))
                                aw-%offset%)))
      (setf i (+ i fp))
      (if (and (> (abs fp) errt) (< j k))
          (go label40))
      (if (< k klim)
          (go label20))
      (setf errd (* h (+ (abs (- i (* 2 iback))) (abs (- ir (* 2 irback))))))
      (setf h (* h 0.5d0))
      (setf m (f2cl-lib:int-mul m 2))
      (setf klim (f2cl-lib:int-sub (f2cl-lib:int-mul 2 klim) noff))
      (go label100004)
     label100005
      (setf i (* i h))
      (cond ((> errd errh) (setf err (* (- errd) m)))
            (t
             (setf err
                     (* err
                        (* (f2cl-lib:fref aw-%data% (2) ((0 *)) aw-%offset%)
                           m)))))
     end_label
      (return (values nil nil nil i err)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::intdei
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '(t (double-float)
                                              (array double-float (*))
                                              (double-float) (double-float))
                                            :return-values
                                            '(nil nil nil fortran-to-lisp::i
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

(in-package :common-lisp-user)


(defun intdeoini (lenaw tiny eps aw)
  (declare (type (array double-float (*)) aw)
           (type (double-float) eps tiny)
           (type (f2cl-lib:integer4) lenaw))
  (f2cl-lib:with-multi-array-data
      ((aw double-float aw-%data% aw-%offset%))
    (prog ((pi4 0.0d0) (tinyln 0.0d0) (epsln 0.0d0) (frq4 0.0d0) (per2 0.0d0)
           (pp 0.0d0) (pq 0.0d0) (ehp 0.0d0) (ehm 0.0d0) (h 0.0d0) (t$ 0.0d0)
           (ep 0.0d0) (em 0.0d0) (tk 0.0d0) (xw 0.0d0) (wg 0.0d0) (xa 0.0d0)
           (noff0 0) (nk0 0) (noff 0) (k 0) (nk 0) (j 0) (efs 0.0d0)
           (enoff 0.0d0) (pqoff 0.0d0) (ppoff 0.0d0) (lmax 0))
      (declare (type (f2cl-lib:integer4) lmax j nk k noff nk0 noff0)
               (type (double-float) ppoff pqoff enoff efs xa wg xw tk em ep t$
                h ehm ehp pq pp per2 frq4 epsln tinyln pi4))
      (setf lmax 5)
      (setf efs 0.1d0)
      (setf enoff 0.4d0)
      (setf pqoff 2.9d0)
      (setf ppoff -0.72d0)
      (setf pi4 (atan 1.0d0))
      (setf tinyln (- (f2cl-lib:flog tiny)))
      (setf epsln (- 1 (f2cl-lib:flog (* efs eps))))
      (setf frq4 (/ 1 (* 2 pi4)))
      (setf per2 (* 4 pi4))
      (setf pq (/ pqoff epsln))
      (setf pp (- ppoff (f2cl-lib:flog (* pq pq frq4))))
      (setf ehp (exp (* 2 pq)))
      (setf ehm (/ 1 ehp))
      (setf (f2cl-lib:fref aw-%data% (3)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (coerce (the f2cl-lib:integer4 lmax) 'double-float))
      (setf (f2cl-lib:fref aw-%data% (4)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              eps)
      (setf (f2cl-lib:fref aw-%data% (5)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (f2cl-lib:fsqrt (* efs eps)))
      (setf noff0 6)
      (setf nk0 (f2cl-lib:int-add 1 (f2cl-lib:int (* enoff epsln))))
      (setf (f2cl-lib:fref aw-%data% (1)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (coerce (the f2cl-lib:integer4 nk0) 'double-float))
      (setf noff (f2cl-lib:int-add (f2cl-lib:int-mul 2 nk0) noff0))
      (setf wg (coerce (the f2cl-lib:integer4 0) 'double-float))
      (setf xw (coerce (the f2cl-lib:integer4 1) 'double-float))
      (f2cl-lib:fdo (k 1 (f2cl-lib:int-add k 1))
                    ((> k nk0) nil)
        (tagbody
          (setf wg (+ wg xw))
          (setf (f2cl-lib:fref aw-%data%
                               ((f2cl-lib:int-add noff
                                                  (f2cl-lib:int-mul -1 2 k)))
                               ((0
                                 (f2cl-lib:int-add lenaw
                                                   (f2cl-lib:int-sub 1))))
                               aw-%offset%)
                  wg)
          (setf (f2cl-lib:fref aw-%data%
                               ((f2cl-lib:int-add noff
                                                  (f2cl-lib:int-mul -1 2 k) 1))
                               ((0
                                 (f2cl-lib:int-add lenaw
                                                   (f2cl-lib:int-sub 1))))
                               aw-%offset%)
                  xw)
          (setf xw (/ (* xw (f2cl-lib:int-sub nk0 k)) k))
         label100000))
      (setf wg (/ per2 wg))
      (f2cl-lib:fdo (k noff0 (f2cl-lib:int-add k 2))
                    ((> k (f2cl-lib:int-add noff (f2cl-lib:int-sub 2))) nil)
        (tagbody
          (setf (f2cl-lib:fref aw-%data% (k)
                               ((0
                                 (f2cl-lib:int-add lenaw
                                                   (f2cl-lib:int-sub 1))))
                               aw-%offset%)
                  (*
                   (f2cl-lib:fref aw-%data% (k)
                                  ((0
                                    (f2cl-lib:int-add lenaw
                                                      (f2cl-lib:int-sub 1))))
                                  aw-%offset%)
                   wg))
          (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add k 1))
                               ((0
                                 (f2cl-lib:int-add lenaw
                                                   (f2cl-lib:int-sub 1))))
                               aw-%offset%)
                  (*
                   (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add k 1))
                                  ((0
                                    (f2cl-lib:int-add lenaw
                                                      (f2cl-lib:int-sub 1))))
                                  aw-%offset%)
                   wg))
         label100001))
      (setf xw (exp (- pp (* 2 pi4))))
      (setf (f2cl-lib:fref aw-%data% (noff)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (f2cl-lib:fsqrt (* xw (* per2 0.5d0))))
      (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add noff 1))
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (* xw pq))
      (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add noff 2))
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (* per2 0.5d0))
      (setf h (coerce (the f2cl-lib:integer4 2) 'double-float))
      (setf nk 0)
      (setf k (f2cl-lib:int-add noff 3))
     label10
      (setf t$ (* h 0.5d0))
     label20
      (setf em (exp (* 2 pq t$)))
      (setf ep (* pi4 em))
      (setf em (/ pi4 em))
      (setf tk t$)
      (setf j k)
     label30
      (setf xw (exp (- pp ep em)))
      (setf wg (f2cl-lib:fsqrt (+ (* frq4 xw) (* tk tk))))
      (setf xa (/ xw (+ tk wg)))
      (setf wg (/ (+ (* pq xw (- ep em)) xa) wg))
      (setf (f2cl-lib:fref aw-%data% (j)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              xa)
      (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1))
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (* xw pq))
      (setf (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2))
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              wg)
      (setf ep (* ep ehp))
      (setf em (* em ehm))
      (setf tk (+ tk 1))
      (setf j (f2cl-lib:int-add j 3))
      (if (and (< ep tinyln) (<= j (f2cl-lib:int-sub lenaw 3)))
          (go label30))
      (setf t$ (+ t$ h))
      (setf k (f2cl-lib:int-add k nk))
      (if (< t$ 1)
          (go label20))
      (setf h (* h 0.5d0))
      (cond
       ((= nk 0)
        (if (> j (f2cl-lib:int-sub lenaw 6))
            (setf j (f2cl-lib:int-sub j 3)))
        (setf nk (f2cl-lib:int-sub j noff)) (setf k (f2cl-lib:int-add k nk))
        (setf (f2cl-lib:fref aw-%data% (2)
                             ((0
                               (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                             aw-%offset%)
                (coerce (the f2cl-lib:integer4 nk) 'double-float))))
      (if (<= (f2cl-lib:int-sub (f2cl-lib:int-mul 2 k) noff 3) lenaw)
          (go label10))
      (setf (f2cl-lib:fref aw-%data% (0)
                           ((0 (f2cl-lib:int-add lenaw (f2cl-lib:int-sub 1))))
                           aw-%offset%)
              (coerce (the f2cl-lib:integer4 (f2cl-lib:int-sub k 3))
                      'double-float))
     end_label
      (return (values nil nil nil nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::intdeoini
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (double-float) (double-float)
                                              (array double-float (*)))
                                            :return-values '(nil nil nil nil)
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

(in-package :common-lisp-user)


(defun intdeo2 (f a omega aw i err)
  (declare (type (array double-float (*)) aw)
           (type (double-float) err i omega a))
  (f2cl-lib:with-multi-array-data
      ((aw double-float aw-%data% aw-%offset%))
    (prog ((eps 0.0d0) (per 0.0d0) (perw 0.0d0) (w02 0.0d0) (ir 0.0d0)
           (h 0.0d0) (iback 0.0d0) (irback 0.0d0) (t$ 0.0d0) (tk 0.0d0)
           (xa 0.0d0) (fm 0.0d0) (fp 0.0d0) (errh 0.0d0) (s0 0.0d0) (s1 0.0d0)
           (s2 0.0d0) (errd 0.0d0) (lenawm 0) (nk0 0) (noff0 0) (nk 0) (noff 0)
           (lmax 0) (m 0) (k 0) (j 0) (jm 0) (l 0))
      (declare
       (type (f2cl-lib:integer4) l jm j k m lmax noff nk noff0 nk0 lenawm)
       (type (double-float) errd s2 s1 s0 errh fp fm xa tk t$ irback iback h ir
        w02 perw per eps))
      (setf lenawm
              (f2cl-lib:int
               (+ (f2cl-lib:fref aw-%data% (0) ((0 *)) aw-%offset%) 0.5d0)))
      (setf nk0
              (f2cl-lib:int
               (+ (f2cl-lib:fref aw-%data% (1) ((0 *)) aw-%offset%) 0.5d0)))
      (setf noff0 6)
      (setf nk
              (f2cl-lib:int
               (+ (f2cl-lib:fref aw-%data% (2) ((0 *)) aw-%offset%) 0.5d0)))
      (setf noff (f2cl-lib:int-add (f2cl-lib:int-mul 2 nk0) noff0))
      (setf lmax
              (f2cl-lib:int
               (+ (f2cl-lib:fref aw-%data% (3) ((0 *)) aw-%offset%) 0.5d0)))
      (setf eps (f2cl-lib:fref aw-%data% (4) ((0 *)) aw-%offset%))
      (setf per (/ 1 (abs omega)))
      (setf w02
              (* 2
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add noff 2)) ((0 *))
                                aw-%offset%)))
      (setf perw (* per w02))
      (setf i
              (funcall f
                       (+ a
                          (*
                           (f2cl-lib:fref aw-%data% (noff) ((0 *)) aw-%offset%)
                           per))))
      (setf ir
              (* i
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add noff 1)) ((0 *))
                                aw-%offset%)))
      (setf i
              (* i
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add noff 2)) ((0 *))
                                aw-%offset%)))
      (setf err (abs i))
      (setf h (coerce (the f2cl-lib:integer4 2) 'double-float))
      (setf m 1)
      (setf k noff)
     label10
      (setf iback i)
      (setf irback ir)
      (setf t$ (* h 0.5d0))
     label20
      (cond
       ((= k noff)
        (tagbody
          (setf tk (coerce (the f2cl-lib:integer4 1) 'double-float))
          (setf k (f2cl-lib:int-add k nk))
          (setf j noff)
         label30
          (setf j (f2cl-lib:int-add j 3))
          (setf xa (* per (f2cl-lib:fref aw-%data% (j) ((0 *)) aw-%offset%)))
          (setf fm (funcall f (+ a xa)))
          (setf fp (funcall f (+ a xa (* perw tk))))
          (setf ir
                  (+ ir
                     (* (+ fm fp)
                        (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1))
                                       ((0 *)) aw-%offset%))))
          (setf fm
                  (* fm
                     (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2)) ((0 *))
                                    aw-%offset%)))
          (setf fp
                  (* fp
                     (- w02
                        (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2))
                                       ((0 *)) aw-%offset%))))
          (setf i (+ i (+ fm fp)))
          (setf err (+ err (+ (abs fm) (abs fp))))
          (setf tk (+ tk 1))
          (if (and (> (f2cl-lib:fref aw-%data% (j) ((0 *)) aw-%offset%) eps)
                   (< j k))
              (go label30))
          (setf errh (* err (f2cl-lib:fref aw-%data% (5) ((0 *)) aw-%offset%)))
          (setf err (* err eps))
          (setf jm (f2cl-lib:int-sub j noff))))
       (t (setf tk t$)
        (f2cl-lib:fdo (j (f2cl-lib:int-add k 3) (f2cl-lib:int-add j 3))
                      ((> j (f2cl-lib:int-add k jm)) nil)
          (tagbody
            (setf xa (* per (f2cl-lib:fref aw-%data% (j) ((0 *)) aw-%offset%)))
            (setf fm (funcall f (+ a xa)))
            (setf fp (funcall f (+ a xa (* perw tk))))
            (setf ir
                    (+ ir
                       (* (+ fm fp)
                          (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1))
                                         ((0 *)) aw-%offset%))))
            (setf fm
                    (* fm
                       (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2))
                                      ((0 *)) aw-%offset%)))
            (setf fp
                    (* fp
                       (- w02
                          (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2))
                                         ((0 *)) aw-%offset%))))
            (setf i (+ i (+ fm fp)))
            (setf tk (+ tk 1))
           label100000))
        (setf j (f2cl-lib:int-add k jm)) (setf k (f2cl-lib:int-add k nk))))
     label100001
      (if (not (and (> (abs fm) err) (< j k)))
          (go label100002))
      (setf j (f2cl-lib:int-add j 3))
      (setf fm
              (funcall f
                       (+ a
                          (* per
                             (f2cl-lib:fref aw-%data% (j) ((0 *))
                                            aw-%offset%)))))
      (setf ir
              (+ ir
                 (* fm
                    (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1)) ((0 *))
                                   aw-%offset%))))
      (setf fm
              (* fm
                 (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 2)) ((0 *))
                                aw-%offset%)))
      (setf i (+ i fm))
      (go label100001)
     label100002
      (setf fm (funcall f (+ a (* perw tk))))
      (setf s2 (* w02 fm))
      (setf i (+ i s2))
      (cond
       ((or (> (abs fp) err) (> (abs s2) err))
        (tagbody
          (setf l 0)
         label40
          (setf l (f2cl-lib:int-add l 1))
          (setf s0 (coerce (the f2cl-lib:integer4 0) 'double-float))
          (setf s1 (coerce (the f2cl-lib:integer4 0) 'double-float))
          (setf s2
                  (* fm
                     (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add noff0 1))
                                    ((0 *)) aw-%offset%)))
          (f2cl-lib:fdo (j (f2cl-lib:int-add noff0 2) (f2cl-lib:int-add j 2))
                        ((> j (f2cl-lib:int-add noff (f2cl-lib:int-sub 2))) nil)
            (tagbody
              (setf tk (+ tk 1))
              (setf fm (funcall f (+ a (* perw tk))))
              (setf s0 (+ s0 fm))
              (setf s1
                      (+ s1
                         (* fm
                            (f2cl-lib:fref aw-%data% (j) ((0 *))
                                           aw-%offset%))))
              (setf s2
                      (+ s2
                         (* fm
                            (f2cl-lib:fref aw-%data% ((f2cl-lib:int-add j 1))
                                           ((0 *)) aw-%offset%))))
             label100003))
          (if (or (<= s2 err) (>= l lmax))
              (go label50))
          (setf i (+ i (* w02 s0)))
          (go label40)
         label50
          (setf i (+ i s1))
          (if (> s2 err)
              (setf err s2)))))
      (setf t$ (+ t$ h))
      (if (< t$ 1)
          (go label20))
      (cond ((= m 1) (setf errd (+ 1 (* 2 errh))))
            (t
             (setf errd
                     (* h
                        (+ (abs (- i (* 2 iback)))
                           (abs (- ir (* 2 irback))))))))
      (setf h (* h 0.5d0))
      (setf m (f2cl-lib:int-mul m 2))
      (if (and (> errd errh)
               (<= (f2cl-lib:int-sub (f2cl-lib:int-mul 2 k) noff) lenawm))
          (go label10))
      (setf i (* i (* h per)))
      (cond ((> errd errh) (setf err (* (- errd) per)))
            (t (setf err (* err (* per m 0.5d0)))))
     end_label
      (return (values nil nil nil nil i err)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::intdeo2
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '(t (double-float) (double-float)
                                              (array double-float (*))
                                              (double-float) (double-float))
                                            :return-values
                                            '(nil nil nil nil
                                              fortran-to-lisp::i
                                              fortran-to-lisp::err)
                                            :calls 'nil)))
