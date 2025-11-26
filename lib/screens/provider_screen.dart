import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_service/utils/color_constants.dart';
import '../controllers/provider_controller.dart';
import '../widgets/provider_card_widget.dart';

class ProviderListScreen extends StatelessWidget {
  const ProviderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderController());

    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "ServiceConnect",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.primaryColor,
                ),
              ),
            ),

            // Search Bar
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: controller.updateSearch,
                  decoration: InputDecoration(
                    hintText: "Search providers by name...",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: controller.searchQuery.value.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              controller.updateSearch('');
                              controller.searchQuery.value = '';
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // List of Providers
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.filteredProviders.isEmpty) {
                  return const Center(
                    child: Text(
                      "No providers found",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.filteredProviders.length,
                  itemBuilder: (context, index) {
                    final provider = controller.filteredProviders[index];
                    return ProviderCardWidget(
                      provider: provider,
                      onBook: () {
                        // Navigate to booking screen
                        Get.snackbar("Booking", "Go to booking screen");
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
