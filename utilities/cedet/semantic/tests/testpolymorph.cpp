/** testpolymorph.cpp --- A sequence of polymorphism examples.
 *
 * Copyright (C) 2009 Eric M. Ludlam
 *
 * Author: Eric M. Ludlam <eric@siege-engine.com>
 * X-RCS: $Id: testpolymorph.cpp,v 1.1 2009/09/01 22:15:45 zappo Exp $
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2, or (at
 * your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

#include <cmath>

// Test 1 - Functions w/ prototypes
namespace proto {

  int pt_func1(int arg1);
  int pt_func1(int arg1) {
    return 0;
  }

}

// Test 2 - Functions w/ different arg lists.
namespace fcn_poly {
  
  int pm_func(void) {
    return 0;
  }
  int pm_func(int a) {
    return a;
  }
  int pm_func(char a) {
    return int(a);
  }
  int pm_func(double a) {
    return int(floor(a));
  }

}

// Test 3 - Methods w/ differet arg lists.
class meth_poly {
public:
  int pm_meth(void) {
    return 0;
  }
  int pm_meth(int a) {
    return a;
  }
  int pm_meth(char a) {
    return int(a);
  }
  int pm_meth(double a) {
    return int(floor(a));
  }

};

// Test 4 - Templates w/ specifiers.
namespace template_spec {
  template <typename T> class test
  {
  public:
    void doSomething(T t) { };
  };

  template <typename T> class test<T *>
  {
  public:
    void doSomething(T* t) { };
  };
}


// End of polymorphism test file.
