// Copyright (c) 1997-2004  Utrecht University (The Netherlands),
// ETH Zurich (Switzerland), Freie Universitaet Berlin (Germany),
// INRIA Sophia-Antipolis (France), Martin-Luther-University Halle-Wittenberg
// (Germany), Max-Planck-Institute Saarbruecken (Germany), RISC Linz (Austria),
// and Tel-Aviv University (Israel).  All rights reserved.
//
// This file is part of CGAL (www.cgal.org); you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public License as
// published by the Free Software Foundation; version 2.1 of the License.
// See the file LICENSE.LGPL distributed with CGAL.
//
// Licensees holding a valid commercial license may use this file in
// accordance with the commercial license agreement provided with the software.
//
// This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE
// WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
//
// $URL: svn+ssh://scm.gforge.inria.fr/svn/cgal/branches/CGAL-3.2-branch/Intersections_3/include/CGAL/intersection_3_1.C $
// $Id: intersection_3_1.C 29773 2006-03-26 21:31:32Z spion $
// 
//
// Author(s)     : Geert-Jan Giezeman <geert@cs.uu.nl>


#include <CGAL/wmult.h>

CGAL_BEGIN_NAMESPACE

namespace CGALi {

template <class K>
Object
intersection(const typename CGAL_WRAP(K)::Plane_3  &plane, 
	     const typename CGAL_WRAP(K)::Line_3 &line, 
	     const K&)
{
    typedef typename K::Point_3 Point_3;
    typedef typename K::Direction_3 Direction_3;
    typedef typename K::RT RT;
    const Point_3 &line_pt = line.point();
    const Direction_3 &line_dir = line.direction();
    RT num,  den;
    num = plane.a()*line_pt.hx() + plane.b()*line_pt.hy()
          + plane.c()*line_pt.hz() + wmult((K*)0, plane.d(), line_pt.hw());
    den = plane.a()*line_dir.dx() + plane.b()*line_dir.dy()
          + plane.c()*line_dir.dz();
    if (den == RT(0)) {
        if (num == RT(0)) {
            // all line
            return make_object(line);
        } else {
            // no intersection
            return Object();
        }
    }
    return make_object(Point_3(
        den*line_pt.hx()-num*line_dir.dx(),
        den*line_pt.hy()-num*line_dir.dy(),
        den*line_pt.hz()-num*line_dir.dz(),
        wmult((K*)0, den, line_pt.hw())));
}

template <class K>
inline
Object
intersection(const typename CGAL_WRAP(K)::Line_3 &line, 
	     const typename CGAL_WRAP(K)::Plane_3  &plane, 
	     const K& k)
{
  return intersection(plane, line, k);
}

template <class K>
Object
intersection(const typename CGAL_WRAP(K)::Plane_3 &plane1, 
	     const typename CGAL_WRAP(K)::Plane_3 &plane2, 
	     const K&)
{
  typedef typename K::Point_3 Point_3;
  typedef typename K::Direction_3 Direction_3;
  typedef typename K::Line_3 Line_3;

    typedef typename K::RT RT;
    const RT &a = plane1.a();
    const RT &b = plane1.b();
    const RT &c = plane1.c();
    const RT &d = plane1.d();
    const RT &p = plane2.a();
    const RT &q = plane2.b();
    const RT &r = plane2.c();
    const RT &s = plane2.d();
    const RT zero = RT(0);
    RT det;
    Point_3 is_pt;
    Direction_3 is_dir;

    det = a*q-p*b;
    if (det != zero) {
        is_pt = Point_3(b*s-d*q, p*d-a*s, zero, det);
        is_dir = Direction_3(b*r-c*q, p*c-a*r, det);
        return make_object(Line_3(is_pt, is_dir));
    }
    det = a*r-p*c;
    if (det != zero) {
        is_pt = Point_3(c*s-d*r, zero, p*d-a*s, det);
        is_dir = Direction_3(c*q-b*r, det, p*b-a*q);
        return make_object(Line_3(is_pt, is_dir));
    }
    det = b*r-c*q;
    if (det != zero) {
        is_pt = Point_3(zero, c*s-d*r, d*q-b*s, det);
        is_dir = Direction_3(det, c*p-a*r, a*q-b*p);
        return make_object(Line_3(is_pt, is_dir));
    }
// degenerate case
    if (a!=zero || p!=zero) {
        if (a*s == p*d)
            return make_object(plane1);
        else
            return Object();
    }
    if (b!=zero || q!=zero) {
        if (b*s == q*d)
            return make_object(plane1);
        else
            return Object();
    }
    if (c!=zero || r!=zero) {
        if (c*s == r*d)
            return make_object(plane1);
        else
            return Object();
    }
    return make_object(plane1);
}

template <class K>
Object
intersection(const typename CGAL_WRAP(K)::Plane_3 &plane1,
	     const typename CGAL_WRAP(K)::Plane_3 &plane2,
	     const typename CGAL_WRAP(K)::Plane_3 &plane3,
	     const K& k)
{
    typedef typename K::Line_3       Line_3;
    typedef typename K::Plane_3      Plane_3;

    // Intersection between plane1 and plane2 can either be
    // a line, a plane, or empty.
    Object o12 = CGALi::intersection(plane1, plane2, k);

    if (const Line_3 *l = object_cast<Line_3>(&o12))
        return CGALi::intersection(plane3, *l, k);

    if (const Plane_3 *pl = object_cast<Plane_3>(&o12))
        return CGALi::intersection(plane3, *pl, k);

    return Object();
}


template <class K>
bool
do_intersect(const typename CGAL_WRAP(K)::Plane_3 &plane, 
	     const typename CGAL_WRAP(K)::Line_3 &line,
	     const K&)
{
    typedef typename K::Point_3 Point_3;
    typedef typename K::Direction_3 Direction_3;
    typedef typename K::RT RT;
    const Point_3 &line_pt = line.point();
    const Direction_3 &line_dir = line.direction();
    RT num,  den;
    den = plane.a()*line_dir.dx() + plane.b()*line_dir.dy()
        + plane.c()*line_dir.dz();
    if (den !=  RT(0))
        return true;
    num = plane.a()*line_pt.hx() + plane.b()*line_pt.hy()
        + plane.c()*line_pt.hz() + wmult((K*)0, plane.d(), line_pt.hw());
    if (num == RT(0)) {
        // all line
        return true;
    } else {
        // no intersection
        return false;
    }
}

template <class K>
inline
bool
do_intersect(const typename CGAL_WRAP(K)::Line_3 &line, 
	     const typename CGAL_WRAP(K)::Plane_3 &plane, 
	     const K& k)
{
  return do_intersect(plane, line, k);
}


template <class K>
Object
intersection(const typename CGAL_WRAP(K)::Plane_3 &plane, 
	     const typename CGAL_WRAP(K)::Ray_3 &ray, 
	     const K& k)
{
    typedef typename K::Point_3 Point_3;
    const Object line_intersection =
            intersection(plane, ray.supporting_line(), k);
    if (const Point_3 *isp = object_cast<Point_3>(&line_intersection)) {
        if (ray.collinear_has_on(*isp))
            return line_intersection;
        else
            return Object();
    }
    if (line_intersection.is_empty())
        return line_intersection;
    return make_object(ray);
}


template <class K>
inline
Object
intersection(const typename CGAL_WRAP(K)::Ray_3 &ray, 
	     const typename CGAL_WRAP(K)::Plane_3 &plane, 
	     const K& k)
{
  return intersection(plane, ray, k);
}



template <class K>
bool
do_intersect(const typename CGAL_WRAP(K)::Plane_3 &plane, 
	     const typename CGAL_WRAP(K)::Ray_3 &ray, 
	     const K& k)
{
    typedef typename K::Point_3 Point_3;
    const Object line_intersection =
            intersection(plane, ray.supporting_line(), k);
    if (line_intersection.is_empty())
        return false;
    if (const Point_3 *isp = object_cast<Point_3>(&line_intersection))
        return ray.collinear_has_on(*isp);
    return true;
}


template <class K>
inline
bool
do_intersect(const typename CGAL_WRAP(K)::Ray_3 &ray, 
	     const typename CGAL_WRAP(K)::Plane_3 &plane, 
	     const K& k)
{
  return do_intersect(plane, ray, k);
}


template <class K>
Object
intersection(const typename CGAL_WRAP(K)::Plane_3 &plane, 
	     const typename CGAL_WRAP(K)::Segment_3 &seg, 
	     const K& k)
{
    typedef typename K::Point_3 Point_3;
    const Point_3 &source = seg.source();
    const Point_3 &target = seg.target();
    Oriented_side source_side,target_side;
    source_side = plane.oriented_side(source);
    target_side = plane.oriented_side(target);
    switch (source_side) {
    case ON_ORIENTED_BOUNDARY:
        if (target_side == ON_ORIENTED_BOUNDARY)
            return make_object(seg);
        else
            return make_object(source);
    case ON_POSITIVE_SIDE:
        switch (target_side) {
        case ON_ORIENTED_BOUNDARY:
            return make_object(target);
        case ON_POSITIVE_SIDE:
            return Object();
        case ON_NEGATIVE_SIDE:
            return intersection(plane, seg.supporting_line(), k);
        }
    case ON_NEGATIVE_SIDE:
        switch (target_side) {
        case ON_ORIENTED_BOUNDARY:
            return make_object(target);
        case ON_POSITIVE_SIDE:
            return intersection(plane, seg.supporting_line(), k);
        case ON_NEGATIVE_SIDE:
            return Object();
        }
    }
    CGAL_kernel_assertion_msg(false, "Supposedly unreachable code.");
    return Object();
}


template <class K>
inline
Object
intersection(const typename CGAL_WRAP(K)::Segment_3 &seg, 
	     const typename CGAL_WRAP(K)::Plane_3 &plane, 
	     const K& k)
{
  return intersection(plane, seg, k);
}


template <class K>
bool
do_intersect(const typename CGAL_WRAP(K)::Plane_3  &plane, 
	     const typename CGAL_WRAP(K)::Segment_3 &seg, 
	     const K&)
{
    typedef typename K::Point_3 Point_3;
    const Point_3 &source = seg.source();
    const Point_3 &target = seg.target();
    Oriented_side source_side,target_side;
    source_side = plane.oriented_side(source);
    target_side = plane.oriented_side(target);
    if ( source_side == target_side
       && target_side != ON_ORIENTED_BOUNDARY) {
        return false;
    }
    return true;
}


template <class K>
inline
bool
do_intersect(const typename CGAL_WRAP(K)::Segment_3 &seg, 
	     const typename CGAL_WRAP(K)::Plane_3  &plane, 
	     const K& k)
{
  return do_intersect(plane, seg, k);
}


template <class K>
Object
intersection(const typename CGAL_WRAP(K)::Line_3 &line,
	     const Bbox_3 &box, 
	     const K&)
{
    typedef typename K::Point_3 Point_3;
    typedef typename K::Direction_3 Direction_3;
    const Point_3 &linepoint = line.point();
    const Direction_3 &linedir = line.direction();
    return intersection_bl(box,
        CGAL::to_double(linepoint.x()),
        CGAL::to_double(linepoint.y()),
        CGAL::to_double(linepoint.z()),
        CGAL::to_double(linedir.dx()),
        CGAL::to_double(linedir.dy()),
        CGAL::to_double(linedir.dz()),
        true, true
        );
}


template <class K>
inline
Object
intersection(const Bbox_3 &box, 
	     const typename CGAL_WRAP(K)::Line_3 &line, 
	     const K& k)
{
  return intersection(line, box, k);
}


template <class K>
Object
intersection(const typename CGAL_WRAP(K)::Ray_3 &ray,
	     const Bbox_3 &box, 
	     const K&)
{
    typedef typename K::Point_3 Point_3;
    typedef typename K::Direction_3 Direction_3;
    const Point_3 &linepoint = ray.source();
    const Direction_3 &linedir = ray.direction();
    return intersection_bl(box,
        CGAL::to_double(linepoint.x()),
        CGAL::to_double(linepoint.y()),
        CGAL::to_double(linepoint.z()),
        CGAL::to_double(linedir.dx()),
        CGAL::to_double(linedir.dy()),
        CGAL::to_double(linedir.dz()),
        false, true
        );
}


template <class K>
inline
Object
intersection(const Bbox_3 &box, 
	     const typename CGAL_WRAP(K)::Ray_3 &ray, 
	     const K& k)
{
  return intersection(ray, box, k);
}



template <class K>
Object
intersection(const typename CGAL_WRAP(K)::Segment_3 &seg, 
	     const Bbox_3 &box, 
	     const K&)
{
    typedef typename K::Point_3 Point_3;
    typedef typename K::Vector_3 Vector_3;
    const Point_3 &linepoint = seg.source();
    const Vector_3 &diffvec = seg.target()-linepoint;
    return intersection_bl(box,
        CGAL::to_double(linepoint.x()),
        CGAL::to_double(linepoint.y()),
        CGAL::to_double(linepoint.z()),
        CGAL::to_double(diffvec.x()),
        CGAL::to_double(diffvec.y()),
        CGAL::to_double(diffvec.z()),
        false, false
        );
}


template <class K>
inline
Object
intersection(const Bbox_3 &box, 
	     const typename CGAL_WRAP(K)::Segment_3 &seg, 
	     const K& k)
{
  return intersection(seg, box, k);
}


template <class K>
Object
intersection(const typename CGAL_WRAP(K)::Line_3 &line,
	     const typename CGAL_WRAP(K)::Iso_cuboid_3 &box, 
	     const K&)
{
    typedef typename K::Point_3 Point_3;
    typedef typename K::Vector_3 Vector_3;
    typedef typename K::Segment_3 Segment_3;
    typedef typename K::RT RT;
    typedef typename K::FT FT;
    bool all_values = true;
    FT _min = 0, _max = 0; // initialization to stop compiler warning
    Point_3 const & _ref_point=line.point();
    Vector_3 const & _dir=line.direction().vector();
    Point_3 const & _iso_min=box.min();
    Point_3 const & _iso_max=box.max();
    for (int i=0; i< _ref_point.dimension(); i++) {
        if (_dir.homogeneous(i) == RT(0)) {
            if (_ref_point.cartesian(i) < _iso_min.cartesian(i)) {
                return Object();
            }
            if (_ref_point.cartesian(i) > _iso_max.cartesian(i)) {
                return Object();
            }
        } else {
            FT newmin, newmax;
            if (_dir.homogeneous(i) > RT(0)) {
                newmin = (_iso_min.cartesian(i) - _ref_point.cartesian(i)) /
                    _dir.cartesian(i);
                newmax = (_iso_max.cartesian(i) - _ref_point.cartesian(i)) /
                    _dir.cartesian(i);
            } else {
                newmin = (_iso_max.cartesian(i) - _ref_point.cartesian(i)) /
                    _dir.cartesian(i);
                newmax = (_iso_min.cartesian(i) - _ref_point.cartesian(i)) /
                    _dir.cartesian(i);
            }
            if (all_values) {
                _min = newmin;
                _max = newmax;
            } else {
                if (newmin > _min)
                    _min = newmin;
                if (newmax < _max)
                    _max = newmax;
                if (_max < _min) {
                    return Object();
                }
            }
            all_values = false;
        }
    }
    CGAL_kernel_assertion(!all_values);
    if (_max == _min) {
        return make_object(Point_3(_ref_point + _dir * _min ));
    }
    return make_object(
        Segment_3(_ref_point + _dir*_min, _ref_point + _dir*_max));
}


template <class K>
inline
Object
intersection(const typename CGAL_WRAP(K)::Iso_cuboid_3 &box, 
	     const typename CGAL_WRAP(K)::Line_3 &line, 
	     const K& k)
{
  return intersection(line, box, k);
}



template <class K>
Object
intersection(const typename CGAL_WRAP(K)::Ray_3 &ray,
	     const typename CGAL_WRAP(K)::Iso_cuboid_3 &box, 
	     const K&)
{
    typedef typename K::Point_3 Point_3;
    typedef typename K::Vector_3 Vector_3;
    typedef typename K::Segment_3 Segment_3;
    typedef typename K::RT RT;
    typedef typename K::FT FT;
    bool all_values = true;
    FT _min= FT(0), _max;
    Point_3 const & _ref_point=ray.source();
    Vector_3 const & _dir=ray.direction().vector();
    Point_3 const & _iso_min=box.min();
    Point_3 const & _iso_max=box.max();
    int i;
    for (i=0; i< _ref_point.dimension(); i++) {
        if (_dir.homogeneous(i) == RT(0)) {
            if (_ref_point.cartesian(i) < _iso_min.cartesian(i)) {
                return Object();
            }
            if (_ref_point.cartesian(i) > _iso_max.cartesian(i)) {
                return Object();
            }
        } else {
            FT newmin, newmax;
            if (_dir.homogeneous(i) > RT(0)) {
                newmin = (_iso_min.cartesian(i) - _ref_point.cartesian(i)) /
                    _dir.cartesian(i);
                newmax = (_iso_max.cartesian(i) - _ref_point.cartesian(i)) /
                    _dir.cartesian(i);
            } else {
                newmin = (_iso_max.cartesian(i) - _ref_point.cartesian(i)) /
                    _dir.cartesian(i);
                newmax = (_iso_min.cartesian(i) - _ref_point.cartesian(i)) /
                    _dir.cartesian(i);
            }
            if (all_values) {
                _max = newmax;
            } else {
                if (newmax < _max)
                    _max = newmax;
            }
            if (newmin > _min)
                 _min = newmin;
            if (_max < _min)
                return Object();
            all_values = false;
        }
    }
    CGAL_kernel_assertion(!all_values);
    if (_max == _min) {
        return make_object(Point_3(_ref_point + _dir * _min ));
    }
    return make_object(
        Segment_3(_ref_point + _dir*_min, _ref_point + _dir*_max));
}


template <class K>
inline
Object
intersection(const typename CGAL_WRAP(K)::Iso_cuboid_3 &box, 
	     const typename CGAL_WRAP(K)::Ray_3 &ray,
	     const K& k)
{
  return intersection(ray, box, k);
}


template <class K>
Object
intersection(const typename CGAL_WRAP(K)::Segment_3 &seg,
	     const typename CGAL_WRAP(K)::Iso_cuboid_3 &box, 
	     const K&)
{
    typedef typename K::Point_3 Point_3;
    typedef typename K::Vector_3 Vector_3;
    typedef typename K::Segment_3 Segment_3;
    typedef typename K::RT RT;
    typedef typename K::FT FT;
    FT _min= FT(0), _max;

    Point_3 const & _ref_point=seg.source();
    Vector_3 const & _dir=seg.direction().vector();
    Point_3 const & _iso_min=box.min();
    Point_3 const & _iso_max=box.max();
    int main_dir =
        (CGAL_NTS abs(_dir.x()) > CGAL_NTS abs(_dir.y()) )
            ? (CGAL_NTS abs(_dir.x()) > CGAL_NTS abs(_dir.z()) ? 0 : 2)
            : (CGAL_NTS abs(_dir.y()) > CGAL_NTS abs(_dir.z()) ? 1 : 2);
    _max = (seg.target().cartesian(main_dir)-_ref_point.cartesian(main_dir)) /
            _dir.cartesian(main_dir);
    int i;
    for (i=0; i< _ref_point.dimension(); i++) {
        if (_dir.homogeneous(i) == RT(0)) {
            if (_ref_point.cartesian(i) < _iso_min.cartesian(i)) {
                return Object();
            }
            if (_ref_point.cartesian(i) > _iso_max.cartesian(i)) {
                return Object();
            }
        } else {
            FT newmin, newmax;
            if (_dir.homogeneous(i) > RT(0)) {
                newmin = (_iso_min.cartesian(i) - _ref_point.cartesian(i)) /
                    _dir.cartesian(i);
                newmax = (_iso_max.cartesian(i) - _ref_point.cartesian(i)) /
                    _dir.cartesian(i);
            } else {
                newmin = (_iso_max.cartesian(i) - _ref_point.cartesian(i)) /
                    _dir.cartesian(i);
                newmax = (_iso_min.cartesian(i) - _ref_point.cartesian(i)) /
                    _dir.cartesian(i);
            }
            if (newmax < _max)
                _max = newmax;
            if (newmin > _min)
                 _min = newmin;
            if (_max < _min)
                return Object();
        }
    }
    if (_max == _min) {
        return make_object(Point_3(_ref_point + _dir * _min ));
    }
    return make_object(
        Segment_3(_ref_point + _dir*_min, _ref_point + _dir*_max));
}


template <class K>
inline
Object
intersection(const typename CGAL_WRAP(K)::Iso_cuboid_3 &box, 
	     const typename CGAL_WRAP(K)::Segment_3 &seg,
	     const K& k)
{
  return intersection(seg, box, k);
}


template <class K>
Object
intersection(
    const typename CGAL_WRAP(K)::Iso_cuboid_3 &icub1,
    const typename CGAL_WRAP(K)::Iso_cuboid_3 &icub2, 
    const K&)
{
    typedef typename K::Point_3 Point_3;
    typedef typename K::Iso_cuboid_3 Iso_cuboid_3;

    Point_3 min_points[2];
    Point_3 max_points[2];
    min_points[0] = icub1.min();
    min_points[1] = icub2.min();
    max_points[0] = icub1.max();
    max_points[1] = icub2.max();
    typedef typename K::FT FT;
    const int DIM = 3;
    int min_idx[DIM];
    int max_idx[DIM];
    Point_3 newmin;
    Point_3 newmax;
    for (int dim = 0; dim < DIM; ++dim) {
        min_idx[dim] =
          min_points[0].cartesian(dim) >= min_points[1].cartesian(dim) ? 0 : 1;
        max_idx[dim] =
          max_points[0].cartesian(dim) <= max_points[1].cartesian(dim) ? 0 : 1;
        if (min_idx[dim] != max_idx[dim]
                && max_points[max_idx[dim]].cartesian(dim)
                   < min_points[min_idx[dim]].cartesian(dim))
            return Object();
    }
    if (min_idx[0] == min_idx[1] && min_idx[0] == min_idx[2]) {
        newmin = min_points[min_idx[0]];
    } else {
        newmin = Point_3(
            min_idx[0] == 0
                ? wmult((K*)0, min_points[0].hx(), min_points[1].hw())
                : wmult((K*)0, min_points[1].hx(), min_points[0].hw())
            ,
            min_idx[1] == 0
                ? wmult((K*)0, min_points[0].hy(), min_points[1].hw())
                : wmult((K*)0, min_points[1].hy(), min_points[0].hw())
            ,
            min_idx[2] == 0
                ? wmult((K*)0, min_points[0].hz(), min_points[1].hw())
                : wmult((K*)0, min_points[1].hz(), min_points[0].hw())
            ,
            wmult((K*)0, min_points[0].hw(), min_points[1].hw()) );
    }
    if (max_idx[0] == max_idx[1] && max_idx[0] == max_idx[2]) {
        newmax = max_points[max_idx[0]];
    } else {
        newmax = Point_3(
            max_idx[0] == 0
                ? wmult((K*)0, max_points[0].hx(), max_points[1].hw())
                : wmult((K*)0, max_points[1].hx(), max_points[0].hw())
            ,
            max_idx[1] == 0
                ? wmult((K*)0, max_points[0].hy(), max_points[1].hw())
                : wmult((K*)0, max_points[1].hy(), max_points[0].hw())
            ,
            max_idx[2] == 0
                ? wmult((K*)0, max_points[0].hz(), max_points[1].hw())
                : wmult((K*)0, max_points[1].hz(), max_points[0].hw())
            ,
            wmult((K*)0, max_points[0].hw(), max_points[1].hw()) );
    }
    Object result = make_object(Iso_cuboid_3(newmin, newmax));
    return result;
}

} // namespace CGALi






template <class K>
inline
Object 
intersection(const Plane_3<K> &plane1, const Plane_3<K> &plane2)
{
  return typename K::Intersect_3()(plane1, plane2);
}

template <class K>
inline
Object 
intersection(const Plane_3<K> &plane1, const Plane_3<K> &plane2,
             const Plane_3<K> &plane3)
{
  return typename K::Intersect_3()(plane1, plane2, plane3);
}


template <class K>
inline
Object
intersection(const Plane_3<K>  &plane, const Line_3<K> &line)
{
  return typename K::Intersect_3()(plane, line);
}

template <class K>
inline
bool
do_intersect(const Plane_3<K> &plane, const Line_3<K> &line)
{
  return typename K::Do_intersect_3()(plane, line);
}

template <class K>
inline
Object
intersection(const Plane_3<K> &plane, const Ray_3<K> &ray)
{
  return typename K::Intersect_3()(plane, ray);
}

template <class K>
inline
bool
do_intersect(const Plane_3<K> &plane, const Ray_3<K> &ray)
{
  return typename K::Do_intersect_3()(plane, ray);
}

template <class K>
inline
Object
intersection(const Plane_3<K> &plane, const Segment_3<K> &seg)
{
  return typename K::Intersect_3()(plane, seg);
}


template <class K>
inline
bool
do_intersect(const Plane_3<K>  &plane, const Segment_3<K> &seg)
{
  return typename K::Do_intersect_3()(plane, seg);
}

template <class K>
inline
Object
intersection(const Line_3<K> &line,
	     const Bbox_3 &box)
{
  return typename K::Intersect_3()(line, box);
}

template <class K>
inline
Object
intersection(const Ray_3<K> &ray,
	     const Bbox_3 &box)
{
  return typename K::Intersect_3()(ray, box);
}

template <class K>
inline
Object
intersection(const Segment_3<K> &seg,
	     const Bbox_3 &box)
{
  return typename K::Intersect_3()(seg, box);
}

template <class K>
inline
Object
intersection(const Line_3<K> &line,
	     const Iso_cuboid_3<K> &box)
{
  return typename K::Intersect_3()(line, box);
}

template <class K>
inline
Object
intersection(const Ray_3<K> &ray,
	     const Iso_cuboid_3<K> &box)
{
  return typename K::Intersect_3()(ray, box);
}

template <class K>
inline
Object
intersection(const Segment_3<K> &seg,
	     const Iso_cuboid_3<K> &box)
{
  return typename K::Intersect_3()(seg, box);
}


template <class K>
inline
Object
intersection(const Iso_cuboid_3<K> &icub1,
	     const Iso_cuboid_3<K> &icub2)
{
  return typename K::Intersect_3()(icub1, icub2);
}

CGAL_END_NAMESPACE
