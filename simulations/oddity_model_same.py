
import actr
import numpy as np
import matplotlib.pyplot as plt

actr.load_act_r_model("ACT-R:simulations;oddity-model-same.lisp")

response = False


def run(trials, human=False):
    correct = 0
    incorrect = 0
    for i in range(trials):
        print("Trial number " + str(i) + " :")
        if experiment(human) is True:
            correct += 1
        else:
            incorrect += 1

    print_graph(correct, incorrect)


def respond_to_key_press(model, key):
    global response

    response = key


def experiment(human=False):

    actr.reset()

    items = actr.permute_list(["B", "C", "D", "F", "G", "H", "J", "K", "L",
                               "M", "N", "P", "Q", "R", "S", "T", "V", "W",
                               "X", "Y", "Z"])
    target = items[0]
    foil = items[1]
    window = actr.open_exp_window(
        "Letter difference", visible=human,  width=390, height=390)
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

    actr.add_text_to_exp_window(window, text1, x=125, y=75)
    actr.add_text_to_exp_window(window, text2, x=75, y=175)
    actr.add_text_to_exp_window(window, text3, x=175, y=175)

    actr.add_command("unit2-key-press", respond_to_key_press,
                     "Assignment 2 task output-key monitor")
    actr.monitor_command("output-key", "unit2-key-press")

    global response
    response = ''

    if human == True:
        if actr.visible_virtuals_available():
            while response == '':
                actr.process_events()

    else:
        actr.install_device(window)
        actr.run(10, True)

    actr.remove_command_monitor("output-key", "unit2-key-press")
    actr.remove_command("unit2-key-press")

    if response.lower() != target.lower():
        return True
    else:
        return False


def print_graph(x, y):
    # creating the dataset
    data = {'Correct': x, 'Incorrect': y}
    courses = list(data.keys())
    values = list(data.values())

    # creating the bar plot
    plt.bar(courses, values, color='#2b5fb3',
            width=0.4)
    plt.ylabel("Number of Trials")
    plt.title("Oddity Model Same")
    plt.show()
