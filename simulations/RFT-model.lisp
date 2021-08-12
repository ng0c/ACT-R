;;; This model is a simple demonstration of using arbitrary
;;; visicon features in conjunction with the image AGI items.
;;; It performs the task created by the background-image.lisp or
;;; background_image.py file.
;;;
;;; The model attends to the items it sees in the window (except
;;; for the background image) from left to right and top to 
;;; bottom moving the mouse to each as it goes.  It also prints
;;; the visual chunks which it receives.

(clear-all)


(define-model oddity-protocol

  (chunk-type perceive-pictures state)
  (chunk-type array picture)

  ; similar to add-dm but does not place the chunks in the model's declarative
  ; memory. This is to avoid unnescessary information being stored.
  (define-chunks same-line next-line)
  
  ; The :v (verbose) parameter controls whether the trace of the model is output.
  ; The :show-focus/needs-mouse parameter controls whether or not the visual attention ring/cursor 
  ; is displayed in the experiment window when the model is performing the task.
  (sgp :v t :show-focus t :needs-mouse t :esc t :trace-detail high)
  
  (p find-start "Find the first image"
     ?goal>
       buffer empty
     =visual-location>
     ==>
     +goal>
     ; Request visual-location buffer for an image at the top left corner i.e., x=0, y=0
     +visual-location>
      - kind image
       screen-y lowest
       screen-x lowest)
  
  (p attend "Attend to anything placed into the visual-location buffer"
     =goal>
     ; tests whether there are any chunks in the buffer. The value does not matter
     =visual-location>
     ?visual>
       state free
     ==>
     =goal>
       state nil
     ; The cmd slot in a request to the visual buffer indicates 
     ; which specific action is being requested.
     ; In this request that is the value move-attention which indicates that 
     ; the production is asking the vision module to move its attention to some 
     ; location (this location is specified in "screen-pos"), create a chunk which 
     ; encodes the object that is there, and place that chunk into the visual buffer.
     +visual>
       cmd move-attention
       screen-pos =visual-location
     !eval! (pprint-chunks-fct (list =visual-location)))
   
  (p attend-and-move "Attend and move to the next image"
     =visual>
       screen-pos =loc
     ?manual>
       state free
   ==>
     +manual> 
       isa move-cursor
       loc =loc
     !eval! (pprint-chunks-fct (list =visual)))

  (p find-next "Find the next image on a single row"
     =goal>
       state nil
     ?visual-location>
       buffer empty
     ?visual>
       state free
       buffer empty
     ?manual>
       state free
     ==>
     =goal>
       state same-line
     +visual-location>
       screen-y current
      > screen-x current
       screen-x lowest
      - kind image)
  
  (p next-row "Find the next row in the image grid"
     =goal>
       state same-line
     ?visual-location>
       buffer failure
     ==>
     =goal>
       state next-line
     +visual-location>
      > screen-y current
       screen-y lowest
       screen-x lowest
      - kind image)
  
  (p no-more "Stop attending when the visual-location buffer fail to find the next image"
     =goal>
       state next-line
     ?visual-location>
       buffer failure
     ==>
     ; clear the goal buffer
     -goal>))
  
  

