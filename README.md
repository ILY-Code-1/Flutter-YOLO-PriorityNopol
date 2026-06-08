# 🚨 PrioScan — Priority Vehicle Scanner

**PrioScan** adalah aplikasi mobile berbasis Flutter untuk **mendeteksi kendaraan prioritas** (Ambulance, Police, Fire Truck) dari gambar menggunakan model **YOLOv8**, lalu **membaca nomor polisi (plat)** secara otomatis melalui EasyOCR. Aplikasi ini ditujukan bagi petugas/pengguna yang membutuhkan identifikasi cepat kendaraan darurat beserta plat nomornya, dan menyimpan setiap hasil deteksi ke dalam riwayat yang tersinkronisasi secara real-time melalui Firebase Firestore.

![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS-blue)
![Flutter](https://img.shields.io/badge/Flutter-SDK%20%5E3.10.8-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)
![State Management](https://img.shields.io/badge/State-GetX-8A2BE2)
![Firebase](https://img.shields.io/badge/Firebase-Firestore-FFCA28?logo=firebase&logoColor=black)
![YOLOv8](https://img.shields.io/badge/AI-YOLOv8%20%2B%20EasyOCR-00FFFF)
![Version](https://img.shields.io/badge/version-1.0.4-success)
![License](https://img.shields.io/badge/license-Proprietary-lightgrey)

> 📷 _Screenshot aplikasi:_ `assets/screenshots/home.png` · `assets/screenshots/detection.png` · `assets/screenshots/result.png` _(placeholder — tambahkan tangkapan layar Anda di sini)_

---

## 📑 Daftar Isi

- [Fitur](#-fitur)
- [Tech Stack](#-tech-stack)
- [Struktur Folder](#-struktur-folder)
- [Prasyarat](#-prasyarat)
- [Instalasi dan Menjalankan](#-instalasi-dan-menjalankan)
- [Konfigurasi Environment](#-konfigurasi-environment)
- [Arsitektur](#-arsitektur)
- [Penggunaan](#-penggunaan)
- [Kontribusi](#-kontribusi)
- [Lisensi](#-lisensi)

---

## ✨ Fitur

Aplikasi memiliki satu aktor utama yaitu **Pengguna/Petugas**, dengan fitur-fitur berikut:

- 🏠 **Melihat Informasi Aplikasi** — Beranda menampilkan deskripsi aplikasi dan langkah "Cara Kerja" deteksi.
- 📸 **Mengambil Gambar Kendaraan** — Menangkap foto kendaraan langsung dari kamera perangkat (live preview).
- 🖼️ **Mengunggah Gambar Kendaraan** — Memilih foto kendaraan dari galeri perangkat.
- 🤖 **Mendeteksi Kendaraan & Plat Nomor** — Mengirim gambar ke API YOLOv8, mengenali jenis kendaraan prioritas, membaca plat nomor (EasyOCR), dan menghitung tingkat keyakinan (confidence).
- 📄 **Melihat Hasil Deteksi** — Menampilkan gambar, jenis kendaraan, nomor polisi, badge confidence (High/Medium/Low), dan tanggal deteksi.
- 🗂️ **Melihat Riwayat Deteksi** — Daftar seluruh deteksi tersimpan, tersinkronisasi real-time dari Firestore dan terurut dari yang terbaru.
- 🔎 **Memfilter Riwayat Deteksi** — Menyaring riwayat berdasarkan kategori: Semua, Ambulance, Police, atau Fire Truck.

---

## 🛠️ Tech Stack

### Frontend (Mobile)
- **Flutter** — SDK `^3.10.8` (Dart 3.x)
- **GetX** `^4.6.6` — state management, dependency injection, dan routing
- **camera** `^0.11.0` — akses kamera untuk menangkap gambar
- **image_picker** `^1.0.7` — memilih gambar dari galeri
- **cupertino_icons** `^1.0.8`

### Backend / AI Service
- **API Deteksi YOLOv8 + EasyOCR** — endpoint eksternal `https://yusnar.my.id/py-yolo-nopol/api/v1/detect` (menerima gambar multipart, mengembalikan `vehicle`, `plate_number`, `confidence`)
- **http** `^1.2.1` & **http_parser** `^4.1.2` — komunikasi multipart HTTP ke API

### Database & Services
- **Firebase Core** `3.15.2`
- **Cloud Firestore** `^5.4.4` — penyimpanan riwayat deteksi (koleksi `vehicle_detection`)
- **Firebase Storage** `^12.3.2`

### Tools
- **flutter_lints** `^6.0.0` — linting
- **flutter_launcher_icons** `^0.14.4` — generator ikon aplikasi
- **flutter_test** — pengujian widget

---

## 📂 Struktur Folder

```text
Flutter-YOLO-PriorityNopol/
├── lib/
│   ├── main.dart                  # Entry point — inisialisasi Firebase & GetMaterialApp
│   ├── app_pages.dart             # Definisi GetPage (routing) + binding & transisi
│   ├── app_routes.dart            # Konstanta nama route (/home, /detection, /result)
│   ├── firebase_options.dart      # Konfigurasi Firebase per-platform
│   └── app/
│       ├── core/
│       │   ├── app_pages.dart     # (deprecated, digantikan lib/app_pages.dart)
│       │   ├── theme/             # Warna, ukuran, & gaya teks aplikasi
│       │   ├── utils/             # SlidePageTransition (animasi navigasi)
│       │   └── widgets/           # Komponen UI reusable (kartu deteksi, tombol, dll)
│       ├── data/
│       │   └── models/
│       │       └── detection_record.dart   # Model domain hasil deteksi + (de)serialisasi Firestore
│       └── features/              # Modul fitur (pola Bindings-Controllers-Views)
│           ├── main/              # Beranda + Riwayat Deteksi (PageView)
│           ├── detection/         # Kamera/upload + submit deteksi
│           └── result/            # Tampilan hasil deteksi
├── assets/
│   └── images/                    # logo.webp, ambulance.webp, police.webp, fireman.webp
├── android/                       # Proyek native Android (berisi google-services.json)
├── ios/ · macos/ · linux/ · windows/ · web/   # Target platform Flutter lain
├── test/                          # widget_test.dart
├── docs/                          # Dokumentasi teknis (UML, desain DB, testing)
├── firebase.json                  # Konfigurasi Firebase
├── flutter_launcher_icons.yaml    # Konfigurasi ikon launcher
└── pubspec.yaml                   # Dependency & metadata project
```

---

## ✅ Prasyarat

Pastikan tools berikut sudah terpasang sebelum menjalankan project:

- **Flutter SDK** `>= 3.10.8` (channel stable) — termasuk Dart SDK `3.x`
- **Android Studio** / **Xcode** — untuk emulator/simulator dan build native
- **Perangkat fisik atau emulator** dengan kamera (fitur kamera memerlukan perangkat ber-kamera)
- **Akun Firebase** + proyek Firebase aktif (untuk Firestore)
- **Git** — untuk meng-clone repository
- Koneksi internet — untuk memanggil API deteksi YOLOv8 dan sinkronisasi Firestore

---

## 🚀 Instalasi dan Menjalankan

**1. Clone repository**
```bash
git clone <url-repository-anda>
cd Flutter-YOLO-PriorityNopol
```

**2. Pasang dependency**
```bash
flutter pub get
```

**3. Konfigurasi Firebase**

Aplikasi memerlukan konfigurasi Firebase agar Firestore dapat berfungsi:
```bash
# Letakkan file konfigurasi Android Anda di:
#   android/app/google-services.json
#
# Atau regenerate konfigurasi multi-platform via FlutterFire CLI:
dart pub global activate flutterfire_cli
flutterfire configure
```
> File `lib/firebase_options.dart` dan `android/app/google-services.json` harus sesuai dengan proyek Firebase Anda.

**4. Jalankan aplikasi (mode development)**
```bash
flutter run
```

**5. Build production**
```bash
# Android APK
flutter build apk --release

# Android App Bundle (untuk Play Store)
flutter build appbundle --release

# iOS
flutter build ios --release
```

---

## ⚙️ Konfigurasi Environment

Aplikasi ini tidak menggunakan file `.env`; konfigurasi tersebar pada beberapa berkas berikut. Gunakan placeholder dan jangan commit nilai sensitif Anda.

| Konfigurasi | Deskripsi | Contoh Nilai | Wajib/Opsional |
|-------------|-----------|--------------|----------------|
| `google-services.json` | Kredensial Firebase untuk Android (`android/app/`) | `YOUR_FIREBASE_ANDROID_CONFIG` | Wajib |
| `firebase_options.dart` | Konfigurasi Firebase per-platform (apiKey, projectId, dll) | `YOUR_FIREBASE_OPTIONS` | Wajib |
| API Detect URL | Endpoint API deteksi YOLOv8 (`_apiUrl` pada `detection_controller.dart`) | `https://your-domain/py-yolo-nopol/api/v1/detect` | Wajib |
| Koleksi Firestore | Nama koleksi penyimpanan deteksi | `vehicle_detection` | Wajib |
| Timeout request | Batas waktu request ke API deteksi | `30` (detik) | Opsional |

---

## 🏛️ Arsitektur

PrioScan menerapkan **feature-first architecture** dengan pola **GetX (MVC-style: Bindings → Controllers → Views)**. Setiap fitur dipisah ke dalam folder mandiri yang berisi `bindings/`, `controllers/`, dan `views/`.

```text
┌─────────────────────────────────────────────────────────┐
│                         View (UI)                         │
│   HomePage · HistoryPage · DetectionView · ResultView     │
│            (reaktif via Obx terhadap Controller)          │
└───────────────┬───────────────────────────────────────────┘
                │ panggil method / amati Rx state
                ▼
┌─────────────────────────────────────────────────────────┐
│                      Controller (GetX)                     │
│   MainController · DetectionController · ResultController  │
│   • logika bisnis  • state (RxBool/RxString/RxList)        │
│   • orkestrasi kamera, API, & navigasi                     │
└───────┬───────────────────────────────┬───────────────────┘
        │                               │
        ▼                               ▼
┌──────────────────┐         ┌──────────────────────────────┐
│  Model / Data     │         │     Layanan Eksternal         │
│ DetectionRecord   │         │  • API YOLOv8 + EasyOCR (HTTP) │
│ (toMap/fromFirest)│◄────────│  • Cloud Firestore (real-time)│
└──────────────────┘         └──────────────────────────────┘
```

**Tanggung jawab tiap layer:**
- **View** — Menampilkan UI dan bereaksi terhadap perubahan state lewat `Obx`. Tidak menyimpan logika bisnis.
- **Binding** — Mendaftarkan/menyuntikkan controller saat route dibuka (lazy dependency injection).
- **Controller** — Memegang state reaktif (Rx), menangani kamera/galeri, memanggil API deteksi, menyimpan & men-stream data Firestore, serta mengatur navigasi.
- **Model (`DetectionRecord`)** — Representasi domain hasil deteksi sekaligus (de)serialisasi ke/dari dokumen Firestore.
- **Layanan eksternal** — API YOLOv8 untuk inferensi & OCR, dan Firestore untuk persistensi riwayat real-time.

---

## 📖 Penggunaan

Alur utama pengguna (happy path):

1. **Buka aplikasi** — Beranda menampilkan deskripsi dan langkah "Cara Kerja".
2. **Tekan `GET STARTED`** — Masuk ke halaman Deteksi Kendaraan dengan pratinjau kamera.
3. **Ambil atau unggah gambar** — Tekan *Ambil Gambar* (kamera) atau *Upload Gambar* (galeri). Gunakan *Ambil Ulang* jika ingin mengganti foto.
4. **Tekan `SUBMIT`** — Gambar dikirim ke API YOLOv8; muncul indikator proses.
5. **Lihat Hasil Deteksi** — Jenis kendaraan, nomor polisi, persentase confidence (badge High/Medium/Low), dan tanggal ditampilkan; data otomatis tersimpan ke Firestore.
6. **Telusuri Riwayat** — Geser ke bawah dari beranda atau tekan *Kembali* dari hasil untuk membuka Riwayat Deteksi, lalu **filter** berdasarkan kategori kendaraan.

> 📷 _Tambahkan tangkapan layar/GIF pada `assets/screenshots/` untuk memperjelas alur ini._

---

## 🤝 Kontribusi

Kontribusi sangat disambut! Ikuti langkah berikut:

1. **Fork** repository ini.
2. **Clone** hasil fork Anda:
   ```bash
   git clone <url-fork-anda>
   ```
3. **Buat branch** sesuai konvensi:
   - `feature/<nama-fitur>` — penambahan fitur baru
   - `fix/<nama-bug>` — perbaikan bug
   - `hotfix/<nama-perbaikan>` — perbaikan mendesak di produksi
   ```bash
   git checkout -b feature/filter-tanggal
   ```
4. **Commit** dengan format pesan yang jelas (mengikuti gaya commit project, mis. `feat:`, `fix:`, atau ringkas seperti `fix apk #6`):
   ```bash
   git commit -m "feat: tambah filter berdasarkan tanggal deteksi"
   ```
5. **Push** dan buka **Pull Request** ke branch `master`:
   ```bash
   git push origin feature/filter-tanggal
   ```

Pastikan `flutter analyze` lulus tanpa error sebelum mengirim Pull Request.

---

## 📄 Lisensi

© 2026 PrioScan — Priority Vehicle Scanner. All rights reserved.

Project ini bersifat proprietary; tidak terdapat lisensi open-source eksplisit. Hubungi pemilik repository untuk izin penggunaan atau distribusi.
