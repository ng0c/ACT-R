# this file generated when environment is closed
# refresh . to make sure sizes are right

wm deiconify .
update
wm withdraw .
if {[winfo screenwidth .] != 1440 || [winfo screenheight .] != 900 || [lindex [wm maxsize .] 0] != 1440 || [lindex [wm maxsize .] 1] != 847} {
  set size_mismatch 1
} else {
  set size_mismatch 0
}

if $size_mismatch {
  set reset_window_sizes [tk_messageBox -icon warning -title "Screen resolution changed" -type yesno \
                                         -message "The screen resolution is not the same as it was the last time the Environment was used.  Should the window positions reset to the defaults?"]
} else { set reset_window_sizes 0}
if {$reset_window_sizes != "yes"} {
  set window_config(.buffer_history) 530x290+455+350
  set changed_window_list(.buffer_history) 1
  set window_config(.visicon) 700x150+370+350
  set changed_window_list(.visicon) 1
  set window_config(.graphic_trace) 870x500+285+200
  set changed_window_list(.graphic_trace) 1
  set window_config(.options) 450x274+495+313
  set changed_window_list(.options) 1
  set window_config(.text_trace_history) 714x340+333+280
  set changed_window_list(.text_trace_history) 1
  set window_config(.buffers) 470x240+970+173
  set changed_window_list(.buffers) 1
  set window_config(.ptrace) 410x370+515+300
  set changed_window_list(.ptrace) 1
  set window_config(.retrieval_history) 670x380+385+300
  set changed_window_list(.retrieval_history) 1
  set window_config(.control_panel) 235x783+8+25
  set changed_window_list(.control_panel) 1
  set window_config(.param_viewer) 400x330+520+300
  set changed_window_list(.param_viewer) 1
  set window_config(.audicon) 870x150+285+350
  set changed_window_list(.audicon) 1
  set window_config(.pick_buffers) 200x340+569+269
  set changed_window_list(.pick_buffers) 1
  set window_config(.stepper) 753x550+244+148
  set changed_window_list(.stepper) 1
  set window_config(.audicon_history) 734x300+353+300
  set changed_window_list(.audicon_history) 1
  set window_config(.declarative) 420x300+510+300
  set changed_window_list(.declarative) 1
  set window_config(.reload_response) 888x328+146+268
  set changed_window_list(.reload_response) 1
  set window_config(.event_queue) 800x180+320+360
  set changed_window_list(.event_queue) 1
  set window_config(.procedural) 500x400+470+250
  set changed_window_list(.procedural) 1
  set window_config(.copyright) 1x1+520+305
  set changed_window_list(.copyright) 1
}
set gui_options(p_selected) #44DA22
set gui_options(p_matched) #FCA31D
set gui_options(p_mismatched) #E1031E
