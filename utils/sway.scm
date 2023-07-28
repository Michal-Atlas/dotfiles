(define-library (utils sway)
  (import (scheme base)
          (guile)
          (gnu system keyboard))
  (export sway-keyboard-layout

          sway-bindings
          sway-exec-bindings
          sway-bindings/nomod
          sway-exec-bindings/nomod)

  (begin

    (define (sway-keyboard-layout layout)
      "Takes a standard guix keyboard-layout object
and emits a Sway input config
compatible with the RDE sway service."
      `(input type:keyboard
              ((xkb_layout ,(keyboard-layout-name layout))
               (xkb_variant ,(keyboard-layout-variant layout))
               (xkb_options ,(string-join
                              (keyboard-layout-options layout)
                              ",")))))

    (define (sway-kbd binds)
      (string-join (listify binds) "+"))
    (define (listify k) (if (list? k) k (list k)))
    (define (sway-mkbd binds)
      (sway-kbd (cons "$mod" (listify binds))))

    (define (sway-serialize-bindings binds schema->bind)
      (map
       (lambda (q) `(bindsym ,(schema->bind (car q))
                        ,@(cdr q)))
       binds))

    (define (prefix-exec l)
      (map (lambda (bind) `(,(car bind) ,@(cons 'exec (listify (cadr bind))))) l))

    (define (sway-bindings binds)
      "Takes a list of binds and commands,
and emits an RDE sway service compatible set of binds.
if the command requires multiple keys,
the car should be a list of all the keys:

@lisp
(\"s\" \"foobar\")
@end lisp

emits something that if ran through RDE sway
will produce:

@example
bindsym $mod+s foobar
@end example

the form is very forgiving and
the cdr may also be a file-like

@lisp
((\"Shift\" \"s\")
 (\"ls\"
  ,(file-append grim \"/bin/grim\")))
@end lisp

so rde will produce

@example
bindsym $mod+Shift+s ls /gnu/store/.../bin/grim
@end example

to not automatically prepend $mod see the /nomod variant"
      (sway-serialize-bindings binds sway-mkbd))

    (define (sway-exec-bindings binds)
      "Like sway-bindings but prefixes
exec to all your commands"
      (sway-serialize-bindings
       (prefix-exec binds)
       sway-mkbd))

    (define (sway-exec-bindings/nomod binds)
      (sway-serialize-bindings (prefix-exec binds) sway-kbd))

    (define (sway-bindings/nomod binds)
      (sway-serialize-bindings binds sway-kbd))
    ))
