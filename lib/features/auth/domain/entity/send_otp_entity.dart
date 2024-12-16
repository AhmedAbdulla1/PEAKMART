
import 'package:peakmart/core/entities/base_entity.dart';

class SendOtpEntity extends BaseEntity {
  final String email;


  SendOtpEntity(
      { required this.email});

  @override
  List<Object?> get props => [email];
}
