// Copyright (c) 1997  Tel-Aviv University (Israel).
// All rights reserved.
//
// This file is part of CGAL (www.cgal.org); you may redistribute it under
// the terms of the Q Public License version 1.0.
// See the file LICENSE.QPL distributed with CGAL.
//
// Licensees holding a valid commercial license may use this file in
// accordance with the commercial license agreement provided with the software.
//
// This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE
// WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
//
// $URL: svn+ssh://scm.gforge.inria.fr/svn/cgal/branches/CGAL-3.2-branch/Arrangement_2/include/CGAL/Arr_point_location/Td_ninetuple.h $
// $Id: Td_ninetuple.h 30322 2006-04-14 15:07:17Z lsaboret $
// 
//
// Author(s)     : Oren Nechushtan <theoren@math.tau.ac.il>
//                 Iddo Hanniel <hanniel@math.tau.ac.il>
#ifndef CGAL_TD_NINETUPLE_H
#define CGAL_TD_NINETUPLE_H

CGAL_BEGIN_NAMESPACE

template <class F0,class F1,class F2,class F3,class F4,class F5,class F6,
  class F7,class F8>
class Td_ninetuple : public Rep
{
public:
  F0 e0;
  F1 e1;
  F2 e2;
  F3 e3;
  F4 e4;
  F5 e5;
  F6 e6;
  F7 e7;
  F8 e8;
  
  Td_ninetuple()
  {}
  Td_ninetuple(const F0 & a0, const F1 & a1, const F2 & a2, const F3 & a3,
               const F4 & a4, const F5 & a5, const F6 & a6, const F7 & a7, 
               const F8 & a8)
    : e0(a0),e1(a1),e2(a2),e3(a3),e4(a4),e5(a5),e6(a6),e7(a7),e8(a8)
  {}
  Td_ninetuple(const Td_ninetuple<F0,F1,F2,F3,F4,F5,F6,F7,F8> & a)
    : e0(a.e0),e1(a.e1),e2(a.e2),e3(a.e3),e4(a.e4),e5(a.e5),e6(a.e6),e7(a.e7),
      e8(a.e8)
  {}
  ~Td_ninetuple()
  {}
};

CGAL_END_NAMESPACE

#endif









