#ifndef INTERNAL_PROJECT_A_HPP_
#define INTERNAL_PROJECT_A_HPP_

#include "stdio.h"

namespace internal
{

class ProjectAHelper
{
public:
  ProjectAHelper() = default;

  void print_debug() const
  {
    fprintf(stdout, "printing random debug message\n");
  }
};

}  // namespace internal
#endif  // INTERNAL_PROJECT_A_HPP_
