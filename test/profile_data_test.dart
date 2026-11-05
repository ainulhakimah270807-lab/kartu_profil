import 'package:flutter_test/flutter_test.dart';
import 'package:kartu_profil_digital/models/profile_data.dart';

void main() {
  test('JSON mempertahankan seluruh field termasuk karakter khusus', () {
    const original = ProfileData(
      name: 'Ainul Hakimah',
      title: 'Mahasiswa "Flutter"',
      bio: 'Belajar JSON & persistensi.\nBaris kedua.',
    );
    final restored = ProfileData.fromJson(original.toJson());
    expect(restored.toMap(), original.toMap());
  });

  test('Field yang belum ada memakai data profil bawaan', () {
    final restored = ProfileData.fromMap({'name': 'Ainul'});
    expect(restored.name, 'Ainul');
    expect(restored.title, ProfileData.defaults.title);
    expect(restored.bio, ProfileData.defaults.bio);
  });
}
