import random
import time
import sys
from os import system
from termcolor import cprint
from datetime import datetime

WORDS_FILE = "big_word_list.txt"
RECORD_FILE = "record.txt"
TIME_LIMIT = 60 # seconds
#TIME_LIMIT = 5 # seconds
NUM_WORDS = 50

def show_timer():
    for remaining in range(TIME_LIMIT, 0, -1):
        sys.stdout.write("\r")
        sys.stdout.write("{:2d}s".format(remaining))
        sys.stdout.flush()
        time.sleep(1)
    sys.stdout.write("\rComplete!            \n")

def load_words():
    words = []
    with open(WORDS_FILE, 'r') as word_file:
        lines = word_file.readlines()
    for line in lines:
        if len(line) > 3:
            words.append(line.strip())
    return words

def choose_words():
    base_words = load_words()
    chosen_words = random.sample(base_words, NUM_WORDS)
    system('clear')
    time.sleep(5)
    print_words(chosen_words)
    show_timer()
    system('clear')
    input_mode(chosen_words)

def input_mode(words):
    ans_words = []
    print("Please enter your answers")
    for i in range(len(words)):
        print(str(i+1) + ". ", end = "")
        ans_word = input("")
        if ans_word == "(exit)" or ans_word == "(end)" or ans_word == "*" or ans_word =="(e)":
            break
        else:
            ans_words.append(ans_word) 

    system('clear')
    correct = 0
    total = len(words)
    for i in range(len(words)):
        if i < len(ans_words):
            if ans_words[i] == words[i]:
                correct += 1
                cprint(str(i+1) + ". " + ans_words[i], "green")
            else:
                cprint(str(i+1) + ". " + ans_words[i] + "\t(" + words[i] +")" , "red")
        else:
            cprint(str(i+1) + ". " + words[i], "red")

    print("\n"*5)
    print("Total score: " + str(correct) + "/" + str(total))

    record_score(correct, total)

def record_score(correct, total):
    with open(RECORD_FILE, "a+") as record_file:
        current_time = datetime.now().strftime('%Y-%m-%d %H:%M')
        record_file.write("* [" + current_time  + "] \t" + str(correct) + "/" + str(total) + " in " + str(TIME_LIMIT) + " seconds.\n")

def print_words(words):
    i = 0
    print("\n"*10)
    while i < len(words):
        #print( str(i+1) + ") " + words[i])
        print ("{:<30} {:<15}".format(str(i + 1) + ". " +  words[i], str(i+2) + ". " + words[i+1]))
        i = i + 2
        #print(str(i+1) + ") " + words[i] + "\t\t\t" + str(i+2) + ") " + words[i+1])
    print("\n"*3)

choose_words()
