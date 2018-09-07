import 'package:kiwi/kiwi.dart';

abstract class Injector {
  @Register.instance(5)
  @Register.instance(6, as: num)
  @Register.instance('test')
  @Register.singleton(ServiceB)
  @Register.factory(ServiceC, as: Service)
  @Register.factory(ServiceC, resolvers: <Type, String>{ServiceA: 'serviceA'})
  void configure();
}

class Service {}

class ServiceA {}

class ServiceB extends Service {
  ServiceB(this.serviceA);

  final ServiceA serviceA;
}

class ServiceC extends Service {
  ServiceC(ServiceA serviceA, ServiceB serviceB) {}
}