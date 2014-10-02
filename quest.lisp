;;;; quest.lisp
(in-package #:quest)

(defun char-to-integer (x)
  (- (char-code x) 48))

(defun read-digit ()
  (let ((c (read-char)))
    (read-char)  ; eat the enter char :@
    (char-to-integer c)))

;; the location class
(defstruct location
  (name "")
  (description "")
  (menu nil))

;; the locations

;; the menu for each location is a list of options, each option being
;; itself a list of the form '(command description function)

;; would it possible to use a either a lambda or a function name?
(defvar *town* nil)
(setf *town* (make-location :name "Town"
                            :description "A very nice town."
                            :menu (list (list "1" "Go to the shop"
                                              #'go-to-shop)
                                        (list "2" "Go to the tavern"
                                              #'(lambda ()
                                                  (go-to-tavern))))))

(defvar *shop* nil)
(setf *shop* (make-location :name "Shop"
                            :description "A very nice shop."
                            :menu (list (list "1" "Go to the town"
                                              #'go-to-town)
                                        (list "2" "Go to the tavern"
                                              #'go-to-tavern))))

(defvar *tavern* nil)
(setf *tavern* (make-location :name "Tavern"
                              :description "A very nice tavern."
                              :menu (list (list "1" "Go to the shop"
                                                #'go-to-shop)
                                          (list "2" "Go to the town"
                                                #'go-to-town))))

(defvar *location* nil)

;; mockup movement functions
(defun go-to-town ()
  (princa :green "You go to the town")
  (setf *location* *town*)
  (fresh-line))

(defun go-to-shop ()
  (princa :green "You go to the shop")
  (setf *location* *shop*)
  (fresh-line))

(defun go-to-tavern ()
  (princa :red "You go to the tavern")
  (setf *location* *tavern*)
  (fresh-line))

(defun go-to (loc)
  (princa :green "You go to the " (location-name loc))
  (setf *location* loc)
  (fresh-line))

;; menu functions
(defun print-menu (loc)
  (dolist (entry (location-menu loc))
    (princa :bold (first entry) ". " (second entry) :reset)
    (fresh-line)))

(defun take-option (opt menu)
  (mapc (lambda (x)
          (let ((key (first x))
                (command (third x)))
            (when (string-equal opt key)
              (funcall command))))
        menu))

;; game flow
(defun take-turn (loc)
  (princa :red (location-name loc) :reset)
  (fresh-line)
  (princa (location-description loc))
  (fresh-line)
  (print-menu loc)
  (princa :cyan :bold "Choose: " :reset)
  (finish-output)
  (take-option (read-line) (location-menu loc)))

(defun game-loop ()
  (take-turn *location*)
  (game-loop))

(defun start ()
  (setf *location* *town*)
  (game-loop)
  (princa :bold "Goodbye!" :reset)
  (fresh-line))

;; entry point for making an executable
(defun main (argv)
  (declare (ignore argv))
  (start))
