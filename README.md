-> TUGAS 7 
 
 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
 Jawab:
 Dalam Flutter, widget tree adalah struktur hierarkis yang menggambarkan bagaimana semua elemen antarmuka pengguna tersusun. Tiap elemen pada layar, mulai dari tombol, teks, hingga keseluruhan tata letak aplikasi, disebut sebagai widget, dan semuanya saling terhubung membentuk pohon (tree). Pohon ini dimulai dari widget utama, seperti MaterialApp, kemudian bercabang menjadi widget lain, seperti Scaffold, AppBar, Center, dan Text. Struktur ini memungkinkan Flutter untuk mengatur bagaimana tampilan UI dirender dan memperbarui hanya bagian yang berubah ketika ada interaksi atau pembaruan data, sehingga kinerja aplikasi tetap efisien.
 
 Hubungan parent-child (induk-anak) dalam widget tree menggambarkan bagaimana tiap widget bisa berisi widget lain di dalamnya. Widget parent bertanggung jawab mengatur posisi, ukuran, dan perilaku dari child-nya. Misalnya, Scaffold menjadi parent bagi AppBar dan body, sementara Center menjadi parent bagi Text. Saat parent mengalami perubahan atau di-rebuild, child juga bisa ikut terpengaruh tergantung pada bagaimana state dan strukturnya diatur. Oleh karena itu, memahami hubungan antara parent-child membantu pengembang membangun UI yang terorganisir, efisien, dan mudah dikelola di Flutter.
 
 Sumber: https://medium.com/@ramantank04/understanding-the-widget-tree-in-flutter-19b1c91be989


 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
 Jawab:
 Widget yang saya gunakan dalam proyek ini dan fungsinya, antara lain:
 1) MaterialApp, widget utama yang mengatur tema, judul, dan halaman awal aplikasi.
 2) Scaffold, kerangka dasar tampilan yang berisi app bar, body, dan floating action button.
 3) AppBar, bagian atas aplikasi yang menampilkan judul “ElevenKick".
 4) Padding, widget untuk memberi jarak antara isi tampilan dengan tepi layar agar tidak terlalu menempel.
 5) Center, widget yang menempatkan semua isi tampilan di bagian tengah layar.
 6) Column, widget untuk menyusun elemen-elemen secara vertikal dari atas ke bawah.
 7) Text, widget yang digunakan untuk menampilkan tulisan seperti judul, teks penjelasan, dan angka counter.
 8) FloatingActionButton, tombol bulat di pojok kanan bawah yang berfungsi untuk menambah nilai counter.
 9) ProductActionMenu, widget buatan sendiri yang berisi tiga tombol aksi: All Products, My Products, dan Create Product.
 10) Column (dalam ProductActionMenu), bagian yang menyusun teks sambutan dan tombol-tombol produk secara vertikal.
 11) SingleChildScrollView, widget yang membuat baris tombol bisa digulir ke samping jika ukurannya melebihi layar.
 12) Row, widget yang menyusun ketiga tombol produk secara horizontal dalam satu baris.
 13) SizedBox, widget yang memberi jarak antar elemen agar tampilan lebih rapi dan tidak saling menempel.
 14) Material, widget yang memberikan tampilan bergaya Material Design pada setiap tombol.
 15) InkWell, widget yang membuat tombol bisa ditekan dan menampilkan efek sentuhan (ripple effect).
 16) Container, yaitu widget yang mengatur ukuran, warna, dan jarak dalam setiap tombol.
 17) Icon, yaitu widget untuk menampilkan gambar ikon di setiap tombol seperti list, tas, dan tanda tambah.
 18) SnackBar, yaitu widget yang menampilkan pesan singkat di bagian bawah layar saat tombol ditekan.
 19) ScaffoldMessenger, yaitu widget yang bertugas menampilkan dan mengatur SnackBar pada halaman aktif.
 20) TextStyle, yaitu widget yang mengatur gaya teks seperti warna huruf, ukuran, dan ketebalan agar tulisan terlihat jelas dan menarik.
 Secara Keseluruhan struktur ini memanfaatkan kombinasi widget StatelessWidget (ProductActionMenu) dan StatefulWidget (MyHomePage) untuk menampilkan antarmuka yang interaktif namun efisien, di mana perubahan state hanya terjadi saat tombol ditekan, sementara elemen visual utama tetap statis.

 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
 Jawab:
 MaterialApp berfungsi sebagai kerangka dasar (root) aplikasi Flutter yang menggunakan Material Design. Widget ini menyediakan beberapa fungsi penting, seperti:
 1) Mendefinisikan widget awal yang akan ditampilkan melalui properti home
 2) Menyediakan konfigurasi seperti tema (theme), judul aplikasi (title), dan navigasi (navigator) yang akan diwariskan ke seluruh bagian aplikasi
 3) Bertindak sebagai pembungkus (wrapper) yang memungkinkan penggunaan widget-widget material (seperti Scaffold, AppBar) dengan benar dalam aplikasi. 
 Widget MaterialApp sering digunakan sebagai widget root karena memastikan bahwa seluruh aplikasi berada di dalam konteks materi desain yang konsisten, termasuk tema, navigasi, dan lokal (localization), serta mempermudah pengelolaan struktur aplikasi. Karena ia menjadi titik awal dari struktur widget tree, menjadikannya root memungkinkan developer untuk menetapkan aspek global aplikasi sekali saja dan membuat bagian lain dari UI bisa mengandalkan konfigurasi tersebut.
 
 Sumber: https://www.vogella.com/tutorials/Flutter/article.html

 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
 Jawab:
 StatelessWidget adalah widget yang tidak punya keadaan (state) yang bisa berubah setelah dibuat. Artinya, tampilan dan data di dalamnya bersifat statis dan tidak akan berubah selama aplikasi berjalan. Widget ini hanya dibangun sekali dan digunakan untuk elemen UI yang tidak memerlukan pembaruan dinamis, seperti teks tetap, ikon, atau layout yang tidak bergantung pada interaksi pengguna. Karena tidak menyimpan atau memperbarui state, StatelessWidget lebih ringan dan efisien dalam hal performa.
 
 Sementara itu, StatefulWidget adalah widget yang punya state yang bisa berubah selama masa hidupnya. Widget ini terdiri dari dua bagian, yaitu kelas widget itu sendiri dan kelas State yang menyimpan data atau kondisi yang bisa berubah. Ketika state mengalami perubahan, misalnya akibat input pengguna, data dari API, atau animasi, Flutter akan memanggil metode setState() untuk memperbarui tampilan (rebuild) hanya pada bagian yang berubah. Contoh penggunaan StatefulWidget termasuk tombol yang mengubah angka saat ditekan, form input yang memvalidasi data, atau tampilan dinamis yang tergantung pada respons pengguna.
 
 Pemilihan antara StatelessWidget dan StatefulWidget tergantung pada kebutuhan aplikasi. Jika UI bersifat tetap dan tidak perlu berubah selama waktu berjalan, maka StatelessWidget adalah pilihan yang lebih tepat karena lebih sederhana dan cepat. Namun, jika aplikasi memerlukan pembaruan tampilan berdasarkan interaksi atau data yang terus berubah, maka StatefulWidget harus digunakan. Dengan paham perbedaan keduanya, pengembang bisa membuat aplikasi Flutter yang lebih efisien, terstruktur, dan sesuai dengan kebutuhan fungsionalnya.
 
 Sumber: https://kodytechnolab.com/blog/stateless-vs-stateful-widget/

 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
 Jawab:
 BuildContext adalah objek yang merepresentasikan posisi suatu widget di dalam widget tree. Objek ini yang kasih informasi tentang di mana widget berada dan memungkinkan widget tersebut berinteraksi dengan elemen lain dalam hierarki, seperti mengakses tema, ukuran layar, atau data dari ancestor widget. Dengan kata lain, BuildContext berfungsi sebagai “identitas lokasi” yang digunakan Flutter untuk membangun dan mengatur hubungan antar-widget dalam struktur UI.
 
 BuildContext sangat penting karena menjadi penghubung antara satu widget dengan widget lain di dalam aplikasi. Melalui context, widget bisa dapat akses ke informasi dari widget yang berada di atasnya (parent atau ancestor) tanpa harus meneruskan data secara manual ke setiap level. Misalnya, Theme.of(context) digunakan untuk mengambil warna dan gaya dari tema aplikasi, atau Navigator.of(context) digunakan untuk berpindah halaman. Tanpa BuildContext, interaksi hierarkis dan pewarisan data dalam Flutter akan jadi jauh lebih susah.
 
 Dalam metode build(BuildContext context), parameter context disediakan langsung oleh framework Flutter setiap kali sebuah widget dibangun. Di dalam metode ini, context digunakan untuk membangun tampilan dengan memanggil widget lain dan mengakses data lingkungan sesuai posisi widget tersebut dalam tree. Karena tiap widget punya context-nya masing-masing, pemilihan context yang tepat sangat penting. Misalnya, jika kita memanggil Scaffold.of(context) dengan context yang belum berada di bawah Scaffold, maka akan terjadi error. Oleh karena itu, memahami dan menggunakan BuildContext dengan benar sangat krusial untuk membangun UI yang efisien dan bebas bug di Flutter.
 
 Sumber: https://api.flutter.dev/flutter/widgets/BuildContext-class.html

 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
 Jawab:
 Hot reload adalah fitur yang memungkinkan pengembang memberikan perubahan kode langsung ke dalam aplikasi yang sedang berjalan tanpa perlu menghentikan prosesnya. Saat hot reload dilakukan, Flutter meng-inject kode Dart yang telah diperbarui ke dalam Virtual Machine (VM) dan kemudian me-rebuild widget tree agar perubahan UI segera terlihat. Keunggulan utama hot reload adalah state aplikasi tetap dipertahankan, sehingga posisi layar, data input, atau interaksi sebelumnya tidak hilang. Fitur ini sangat membantu dalam pengembangan karena memungkinkan iterasi cepat terhadap desain antarmuka maupun logika tampilan.
 
 Sementara itu, hot restart bekerja dengan cara memuat ulang seluruh aplikasi dari awal, termasuk menjalankan kembali fungsi main(). Proses ini akan menghapus semua state yang sebelumnya tersimpan, sehingga aplikasi kembali ke kondisi awal seolah baru dijalankan. Hot restart digunakan ketika perubahan kode tidak bisa diterapkan hanya dengan hot reload, seperti perubahan pada variabel global, inisialisasi utama, atau konstruktor yang tidak bisa di-update secara dinamis.
 
 Dengan demikian, perbedaan utamanya adalah bahwa hot reload mempertahankan state aplikasi, sedangkan hot restart menghapus dan memulai ulang seluruh state. Kombinasi keduanya memungkinkan pengembang Flutter bekerja lebih efisien menggunakan hot reload untuk perubahan kecil dan cepat, serta hot restart untuk perubahan besar yang memengaruhi struktur dasar aplikasi.
 
 Sumber: https://docs.flutter.dev/tools/hot-reload 


-> TUGAS 8

1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
Jawab:
Navigator.push() digunakan untuk menambahkan halaman baru di atas halaman yang sedang aktif dalam route stack. Artinya, halaman sebelumnya tetap tersimpan di bawah dan masih bisa dikunjungi kembali ketika pengguna menekan tombol Back. Sedangkan Navigator.pushReplacement() akan menghapus halaman saat ini dan menggantinya dengan halaman baru. Halaman lama tidak disimpan dalam stack, sehingga ketika pengguna menekan tombol Back, ia tidak akan kembali ke halaman sebelumnya, tetapi langsung keluar atau kembali ke halaman yang lebih bawah di stack (jika ada).

Dalam aplikasi Football Shop saya, saya menggunakan Navigator.push() untuk membuka halaman baru di atas halaman saat ini, sehingga pengguna masih bisa kembali ke halaman sebelumnya dengan tombol back. Contoh penggunaannya di aplikasi saya adalah saat membuka halaman "Tambah Produk" dari halaman utama—pengguna bisa mengisi form, lalu kembali ke halaman utama jika mau. Sedangkan, Navigator.pushReplacement() saya pakai untuk mengganti halaman saat ini dengan halaman baru, sehingga halaman sebelumnya dihapus dari stack dan pengguna tidak bisa kembali ke halaman lama dengan tombol back. Contohnya, setelah berhasil menambah produk dan mau langsung kembali ke halaman utama tanpa bisa kembali ke form tambah produk.

Sumber: https://pbp-fasilkom-ui.github.io/ganjil-2026/docs/tutorial-7#push-push

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
Jawab:
Saya memanfaatkan hierarchy widget, seperti Scaffold, AppBar, dan Drawer untuk menciptakan struktur halaman yang konsisten di seluruh aplikasi. Saya pakai Scaffold sebagai kerangka utama tiap halaman karena widget ini menyediakan struktur dasar yang lengkap, termasuk area untuk AppBar, Drawer, dan Body. Dengan begitu, tiap halaman memiliki tata letak yang seragam dan mudah dipelihara, sekaligus memudahkan saya dalam mengatur tampilan serta fungsi antarhalaman agar tetap konsisten.

Selain itu, saya menambahkan AppBar di bagian atas untuk menampilkan judul halaman dan tombol navigasi agar pengguna lebih mudah memahami konteks halaman yang sedang dibuka. Saya juga pakai Drawer sebagai menu navigasi samping untuk memudahkan perpindahan antarhalaman tanpa mengubah keseluruhan struktur. Dengan cara ini, aplikasi saya punya tampilan yang teratur, navigasi yang konsisten, serta pengalaman pengguna yang lebih baik dan terintegrasi.

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
Jawab:
Kelebihan menggunakan layout widget, seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form adalah untuk menciptakan tampilan yang rapi, responsif, dan nyaman digunakan. Padding bantu kasih jarak antar elemen agar form tidak terlihat menumpuk dan lebih mudah dibaca oleh pengguna. Ini membuat antarmuka terlihat lebih seimbang dan profesional.

Sementara itu, SingleChildScrollView dan ListView digunakan untuk mastiin seluruh elemen form tetap dapat diakses meskipun ruang layar terbatas. SingleChildScrollView mencegah terjadinya overflow dengan memungkinkan pengguna menggulir tampilan form secara vertikal, sedangkan ListView lebih efisien untuk menampilkan daftar elemen form yang panjang atau dinamis. Dengan kombinasi ketiga widget ini, tampilan form menjadi lebih terstruktur, mudah digunakan di berbagai ukuran layar, serta memberikan pengalaman pengguna yang lebih baik.

- Contoh penggunaan di ElevenKick:
1) Padding digunakan untuk kasih jarak antar elemen form, seperti antara TextFormField, tombol, dan label, sehingga tampilan tidak terlalu menempel dan lebih nyaman dilihat. Contohnya, setiap input pada form tambah produk dibungkus dengan Padding agar ada ruang di sekelilingnya.
2) SingleChildScrollView digunakan untuk membungkus seluruh form, sehingga jika jumlah field cukup banyak atau layar perangkat kecil, pengguna tetap bisa menggulir seluruh isi form tanpa terjadi overflow. Pada halaman AddProductPage, seluruh Form dibungkus dengan SingleChildScrollView agar bisa di-scroll.
3) ListView cocok digunakan jika elemen form bersifat dinamis atau jumlahnya banyak, karena ListView otomatis menangani scrolling dan rendering list secara efisien. Misalnya, jika ingin menampilkan daftar produk atau input yang jumlahnya bisa bertambah, ListView bisa digunakan.

Sumber: https://www.bacancytechnology.com/blog/flutter-widgets

4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
Jawab:
Saya menyesuaikan warna tema aplikasi ElevenKick agar konsisten dengan identitas visual brand toko dengan cara mengatur properti theme pada widget MaterialApp. Di dalam theme, saya menentukan warna utama (primaryColor atau colorScheme.primary), warna aksen, warna background, dan warna teks sesuai dengan warna khas brand ElevenKick, misalnya menggunakan warna hijau tua dan putih jika itu warna utama toko.

Selain itu, saya juga menggunakan warna yang sama pada elemen penting, seperti AppBar, tombol, ikon, dan highlight agar seluruh tampilan aplikasi terasa seragam dan merepresentasikan brand. Dengan konsistensi warna di seluruh halaman, pengguna akan langsung mengenali identitas visual ElevenKick setiap kali membuka aplikasi.

-> TUGAS 9
1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?
Jawab:
Membuat model Dart saat mengambil atau mengirim data JSON penting karena model ngasih struktur yang jelas, konsisten, dan terprediksi buat data yang dipakai aplikasi. Menurut sumber, penggunaan model bisa bantu melakukan parsing dan serialization dengan cara yang lebih aman dan mudah dipelihara. Dengan model, setiap field punya tipe data yang pasti, sehingga meminimalkan kesalahan saat data diproses di berbagai bagian aplikasi.

Jika hanya menggunakan Map<String, dynamic> tanpa model, maka validasi tipe jadi lebih lemah. Harus melakukan pengecekan manual tiap kali mengambil data, misalnya memastikan bahwa nilai yang diambil adalah String, int, atau double. Ini rentan menimbulkan error runtime, seperti type cast error saat struktur atau tipe data tidak sesuai ekspektasi. Selain itu, null-safety jadi sulit dijaga karena dynamic bisa berisi nilai apa pun, termasuk null yang tidak terduga.

Dari sisi maintainability, tidak adanya model buat kode jadi berantakan, duplikatif, dan lebih susah dikembangkan. Tiap bagian aplikasi yang memanfaatkan data JSON harus menulis ulang logika pemetaan atau pengecekan tipe yang sama. Dengan model, perubahan API (misalnya penambahan atau penghapusan field) cukup diperbarui di satu tempat.

Jadi, model juga bantu meningkatkan readability dan mempermudah kolaborasi. Developer lain bisa langsung paham bentuk data hanya dengan melihat class model, sementara menggunakan Map<String, dynamic> membuat struktur data tidak terdokumentasi secara eksplisit. Model menjadikan aplikasi lebih scalable, lebih aman, dan lebih mudah dikelola dalam jangka panjang.

Sumber: https://codewithandrea.com/articles/parse-json-dart/

2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.
Jawab:
Package http digunakan untuk melakukan HTTP request standar, baik mengirim maupun menerima data, tanpa pengaturan khusus. Sementara itu, CookieRequest dirancang khusus untuk berinteraksi dengan backend Django yang menggunakan session-based authentication, karena secara otomatis menyimpan dan mengirim cookie, sehingga request yang memerlukan login dapat dilakukan tanpa harus mengelola cookie secara manual.

3. Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
Jawab:
Instance CookieRequest perlu dibagikan ke semua komponen dalam aplikasi Flutter karena Flutter tidak punya global shared state secara otomatis, seperti beberapa framework lain. Mirip dengan konsep shared state management yang dijelaskan dalam dokumentasi Flutter untuk developer React Native, Flutter bekerja dengan sistem widget yang bersifat immutable. Akibatnya, jika ada objek yang perlu dipakai secara konsisten di banyak bagian aplikasi, seperti CookieRequest buat jaga sesi login, simpan cookie, dan lakuin permintaan HTTP—maka objek tersebut harus secara eksplisit dibagikan melalui mekanisme, seperti inherited widgets, provider, atau state management lainnya.

Jika tiap widget buat instance CookieRequest sendiri, maka cookie, sesi login, dan data autentikasi tidak akan konsisten. Hal ini bisa menyebabkan pengguna dianggap “logout” di satu halaman dan “login” di halaman lain karena tiap instance tidak saling berbagi state. Dengan satu instance yang sama, seluruh komponen dapat menggunakan state autentikasi bersama.

Pendekatan ini mengikuti prinsip single source of truth yang ditekankan Flutter. Dengan membagikan instance CookieRequest secara terpusat, aplikasi jadi lebih stabil, mudah dikelola, dan memastikan perilaku autentikasi tetap konsisten di semua halaman.

Sumber: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
Jawab:
Agar Flutter bisa berkomunikasi dengan Django, beberapa konfigurasi konektivitas harus disiapkan sesuai cara Flutter berinteraksi dengan backend di lingkungan mobile. Aplikasi mobile membutuhkan pengaturan host dan izin jaringan yang eksplisit. Karena Android emulator tidak bisa menggunakan localhost buat akses server di komputer pengembang, Flutter harus pakai alamat khusus 10.0.2.2. Karena itu, Django perlu menambahkan 10.0.2.2 ke dalam ALLOWED_HOSTS agar server mengizinkan request dari emulator dan tidak memblokirnya sebagai host yang tidak sah.

Selain itu, konektivitas lintas platform perlu pengaturan CORS dan konfigurasi cookie, seperti SameSite supaya Flutter bisa kirim permintaan ke origin yang berbeda serta menerima cookie sesi dari Django. Prinsip ini sejalan dengan penjelasan dokumentasi bahwa komunikasi aplikasi–server sering melibatkan cross-origin requests yang harus diizinkan secara eksplisit oleh backend. Jika CORS atau pengaturan SameSite/cookie tidak diaktifkan, request dari Flutter bisa diblokir, atau cookie autentikasi tidak akan terkirim sehingga proses login atau request terenkripsi gagal.

Di sisi Android, Flutter juga butuh izin akses internet melalui deklarasi permission, karena platform mobile memerlukan izin eksplisit untuk fitur yang mengakses resource sistem. Tanpa izin ini, aplikasi tidak bisa buat koneksi jaringan meskipun endpoint dan server sudah benar.

Jika konfigurasi tersebut tidak dilakukan dengan benar, Flutter tidak akan bisa berkomunikasi dengan Django. Hal ini dapat menyebabkan error, seperti host not allowed, blocked by CORS, cookie tidak terkirim atau tidak tersimpan, serta kegagalan total untuk melakukan request jaringan. Akibatnya, fitur seperti login, pengambilan data, dan proses API lainnya tidak akan berfungsi dalam aplikasi.

Sumber:  https://docs.flutter.dev/get-started/flutter-for/react-native-devs

5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
Jawab:
Mekanisme pengiriman data di Flutter dimulai dari tahap pengambilan input pengguna, misalnya melalui TextField atau form yang simpan nilai ke variabel. Setelah input terkumpul, Flutter siapin data tersebut dalam format yang sesuai, umumnya JSON buat dikirimkan ke server. Tahap ini melibatkan pembuatan request body serta penentuan endpoint API yang akan menerima data.

Selanjutnya, Flutter menggunakan paket, seperti http buat melakukan HTTP POST request ke server. Pada tahap ini, data dikirim melalui internet bersama header yang diperlukan, seperti Content-Type: application/json. Server kemudian memproses data tersebut dan mengembalikan respons, biasanya juga dalam format JSON. Ini mengikuti pola umum request–response.

Setelah respons diterima, Flutter melakukan parsing data dari JSON jadi objek Dart atau langsung memetakan nilai yang diperlukan. Hasil respons tersebut kemudian ditampilkan kembali di UI, misalnya melalui widget, seperti Text, ListView, atau elemen lain yang diperbarui dengan setState atau state management tertentu. Dengan mekanisme ini, data bisa mengalir dari input pengguna, dikirim ke server, diproses, dan akhirnya ditampilkan kembali dalam aplikasi.

Sumber: https://www.geeksforgeeks.org/flutter/flutter-sending-data-to-the-internet/

6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
Jawab:
Proses autentikasi diawali dari register, di mana Flutter mengambil input user melalui form, melakukan validasi data, dan mengirimkan request dalam format JSON ke Django. Django mengecek dan memverifikasi informasi tersebut sebelum membuat akun baru. Setelah itu, user bisa login dengan memasukkan username dan password di Flutter, yang dikirim menggunakan CookieRequest ke endpoint login Django. Jika kredensial valid, Django mengembalikan response sukses beserta session cookie (sessionid), yang otomatis disimpan oleh CookieRequest sehingga setiap request berikutnya mengenali user tanpa perlu login lagi. Setelah login berhasil, Flutter menavigasikan user ke halaman menu utama yang hanya bisa diakses oleh authenticated user. Saat logout, Flutter mengirim request ke endpoint logout Django, yang menghapus session di server dan CookieRequest menghapus cookie lokal, sehingga status login hilang dan user diarahkan kembali ke halaman login.

7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).
Jawab:
Pertama, konfigurasi Django perlu disesuaikan, termasuk ALLOWED_HOSTS, CORS, dan pengaturan cookie, agar backend dapat terhubung dengan Flutter, serta memastikan proyek berjalan dan endpoint JSON dapat diakses. Selanjutnya, tambahkan fungsi-fungsi di Django untuk menerima request dan mengirim data ke Flutter.

Di sisi Flutter, buat file-file baru untuk autentikasi, dimulai dari register dengan form TextFormField untuk username, password, dan confirm password. Saat tombol Register ditekan, form divalidasi, datanya dikirim ke endpoint register Django, dan jika berhasil, tampilkan SnackBar serta arahkan user ke halaman login. Login di Flutter dilakukan menggunakan request.login(".../auth/login/", {...}) dari package pbp_django_auth, sehingga jika kredensial valid, session cookie dari Django tersimpan di CookieRequest dan user diarahkan ke MyHomePage.

Agar sistem autentikasi terintegrasi, di main.dart aplikasi dibungkus dengan Provider dan diberikan satu instance CookieRequest ke seluruh widget; fitur yang membutuhkan login memanfaatkan instance ini. Untuk logout, gunakan request.logout(".../auth/logout/") dan arahkan kembali ke LoginPage saat berhasil.

Selain itu, buat model Dart kustom ProductEntry yang strukturnya mengikuti model Django, lengkap dengan fromJson dan toJson, agar respons JSON dari Django bisa langsung dikonversi menjadi objek dengan tipe data aman. Untuk menampilkan daftar produk, buat ProductEntryListPage yang melakukan request.get(".../json/"), mengubah hasilnya menjadi list, dan menampilkannya menggunakan ListView.builder serta ProductEntryCard yang menampilkan name, price, potongan description, thumbnail via Image.network (proxy), category, dan label “Featured” jika is_featured bernilai true.

Untuk detail produk, buat ProductDetailPage yang menerima satu objek ProductEntry dari onTap di card, menampilkan semua atribut beserta thumbnail di atas, serta menyediakan tombol back bawaan AppBar. Terakhir, untuk menampilkan produk milik user yang login, tambahkan fungsi di Django dengan Product.objects.filter(user=request.user) yang mengembalikan JSON hanya berisi produk user tersebut, lalu di Flutter buat MyProductListPage yang memanggil endpoint ".../json/my-products/" dan menampilkannya sama seperti halaman All Products, sehingga hanya menampilkan produk yang ditambahkan oleh akun yang sedang login.
