#ifndef DISSENT_BUFFER_TRANSPORT_ADDRESS_H_GUARD
#define DISSENT_BUFFER_TRANSPORT_ADDRESS_H_GUARD

#include "Address.hpp"

namespace Dissent {
namespace Transports {
  /**
   * Private data holder for BufferAddress
   */
  class BufferAddressData : public AddressData {
    public:
      explicit BufferAddressData(const QUrl &url, int id) :
        AddressData(url), id(id)
      {
      }

      virtual ~BufferAddressData() { }
      virtual bool Equals(const AddressData *other) const;

      const int id;
      inline virtual bool Valid() const { return id > 0; }
      
      BufferAddressData(const BufferAddressData &other) : AddressData(other), id(0)
      {
        throw std::logic_error("Not callable");
      }
                
      BufferAddressData &operator=(const BufferAddressData &)
      {
        throw std::logic_error("Not callable");
      }
  };

  /**
   * A wrapper container for (Buffer)AddressData for Buffer end points
   */
  class BufferAddress : public Address {
    public:
      const static QString Scheme;

      explicit BufferAddress(const QUrl &url);
      BufferAddress(const BufferAddress &other);

      /**
       * Creates a buffer address using the provided int
       * @param id the integer to use, defaults to "any"
       */
      explicit BufferAddress(int id = 0);

      /**
       * Destructor
       */
      virtual ~BufferAddress() {}

      static const Address Create(const QUrl &url);
      static const Address CreateAny();

      /**
       * An integer that uniquely identifies a BufferEdge endpoint
       */
      inline int GetId() const {
        const BufferAddressData *data = GetData<BufferAddressData>();
        if(data == 0) {
          return -1;
        } else {
          return data->id;
        }
      }

    private:
      void Init(int id);
  };
}
}

#endif
