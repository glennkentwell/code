#ifndef DISSENT_APPLICATIONS_COMMAND_LINE_H_GUARD
#define DISSENT_APPLICATIONS_COMMAND_LINE_H_GUARD

#include <QList>
#include <QObject>
#include <QSharedPointer>
#include <QSocketNotifier>
#include <QTextStream>

#include "ConsoleSink.hpp"

namespace Dissent {
namespace Applications {
  class Node;

  /**
   * Allows for Asynchronous access to the commandline for input and output
   * purposes.  Useful for console applications.
   */
  class CommandLine : public ConsoleSink {
    Q_OBJECT

    public:
      /**
       * Constructor
       * @param nodes the set of nodes running in this process
       */
      explicit CommandLine(const QList<QSharedPointer<Node> > &nodes);

      virtual ~CommandLine();

      /**
       * Start the command line services
       */
      void Start();

      /**
       * A sink input to print data to the console in a pretty way
       * @param from the sender of the data
       * @param data incoming data
       */
      virtual void HandleData(const QSharedPointer<ISender> &from,
          const QByteArray &data);

    public slots:
      /**
       * Stop the commmand line services
       */
      void Stop();

    private slots:
      /**
       * Called when there is input on stdin
       */
      void Read();

    protected:
      void PrintCommandLine();
      const QList<QSharedPointer<Node> > &_nodes;
      int _current_node;
      bool _running;
      QSocketNotifier _notify;
      QTextStream _qtin;
  };
}
}

#endif
