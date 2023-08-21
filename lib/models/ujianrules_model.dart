class UjianRules {
  final int id;
  final String title;
  final String subtitle;

  UjianRules({required this.id, required this.title, required this.subtitle});

  static List<UjianRules> ujianList = [
    UjianRules(
        id: 1,
        title: "Perangkat",
        subtitle:
            "Siswa harus menggunakan ponsel atau tablet yang kompatibel dengan aplikasi ujian."),
    UjianRules(
        id: 2,
        title: "Persiapan",
        subtitle:
            "Pastikan perangkat memiliki baterai yang cukup dan aplikasi ujian telah diunduh dan dites sebelumnya."),
    UjianRules(
        id: 3,
        title: "Koneksi Internet",
        subtitle:
            "Siswa memerlukan koneksi internet yang stabil selama ujian."),
    UjianRules(
        id: 4,
        title: "Lingkungan Ujian",
        subtitle:
            "Pastikan berada di ruangan yang tenang, tanpa gangguan, dan pencahayaan yang memadai."),
    UjianRules(
        id: 5,
        title: "Integritas",
        subtitle:
            "Dilarang mengakses sumber lain atau berkomunikasi dengan orang lain selama ujian. Pengawasan mungkin dilakukan melalui kamera."),
    UjianRules(
        id: 6,
        title: "Notifikasi",
        subtitle:
            "Aktifkan notifikasi pada aplikasi untuk menerima instruksi atau pemberitahuan."),
    UjianRules(
        id: 7,
        title: "Masalah Teknis",
        subtitle:
            "Jika ada masalah, segera hubungi pengawas ujian atau dukungan teknis."),
    UjianRules(
        id: 8,
        title: "Durasi",
        subtitle: "Mulai dan selesaikan ujian sesuai jadwal yang ditentukan."),
    UjianRules(
        id: 9,
        title: "Penggunaan Aplikasi Lain",
        subtitle: "Dilarang keras membuka aplikasi lain selama ujian."),
    UjianRules(
        id: 10,
        title: "Konsekuensi",
        subtitle:
            "Pelanggaran peraturan dapat mengakibatkan pembatalan hasil ujian atau sanksi lainnya.")
  ];
}
