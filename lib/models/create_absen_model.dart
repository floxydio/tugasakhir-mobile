class CreateAbsen {
  final int userId;
  final int guruId;
  final int kelasId;
  final int pelajaranId;
  final String keterangan;
  final String reason;

  CreateAbsen({
    required this.userId,
    required this.guruId,
    required this.kelasId,
    required this.pelajaranId,
    required this.keterangan,
    required this.reason,
  });
}
