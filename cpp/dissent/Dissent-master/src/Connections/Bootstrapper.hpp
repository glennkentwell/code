#ifndef DISSENT_CONNECTIONS_BOOTSTRAPPER_H_GUARD
#define DISSENT_CONNECTIONS_BOOTSTRAPPER_H_GUARD

#include "Utils/Timer.hpp"

#include "ConnectionAcquirer.hpp"

namespace Dissent {
namespace Utils {
  class TimerEvent;
}

namespace Connections {
  /**
   * Manages incoming and outgoing connections -- A node should only
   * send requests on outgoing connections.
   */
  class Bootstrapper : public ConnectionAcquirer {
    Q_OBJECT

    public:
      typedef Utils::TimerEvent TimerEvent;

      /**
       * Create a ConnectionAcquirer
       * @param cm Connection manager used for creating (and monitoring)
       * connections
       * @param remote_endpoints a list of potential remote end points
       */
      Bootstrapper(const QSharedPointer<ConnectionManager> &cm,
          const QList<Address> &remote_endpoints);

      /**
       * Allow for inheritance!
       */
      virtual ~Bootstrapper();

      /**
       * Return a list of potential remote peers
       */
      const QList<Address> GetRemoteEndpoints() { return _remote_endpoints; }

    protected:
      /**
       * Start creating connections!
       */
      virtual void OnStart();

      /**
       * Stop creating connections!
       */
      virtual void OnStop();

    private:
      /**
       * A new connection
       * @param con the new connection
       */
      virtual void HandleConnection(const QSharedPointer<Connection> &con);

      /**
       * A connection attempt failed
       */
      virtual void HandleConnectionAttemptFailure(const Address &addr,
          const QString &reason);

      /**
       * Reconnects to all peers in the _remote_endpoints
       */
      void Bootstrap(const int &);

      /**
       * Do we need to bootstrap some more?
       */
      bool NeedConnection();

      QList<Address> _remote_endpoints;

      TimerEvent *_bootstrap_event;
      int _count;

    private slots:
      /**
       * A connection has disconnected, evaluate if we need to bootstrap.
       */
      void HandleDisconnect(const QString &reason);
  };
}
}

#endif
