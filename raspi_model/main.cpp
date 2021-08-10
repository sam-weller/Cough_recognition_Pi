#include "main.h"
#include "raspi_model.h"
#include "raspi_model_terminate.h"
#include "rt_nonfinite.h"
#include <string.h>

int main_raspi_model();

int main_raspi_model() {
  int x = raspi_model();
  if(x == 1) {return 1;}
  else {return 0;}
}

int main(int, const char * const []) {
  int x = main_raspi_model();
  return x;
}
