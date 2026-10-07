import '../models/course.dart';
import '../models/course_type.dart';

class CourseRepository {
  final List<CourseType> _courseTypes = const [
    CourseType(id: 'all', name: 'All Courses'),
    CourseType(id: 'mobile', name: 'Mobile Development'),
    CourseType(id: 'web', name: 'Web Development'),
    CourseType(id: 'ai', name: 'Artificial Intelligence'),
    CourseType(id: 'ui_ux', name: 'UI/UX Design'),
  ];

  List<Course> _courses = [
    const Course(
      id: '1',
      title: 'Flutter Development',
      description: 'Build beautiful mobile platform apps',
      price: 120.0,
      star: 4.9,
      reviewsCount: 120,
      typeId: 'mobile',
      isInterest: false,
    ),
    const Course(
      id: '2',
      title: 'AI Fundamentals',
      description: 'Introduction to artificial intelligence',
      price: 150.0,
      star: 4.6,
      reviewsCount: 95,
      typeId: 'ai',
      isInterest: false,
    ),
    const Course(
      id: '3',
      title: 'Web Development',
      description: 'Learn modern web technologies',
      price: 100.0,
      star: 4.5,
      reviewsCount: 110,
      typeId: 'web',
      isInterest: false,
    ),
    const Course(
      id: '4',
      title: 'Mobile Development',
      description: 'Build Android & iOS apps',
      price: 130.0,
      star: 4.7,
      reviewsCount: 85,
      typeId: 'mobile',
      isInterest: false,
    ),
    const Course(
      id: '5',
      title: 'UI/UX Design',
      description: 'Master Figma and modern UI/UX design',
      price: 110.0,
      star: 4.8,
      reviewsCount: 70,
      typeId: 'ui_ux',
      isInterest: false,
    ),
    const Course(
      id: '6',
      title: 'Python for Beginners',
      description: 'Introduction to programming basics',
      price: 80.0,
      star: 4.2,
      reviewsCount: 65,
      typeId: 'ai',
      isInterest: false,
    ),
  ];

  List<CourseType> getCourseTypes() {
    return List.unmodifiable(_courseTypes);
  }

  List<Course> getCourses() {
    return List.unmodifiable(_courses);
  }

  /// Popular Courses are courses with star >= 4.5 (as per requirements)
  List<Course> getPopularCourses() {
    return _courses.where((course) => course.star >= 4.5).toList();
  }

  List<Course> getCoursesByType(String typeId) {
    if (typeId == 'all') {
      return List.unmodifiable(_courses);
    }
    return _courses.where((course) => course.typeId == typeId).toList();
  }

  List<Course> toggleInterest(String courseId) {
    _courses = _courses.map((course) {
      if (course.id == courseId) {
        return course.copyWith(isInterest: !course.isInterest);
      }
      return course;
    }).toList();
    return List.unmodifiable(_courses);
  }

  List<Course> searchCourses(String query, {String? typeId}) {
    var list = (typeId == null || typeId == 'all')
        ? _courses
        : _courses.where((course) => course.typeId == typeId).toList();

    if (query.trim().isEmpty) {
      return list;
    }

    final lowerQuery = query.toLowerCase().trim();
    return list
        .where((course) => course.title.toLowerCase().contains(lowerQuery))
        .toList();
  }
}
