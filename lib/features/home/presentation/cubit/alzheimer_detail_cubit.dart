import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/alzheimer_models.dart';
import 'alzheimer_detail_state.dart';

class AlzheimerDetailCubit extends Cubit<AlzheimerDetailState> {
  AlzheimerDetailCubit() : super(AlzheimerDetailLoading());

  void loadDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 700));

    emit(AlzheimerDetailLoaded(
      identityData: IdentityRecognitionData(
        instruction: "Point the camera toward your visitor to see their name and your last memory together.",
        imagePath: "https://lh3.googleusercontent.com/aida-public/AB6AXuC-MvL2ZOU9XdsMAnle_ftfpIc7EoTWnN5fuz4IT2VW3wPhfJisRRBi8zwd_KDQfhajWPAUsllztiavB5gUnvkH1xCTMvMEZy2nRnpuR4b4HMqB-iqJIsIkA0MVBjXvzefOpChclzG-SJ2nKTTb273OB1Y3Wm1QuMYiMs8Ohhb2c4oKpBiWi7rOJr2x-4bcQ4-WrQVSiNxecDU9MLphInz6RC-3r20R_0PFvRwJAWY_-Q9-ZiTuoP-COqxb6jEYga3YE1ebqbhG50rC",
      ),
      medicines: [
        DetailMedicineItem(
          timeLabel: "08:00 AM - Breakfast",
          name: "Donepezil",
          dosageDescription: "1 Pill • White Round",
          isTaken: true,
          type: "pill",
        ),
        DetailMedicineItem(
          timeLabel: "02:00 PM - Afternoon",
          name: "Memantine",
          dosageDescription: "10ml • Liquid",
          isTaken: false,
          type: "liquid",
        ),
      ],
      safeZoneData: SafeZoneData(
        locationName: "Home in London",
        mapImagePath: "https://lh3.googleusercontent.com/aida-public/AB6AXuDtwEHDZVacs_QwKj6TV8rdYxq3QU0o0GhlPlw-qjuxEZkAP3JkBeae7gnvNd3r_cCG35pRo7A9yOsoxoqM1aoZcO13HxNkWE9YsnLfNwhTnYuCK0uEgzNK5tfueD7O-BysK7EukiM8G90EHVnhTfnNBYEqAAzb5hUtwgrGhbeSlBbpgGZlkH7uk23OKotlzhJAvHTd5iZfQQ8O0oTbdt_TPfKbZ2w97MUHQV5vR8-LjJfC-i22bdz_HX27sZQ-yuKW-BDnotkNAngx",
      ),
    ));
  }
}
