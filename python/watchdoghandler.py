# http://pythonhosted.org//watchdog/quickstart.html#a-simple-example
# python watchdog should be able to monitor for changes

from watchdog.observers import Observer
from watchdog.events import LoggingEventHandler


observer = Observer()
ehandler = LoggingEventHandler()
observer.schedule(ehandler, "/home/glenn", recursive=True)
observer.schedule(ehandler, "/tmp", recursive=True)

