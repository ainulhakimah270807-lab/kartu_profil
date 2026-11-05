import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kartu_profil_digital/main.dart';
import 'package:kartu_profil_digital/services/pref_service.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('Kartu profil menampilkan jumlah pembukaan tersimpan', (
    tester,
  ) async {
    final prefs = await PrefService.init();
    await prefs.increaseOpenCount();
    await tester.pumpWidget(MyApp(prefs: prefs));

    expect(find.text('Fakhry Firdaus'), findsOneWidget);
    expect(find.text('Software Engineer & Dosen'), findsOneWidget);
    expect(find.text('Kartu ini sudah dibuka 1 kali'), findsOneWidget);
  });
}
