(define-module (system networks wireguard)
  #:use-module (atlas utils services)
  #:use-module (srfi srfi-1)
  #:use-module (system hostname)
  #:use-module (gnu services vpn)
  #:use-module (gnu services base)
  #:use-module (ice-9 curried-definitions)
  #:export (wireguard:keepalive
            wireguard:get
            wireguard:peers))

(define wireguard:keepalive
  (make-parameter #f))

(define wireguard:peers
  (make-parameter
   (list
    (wireguard-peer
     (name "hydra")
     (endpoint "yg-hydra:51820")
     (allowed-ips '("fd4c:16e4:7d9b:0::1/128"))
     (public-key "0MigA4ewwzbwrlrZsi7+xhxn893q3nbtTPn6uiB2LEE="))
    (wireguard-peer
     (name "dagon")
     (endpoint "yg-dagon:51820")
     (allowed-ips '("fd4c:16e4:7d9b:0::2/128"))
     (public-key "VUk71x+wmwt//38RNT47ZNFJP0ZB2xB++4bAAtT6uEU="))
    (wireguard-peer
     (name "arc")
     (allowed-ips '("fd4c:16e4:7d9b:0::3/128"))
     (public-key "+i1Pv+p34kp/iEsPYeIj1mz/WkisdAUfQYlioRLbmxY=")))))

(define ((peer-by-name name) peer)
  (string=
   (wireguard-peer-name peer)
   name))

(define (wireguard:get)
  (list
   (+s hosts wireguard-hosts
       (append-map
        (lambda (wp)
          (map
           (lambda (addr)
             (host
              (car (string-split addr #\/))
              (wireguard-peer-name wp)))
           (wireguard-peer-allowed-ips wp)))
        (wireguard:peers)))
   (&s wireguard
       (addresses
        (wireguard-peer-allowed-ips
         (find (peer-by-name (hostname)) (wireguard:peers))))
       (peers
        (filter
         (negate (peer-by-name (hostname)))
         (wireguard:peers))))))
