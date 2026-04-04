import 'package:equatable/equatable.dart';
import '../../../../domain/entities/alzheimer_models.dart';

abstract class AlzheimerDetailState extends Equatable {
  const AlzheimerDetailState();
  @override
  List<Object?> get props => [];
}

class AlzheimerDetailLoading extends AlzheimerDetailState {}

class AlzheimerDetailLoaded extends AlzheimerDetailState {
  final IdentityRecognitionData identityData;
  final List<DetailMedicineItem> medicines;
  final SafeZoneData safeZoneData;
  final String? alertMessage;

  const AlzheimerDetailLoaded({
    required this.identityData,
    required this.medicines,
    required this.safeZoneData,
    this.alertMessage,
  });

  AlzheimerDetailLoaded copyWith({
    IdentityRecognitionData? identityData,
    List<DetailMedicineItem>? medicines,
    SafeZoneData? safeZoneData,
    String? alertMessage,
    bool clearAlert = false,
  }) {
    return AlzheimerDetailLoaded(
      identityData: identityData ?? this.identityData,
      medicines: medicines ?? this.medicines,
      safeZoneData: safeZoneData ?? this.safeZoneData,
      alertMessage: clearAlert ? null : (alertMessage ?? this.alertMessage),
    );
  }

  @override
  List<Object?> get props => [identityData, medicines, safeZoneData, alertMessage];
}
