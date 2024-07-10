abstract class BaseUseCase<Type, Params> {
  Future<Type> call(Params? params);
}

abstract class Params {}


class NoParams {
  List<Object> get props => [];
}


