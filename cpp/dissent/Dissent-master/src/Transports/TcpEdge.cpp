#include "TcpEdge.hpp"
#include "Utils/Serialization.hpp"
#include "Utils/Time.hpp"

using Dissent::Utils::Serialization;

namespace Dissent {
namespace Transports {
  const QByteArray TcpEdge::Zero = QByteArray(4, 0);

  TcpEdge::TcpEdge(const Address &local, const Address &remote, bool outgoing,
      QTcpSocket *socket) :
    Edge(local, remote, outgoing),
    _socket(socket, &QObject::deleteLater),
    _connected(true)
  {
    socket->setParent(0);

    socket->setSocketOption(QAbstractSocket::KeepAliveOption, 1);

    QObject::connect(socket, SIGNAL(readyRead()), this, SLOT(Read()));
    QObject::connect(this, SIGNAL(DelayedRead()), this, SLOT(Read()),
        Qt::QueuedConnection);
    QObject::connect(socket, SIGNAL(disconnected()), this, SLOT(HandleDisconnect()));
    QObject::connect(socket, SIGNAL(error(QAbstractSocket::SocketError)),
        this, SLOT(HandleError(QAbstractSocket::SocketError)));
  }

  TcpEdge::~TcpEdge()
  {
  }

  void TcpEdge::Send(const QByteArray &data)
  {
    if(Stopped()) {
      qWarning() << "Attempted to send on a closed edge:" << ToString();
      return;
    }

    QByteArray length(4, 0);
    Serialization::WriteInt(data.size(), length, 0);
    if((_socket->write(length) != 4) ||
        (_socket->write(data) != data.size()) ||
        (_socket->write(Zero) != 4))
    {
      qCritical() << "Didn't write all data to the socket!!!!!";
    }
    Sent();
  }

  void TcpEdge::Read()
  {
    int total_length = _socket->bytesAvailable();
    qint64 stime = Utils::Time::GetInstance().MSecsSinceEpoch();
    qint64 ntime = stime;
    bool delay = false;

    while(total_length >= 8 && !delay) {
      QByteArray length_arr = _socket->peek(4);
      if(length_arr.isEmpty()) {
        qCritical() << "Error reading Tcp socket in" << ToString();
        Stop("Error reading Tcp socket");
        return;
      }

      int length = Serialization::ReadInt(length_arr, 0);
      if(length + 8 > total_length) {
        break;
      }

      if(length < 0) {
        Stop("Error reading Tcp socket");
        return;
      }

      QByteArray msg = _socket->read(length + 8);
      if(msg.isEmpty()) {
        Stop("Error reading Tcp socket");
        qCritical() << "Error reading Tcp socket in" << ToString();
        return;
      }

      if(Serialization::ReadInt(msg, length + 4) != 0) {
        qCritical() << "Mismatch on byte array!";
      }

      PushData(GetSharedPointer(), msg.mid(4, length));
      total_length = _socket->bytesAvailable();
      ntime = Utils::Time::GetInstance().MSecsSinceEpoch();
      delay = (ntime - stime) > 1000;
    }

    if(delay) {
      QObject::disconnect(_socket.data(), SIGNAL(readyRead()), this, SLOT(Read()));
      emit DelayedRead();
      _connected = false;
    } else if(!_connected) {
      QObject::connect(_socket.data(), SIGNAL(readyRead()), this, SLOT(Read()));
      _connected = true;
    }
  }

  void TcpEdge::OnStop()
  {
    Edge::OnStop();
    // The following is somewhat dangerous but we do not have a clear definition of
    // the effect on what a Stop call has on an Edge.
    _socket->abort();
//    _socket->disconnectFromHost();
  }

  void TcpEdge::HandleError(QAbstractSocket::SocketError)
  {
    // If the close reason isn't empty, it was closed by the other side, no
    // need to report anything
    if(Stop(_socket->errorString())) {
      qWarning() << "Received warning from TcpEdge (" << ToString() << "):" <<
        _socket->errorString();
    }
  }

  void TcpEdge::HandleDisconnect()
  {
    // This will only succeed if Stop hasn't been called, so no loss...
    Stop("Disconnected");
    StopCompleted();
  }
}
}
