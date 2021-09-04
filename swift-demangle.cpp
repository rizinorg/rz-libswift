#include <rz_libswift.h>
#include <iostream>

int main(int argc, char const *argv[]) {
	if (argc != 2) {
		std::cerr << argv[0];
		std::cerr << " <swift symbol>";
		std::cerr << std::endl;
		return 1;
	}
	std::string symbol(argv[1]);
	std::cout << rz_libswift_demangle_line(symbol) << std::endl;
	return 0;
}