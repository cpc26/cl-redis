;;; CL-REDIS system definition
;;; (c) Vsevolod Dyomkin, Oleksandr Manzyuk.  See LICENSE file for permissions

(in-package :asdf)

(defsystem #:cl-redis
  :version "2.2.1"
  :maintainer "Vsevolod Dyomkin <vseloved@gmail.com>"
  :licence "MIT"
  :description "Redis database client, using iolib interface."
  :depends-on (#:rutils #:cl-ppcre #:usocket #:flexi-streams)
  :serial t
  :components ((:file "package")
               (:file "float")
               (:file "connection")
               (:file "redis")
               (:file "commands")))


(defmethod perform ((o test-op)
                    (c (eql (find-system 'cl-redis))))
  (operate 'load-op '#:cl-redis)
  (operate 'test-op '#:cl-redis-test))

(defsystem #:cl-redis-test
  :version "2.0.0"
  :maintainer "Vsevolod Dyomkin <vseloved@gmail.com>"
  :licence "MIT"
  :description "CL-Redis test suite"
  :depends-on (#:cl-redis #:bordeaux-threads #:flexi-streams #:nuts)
  :components ((:file "test")))

(defmethod perform ((o test-op)
                    (c (eql (find-system 'cl-redis-test))))
  (operate 'load-op '#:cl-redis-test)
  (funcall (intern (symbol-name 'run-all-tests)
                   '#:cl-redis-test)))

;;; end
