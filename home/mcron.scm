(&s home-mcron
    (jobs
     (list
      #~(job "0 * * * *"
             (string-append
              #$(file-append findutils "/bin/find")
              " ~/tmp/ ~/Downloads/ -mindepth 1 -mtime +2 -delete;")
             "Clear tmpfiles")
      #~(job "0 * * * *"
	     "guix gc -F 20G")
      #~(job "0 0 * * 0"
             #$(file-append podman "/bin/podman container prune -f")
             "podman prune containers")
      #~(job "0 0 * * 0"
             #$(file-append podman "/bin/podman image prune -f")
             "podman prune images"))))
