(define-module (networks wireguard)
  #:use-module (atlas utils services)
  #:use-module (srfi srfi-1)
  #:use-module (gnu services vpn)
  #:use-module (gnu services base)
  #:use-module (ice-9 curried-definitions)
  #:use-module (rde features)
  #:export (feature-wireguard))

(define* (feature-wireguard
          #:key
          (prefix "fd4c:16e4:7d9b:0"))
  (define (get-system-services config)
    (define host-name (get-value 'host-name config))

    (define (wg-ip host)
      (format #f "~a::~x/128" prefix host))

    (define wireguard:peers
      (make-parameter
       (list
        (wireguard-peer
         (name "hydra")
         (endpoint "yg-hydra:51820")
         (allowed-ips (list (wg-ip 1)))
         (public-key "0MigA4ewwzbwrlrZsi7+xhxn893q3nbtTPn6uiB2LEE="))
        (wireguard-peer
         (name "dagon")
         (endpoint "yg-dagon:51820")
         (allowed-ips (list (wg-ip 2)))
         (public-key "VUk71x+wmwt//38RNT47ZNFJP0ZB2xB++4bAAtT6uEU="))
	(wireguard-peer
         (name "leviathan")
         (endpoint "yg-leviathan:51820")
         (allowed-ips (list (wg-ip 3)))
         (public-key "tt3aPukVGsz3qYzg3bZofHz7L6EBohjf6FEgip44S3c="))
        (wireguard-peer
         (name "arc")
         (allowed-ips (list (wg-ip 4)))
         (public-key "+i1Pv+p34kp/iEsPYeIj1mz/WkisdAUfQYlioRLbmxY=")))))

    (define ((peer-by-name name) peer)
      (string=
       (wireguard-peer-name peer)
       name))

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
           (find (peer-by-name host-name)
                 (wireguard:peers))))
         (peers
          (filter
           (negate (peer-by-name host-name))
           (wireguard:peers))))))
  (feature
   (name 'wireguard)
   (system-services-getter get-system-services)))