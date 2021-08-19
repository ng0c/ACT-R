
import actr

actr.load_act_r_model("ACT-R:simulations;oddity-img-model.lisp")

response = False


def respond_to_mouse_click(model, key):
    global response

    response = key


def experiment(human=False):

    actr.reset()

    items = actr.permute_list(
        ["dog.gif", "cake.gif", "boat.gif", "cat.gif", "gelato.gif", "horse.gif"])
    target = items[0]
    foil = items[1]
    window = actr.open_exp_window("Image difference", width=400, height=400)

    actr.install_device(window)
    actr.start_hand_at_mouse()

    text1 = foil
    text2 = foil
    text3 = foil
    index = actr.random(3)

    if index == 0:
        text1 = target
    elif index == 1:
        text2 = target
    else:
        text3 = target

    actr.add_items_to_exp_window(window, actr.create_image_for_exp_window(
        window, text1,  text1, x=125, y=75, width=128, height=128, action="oddity-mouse-click"))
    actr.add_image_to_exp_window(
        window, text2, text2, x=75, y=210,  width=128, height=128, action="oddity-mouse-click")
    actr.add_image_to_exp_window(
        window, text3, text3, x=210, y=210, width=128, height=128, action="oddity-mouse-click")

    actr.add_command("oddity-mouse-click", respond_to_mouse_click,
                     "oddity task output-mouse monitor")
    actr.monitor_command("click-mouse", "oddity-mouse-click")

    global response
    response = ''

    if human == True:
        if actr.visible_virtuals_available():
            while response == '':
                actr.process_events()
                actr.run_n_events(2)
                # run for up to 5 seconds using real-time if the window is visible
                actr.run(5, human)
    else:
        actr.install_device(window)
        actr.run(10, True)

    actr.remove_command_monitor("click-mouse", "oddity-mouse-click")
    actr.remove_command("oddity-mouse-click")

    if response == target:
        return True
    else:
        return False
