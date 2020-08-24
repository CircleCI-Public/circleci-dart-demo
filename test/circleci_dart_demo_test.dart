@TestOn("vm")
import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import '../bin/number_guesser.dart' as number_guesser;
import '../bin/circleci_dart_demo.dart' as number_thinker;

void main() {

  // "binding multiple times on the same (address, port) combination".
  Future _server;
  Future startServer() => _server ??= number_thinker.main();

  test('number_thinker response', () {
    _test() async {
      expect(await getUrl('localhost', 4041), anyOf('true\n', 'false\n'));
    }

    expect(
        () => Future.any([
              startServer(),
              _test(),
            ]),
        prints(allOf(
          startsWith("I'm thinking of a number:"),
          contains('Request handled.'),
        )));
  });

  test('client bad guess', () async {
    expect(
        () => Future.any([
              startServer(),
              number_guesser.checkGuess(99),
            ]),
        prints(allOf(
          contains('Guess is 99.'),
          contains('Bad guess'),
        )));
  });

  test('client good guess', () async {
    _test() async {
      // For now, guess each number in turn
      // (rather than having to mock the int generator).
      for (var i = 0; i < 10; i++) {
        if (await number_guesser.checkGuess(i)) return;
      }
    }

    expect(
        () => Future.any([
              startServer(),
              _test(),
            ]),
        prints(contains('Good guess')));
  });
}

Future<String> getUrl([
  String host = 'localhost',
  int port = 8080,
  String path = '',
]) async {
  final client = HttpClient();
  final request = await client.get(host, port, path);
  final response = await request.close();
  final data = await utf8.decoder.bind(response).toList();
  return data.join('');
}

