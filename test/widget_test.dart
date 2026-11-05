import 'package:flutter/material.dart';
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
  testWidgets('Mode gelap berubah dan disimpan ketika switch ditekan', (
    tester,
  ) async {
    final prefs = await PrefService.init();
    await tester.pumpWidget(MyApp(prefs: prefs));

    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();

    expect(prefs.isDarkMode, isTrue);
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
  });

  testWidgets('Tema tersimpan dipakai sejak frame pertama', (tester) async {
    SharedPreferences.setMockInitialValues({'is_dark_mode': true});
    final prefs = await PrefService.init();
    await tester.pumpWidget(MyApp(prefs: prefs));

    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
  });
}
