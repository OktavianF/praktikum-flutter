# Laporan Praktikum Konversi Suhu

Aplikasi Flutter sederhana untuk mengonversi suhu antara berbagai satuan (Celsius, Fahrenheit, Kelvin, dan Reamur). Proyek ini telah direfactor menggunakan arsitektur **Clean Code**, **BLoC State Management**, serta menerapkan **Unit, BLoC, dan Widget Tests** untuk menjamin kualitas aplikasi.

## Firebase Authentication (13 Mei 2026)

Proyek ini telah diperbarui dengan fitur keamanan dan antarmuka pengguna yang lebih premium:
- **Firebase Authentication**: Implementasi fitur Login dan Register menggunakan Firebase Auth.
- **Auth State Management**: Penggunaan `StreamBuilder` untuk manajemen status login pengguna secara real-time.
- **Service Layer**: Penambahan `AuthService` untuk pemisahan logika autentikasi dari UI.
- **Enhanced UX**: Desain input field yang lebih interaktif dan kartu hasil yang lebih informatif.
- **Logout Feature**: Memungkinkan pengguna keluar dari aplikasi dengan aman.

## Fitur Utama

- Input suhu menggunakan `TextField`.
- Pemilihan satuan input dengan `DropdownButton` yang reaktif.
- Konversi secara bersamaan ke Celsius, Fahrenheit, Kelvin, dan Reamur.
- Validasi input yang aman (pesan error untuk input kosong maupun format non-angka).
- Tampilan hasil dalam kartu terpisah agar mudah dibaca.
- **State Management BLoC** untuk performa _rebuild_ komponen UI yang lebih efisien.

## Struktur Proyek BLoC & Clean Architecture

Struktur utama aplikasi disusun untuk pemisahan tanggung jawab (Separation of Concerns):

```text
lib/
├── main.dart
├── bloc/
│   ├── konversi_suhu_bloc.dart
│   ├── konversi_suhu_event.dart
│   └── konversi_suhu_state.dart
├── models/
│   └── suhu_converter.dart
├── pages/
│   ├── home_page.dart
│   ├── login_page.dart
│   └── register_page.dart
├── services/
│   └── auth_service.dart
└── widgets/
	└── hasil_card.dart
```

Keterangan:

- **`bloc/`**: Berisi tiga lapis komponen state management. Event menyimpan interaksi pengguna. State mendefinisikan keadaan aplikasi (satuan terpilih, hasil konversi, pesan error). BLoC menjembatani Event ke dalam perhitungan di Model untuk memproduksi State baru.
- **`models/suhu_converter.dart`**: Berisi algoritma konversi numerik murni.
- **`pages/`**: Berisi halaman-halaman aplikasi. `home_page.dart` untuk konversi, `login_page.dart` dan `register_page.dart` untuk autentikasi.
- **`services/auth_service.dart`**: Menangani interaksi langsung dengan Firebase Authentication.
- **`widgets/hasil_card.dart`**: Widget modular yang disajikan berulang untuk setiap satuan suhu dengan desain yang telah diperbarui.

## Logika Kalkulator Konversi

Semua proses konversi terpusat menggunakan model referensi absolut yaitu **Celsius**. 

1. Menyerap data input dan mengidentifikasi satuan awal.
2. Mengonversi ke titik tumpu (Celsius).
3. Mendistribusikan titik tumpu Celsius itu masing-masing ke Fahrenheit, Kelvin, dan Reamur sekaligus.

Rumus Matematika:
- Ke Celsius: `F: (F - 32) * 5 / 9` | `K: K - 273.15` | `R: R * 5 / 4`
- Dari Celsius: `F: (C * 9 / 5) + 32` | `K: C + 273.15` | `R: C * 4 / 5`

## Pengujian (Testing) & Code Coverage

Proyek ini telah menerapkan _Test-Driven Development (TDD)_ parsial dengan hasil liputan kode (**Code Coverage**) di atas **90%**. Terdapat 3 tahapan test utama yang diletakkan pada folder `test/`:
1. **Model Tests** (`test/models/suhu_converter_test.dart`): Verifikasi validitas rumus algoritma matematika.
2. **BLoC Tests** (`test/bloc/konversi_suhu_bloc_test.dart`): Menguji _state transition_ berdasarkan _event_.
3. **Widget Tests** (`test/widget_test.dart`): Uji fungsionalitas UI komponen Visual dan alur interaksi ketikan input _mocking_.

## Cara Menjalankan Aplikasi & Tes

Pastikan Flutter SDK terpasang di sistem.

1. **Jalankan Aplikasi:**
```bash
flutter pub get
flutter run
```

2. **Jalankan Analisis Kode Statis (Linter):**
```bash
flutter analyze
```

3. **Jalankan Pengujian Otomatis:**
```bash
flutter test
```

4. **Jalankan Pengujian dengan Coverage Laporan:**
```bash
flutter test --coverage
```

Status terakhir:

- `flutter analyze`: tidak ditemukan issue.
- `flutter test`: 9 test berhasil lulus.

Jenis pengujian yang digunakan:

- Unit test untuk memastikan rumus konversi suhu benar.
- Widget test untuk memastikan elemen UI tampil dan interaksi dasar berjalan.

## Hasil Tampilan Aplikasi (UI Terbaru)

Berikut dokumentasi hasil aplikasi terbaru (Auth & Elegant UI):

| Halaman Login | Halaman Utama (Update) | Notifikasi Login Gagal |
| --- | --- | --- |
| ![Login Page](screenshots/login-sukses.jpeg) | ![Main Page](screenshots/halaman-utama.jpeg) | ![Login Failed](screenshots/login-gagal.jpeg) |

### Dokumentasi Konversi Suhu (UI Lama)

| Input Celsius | Input Fahrenheit |
| --- | --- |
| ![Hasil konversi dari Celsius](screenshots/celcius.png) | ![Hasil konversi dari Fahrenheit](screenshots/fahrenheit.png) |

| Input Kelvin | Input Reamur |
| --- | --- |
| ![Hasil konversi dari Kelvin](screenshots/kelvin.png) | ![Hasil konversi dari Reamur](screenshots/reamur.png) |

## Kesimpulan

Praktikum ini menghasilkan aplikasi konversi suhu yang sederhana namun sudah memiliki struktur kode yang lebih baik. Dengan pemisahan antara logika, halaman, dan widget, aplikasi menjadi lebih mudah dibaca, diuji, dan dikembangkan lebih lanjut.
