// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(courseRepository)
final courseRepositoryProvider = CourseRepositoryProvider._();

final class CourseRepositoryProvider
    extends
        $FunctionalProvider<
          CourseRepository,
          CourseRepository,
          CourseRepository
        >
    with $Provider<CourseRepository> {
  CourseRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'courseRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$courseRepositoryHash();

  @$internal
  @override
  $ProviderElement<CourseRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CourseRepository create(Ref ref) {
    return courseRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CourseRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CourseRepository>(value),
    );
  }
}

String _$courseRepositoryHash() => r'ef1c5c3fbe611302f4c1f67b9a9ac31aaf3c0f89';

@ProviderFor(CourseViewModel)
final courseViewModelProvider = CourseViewModelProvider._();

final class CourseViewModelProvider
    extends $NotifierProvider<CourseViewModel, CourseState> {
  CourseViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'courseViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$courseViewModelHash();

  @$internal
  @override
  CourseViewModel create() => CourseViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CourseState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CourseState>(value),
    );
  }
}

String _$courseViewModelHash() => r'0bc0f80235d2a3340c1e56ba67f2e73b8b938a81';

abstract class _$CourseViewModel extends $Notifier<CourseState> {
  CourseState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CourseState, CourseState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CourseState, CourseState>,
              CourseState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
