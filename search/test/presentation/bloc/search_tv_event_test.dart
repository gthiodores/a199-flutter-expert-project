import 'package:flutter_test/flutter_test.dart';
import 'package:search/presentation/bloc/search_bloc.dart';

void main() {
  test('should return true when events are identical', () {
    final testEvent1 = OnQueryChanged('test');
    final testEvent2 = OnQueryChanged('test');

    expect(testEvent1 == testEvent2, true);
  });

  test('should return false when events are different', () {
    final testEvent1 = OnQueryChanged('query');
    final testEvent2 = OnQueryChanged('queryy');

    expect(testEvent1 == testEvent2, false);
  });
}
