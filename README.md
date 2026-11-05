# Kartu Profil Digital

Praktikum local storage Flutter berdasarkan [modul Pak Fakhry](https://github.com/iffakhry/mobile-app-jti/blob/main/12-local-storage-sqlite.md), dikerjakan bertahap sampai checkpoint 5.

## Menjalankan aplikasi

```powershell
flutter pub get
flutter run -d edge
```

Flutter yang digunakan: 3.47.7 dengan Dart 3.13.5. Dependensi `shared_preferences`, `sqflite`, dan `path` sudah terpasang sesuai Lab 1. Checkpoint 1 sampai 5 dapat dijalankan di browser. SQLite baru digunakan setelah checkpoint 5 dan memerlukan target Android atau iOS sesuai modul.

## Pemeriksaan

```powershell
flutter analyze
flutter test
```

## Progres

- Checkpoint 1: kartu profil statis dengan data Fakhry Firdaus.

Setiap checkpoint diuji, di-commit, dan di-push sebelum checkpoint berikutnya dimulai. Bukti tampilan disimpan di `docs/screenshots`.
