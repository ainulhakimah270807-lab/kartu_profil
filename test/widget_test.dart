import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kartu_profil_digital/main.dart';
import 'package:kartu_profil_digital/services/pref_service.dart';
import 'package:kartu_profil_digital/models/profile_data.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('Kartu profil menampilkan jumlah pembukaan tersimpan', (
    tester,
  ) async {
    final prefs = await PrefService.init();
    await prefs.increaseOpenCount();
    await tester.pumpWidget(MyApp(prefs: prefs));

    expect(find.text('Ainul Hakimah'), findsOneWidget);
    expect(find.text('Mahasiswa'), findsOneWidget);
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
  testWidgets('Form menolak nama yang hanya berisi spasi', (tester) async {
    final prefs = await PrefService.init();
    await tester.pumpWidget(MyApp(prefs: prefs));
    await tester.tap(find.byTooltip('Edit profil'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), '   ');
    await tester.ensureVisible(find.text('Simpan'));
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Wajib diisi'), findsOneWidget);
    expect(find.text('Edit Profil'), findsOneWidget);
    expect(prefs.profile.name, ProfileData.defaults.name);
  });

  testWidgets('Simpan profil memperbarui kartu dan penyimpanan', (
    tester,
  ) async {
    final prefs = await PrefService.init();
    await tester.pumpWidget(MyApp(prefs: prefs));
    await tester.tap(find.byTooltip('Edit profil'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), ' Ainul Hakimah ');
    await tester.enterText(find.byType(TextFormField).at(1), 'Mahasiswa');
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'Belajar local storage Flutter.',
    );
    await tester.ensureVisible(find.text('Simpan'));
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Ainul Hakimah'), findsOneWidget);
    expect(find.text('Profil tersimpan'), findsOneWidget);
    expect(prefs.profile.name, 'Ainul Hakimah');
    expect(prefs.profile.title, 'Mahasiswa');
  });

  testWidgets('Kembali dari form tidak mengubah profil', (tester) async {
    final prefs = await PrefService.init();
    await tester.pumpWidget(MyApp(prefs: prefs));
    await tester.tap(find.byTooltip('Edit profil'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Tidak disimpan');
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Ainul Hakimah'), findsOneWidget);
    expect(prefs.profile.name, ProfileData.defaults.name);
  });

  testWidgets('Pembukaan berikutnya menampilkan profil yang tersimpan', (
    tester,
  ) async {
    const stored = ProfileData(
      name: 'Ainul Hakimah',
      title: 'Mahasiswa',
      bio: 'Profil tersimpan',
    );
    SharedPreferences.setMockInitialValues({'profile_data': stored.toJson()});
    final prefs = await PrefService.init();
    await tester.pumpWidget(MyApp(prefs: prefs));

    expect(find.text('Ainul Hakimah'), findsOneWidget);
    expect(find.text('Profil tersimpan'), findsOneWidget);
  });
}
