(define-library (utils services)
  (import (scheme base)
          (guile)
          (gnu services))
  (export @host
          @host-append
          hostname
          macromap
          &s +s)

  (begin

    (define-syntax-rule (macromap prefix (inner ...) ...)
      "Simple macro that prefixes a list of expressions
with a symbol:

@lisp
(macromap foo
  (bar 2)
  (tar 4))
=> (list (foo bar 2) (foo tar 4))
@end lisp"
      (list (prefix inner ...) ...))

    (define hostname (make-parameter
                      ""
                      (compose
                       symbol->keyword
                       string->symbol)))
    (define (@host . body)
      "Returns the body as a list,
omitting all expressions that follow
a keyword which isn't equal to the value of hostname.

@lisp
(\\@host 1 2 #:hydra 3 4 #:dagon 5)
@end lisp

On hydra this would yield
@lisp
(1 2 3 4)
@end lisp
and on dagon it would yield
@lisp
(1 2 4 5)
@end lisp

useful when a service/package/mount is
only relevant on some machines"
      (let ((self (hostname)))
        (let loop ((body body))
          (if (null? body) body
              (if (keyword? (car body))
                  (if (eq? (car body) self)
                      (cons (cadr body) (loop (cddr body)))
                      (loop (cddr body)))
                  (cons (car body) (loop (cdr body))))))))

    (define (@host-append . body)
      (apply append (apply @host body)))

    (define (name->typename ctx name)
      (datum->syntax ctx (symbol-append
                          (syntax->datum name)
                          '-service-type)))
    (define (name->configname ctx name)
      (datum->syntax ctx (symbol-append
                          (syntax->datum name)
                          '-configuration)))

    (define-syntax &s
      (lambda (x)
        "Takes a name and
configuration body and yields a valid
guix service expression:

@lisp
(&s hurd-vm
  (disk-size 20)
  (memory-size 2048))
@end lisp

transforms into

@lisp
(service hurd-vm-service-type
  (hurd-vm-configuration
    (disk-size 20)
    (memory-size 2048)))
@end lisp

if you with to pass the body as-is, then
pass #:config before it:

@lisp
(&s pam-limits #:config
  (list (pam-limits-entry \"*\" 'both 'nofile 524288)))
@end lisp

simple outputs

@lisp
(service pam-limits-service-type
  (list (pam-limits-entry \"*\" 'both 'nofile 524288)))
@end lisp"
        (syntax-case x ()
          [(_ name)
           (with-syntax ([service-type (name->typename x #'name)])
             #'(service service-type))]
          [(_ name #:config config)
           (with-syntax
               ([service-type (name->typename x #'name)])
             #'(service service-type
                        config))]
          [(_ name config ...)
           (with-syntax
               ([service-type (name->typename x #'name)]
                [configuration (name->configname x #'name)])
             #'(service service-type
                        (configuration
                         config ...)))])))

    (define-syntax +s
      (lambda (x)
        "Similar to &s,
but doesn't wrap in a configuration struct,
and declares a simple-service:

@lisp
(+s hosts
  (list (host \"127.10.1.0\" \"example.local\")))
@end lisp

expands to

@lisp
(simple-service \"hosts extension\" hosts-service-type
  (list (host \"127.10.1.0\" \"example.local\")))
@end lisp"
        (syntax-case x ()
          [(_ name config)
           (with-syntax ([service-type (name->typename x #'name)])
             #'(simple-service (format #f "~a extension" service-type)
                               service-type
                               config))])))
    ))
