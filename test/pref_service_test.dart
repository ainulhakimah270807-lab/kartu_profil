import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kartu_profil_digital/services/pref_service.dart';
import 'package:kartu_profil_digital/models/profile_data.dart';

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
  test('Profil disimpan sebagai JSON dan dibaca oleh instance baru', () async {
    final first = await PrefService.init();
    const profile = ProfileData(
      name: 'Ainul Hakimah',
      title: 'Mahasiswa',
      bio: 'Belajar Flutter',
    );
    await first.saveProfile(profile);

    final second = await PrefService.init();
    expect(second.profile.toMap(), profile.toMap());
    final storage = await SharedPreferences.getInstance();
    expect(storage.getString('profile_data'), profile.toJson());
  });

  test('JSON rusak atau tipe field salah kembali ke profil bawaan', () async {
    for (final raw in ['{rusak', '[]', '{"name":42}']) {
      SharedPreferences.setMockInitialValues({'profile_data': raw});
      final prefs = await PrefService.init();
      expect(prefs.profile.toMap(), ProfileData.defaults.toMap());
    }
  });
}
