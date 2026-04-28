import 'package:salvando_vidas/data/stores/home/counter.dart';
import 'package:test/test.dart';

void main() {
  test("Teste da classe Counter", () {
    Counter counter = Counter();
    expect(counter.value, 0);

    counter.increment();
    expect(counter.value, 1);
  });
}
