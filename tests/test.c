#include "libasm.h"
#include <stdio.h>

int main() {
  char *string = "Hello World!";
  size_t length = ft_strlen(string);

  printf("Length of \"%s\" is %zu\n", string, length);

  return 0;
}
