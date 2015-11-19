#include <stdio.h>

int main () {
	int z=7;
	int i=0, j=0, MAX=32767;
	for (i=0; i<MAX; i++) {
		for (j=0; j<MAX; j++) {
			z<<1;
		}
	}
}
