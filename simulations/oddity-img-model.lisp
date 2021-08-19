(clear-all)

(define-model oddity
    
(sgp :v t :show-focus t :needs-mouse t)


(chunk-type read-letters state)
(chunk-type array letter1 letter2 letter3 temp answer position1 position2 position3)

(add-dm 
 (start isa chunk)
 (attend isa chunk)
 (evaluate isa chunk)
 (respond isa chunk)
 (done isa chunk)
 (goal isa read-letters state start))

(P find-unattended-letter
    =goal>
      ISA read-letters
      state start
    ?imaginal>
      state free
==>
    +visual-location>
        :attended nil
    =goal>
        state find-location
    +imaginal>
         letter1 nil
)

(P attend-letter
    =goal>
        ISA read-letters
        state find-location
    =visual-location>
    ?visual>
        state free
    ?manual>
        state free
==>
    +visual>
        isa move-attention
        cmd move-attention
        screen-pos =visual-location
    =goal>
        state attend
    +manual>
       isa move-cursor
       loc =visual-location
)

(P encode-letter1
    =goal>
        ISA read-letters
        state attend
    =visual>
         value =text
         screen-pos =pos
    ?imaginal>
        state free
    =imaginal>
        letter1 nil
==>
    =goal>
        state find-location
    +imaginal>
         isa array
         letter1 =text
         position1 =pos
    +visual-location>
         :attended new
)

(P encode-letter2
    =goal>
        ISA read-letters
        state attend
    =visual>
         value =text
         screen-pos =pos
    ?imaginal>
        state free
    =imaginal>
         letter1 =val
         position1 =position1
==>
    =goal>
        state find-location
    +imaginal>
         isa array
         letter1 =val
         position1 =position1
         letter2 =text
         position2 =pos
         answer =position1
    +visual-location>
         :attended nil
)

(P encode-letter3
    =goal>
        ISA read-letters
        state attend
    =visual>
         value =text
         screen-pos =pos
    ?imaginal>
        state free
    =imaginal>
         letter1 =l1
         position1 =position1
         letter2 =l2
         position2 =position2
==>
    =goal>
        state evaluate
    +imaginal>
         isa array
         letter1 =l1
         position1 =position1
         letter2 =l2
         position2 =position2
         letter3 =text
         position3 =pos
         temp =position1
)

(P evaluate-if
   =goal> 
      isa read-letters
      state evaluate
   ?imaginal>
      state free
   =imaginal>
      letter1 =l1
      letter2 =l1
      temp =l1
      letter3 =l3
      position3 =position3
==>
   =goal>
      state respond
   +imaginal>
      answer =position3
)

(P evaluate-elif
   =goal> 
      isa read-letters
      state evaluate
   ?imaginal>
      state free
   =imaginal>
      letter1 =l1
      letter2 =l2
      temp =l1
      letter3 =l1
      position2 =position2
==>
   =goal>
      state respond
   +imaginal>
      answer =position2
)

(P evaluate-else
   =goal> 
      isa read-letters
      state evaluate
   ?imaginal>
      state free
   =imaginal>
      letter1 =l1
      - letter2 =l1
      - letter3 =l1
      position1 =position1
==>
   =goal>
      state respond
   +imaginal>
      answer =position1
)

; responds incorrectly because the location for the right answer is
; not stored
(P respond
   =goal>
      ISA read-letters
      state respond
   =imaginal>
      isa array
      answer =ans
   ?manual>
      state free
==>
   =goal>
      state done
   +manual>
    ;;   cmd click-mouse
    ;;   loc =ans
        isa move-cursor
        loc =ans
)

(goal-focus goal)
)
