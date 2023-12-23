(define-module (system networks wireguard)
  #:use-module (atlas utils services)
  #:use-module (srfi srfi-1)
  #:use-module (system hostname)
  #:use-module (gnu services vpn)
  #:use-module (gnu services base)
  #:export (wireguard:keepalive
            wireguard:get
            wireguard:remote-peer
            wireguard:peers))

(define wireguard:keepalive
  (make-parameter #f))

(define (wireguard:remote-peer)
  (wireguard-peer
   (name "central")
   (endpoint "130.61.54.212:51820")
   (public-key "DfSW8vkOq5riNSenbVwRK7GUECcfbvGSUjHLUw1PAhc=")
   (allowed-ips '("10.0.0.0/24"))
   (keep-alive (wireguard:keepalive))))

(define wireguard:peers
  (make-parameter
   (list
    (wireguard-peer
     (name "hydra")
     (allowed-ips '("10.0.0.2/32"))
     (public-key "0MigA4ewwzbwrlrZsi7+xhxn893q3nbtTPn6uiB2LEE="))
    (wireguard-peer
     (name "dagon")
     (allowed-ips '("10.0.0.3/32"))
     (public-key "VUk71x+wmwt//38RNT47ZNFJP0ZB2xB++4bAAtT6uEU="))
    (wireguard-peer
     (name "arc")
     (public-key "+i1Pv+p34kp/iEsPYeIj1mz/WkisdAUfQYlioRLbmxY="))
    (wireguard-peer
     (name "sps")
     (allowed-ips '("13.0.0.101/32" "13.0.0.102/32" "13.0.0.103/32"))
     (public-key "h5aakFQU0KsraXu6o6ySX7JY588sBt6IV+GiaRMjCEw=")))))
     (allowed-ips '("10.0.0.4/32"))

(define (remote-config-file)
  ((@@ (gnu services vpn) wireguard-configuration-file)
   (wireguard-configuration
    (addresses (list "10.0.0.1/24"))
    (peers (wireguard:peers)))))

(define (peer-by-name)
  (find
   (lambda (p)
     (string=
      (wireguard-peer-name p)
      (hostname)))
   (wireguard:peers)))

(define (wireguard:get)
  (list
   (+s hosts wireguard-hosts
       (append-map
        (lambda (wp)
          (map
           (lambda (addr)
             (host
              (car (string-split addr #\/))
              (string-append "wg-" (wireguard-peer-name wp))))
           (wireguard-peer-allowed-ips wp)))
        (wireguard:peers)))
   (&s wireguard
       (addresses
        (wireguard-peer-allowed-ips (peer-by-name)))
       (peers (list (wireguard:remote-peer))))))
