import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kartu_profil_digital/services/pref_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test(
    'Jumlah pembukaan dimulai dari nol dan tersimpan antar instance',
    () async {
      final first = await PrefService.init();
      expect(first.openCount, 0);
      await first.increaseOpenCount();

      final second = await PrefService.init();
      expect(second.openCount, 1);
      await second.increaseOpenCount();
      expect(second.openCount, 2);
    },
  );
  test('Pilihan mode gelap dapat dibaca oleh instance berikutnya', () async {
    final first = await PrefService.init();
    expect(first.isDarkMode, isFalse);
    await first.setDarkMode(true);

    final second = await PrefService.init();
    expect(second.isDarkMode, isTrue);
    expect(second.openCount, 0);
  });
}
