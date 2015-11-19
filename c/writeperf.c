#include <stdio .h>

/* my code, but it's been at http://pastie.org/pastes/451538.txt  */

int main(int argc, char* argv[])
{
        if (argc>1)
        {
                printf("%s\n", argv[1]);
                FILE *f;
                f = fopen(argv[1], "w");

                int c=0, num=8192, sz=8192;
                char block[num];
                for (c=0; c<sz ; c++)
                        block[c] = '1';
                for (c=0; c<num; c++)
                        fprintf(f, block);
                fclose(f);
        }
        else
                printf("specify a full filename path dumbass\n");
}

