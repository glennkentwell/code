
def dirx(thing, search=None):
    if search is None:
        return dir(thing)
    else:
        dirlist = []
        x = dir(thing)
        for xx in x:
            if xx.find(search) >= 0:
                dirlist.append(xx)
        print str(len(dirlist)) + ' items'
        return dirlist
