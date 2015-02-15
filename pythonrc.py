#!/usr/bin/env python

import os, sys, rlcompleter, atexit, readline

default_completer = rlcompleter.Completer()
def completer(text, state):
    if text.strip() == "":
        if state == 0:
            return text + "\t"
    else:
        return default_completer.complete(text, state)
readline.set_completer(completer)

if 'libedit' in readline.__doc__:
    readline.parse_and_bind("bind ^I rl_complete")
else:
    readline.parse_and_bind("tab: complete")

history_path = os.path.expanduser("~/.state/python_history")
if os.path.exists(history_path):
    readline.read_history_file(history_path)
def save_history(history_path=history_path):
    readline.write_history_file(history_path)
atexit.register(save_history)

del os, sys, rlcompleter, atexit
