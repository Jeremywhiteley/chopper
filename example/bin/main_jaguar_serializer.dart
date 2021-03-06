import 'package:chopper/chopper.dart';
import 'definition/definition.dart';
import 'definition/model.dart';

import 'definition/jaguar_serializer.dart';

main() async {
  final chopper = new ChopperClient(
      baseUrl: "http://localhost:8000",
      converter: const JaguarConverter(),
      apis: [
        // the generated service
        new MyService()
      ],
      /* ResponseInterceptorFunc | RequestInterceptorFunc | ResponseInterceptor | RequestInterceptor */
      interceptors: [
        new Headers(const {"Content-Type": "application/json"}),
      ]);

  final myService = chopper.service(MyService) as MyService;

  final response1 = await myService.getResource("1");
  print(response1.body); // undecoded String

  final response2 = await myService.getTypedResource();
  print(response2.body); // decoded Resource

  await myService.newResource(new Resource("3", "Super Name"));
}
