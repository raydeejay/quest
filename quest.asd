;;;; quest.asd

(asdf:defsystem #:quest
  :serial t
  :description "A casual game about questing and other epic matters"
  :author "Sergi Reyner <sergi.reyner@gmail.com>"
  :license "MIT"
  :depends-on (#:ansi)
  :components ((:file "package")
               (:file "quest")))

