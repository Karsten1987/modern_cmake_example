#include "project_a/project_a.hpp"
#include "./internal_include/project_a.hpp"

#include "stdio.h"

void ProjectA::print() const
{
  fprintf(stdout, "printing ProjectA\n");
  internal::ProjectAHelper a_helper;
  a_helper.print_debug();
}
