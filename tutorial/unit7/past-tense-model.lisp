(clear-all)

(define-model past-tense
   ; All parameters for the model
   (sgp
     ; v = verbose, controls whether the trace of the model is output.
     ; t is the default value, if :v is set to nil then no output is visible
     :V t 

     ; specifying that retrieval requests will always take 50ms to complete
     :esc T

     ; setting the utility learning trace mechanism in the model
     :ul t 

     ; optimised learning parameter
     :OL 6   

     ; base-learning parameter (which are almost always set to 0.5)
     :BLL 0.5  

     ; activation noise
     :ANs 0.1   

     ; controlling noise in utility
     :EGs 0.2

     ; maximum associative strength - spreading activation   
     :mas  3.5 

     ; latency factor
     :LF 0.5

     ; the retrieval threshold sets the minimum activation a chunk can have 
     ; and still be retrieved
     :RT 0.5

     ; production compilation can be turned on/off with :epl. Currently, compilation
     ; is turned on.
     ; Note: this has relatively little effect on the accuracy of recall but 
     ; turning it on greatly increases the speed-up over trials in the recall time.
     :epl t

     ; learning rate, typically set to 0.2 but can be adjusted if needed
     :alpha 0.1 

     ; production compilation trace - when set to t, :v also need to be set to t.
     ; you will see the system print out the new productions as 
     ; they are composed or the reason why two productions could not be composed.
     :pct t

     ; utility learning for productions
     :iu 5    

     ; normalize chunk names after run
     ; This parameter does not affect the model’s performance on the tasks, but 
     ; it does affect the actual time it takes to run the simulation.
     ; can be useful for debugging (see page 267 for details).
     :ncnar nil

     ; related to previous/current productions in the imaginal module
     :do-not-harvest imaginal)
; commands for creating the model's initial knowledge
; with chunks amd productions  
(chunk-type past-tense verb stem suffix)
  (chunk-type goal state)
  
  (define-chunks 
      (starting-goal isa goal state start)
      (start isa chunk) (blank isa chunk) (done isa chunk))


  (declare-buffer-usage goal goal state)
  (declare-buffer-usage imaginal past-tense :all)

;;; When there is a stem and no suffix we have an irregular

(p past-tense-irregular
   =goal>
     isa    goal
     state  done
   =imaginal>
     isa    past-tense
     verb   =word
     stem   =past
     suffix blank
   ==>
   =goal> 
     state  nil)

(spp past-tense-irregular :reward 5)

;;; When the stem matches the verb and the suffix is not "blank" consider it regular

(p past-tense-regular
   =goal>
    isa     goal
    state   done
   =imaginal>
     isa    past-tense
     verb   =stem
     stem   =stem
     suffix =suffix
   !safe-eval! (not (eq =suffix 'blank)) 
  ==>
   =goal> 
     state  nil)

(spp past-tense-regular :reward 4.2)

;;; when there's no stem and no suffix that's a "give up" result

(p no-past-tense-formed
   =goal>
     isa    goal
     state  done
   =imaginal>
     isa    past-tense
     stem   nil
     suffix nil
  ==>
   =goal> 
     state  nil)

(spp no-past-tense-formed :reward 3.9) 
)