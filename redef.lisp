;; (defpackage :redef 
;;   (use :cl :sb-mop))

;; (in-package :redef)

(use-package :sb-mop)

(defmacro def (name expr &rest body)
  (if (null body)
      `(defparameter ,name ,expr)
      `(defmethod ,name ,expr ,@body)
      ))

(defmacro cls (name super &rest slots)
  (let ((processed-slots (mapcan (lambda (slot-name)
                                   (let ((slot-keyword (values (intern (string-upcase (symbol-name slot-name))
                                                                       "KEYWORD"))))
                                     `((,slot-name :initarg ,slot-keyword :accessor ,slot-keyword)))) slots)))
    `(defclass ,name ,super ,processed-slots)))



;; (def foo (x)
;;   (+ 2 x))

;; (def foo ((x cons))
;;   (cons 2 x))

(cls cc () 
       x y)

;(def c (obj 'cc 1 2))

(def c (make-instance 'cc :x 1 :y 2))

