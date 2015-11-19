#ifndef DISSENT_ANONYMITY_CONTINUOUS_BULK_ROUND_H_GUARD
#define DISSENT_ANONYMITY_CONTINUOUS_BULK_ROUND_H_GUARD

#include <QMetaEnum>
#include <QSharedPointer>

#include "Crypto/CryptoRandom.hpp"
#include "Crypto/DiffieHellman.hpp"
#include "Messaging/BufferSink.hpp"
#include "Messaging/GetDataCallback.hpp"
#include "Utils/TimerEvent.hpp"
#include "Utils/Triple.hpp"
#include "Utils/Random.hpp"

#include "Log.hpp"
#include "Round.hpp"

namespace Dissent {
namespace Utils {
  class Random;
}

namespace Anonymity {
  class ShuffleRound;

  /**
   * Represents a single instance of a cryptographically secure anonymous
   * exchange.
   *
   * The "V2" bulk protocol consists of a shuffle round which shares an
   * anonymous DiffieHellman public component and public signing key.  The
   * cleartext in each transmission is the phase number, length of the next
   * phase's message, a message, and a signature.  The xor mask generation,
   * distribution, and resolution  are the same as "V1".  See BulkRound
   * comments for more information.
   */
  class RepeatingBulkRound : public Round {
    Q_OBJECT

    Q_ENUMS(State);
    Q_ENUMS(MessageType);

    public:
      typedef Crypto::DiffieHellman DiffieHellman;
      typedef Messaging::BufferSink BufferSink;
      typedef Messaging::GetDataMethod<RepeatingBulkRound> BulkGetDataCallback;
      typedef Utils::Random Random;
      typedef Utils::Triple<QByteArray, QSharedPointer<AsymmetricKey>,
              Crypto::CryptoRandom> Descriptor;

      /**
       * Varius stages of the bulk
       */
      enum State {
        Offline,
        Shuffling,
        PhasePreparation,
        DataSharing,
        Finished
      };

      /**
       * Converts a MessageType into a QString
       * @param mt value to convert
       */
      static QString StateToString(State st)
      {
        int index = staticMetaObject.indexOfEnumerator("State");
        return staticMetaObject.enumerator(index).valueToKey(st);
      }

      /**
       * Various message types sent and received
       */
      enum MessageType {
        BulkData = 0,
      };

      /**
       * Converts a MessageType into a QString
       * @param mt value to convert
       */
      static QString MessageTypeToString(MessageType mt)
      {
        int index = staticMetaObject.indexOfEnumerator("MessageType");
        return staticMetaObject.enumerator(index).valueToKey(mt);
      }

      /**
       * Constructor
       * @param group Group used during this round
       * @param ident the local nodes credentials
       * @param round_id Unique round id (nonce)
       * @param network handles message sending
       * @param get_data requests data to share during this session
       * @param create_shuffle optional parameter specifying a shuffle round
       * to create, currently used for testing
       */
      explicit RepeatingBulkRound(const Group &group, const PrivateIdentity &ident,
          const Id &round_id, QSharedPointer<Network> network,
          GetDataCallback &get_data,
          CreateRound create_shuffle = &TCreateRound<ShuffleRound>);

      /**
       * Destructor
       */
      virtual ~RepeatingBulkRound() {}

      /**
       * Handle a data message from a remote peer
       * @param notification message from a remote peer
       */
      virtual void IncomingData(const Request &notification);

      /**
       * Returns a list of members who have been blamed in the round
       */
      inline virtual const QVector<int> &GetBadMembers() const { return _bad_members; }

      /**
       * QString rep
       */
      inline virtual QString ToString() const
      {
        return "RepeatingBulkRound: " + GetRoundId().ToString() +
          " Phase: " + QString::number(_phase);
      }

      /**
       * Internal bulk state
       */
      inline State GetState() { return _state; }

      /**
       * Returns the ShuffleRound used to exchange descriptors
       */
      QSharedPointer<Round> GetShuffleRound() { return _shuffle_round; }

      /**
       * Notifies this round that a peer has joined the session.  This will
       * cause this type of round to finished immediately.
       */
      virtual void PeerJoined() { _stop_next = true; }

      /**
       * Returns the internal phase.
       */
      virtual uint GetPhase() { return _phase; }

      /**
       * Checks and prints the state of the round
       */
      void CheckState(const int &undef);

    protected:
      /**
       * Called when the BulkRound is started
       */
      virtual void OnStart();

      /**
       * Called when the BulkRound is stopped
       */
      virtual void OnStop();

      /**
       * If data is from a legitimate group member, it is processed
       * @param data Incoming data
       * @param from the remote peer sending the data
       */
      virtual void ProcessData(const Id &from, const QByteArray &data);

      /**
       * This function does the hard work of processing data packets and throws
       * exceptions for invalid data packets
       * @param data Incoming data
       * @param from sending peer
       */
      void ProcessDataBase(const Id &from, const QByteArray &data);

      /**
       * Returns the ShuffleSink to access serialized descriptors
       */
      const BufferSink &GetShuffleSink() const
      {
        return _shuffle_sink;
      }

      /**
       * Returns the parsed descriptors
       */
      const QVector<Descriptor> &GetDescriptors() const { return _descriptors; }

      /**
       * Parses and handles bulk data messages
       * @param stream serialized message
       * @param from the sender
       */
      void HandleBulkData(QDataStream &stream, const Id &from);

      /**
       * Returns this phases expected message size
       */
      uint GetExpectedBulkMessageSize() { return _expected_bulk_size; }

      /**
       * Sets the list of anonymous rngs
       */
      void SetAnonymousRngs(const QVector<Crypto::CryptoRandom> &anon_rngs)
      {
        _anon_rngs = anon_rngs;
      }

      const QVector<Crypto::CryptoRandom> &GetAnonymousRngs() { return _anon_rngs; }

      /**
       * Sets the internal state of the bulk round
       */
      void SetState(State state) { _state = state; }

      /**
       * Prepares the local members cleartext message
       * returns the local members cleartext message
       */
      QByteArray GenerateMyCleartextMessage();

      /**
       * Returns the local members index
       */
      uint GetMyIndex() { return _my_idx; }

      /**
       * Returns the list of current phase message lengths
       */
      const QVector<uint> &GetMessageLengths() { return _message_lengths; }

      /**
       * Returns the list of static sized headers / footers
       */
      const QVector<uint> &GetHeaderLengths() { return _header_lengths; }

      /**
       * Returns the anonymous DiffieHellman key
       */
      DiffieHellman &GetAnonymousDh() { return _anon_dh; }

      /**
       * Does all the prep work for the next phase, clearing and zeroing out
       * all the necessary fields
       * @returns true if all good, returns false if stopped
       */
      virtual bool PrepForNextPhase();

    private:
      /**
       * Once all bulk data messages have been received, parse them
       */
      void ProcessMessages();
      
      /**
       * Parse the clear text message returning back the entry if the contents
       * are valid
       * @param cleartext the entire cleartext array
       * @param member_idx the anonymous owners index
       * @returns the cleartext message
       */
      QByteArray ProcessMessage(const QByteArray &cleartext, uint member_idx);

      /**
       * Prepares the messages for the phase registered and sends the proper
       * bulk message
       */
      void NextPhase();

      /**
       * Generates the entire xor message with the local members message
       * embedded within
       */
      virtual QByteArray GenerateXorMessage();

      /**
       * Generates the proper xor message for the local member
       * @returns the local members xor message
       */
      QByteArray GenerateMyXorMessage();

      /**
       * Returns the descriptors for sending in the shuffle round
       * @param max maximum amount of bytes to return
       * @returns the descriptor and false
       */
      QPair<QByteArray, bool> GetShuffleData(int max);

      /**
       * Parses the descriptor and returns a parsed descriptor
       * @param bdes the serialized descriptor
       * @returns the parsed descriptor
       */
      Descriptor ParseDescriptor(const QByteArray &bdes);

      /**
       * Called when it is time to generate the anon key and dh
       */
      BulkGetDataCallback _get_shuffle_data;

      /**
       * Current state of the node
       */
      State _state;

      /**
       * Stores all validated messages that arrived before start was called
       */
      Log _offline_log;

      /**
       * Stores all validated incoming messages
       */
      Log _log;

      /**
       * Anonymous DH used to generate RNG seeds
       */
      DiffieHellman _anon_dh;

      /**
       * Anonymous key used sign messages
       */
      QSharedPointer<AsymmetricKey> _anon_key;

      /**
       * Rngs used to generate our xor message
       */
      QVector<Crypto::CryptoRandom> _anon_rngs;

      /**
       * Holds the shuffle round
       */
      QSharedPointer<Round> _shuffle_round;

      /**
       * Stores the output of the shuffle
       */
      BufferSink _shuffle_sink;

      /**
       * Size determines by the accumulated length in the descriptors
       */
      uint _expected_bulk_size;

      /**
       * Fixed sized footer / header lengths
       */
      QVector<uint> _header_lengths;

      /**
       * Message lengths for the next phase
       */
      QVector<uint> _message_lengths;

      /**
       * The continuous bulk round is made up of many bulk phases
       */
      uint _phase;

      /**
       * received bulk messages
       */
      QVector<QByteArray> _messages;

      /**
       * List of messages that should be in the local nodes slot
       */
      QVector<QByteArray> _expected_msgs;

      /**
       * Count of received messages
       */
      uint _received_messages;

      /**
       * Next clear text message
       */
      QByteArray _next_msg;

      /**
       * Anon dh and keys
       */
      QVector<Descriptor> _descriptors;

      /**
       * Data placed into the shuffle
       */
      QByteArray _shuffle_data;

      /**
       * Anon index
       */
      uint _my_idx;

      /**
       * List of bad nodes by group index
       */
      QVector<int> _bad_members;

      /**
       * Causes this round to stop after the current phase ends
       */
      bool _stop_next;

      Utils::TimerEvent _check_event;

      uint _last_phase;

    private slots:
      /**
       * Called when the descriptor shuffle ends
       */
      void ShuffleFinished();
  };
}
}

#endif
