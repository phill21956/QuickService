import 'package:flutter/material.dart';
import 'package:quick_service/utils/color_constants.dart';
import '../models/provider_model.dart';

class ServiceProviderCardWidget extends StatelessWidget {
  final ProviderModel provider;
  final VoidCallback onBook;

  const ServiceProviderCardWidget({
    super.key,
    required this.provider,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipOval(
            child: Image.network(
              provider.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          // Provider Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text("${provider.rating}"),
                  ],
                ),

                const SizedBox(height: 4),

                Text("\$${provider.hourlyRate}/hr"),
                const SizedBox(height: 4),

                if (provider.isVerified)
                  Row(
                    children: const [
                      Icon(Icons.check_circle, color: Colors.green, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "Verified",
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          // Book Button
          ElevatedButton(
            onPressed: onBook,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: const Text(
              "Book",
              style: TextStyle(color: ColorConstants.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
