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
  set window_config(.pgraph) 700x400+370+250
  set changed_window_list(.pgraph) 1
  set window_config(.whynotdm) 200x300+620+300
  set changed_window_list(.whynotdm) 1
  set window_config(.p_history_whynot_view) 316x200+620+350
  set changed_window_list(.p_history_whynot_view) 1
  set window_config(.buffer_history) 812x498+441+25
  set changed_window_list(.buffer_history) 1
  set window_config(.visicon) 940x309+219+470
  set changed_window_list(.visicon) 1
  set window_config(.visicon_history) 810x340+315+280
  set changed_window_list(.visicon_history) 1
  set window_config(.graphic_trace) 870x500+285+200
  set changed_window_list(.graphic_trace) 1
  set window_config(.options) 450x274+495+313
  set changed_window_list(.options) 1
  set window_config(.text_trace_history) 714x340+333+280
  set changed_window_list(.text_trace_history) 1
  set window_config(.buffers) 585x270+124+387
  set changed_window_list(.buffers) 1
  set window_config(.ptrace) 832x415+333+213
  set changed_window_list(.ptrace) 1
  set window_config(.retrieval_history) 670x380+429+277
  set changed_window_list(.retrieval_history) 1
  set window_config(.control_panel) 235x783+0+25
  set changed_window_list(.control_panel) 1
  set window_config(.param_viewer) 400x330+520+300
  set changed_window_list(.param_viewer) 1
  set window_config(.stepper) 753x550+244+148
  set changed_window_list(.stepper) 1
  set window_config(.audicon) 870x150+285+350
  set changed_window_list(.audicon) 1
  set window_config(.pick_buffers) 200x340+569+269
  set changed_window_list(.pick_buffers) 1
  set window_config(.declarative) 734x386+50+313
  set changed_window_list(.declarative) 1
  set window_config(.audicon_history) 734x300+353+300
  set changed_window_list(.audicon_history) 1
  set window_config(.bold_graphs) 660x250+350+352
  set changed_window_list(.bold_graphs) 1
  set window_config(.reload_response) 888x328+146+268
  set changed_window_list(.reload_response) 1
  set window_config(.event_queue) 800x180+290+277
  set changed_window_list(.event_queue) 1
  set window_config(.whynot) 498x419+520+379
  set changed_window_list(.whynot) 1
  set window_config(.copyright) 1x1+520+305
  set changed_window_list(.copyright) 1
  set window_config(.procedural) 500x400+361+228
  set changed_window_list(.procedural) 1
}
set gui_options(p_selected) #44DA22
set gui_options(p_matched) #FCA31D
set gui_options(p_mismatched) #E1031E
