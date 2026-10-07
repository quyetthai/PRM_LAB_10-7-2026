import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/course.dart';
import '../models/course_type.dart';
import '../repositories/course_repository.dart';

part 'course_viewmodel.g.dart';

class CourseState {
  final List<CourseType> courseTypes;
  final List<Course> courses;
  final String selectedTypeId;
  final String searchQuery;
  final int selectedTabIndex;

  const CourseState({
    required this.courseTypes,
    required this.courses,
    this.selectedTypeId = 'all',
    this.searchQuery = '',
    this.selectedTabIndex = 0,
  });

  List<Course> get popularCourses {
    return courses
        .where((course) => course.star >= 4.5)
        .toList();
  }

  List<Course> get filteredCourses {
    var result = selectedTypeId == 'all'
        ? List<Course>.from(courses)
        : courses
        .where(
          (course) => course.typeId == selectedTypeId,
    )
        .toList();

    final query = searchQuery.trim().toLowerCase();

    if (query.isNotEmpty) {
      result = result
          .where(
            (course) =>
            course.title.toLowerCase().contains(query),
      )
          .toList();
    }

    return result;
  }

  CourseType? get selectedCourseType {
    for (final type in courseTypes) {
      if (type.id == selectedTypeId) {
        return type;
      }
    }

    return null;
  }

  CourseState copyWith({
    List<CourseType>? courseTypes,
    List<Course>? courses,
    String? selectedTypeId,
    String? searchQuery,
    int? selectedTabIndex,
  }) {
    return CourseState(
      courseTypes: courseTypes ?? this.courseTypes,
      courses: courses ?? this.courses,
      selectedTypeId:
      selectedTypeId ?? this.selectedTypeId,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTabIndex:
      selectedTabIndex ?? this.selectedTabIndex,
    );
  }
}

@riverpod
CourseRepository courseRepository(Ref ref) {
  return CourseRepository();
}

@riverpod
class CourseViewModel extends _$CourseViewModel {
  late final CourseRepository _repository;

  @override
  CourseState build() {
    _repository = ref.watch(courseRepositoryProvider);

    return CourseState(
      courseTypes: _repository.getCourseTypes(),
      courses: _repository.getCourses(),
    );
  }

  void selectTab(int index) {
    state = state.copyWith(
      selectedTabIndex: index,
    );
  }

  void selectCourseType(String typeId) {
    state = state.copyWith(
      selectedTypeId: typeId,
      selectedTabIndex: 1,
    );
  }

  void seeAllCourses() {
    state = state.copyWith(
      selectedTypeId: 'all',
      searchQuery: '',
      selectedTabIndex: 1,
    );
  }

  void toggleInterest(String courseId) {
    final updatedCourses =
    _repository.toggleInterest(courseId);

    state = state.copyWith(
      courses: updatedCourses,
    );
  }

  void setSearchQuery(String query) {
    state = state.copyWith(
      searchQuery: query,
    );
  }
}