#ifndef DISSENT_WEB_MESSAGE_WEB_SERVICE_GUARD
#define DISSENT_WEB_MESSAGE_WEB_SERVICE_GUARD

#include <QByteArray>
#include <QSharedPointer>

#include "WebService.hpp"

namespace Dissent {
namespace Web {
  /**
   * A WebService that can handle messages
   * incoming from an anonymity Session object
   */
  class MessageWebService : public QObject, public WebService {
    Q_OBJECT

    public:
      virtual ~MessageWebService() {}

    public slots:
      /**
       * Slot called when new data is arriving from a session
       */
      void HandleIncomingMessage(const QByteArray &data)
      {
        HandleMessage(data);
      }

    private:
      /**
       * Called by HandleIncomingMessage
       */
      virtual void HandleMessage(const QByteArray &data) = 0;
  };
}
}

#endif
