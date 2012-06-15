(cls cc ()
     x
     y)


(cls cd ()
     x
     y
     (z 7))

(cls ce ()
     x
     y

     (def f () (* x y)))

(cls cf ()
     x
     y

     (def f (z) (* x y z)))

(cls cg ()
     x
     y

     (def f (z) (* x y z))
     (def g (z) (* x y (f z))))


