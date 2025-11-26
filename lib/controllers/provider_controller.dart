import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/provider_model.dart';

class ProviderController extends GetxController {
  var searchQuery = ''.obs;
  var isLoading = true.obs;
  var searchController = TextEditingController();

  // Mock Data
  final providers = <ProviderModel>[
    ProviderModel(
      id: '1',
      name: 'John Smith',
      imageUrl: 'https://i.pravatar.cc/150?img=12',
      rating: 4.8,
      hourlyRate: 45.0,
      isVerified: true,
    ),
    ProviderModel(
      id: '2',
      name: 'Emily Carter',
      imageUrl: 'https://i.pravatar.cc/150?img=25',
      rating: 4.6,
      hourlyRate: 40.0,
      isVerified: true,
    ),
    ProviderModel(
      id: '3',
      name: 'Michael Johnson',
      imageUrl: 'https://i.pravatar.cc/150?img=18',
      rating: 4.2,
      hourlyRate: 35.0,
      isVerified: false,
    ),
    ProviderModel(
      id: '4',
      name: 'Sophia Williams',
      imageUrl: 'https://i.pravatar.cc/150?img=30',
      rating: 5.0,
      hourlyRate: 60.0,
      isVerified: true,
    ),
    ProviderModel(
      id: '5',
      name: 'David Brown',
      imageUrl: 'https://i.pravatar.cc/150?img=40',
      rating: 3.9,
      hourlyRate: 28.0,
      isVerified: false,
    ),
    ProviderModel(
      id: '6',
      name: 'Olivia Green',
      imageUrl: 'https://i.pravatar.cc/150?img=22',
      rating: 4.7,
      hourlyRate: 52.0,
      isVerified: true,
    ),
    ProviderModel(
      id: '7',
      name: 'Liam Anderson',
      imageUrl: 'https://i.pravatar.cc/150?img=35',
      rating: 4.4,
      hourlyRate: 38.0,
      isVerified: false,
    ),
    ProviderModel(
      id: '8',
      name: 'Ava Thompson',
      imageUrl: 'https://i.pravatar.cc/150?img=15',
      rating: 4.9,
      hourlyRate: 55.0,
      isVerified: true,
    ),
  ].obs;

  // Filter logic
  List<ProviderModel> get filteredProviders {
    if (searchQuery.value.isEmpty) {
      return providers;
    }
    return providers
        .where(
          (p) => p.name.toLowerCase().contains(searchQuery.value.toLowerCase()),
        )
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    fakeLoading();
  }

  void fakeLoading() async {
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }
}
