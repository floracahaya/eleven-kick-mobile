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
