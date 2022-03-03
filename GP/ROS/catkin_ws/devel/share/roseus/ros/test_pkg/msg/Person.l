;; Auto-generated. Do not edit!


(when (boundp 'test_pkg::Person)
  (if (not (find-package "TEST_PKG"))
    (make-package "TEST_PKG"))
  (shadow 'Person (find-package "TEST_PKG")))
(unless (find-package "TEST_PKG::PERSON")
  (make-package "TEST_PKG::PERSON"))

(in-package "ROS")
;;//! \htmlinclude Person.msg.html


(intern "*UNKOWN*" (find-package "TEST_PKG::PERSON"))
(shadow '*UNKOWN* (find-package "TEST_PKG::PERSON"))
(defconstant test_pkg::Person::*UNKOWN* 0)
(intern "*MALE*" (find-package "TEST_PKG::PERSON"))
(shadow '*MALE* (find-package "TEST_PKG::PERSON"))
(defconstant test_pkg::Person::*MALE* 1)
(intern "*FEMALE*" (find-package "TEST_PKG::PERSON"))
(shadow '*FEMALE* (find-package "TEST_PKG::PERSON"))
(defconstant test_pkg::Person::*FEMALE* 2)

(defun test_pkg::Person-to-symbol (const)
  (cond
        ((= const 0) 'test_pkg::Person::*unkown*)
        ((= const 1) 'test_pkg::Person::*male*)
        ((= const 2) 'test_pkg::Person::*female*)
        (t nil)))

(defclass test_pkg::Person
  :super ros::object
  :slots (_name _sex _age ))

(defmethod test_pkg::Person
  (:init
   (&key
    ((:name __name) "")
    ((:sex __sex) 0)
    ((:age __age) 0)
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _sex (round __sex))
   (setq _age (round __age))
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:sex
   (&optional __sex)
   (if __sex (setq _sex __sex)) _sex)
  (:age
   (&optional __age)
   (if __age (setq _age __age)) _age)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; uint8 _sex
    1
    ;; uint8 _age
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; uint8 _sex
       (write-byte _sex s)
     ;; uint8 _age
       (write-byte _age s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; uint8 _sex
     (setq _sex (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _age
     (setq _age (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get test_pkg::Person :md5sum-) "9c69d4cca8265e8579c3162e701f97d6")
(setf (get test_pkg::Person :datatype-) "test_pkg/Person")
(setf (get test_pkg::Person :definition-)
      "string name
uint8 sex
uint8 age

uint8 unkown = 0
uint8 male = 1
uint8 female = 2

")



(provide :test_pkg/Person "9c69d4cca8265e8579c3162e701f97d6")


