#include <my_library/my_template.hpp>

#include <cassert>



struct my_type{};

bool operator ==(const my_type&, const my_type&) 
{
  return true;
}



void test_my_template_basic_types()
{
  using test_type = my_library::my_template<int>;

  test_type test_value;

  test_value.set_value(10);
  assert(10 == test_value.get_value());
}



void test_my_template_custom_types()
{
  using test_type = my_library::my_template<my_type>;

  test_type test_value;

  test_value.set_value(my_type{});
  assert(my_type{} == test_value.get_value());
}