(+s home-mcron hydra-extensions
    (list #~(job "0 6 * * *"
                 (string-append
                  #$(file-append onedrive "/bin/onedrive")
                  " --synchronize")
                 "Onedrive")
          #~(job "*/10 * * * *"
                 (string-append
                  #$(file-append procps "/bin/pgrep") " unison >/dev/null || "
                  #$(file-append unison "/bin/unison")
                  " -batch watch")
                 "Unison")))
