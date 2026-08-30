// import 'package:equatable/equatable.dart';

// abstract class Failure extends Equatable {
abstract class Failure {
  final List<dynamic> properties; // Relevante para el Equatable.

  const Failure([this.properties = const []]);

  // @override
  // List<Object> get props => [properties];
}

//*~~~~~ServerFailure~~~~~.
class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message}) : super([message]);
}

//*~~~~~CacheFailure~~~~~.
class CacheFailure extends Failure {
  final String message;

  CacheFailure({required this.message}) : super([message]);
}

//*~~~~~GeneralFailure~~~~~.
class GeneralFailure extends Failure {
  final String message;

  GeneralFailure({required this.message}) : super([message]);
}
