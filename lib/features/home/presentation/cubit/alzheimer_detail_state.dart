import 'package:equatable/equatable.dart';
import '../../domain/entities/alzheimer_models.dart';

abstract class AlzheimerDetailState extends Equatable {
  const AlzheimerDetailState();
  @override
  List<Object> get props => [];
}

class AlzheimerDetailLoading extends AlzheimerDetailState {}

class AlzheimerDetailLoaded extends AlzheimerDetailState {
  final IdentityRecognitionData identityData;
  final List<DetailMedicineItem> medicines;
  final SafeZoneData safeZoneData;

  const AlzheimerDetailLoaded({
    required this.identityData,
    required this.medicines,
    required this.safeZoneData,
  });

  @override
  List<Object> get props => [identityData, medicines, safeZoneData];
}
