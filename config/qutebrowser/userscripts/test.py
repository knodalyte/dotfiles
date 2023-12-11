#!/usr/bin/env python

from qutescript import userscript


@userscript
def hello_world(request):
    request.send_text(request.text)
    # request.send_text('Hello, world!')


if __name__ == '__main__':
    hello_world()

