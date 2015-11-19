#ifndef DISSENT_IDENTITY_PRIVATE_IDENTITY_H_GUARD
#define DISSENT_IDENTITY_PRIVATE_IDENTITY_H_GUARD

#include <QSharedPointer>

#include "Connections/Id.hpp"
#include "Crypto/AsymmetricKey.hpp"
#include "Crypto/DiffieHellman.hpp"
#include "PublicIdentity.hpp"

namespace Dissent {
namespace Identity {
  /**
   * A container class for holding a user's data.  Allows for making changes
   * to the user component in the session and round code easier.
   */
  class PrivateIdentity {
    public:
      typedef Connections::Id Id;
      typedef Crypto::AsymmetricKey AsymmetricKey;
      typedef Crypto::DiffieHellman DiffieHellman;

      /**
       * Constructor
       * @param local_id local node's id
       * @param signing_key local node's signing key
       * @param decryption_key local node's decryption key
       * @param dh_key local node's DiffieHellman key
       * @param super_peer is the peer capable of being a super peer
       */
      explicit PrivateIdentity(const Id &local_id = Id::Zero(),
          QSharedPointer<AsymmetricKey> signing_key = QSharedPointer<AsymmetricKey>(),
          QSharedPointer<AsymmetricKey> decryption_key = QSharedPointer<AsymmetricKey>(),
          DiffieHellman dh_key = DiffieHellman(),
          bool super_peer = true) :
        _local_id(local_id),
        _signing_key(signing_key),
        _decryption_key(decryption_key),
        _dh_key(dh_key),
        _super_peer(super_peer)
      {
      }

      /**
       * Returns the local node's Id
       */
      const Id &GetLocalId() const { return _local_id; }

      /**
       * Returns the local node's signing key
       */
      QSharedPointer<AsymmetricKey> GetSigningKey() const { return _signing_key; }

      /**
       * Returns the decrypting key
       */
      QSharedPointer<AsymmetricKey> GetDecryptionKey() const { return _decryption_key; }

      /**
       * Returns the local node's DiffieHellman key
       */
      const DiffieHellman &GetDhKey() const { return _dh_key; }

      /**
       * Returns if the member can be a super peer
       */
      bool GetSuperPeer() const { return _super_peer; }

    private:
      Id _local_id;
      QSharedPointer<AsymmetricKey> _signing_key;
      QSharedPointer<AsymmetricKey> _decryption_key;
      DiffieHellman _dh_key;
      bool _super_peer;
  };

  inline PublicIdentity GetPublicIdentity(const PrivateIdentity &ident)
  {
    QSharedPointer<PrivateIdentity::AsymmetricKey> v_key, d_key;
    QByteArray dh_pub = QByteArray();

    if(ident.GetSigningKey()) {
      v_key = ident.GetSigningKey()->GetPublicKey();
    }

    if(ident.GetDecryptionKey()) {
      d_key = ident.GetDecryptionKey()->GetPublicKey();
    }

    dh_pub = ident.GetDhKey().GetPublicComponent();

    return PublicIdentity(ident.GetLocalId(), v_key, d_key, dh_pub,
        ident.GetSuperPeer());
  }
}
}

#endif
