(clear-all)

(define-model oddity
    
(sgp :v t :show-focus t)


(chunk-type read-letters state)
(chunk-type array letter1 letter2 letter3 temp answer)

(add-dm 
 (start isa chunk)
 (attend isa chunk)
 (find-next isa chunk)
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
==>
    +visual>
        isa move-attention
        cmd move-attention
        screen-pos =visual-location
    =goal>
        state attend
)

(P encode-letter1
    =goal>
        ISA read-letters
        state attend
    =visual>
         value =text
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
    +visual-location>
         :attended new
)

(P encode-letter2
    =goal>
        ISA read-letters
        state attend
    =visual>
         value =text
    ?imaginal>
        state free
    =imaginal>
         letter1 =val
==>
    =goal>
        state find-location
    +imaginal>
         isa array
         letter1 =val
         letter2 =text
         answer =val
    +visual-location>
         :attended nil
)

(P encode-letter3
    =goal>
        ISA read-letters
        state attend
    =visual>
         value =text
    ?imaginal>
        state free
    =imaginal>
         letter1 =l1
         letter2 =l2
==>
    =goal>
        state evaluate
    +imaginal>
         isa array
         letter1 =l1
         letter2 =l2
         letter3 =text
         temp =l1
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
==>
   =goal>
      state respond
   +imaginal>
      answer =l3)

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
==>
   =goal>
      state respond
   +imaginal>
      answer =l2)

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
==>
   =goal>
      state respond
   +imaginal>
      answer =l1)

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
      cmd click-mouse
      key =ans
)

(goal-focus goal)
)
