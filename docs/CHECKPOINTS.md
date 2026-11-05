# Bukti Pengerjaan Checkpoint 1 sampai 5

Setiap checkpoint diuji, di-commit, lalu di-push ke `main` sebelum implementasi checkpoint berikutnya dimulai. Hash remote diperiksa setelah setiap push.

| Checkpoint | Fitur | Tes lulus | Commit |
| --- | --- | --- | --- |
| 1 | Kartu profil statis | 1 | [565174e](https://github.com/ainulhakimah270807-lab/kartu_profil/commit/565174ef9a346832f6b927a2c2a3b2f3a7f44109) |
| 2 | Penghitung buka aplikasi | 2 | [ed40043](https://github.com/ainulhakimah270807-lab/kartu_profil/commit/ed40043878e6a037d71a472cf025626fafca2ad9) |
| 3 | Tema gelap tersimpan | 5 | [a189b3d](https://github.com/ainulhakimah270807-lab/kartu_profil/commit/a189b3d65b3be40ae86a9a7c40a2d339664e8a1f) |
| 4 | Edit profil Ainul dan JSON | 13 | [9e64d0e](https://github.com/ainulhakimah270807-lab/kartu_profil/commit/9e64d0ea9f0f828e69659a81c69279d1d6d60f1a) |
| 5 | Reset profil dan inspeksi key | 15 | [47af715](https://github.com/ainulhakimah270807-lab/kartu_profil/commit/47af715835520579842e0ace86f8785d7208b446) |

## Hasil pengujian browser

- Checkpoint 1: kartu profil statis tampil sesuai Lab 1.
- Checkpoint 2: penghitung berubah dari 1 menjadi 2 setelah tab aplikasi ditutup dan dibuka lagi.
- Checkpoint 3: mode gelap tetap aktif setelah pembukaan ulang; penghitung menjadi 4.
- Checkpoint 4: nama bawaan disesuaikan menjadi Ainul Hakimah. Bio hasil edit tetap tampil setelah aplikasi dibuka ulang, saat penghitung menunjukkan 7.
- Checkpoint 5: reset mengganti bio hasil edit dengan bio bawaan, tema tetap gelap, dan penghitung tetap 8. Saat aplikasi dibuka ulang, hasil reset bertahan dan penghitung bertambah menjadi 9.

Analisis kode akhir tidak menemukan masalah. Seluruh 15 tes lulus, mencakup data JSON rusak, validasi form, pembatalan edit, pemuatan tema sejak frame pertama, serta reset selektif.

## Bukti visual

Seluruh gambar ada di [screenshots](screenshots). Gambar `kode-01.png` sampai `kode-05.png` merupakan cuplikan dari sumber Dart aktual dengan latar putih dan nomor baris. Kode lengkap tersedia di folder [lib](../lib).

## Batas praktikum

Implementasi berhenti pada checkpoint 5 dari [modul Local Storage dan SQLite](https://github.com/iffakhry/mobile-app-jti/blob/main/12-local-storage-sqlite.md). SQLite dan CRUD pada pertemuan kedua belum termasuk tahap ini. Identitas profil versi akhir adalah Ainul Hakimah; gambar checkpoint 1 sampai 3 mempertahankan data contoh modul sebagai riwayat pengerjaan.
