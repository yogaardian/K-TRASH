class Order {
  final int? id;
  final String nama;
  final String alamat;
  final String code;
  final String? jenisSampah;
  final String? catatan;

  Order({
    this.id,
    required this.nama,
    required this.alamat,
    required this.code,
    this.jenisSampah,
    this.catatan,
  });
}
