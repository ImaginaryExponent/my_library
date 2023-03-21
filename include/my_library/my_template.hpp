#pragma once

namespace my_library
{
  template <typename T>
  class my_template
  {
  public:
    void set_value(const T &val)
    {
      m_value = val;
    }

    const T &get_value() const noexcept
    {
      return m_value;
    }
    
  private:
    T m_value;
  };
}