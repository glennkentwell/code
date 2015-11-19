#include "DissentTest.hpp"
#include "OverlayHelper.hpp"

namespace Dissent {
namespace Tests {

  QSharedPointer<Node> CreateNode(const Id &id, const Group &group,
      const QList<Address> &local, const QList<Address> &remote,
      const QSharedPointer<ISink> &sink, SessionFactory::SessionType session)
  {
    QByteArray bid(id.GetByteArray());
    QSharedPointer<AsymmetricKey> key(new RsaPrivateKey(bid, true));
    DiffieHellman dh(bid, true);
    PrivateIdentity ident(id, key, key, dh);
    return Node::CreateClientServer(ident, group, local, remote, sink, session);
  }

  bool CheckClientServer(const QList<QSharedPointer<Node> > &nodes,
      const Group &group)
  {
    foreach(const QSharedPointer<Node> &node, nodes) {
      const QSharedPointer<BaseOverlay> &overlay(node->GetOverlay());

      if(group.GetSubgroup().Contains(overlay->GetId())) {
        foreach(const PublicIdentity &gc, group.GetSubgroup()) {
          if(overlay->GetConnectionTable().GetConnection(gc.GetId()) == 0) {
            return false;
          }
        }
      } else {
        bool found = false;
        foreach(const QSharedPointer<Connection> &con,
            overlay->GetConnectionTable().GetConnections())
        {
          if(group.GetSubgroup().Contains(con->GetRemoteId())) {
            found = true;
            break;
          }
        }
        if(!found) {
          return false;
        }
      }
    }
    return true;
  }

  QList<QSharedPointer<Node> > GenerateOverlay(int server_total,
      int client_total, SessionFactory::SessionType session)
  {
    CryptoRandom rand;
    int leader_index = rand.GetInt(0, server_total); //client_total + server_total);
    int bootstrap_index = leader_index;
//    int bootstrap_index = rand.GetInt(0, client_total + server_total);

    QList<QSharedPointer<Node> > nodes;
    int client_count = 0, server_count = 0;
    Group group = Group(QVector<PublicIdentity>(), Id(), Group::ManagedSubgroup);

    QList<Address> local;
    local.append(BufferAddress(1));
    QList<Address> remote;
    remote.append(BufferAddress(1));

    if(bootstrap_index == leader_index) {
      QSharedPointer<ISink> sink(new BufferSink());
      nodes.append(CreateNode(group.GetLeader(), group, local, remote,
            sink, session));
      bootstrap_index < server_total ? server_count++ : client_count++;

      local[0] = BufferAddress::CreateAny();
    } else {
      QSharedPointer<ISink> sink(new BufferSink());
      nodes.append(CreateNode(Id(), group, local, remote, sink, session));
      bootstrap_index < server_total ? server_count++ : client_count++;

      local[0] = BufferAddress::CreateAny();

      sink = QSharedPointer<ISink>(new BufferSink());
      nodes.append(CreateNode(group.GetLeader(), group, local, remote,
            sink, session));
      leader_index < server_total ? server_count++ : client_count++;
    }

    for(int idx = server_count; idx < server_total; idx++) {
      QSharedPointer<ISink> sink(new BufferSink());
      nodes.append(CreateNode(Id(), group, local, remote, sink, session));
    }

    for(int idx = client_count; idx < client_total; idx++) {
      QSharedPointer<ISink> sink(new BufferSink());
      nodes.append(CreateNode(Id(), group, local, remote, sink, session));
    }

    QVector<PublicIdentity> clients;
    QVector<PublicIdentity> servers;

    SignalCounter sc;
    foreach(QSharedPointer<Node> node, nodes) {
      QObject::connect(node->GetSessionManager().GetDefaultSession().data(),
          SIGNAL(RoundStarting(QSharedPointer<Round>)), &sc, SLOT(Counter()));
      node->GetOverlay()->Start();
      clients.append(GetPublicIdentity(node->GetPrivateIdentity()));
      if(clients.last().GetSuperPeer()) {
        servers.append(clients.last());
      }
    }

    qDebug() << "Running until first round is started";
    int count = server_total + client_total;
    RunUntil(sc, count);
    qDebug() << "First round started";

    Group fullgroup(clients, group.GetLeader(), Group::ManagedSubgroup, servers);
    EXPECT_TRUE(CheckClientServer(nodes, fullgroup));
    return nodes;
  }

  TEST(CSOverlay, Bootstrap)
  {
    int clients = Random::GetInstance().GetInt(TEST_RANGE_MIN, TEST_RANGE_MAX);
    int servers = Random::GetInstance().GetInt(4, TEST_RANGE_MIN);
    Timer::GetInstance().UseVirtualTime();
    QList<QSharedPointer<Node> > nodes = GenerateOverlay(servers, clients,
        SessionFactory::NULL_ROUND);
    TerminateOverlay(nodes);
  }

  TEST(CSOverlay, Session)
  {
    int clients = Random::GetInstance().GetInt(TEST_RANGE_MIN, TEST_RANGE_MAX);
    int servers = Random::GetInstance().GetInt(4, TEST_RANGE_MIN);
    Timer::GetInstance().UseVirtualTime();
    QList<QSharedPointer<Node> > nodes = GenerateOverlay(servers, clients,
        SessionFactory::REPEATING_BULK);
    SendTest(nodes);
    TerminateOverlay(nodes);
  }
}
}
