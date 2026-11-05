import 'package:flutter_test/flutter_test.dart';
import 'package:kartu_profil_digital/main.dart';

void main() {
  testWidgets('Checkpoint 1 menampilkan kartu profil bawaan', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Kartu Profil Digital'), findsOneWidget);
    expect(find.text('Fakhry Firdaus'), findsOneWidget);
    expect(find.text('Software Engineer & Dosen'), findsOneWidget);
    expect(
      find.text('Suka membangun aplikasi mobile dan berbagi ilmu.'),
      findsOneWidget,
    );
  });
}
