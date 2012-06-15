(defpackage :redef
  (:use :cl :sb-mop))

(in-package :redef)

;(use-package :sb-mop)

(defun sym->kwd (s)
  (values (intern (string-upcase (symbol-name s))
                  "KEYWORD")))

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



(def obj ((kls symbol) &rest args)
  (apply #'obj (find-class kls) args))

(def obj ((kls class) &rest args)
  (unless (class-finalized-p kls) (finalize-inheritance kls))
  (let* ((symbols (mapcar #'slot-definition-name (class-slots kls)))
         (keywords (mapcar #'sym->kwd symbols))
         (argpairs (mapcar #'(lambda (u v) (list u v))
                           keywords
                           args))
         (initargs (reduce #'append argpairs)))
    (apply #'make-instance (cons kls initargs))))

(cls cc () 
       x y)

(def d (obj 'cc 3 2))



