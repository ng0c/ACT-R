(clear-all)

(define-model unit2
    
(sgp :v t :show-focus t)


(chunk-type read-letters state)
(chunk-type array letter1 letter2 letter3 answer)

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
==>
    +visual-location>
        :attended nil
    =goal>
        state find-location
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

(P encode-letter
    =goal>
        ISA read-letters
        state attend
    =visual>
         value =text
    ?imaginal>
        state free
==>
    =goal>
        state find-location
    +imaginal>
         isa array
         letter1 =text
)

(P respond
   =goal>
      ISA read-letters
      state respond
   =imaginal>
      isa array
      answer =ans
      letter1 =ans
   ?manual>
      state free
==>
   =goal>
      state done
   +manual>
      cmd press-key
      key =ans
)

(goal-focus goal)
)
