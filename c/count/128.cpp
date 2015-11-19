#include <boost/multiprecision/cpp_int.hpp>
#include <boost/lexical_cast.hpp>
#include <cmath>
#include <iostream>

// Requires Boost 1.53 or higher (for multiprecision)
// How long does it take one core to count to a certain number of bits?
// To build: g++ 128.cpp -o count -Wall -Wextra
// To use: time ./count number

int main(int argc, char * argv[])
{
	const std::string usage = "usage: time ./count number\n";

	if( argc != 2 )
	{
		std::cerr << usage;
		return 1;
	}

	namespace mp = boost::multiprecision;

	int bits = boost::lexical_cast<int>(argv[1]);

	mp::uint512_t c(pow(2, bits));
	mp::uint512_t d(0);

	std::cout << "Counting to: " << c << "\n";

        while ( d != c )
	{
		++d;
	}

	return 0;
}

