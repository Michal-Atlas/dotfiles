(define-library (system services syncthing)
  (import (guile)
          (srfi srfi-1)
          (gnu services configuration)
          (gnu services shepherd)
          (gnu home services)
          (gnu home services shepherd)
          (gnu services)
          (guix gexp))
  (export syncthing-configure-instance)

  (begin
    (define (listof-pred type)
      (lambda (sdl)
       (and (list? sdl)
            (every type sdl))))

    (define-configuration/no-serialization syncthing-device
      (id (string) "")
      (name (string) ""))

    (define listof-st-dev? (listof-pred syncthing-device?))

    (define-configuration/no-serialization syncthing-folder
      (id (string) "")
      (path (string) "")
      (devices (listof-st-dev) ""))

    (define listof-st-fold? (listof-pred syncthing-folder?))

    (define-configuration/no-serialization syncthing-configure-configuration
      (devices (listof-st-dev '()) "")
      (folders (listof-st-fold '()) ""))

    (define (conf-dev->json conf)
      (format #f "[~{~a~^,~}]"
              (map
               (lambda (dev)
                 (format #f "{ \"deviceID\": \"~a\", \"name\": \"~a\" }"
                         (syncthing-device-id dev)
                         (syncthing-device-name dev)))
               conf)))

    (define (conf-fold->json conf)
      (format #f "[~{~a~^,~}]"
              (map
               (lambda (fol)
                 (format #f "{ \"devices\": [~{~a~^,~}], \"id\": \"~a\", \"path\": \"~a\" }"
                         (map
                          (lambda (dev)
                            (format #f "{ \"deviceID\": \"~a\" }"
                                    (syncthing-device-id dev)))
                          (syncthing-folder-devices fol))
                         (syncthing-folder-id fol)
                         (syncthing-folder-path fol)))
               conf)))

    (define (activation-gexp conf)
      #~(begin
          (use-modules (sxml simple)
                       (sxml xpath)
                       (web client))
          (let ((apikey (cadar
                         ((sxpath '(configuration gui apikey))
                          (call-with-input-file
                              "/home/michal_atlas/.config/syncthing/config.xml"
                            xml->sxml)))))
            (format #t "Syncthing Configuration Response: ~a"
             (http-request (string-append "http://127.0.0.1:8384/rest/config")
                           #:method 'PUT
                           #:headers `((X-API-Key . ,apikey))
                           #:body
                           (format #f "{ \"devices\": ~a, \"folders\": ~a }"
                                   #$(conf-dev->json
                                      (syncthing-configure-configuration-devices conf))
                                   #$(conf-fold->json
                                      (syncthing-configure-configuration-folders conf))))))))

    (define syncthing-configure-service-type
      (service-type
       (name 'syncthing-configure)
       (description "Uses Syncthing's API to set the devices and folders,
according to a declaration")
       (extensions
        (list (service-extension home-activation-service-type
                                 activation-gexp)))))

    (define syncthing-configure-instance
      (let* ((devices (list
                      (syncthing-device
                       (name "nox")
                       (id "JBRYVQP-2GYSCCK-2M37T6I-KSETJHC-UY7ZUQ5-GW56FMG-LDRDFQC-YUH5EAY"))
                      (syncthing-device
                       (name "hydra")
                       (id "4F77KY2-XKLI7OD-J5GX6RH-VLFWIZA-M45YSV2-C2PNRGE-4GCE5Y5-ZLSTHQP"))
                      (syncthing-device
                       (name "dagon")
                       (id "UOVQXCK-LGQ7OA5-YQUBF67-QHTENZK-KEEGPET-PLZZQFZ-BPSZRCJ-LVEBTAD"))))
            (folders (list "cl" "Documents" "Sync" "Zotero")))
          (service syncthing-configure-service-type
                   (syncthing-configure-configuration
                    (folders
                     (map
                      (lambda (f)
                        (syncthing-folder
                         (id f)
                         (path (string-append "/home/michal_atlas/" f))
                         (devices devices)))
                      folders))
                    (devices devices)))))))
