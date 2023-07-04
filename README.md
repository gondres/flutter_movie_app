A new Movie App project supported by TMDB API.

## Getting Started

Clone Guide
1. Buka VSCode anda
2. Ketik CTRL + SHIFT + P
3. lalu ketik "Git Clone" tekan Enter
4. Kemudian copy paste url link github "https://github.com/gondres/flutter_movie_app.git" tekan Enter.
5. Lalu buka folder clone app.
5. Lalu ke File → Preferences → Settings
   cari "Flutter run additional args"
   lalu klik Add Item
   lalu ketik --no-sound-null-safety
   Click OK.
6.lalu Klik kanan padA file android -> New File -> ketik" local.properties"
Lalu isi code di bawah ini:
``
sdk.dir={{path android sdk}}
flutter.sdk={{path flutter sdk}}
flutter.buildMode=debug
flutter.versionName=1.0.0
flutter.versionCode=1
``
7. buka terminal, ketik "flutter upgrade"
8. Buka emulator android anda.
9. Lalu, buka terminal, ketik "flutter run"

Semoga membantu :D.
