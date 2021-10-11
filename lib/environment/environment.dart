enum EnvironmentType {
  Dev,
  Prod,
}

abstract class Environment {
  String get scheme;

  String get host;

  int get port;

  String get scope;

  EnvironmentType get currentEnvironment;
}

class Development extends Environment {
  @override
  EnvironmentType get currentEnvironment => EnvironmentType.Dev;

  @override
  String get scheme => 'https';

  @override
  String get host => 'jsonplaceholder.typicode.com';

  @override
  int get port => null;

  @override
  String get scope => null;
}

class Production extends Environment {
  @override
  EnvironmentType get currentEnvironment => EnvironmentType.Prod;

  @override
  String get scheme => 'https';

  @override
  String get host => 'jsonplaceholder.typicode.com';

  @override
  int get port => null;

  @override
  String get scope => null;
}
