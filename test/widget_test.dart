import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:de1/main.dart';
import 'package:de1/repositories/course_repository.dart';
import 'package:de1/viewmodels/course_viewmodel.dart';
import 'package:de1/views/widgets/app_drawer.dart';

void main() {
  group('Câu 1 - MVVM & Riverpod Tests', () {
    test('CourseRepository returns expected types and popular courses (star >= 4.5)', () {
      final repository = CourseRepository();
      final types = repository.getCourseTypes();
      final allCourses = repository.getCourses();
      final popularCourses = repository.getPopularCourses();

      expect(types.length, 5);
      expect(types.any((t) => t.name == 'All Courses'), isTrue);
      expect(types.any((t) => t.name == 'Mobile Development'), isTrue);

      // Verify Popular Courses have star >= 4.5
      expect(popularCourses.isNotEmpty, isTrue);
      for (final course in popularCourses) {
        expect(course.star >= 4.5, isTrue);
      }

      // Verify course with star < 4.5 is not in popularCourses
      expect(allCourses.any((c) => c.star < 4.5), isTrue);
      expect(popularCourses.any((c) => c.star < 4.5), isFalse);
    });

    test('CourseViewModel state operations and filtering', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(courseViewModelProvider.notifier);
      final initialState = container.read(courseViewModelProvider);

      expect(initialState.selectedTabIndex, 0);
      expect(initialState.selectedTypeId, 'all');

      // Test selectCourseType switches tab to 1 (Courses)
      notifier.selectCourseType('mobile');
      final updatedState = container.read(courseViewModelProvider);
      expect(updatedState.selectedTypeId, 'mobile');
      expect(updatedState.selectedTabIndex, 1);

      // Test seeAllCourses switches tab to 1 and shows all
      notifier.seeAllCourses();
      final seeAllState = container.read(courseViewModelProvider);
      expect(seeAllState.selectedTypeId, 'all');
      expect(seeAllState.selectedTabIndex, 1);

      // Test toggleInterest
      final firstCourseId = seeAllState.courses.first.id;
      final initialInterest = seeAllState.courses.first.isInterest;
      notifier.toggleInterest(firstCourseId);
      final interestState = container.read(courseViewModelProvider);
      expect(
        interestState.courses.firstWhere((c) => c.id == firstCourseId).isInterest,
        !initialInterest,
      );
    });
  });

  group('Câu 2 - UI & Navigation Tests', () {
    testWidgets('Home page displays Banner, Features, and Popular Courses',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Check App Bar
      expect(find.text('COURSE APP'), findsOneWidget);

      // Check Banner
      expect(find.text('Learn\nNew Skills'), findsOneWidget);
      expect(find.text('For A Better Future'), findsOneWidget);

      // Check Feature Badges
      expect(find.text('50+'), findsOneWidget);
      expect(find.text('Expert'), findsOneWidget);
      expect(find.text('Flexible'), findsOneWidget);

      // Check Section header
      expect(find.text('Popular Courses'), findsOneWidget);
      expect(find.text('See All'), findsOneWidget);

      // Check BottomNavigationBar items
      expect(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.text('Home'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.text('Courses'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.text('My Learning'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.text('Profile'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('See All switches to Courses screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap See All
      await tester.tap(find.text('See All'));
      await tester.pumpAndSettle();

      // Verify title is now COURSES
      expect(find.text('COURSES'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('Drawer opens and lists categories from ViewModel',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Open drawer using scaffoldState
      final scaffoldFinder = find.byType(Scaffold);
      final scaffoldState = tester.state<ScaffoldState>(scaffoldFinder.first);
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      // Verify User header inside AppDrawer
      expect(find.text('Nguyễn Văn A'), findsOneWidget);

      // Verify Categories from ViewModel inside Drawer
      final drawerFinder = find.byType(AppDrawer);
      expect(
        find.descendant(of: drawerFinder, matching: find.text('All Courses')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: drawerFinder, matching: find.text('Mobile Development')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: drawerFinder, matching: find.text('Web Development')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: drawerFinder, matching: find.text('Artificial Intelligence')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: drawerFinder, matching: find.text('UI/UX Design')),
        findsOneWidget,
      );

      // Tap a category: Mobile Development inside Drawer
      await tester.tap(
        find.descendant(of: drawerFinder, matching: find.text('Mobile Development')),
      );
      await tester.pumpAndSettle();

      // Drawer should be closed and screen navigated to COURSES
      expect(find.text('COURSES'), findsOneWidget);
      expect(find.text('Showing: Mobile Development (2)'), findsOneWidget);
    });
  });
}
