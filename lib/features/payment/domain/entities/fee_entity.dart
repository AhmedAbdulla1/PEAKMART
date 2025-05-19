class FeesEntity {
  /// Fixed upload cost
  final num upload;
  /// Percentage-based upload fee
  final num uploadFee;
  final num enrollFee;
  final num payFee;
  final num bidFee;

  FeesEntity({
    required this.upload,
    required this.uploadFee,
    required this.enrollFee,
    required this.payFee,
    required this.bidFee,
  }) {
    assert(upload >= 0, 'Upload cost cannot be negative');
    assert(uploadFee >= 0, 'Upload fee percentage cannot be negative');
    assert(enrollFee >= 0, 'Enroll fee cannot be negative');
    assert(payFee >= 0, 'Pay fee cannot be negative');
    assert(bidFee >= 0, 'Bid fee cannot be negative');
  }
}