import 'package:challenge_pinapp/domain/entities/failure.dart';
import 'package:equatable/equatable.dart';

sealed class Worker<T> {
  const Worker();

  bool get isLoading => this is Loading<T>;

  bool get isSuccess => this is Success<T>;

  bool get isError => this is Error<T>;

  T? get value => isSuccess ? (this as Success<T>).value : null;

  Failure? get error => isError ? (this as Error<T>).error : null;
}

class Success<T> extends Worker<T> with EquatableMixin {
  const Success(this.value);

  @override
  final T value;

  @override
  List<Object?> get props => [value];
}

class Loading<T> extends Worker<T> {
  const Loading();
}

class Error<T> extends Worker<T> with EquatableMixin {
  const Error(this.error);

  @override
  final Failure error;

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
