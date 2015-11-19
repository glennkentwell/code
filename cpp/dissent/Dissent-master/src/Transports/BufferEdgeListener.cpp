#include <QDebug>
#include "BufferEdgeListener.hpp"
#include "Utils/Random.hpp"

using Dissent::Utils::Random;

namespace Dissent {
namespace Transports {
  QHash<int, BufferEdgeListener *> BufferEdgeListener::_el_map;

  BufferEdgeListener::BufferEdgeListener(const BufferAddress &local_address) :
    EdgeListener(local_address), _valid(false)
  {
  }

  EdgeListener *BufferEdgeListener::Create(const Address &local_address)
  {
    const BufferAddress &ba = static_cast<const BufferAddress &>(local_address);
    return new BufferEdgeListener(ba);
  }

  BufferEdgeListener::~BufferEdgeListener()
  {
    DestructorCheck();
  }

  void BufferEdgeListener::OnStart()
  {
    EdgeListener::OnStart();

    const BufferAddress addr = static_cast<const BufferAddress &>(GetAddress());
    int id = addr.GetId();
    if(id == 0) {
      while(_el_map.contains(id = Random::GetInstance().GetInt(1))) ;
      SetAddress(BufferAddress(id));
    }

    if(_el_map.contains(id)) {
      qWarning() << "Attempting to create two BufferEdgeListeners with the same" <<
        " address: " << addr.ToString();
      return;
    }

    _valid = true;
    _el_map[id] = this;
  }

  void BufferEdgeListener::OnStop()
  {
    EdgeListener::OnStop();
    if(!_valid) {
      return;
    }

    const BufferAddress &loc_ba = static_cast<const BufferAddress &>(GetAddress());
    _el_map.remove(loc_ba.GetId());
  }

  void BufferEdgeListener::CreateEdgeTo(const Address &to)
  {
    if(Stopped()) {
      qWarning() << "Cannot CreateEdgeTo Stopped EL";
      return;
    }

    if(!Started()) {
      qWarning() << "Cannot CreateEdgeTo non-Started EL";
      return;
    }

    const BufferAddress &rem_ba = static_cast<const BufferAddress &>(to);
    BufferEdgeListener *remote_el = _el_map.value(rem_ba.GetId());
    if(remote_el == 0) {
      qDebug() << "Attempting to create an Edge to an EL that doesn't exist from " <<
        GetAddress().ToString() << " to " << to.ToString();
      ProcessEdgeCreationFailure(to, "No such peer");
      return;
    }

    int delay = Dissent::Utils::Random::GetInstance().GetInt(10, 50);
    BufferEdge *local_edge(new BufferEdge(GetAddress(), remote_el->GetAddress(), true, delay));
    BufferEdge *remote_edge(new BufferEdge(remote_el->GetAddress(), GetAddress(), false, delay));

    QSharedPointer<BufferEdge> ledge(local_edge);
    SetSharedPointer(ledge);
    QSharedPointer<BufferEdge> redge(remote_edge);
    SetSharedPointer(redge);

    local_edge->SetRemoteEdge(redge);
    remote_edge->SetRemoteEdge(ledge);

    ProcessNewEdge(ledge);
    remote_el->ProcessNewEdge(redge);
  }
}
}
