// Copyright (c) 2003-2006  INRIA Sophia-Antipolis (France).
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
// $URL: svn+ssh://scm.gforge.inria.fr/svn/cgal/branches/CGAL-3.2-branch/Curved_kernel/include/CGAL/Curved_kernel/function_objects_on_circle_2.h $
// $Id: function_objects_on_circle_2.h 29572 2006-03-17 10:17:29Z afabri $
//
// Author(s)     : Monique Teillaud, Sylvain Pion

// Partially supported by the IST Programme of the EU as a Shared-cost
// RTD (FET Open) Project under Contract No  IST-2000-26473 
// (ECG - Effective Computational Geometry for Curves and Surfaces) 
// and a STREP (FET Open) Project under Contract No  IST-006413 
// (ACS -- Algorithms for Complex Shapes)

#ifndef CGAL_CURVED_KERNEL_FUNCTION_OBJECTS_ON_CIRCLE_2_H
#define CGAL_CURVED_KERNEL_FUNCTION_OBJECTS_ON_CIRCLE_2_H

#include <CGAL/Curved_kernel/internal_functions_on_circle_2.h>

#include <CGAL/Curved_kernel/function_objects_on_line_2.h> 
// to be removed when CGAL::Kernel has a Get_equation

namespace CGAL {
namespace CircularFunctors {

  template < class CK >
  class Construct_circle_2 : public  CK::Linear_kernel::Construct_circle_2
  {
  public:
    
    typedef typename CK::Circle_2 result_type;
    typedef Arity_tag<1>          Arity; 

    using CK::Linear_kernel::Construct_circle_2::operator();

    result_type
    operator() ( const typename CK::Polynomial_for_circles_2_2 &eq )
      {
	return construct_circle_2<CK>(eq);
      }
  };

  template < class CK >
  class Get_equation : public LinearFunctors::Get_equation<CK>
  {
    public:

    typedef typename CK::Polynomial_for_circles_2_2 result_type;
    typedef Arity_tag<1>                            Arity;

    using LinearFunctors::Get_equation<CK>::operator();

    result_type
    operator() ( const typename CK::Circle_2 & c )
      {
	return CircularFunctors::get_equation<CK>(c);
      }
  };

} // namespace CircularFunctors
} // namespace CGAL

#endif // CGAL_CURVED_KERNEL_FUNCTION_OBJECTS_ON_CIRCLE_2_H
