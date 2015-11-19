#!/usr/bin/python

# http://stackoverflow.com/questions/566746/how-to-get-console-window-width-in-python
def ttysz():
    import fcntl, termios, struct
    h, w, hp, wp = struct.unpack('hhhh',
        fcntl.ioctl(0, termios.tiocgwinsz,
        struct.pack('hhhh', 0, 0, 0, 0)))
    return w, h
