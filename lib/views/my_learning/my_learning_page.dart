import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../viewmodels/course_viewmodel.dart';
import '../home/widgets/popular_course_card.dart';

class MyLearningPage extends ConsumerWidget {
  const MyLearningPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(courseViewModelProvider);
    final notifier = ref.read(courseViewModelProvider.notifier);

    final interestedCourses =
    state.courses.where((course) => course.isInterest).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interested Courses',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (interestedCourses.isEmpty)
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite_border_rounded,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'No saved courses yet.\nTap the heart icon to save your courses!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: interestedCourses.length,
                itemBuilder: (context, index) {
                  final course = interestedCourses[index];

                  return PopularCourseCard(
                    course: course,
                    onToggleInterest: () {
                      notifier.toggleInterest(course.id);
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}