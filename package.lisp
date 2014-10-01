;;;; package.lisp

(defpackage #:quest
  (:use #:cl
        #:ansi-color)
  (:import-from #:ansi-color
                #:princa)
  (:export #:start
           #:main))

