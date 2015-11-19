#include "Id.hpp"
#include "Crypto/CryptoRandom.hpp"
#include <QDebug>

namespace Dissent {
namespace Connections {
  const Id &Id::Zero()
  {
    static Id zero(QByteArray(Id::ByteSize, 0));
    return zero;
  }

  Id::Id()
  {
    QByteArray bid(Id::ByteSize, 0);
    Crypto::CryptoRandom().GenerateBlock(bid);
    _integer = Integer(bid);
  }
  
  Id::Id(const QByteArray &bid) : _integer(bid)
  {
  }

  Id::Id(const Integer &integer) : _integer(integer)
  {
  }

  Id::Id(const QString &sid) : _integer(sid)
  {
    if(_integer.ToString() != sid) {
      _integer = Zero()._integer;
    }
  }
}
}
