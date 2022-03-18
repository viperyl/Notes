;; Auto-generated. Do not edit!


(when (boundp 'l_service::Person)
  (if (not (find-package "L_SERVICE"))
    (make-package "L_SERVICE"))
  (shadow 'Person (find-package "L_SERVICE")))
(unless (find-package "L_SERVICE::PERSON")
  (make-package "L_SERVICE::PERSON"))
(unless (find-package "L_SERVICE::PERSONREQUEST")
  (make-package "L_SERVICE::PERSONREQUEST"))
(unless (find-package "L_SERVICE::PERSONRESPONSE")
  (make-package "L_SERVICE::PERSONRESPONSE"))

(in-package "ROS")





(intern "*UNKNOWN*" (find-package "L_SERVICE::PERSONREQUEST"))
(shadow '*UNKNOWN* (find-package "L_SERVICE::PERSONREQUEST"))
(defconstant l_service::PersonRequest::*UNKNOWN* 0)
(intern "*MALE*" (find-package "L_SERVICE::PERSONREQUEST"))
(shadow '*MALE* (find-package "L_SERVICE::PERSONREQUEST"))
(defconstant l_service::PersonRequest::*MALE* 1)
(intern "*FEAMLE*" (find-package "L_SERVICE::PERSONREQUEST"))
(shadow '*FEAMLE* (find-package "L_SERVICE::PERSONREQUEST"))
(defconstant l_service::PersonRequest::*FEAMLE* 2)
(defclass l_service::PersonRequest
  :super ros::object
  :slots (_name _age _sex ))

(defmethod l_service::PersonRequest
  (:init
   (&key
    ((:name __name) "")
    ((:age __age) 0)
    ((:sex __sex) 0)
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _age (round __age))
   (setq _sex (round __sex))
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:age
   (&optional __age)
   (if __age (setq _age __age)) _age)
  (:sex
   (&optional __sex)
   (if __sex (setq _sex __sex)) _sex)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; uint8 _age
    1
    ;; uint8 _sex
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; uint8 _age
       (write-byte _age s)
     ;; uint8 _sex
       (write-byte _sex s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; uint8 _age
     (setq _age (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _sex
     (setq _sex (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass l_service::PersonResponse
  :super ros::object
  :slots (_result ))

(defmethod l_service::PersonResponse
  (:init
   (&key
    ((:result __result) "")
    )
   (send-super :init)
   (setq _result (string __result))
   self)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:serialization-length
   ()
   (+
    ;; string _result
    4 (length _result)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _result
       (write-long (length _result) s) (princ _result s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _result
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _result (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass l_service::Person
  :super ros::object
  :slots ())

(setf (get l_service::Person :md5sum-) "9495c620750744a2177d2501849849d0")
(setf (get l_service::Person :datatype-) "l_service/Person")
(setf (get l_service::Person :request) l_service::PersonRequest)
(setf (get l_service::Person :response) l_service::PersonResponse)

(defmethod l_service::PersonRequest
  (:response () (instance l_service::PersonResponse :init)))

(setf (get l_service::PersonRequest :md5sum-) "9495c620750744a2177d2501849849d0")
(setf (get l_service::PersonRequest :datatype-) "l_service/PersonRequest")
(setf (get l_service::PersonRequest :definition-)
      "string name
uint8 age
uint8 sex
# request
uint8 unknown = 0
uint8 male = 1
uint8 feamle = 2
---
# response
string result

")

(setf (get l_service::PersonResponse :md5sum-) "9495c620750744a2177d2501849849d0")
(setf (get l_service::PersonResponse :datatype-) "l_service/PersonResponse")
(setf (get l_service::PersonResponse :definition-)
      "string name
uint8 age
uint8 sex
# request
uint8 unknown = 0
uint8 male = 1
uint8 feamle = 2
---
# response
string result

")



(provide :l_service/Person "9495c620750744a2177d2501849849d0")


