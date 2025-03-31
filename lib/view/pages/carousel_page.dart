import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/controller/carousel_controller.dart';
import 'package:fuel_delivary_app_admin/controller/image_controller.dart';
import 'package:fuel_delivary_app_admin/model/carousel_model.dart';
import 'package:fuel_delivary_app_admin/view/dialog/carousel_dialogs.dart';
import 'package:get/get.dart';

class CarouselPageView extends StatefulWidget {
  const CarouselPageView({super.key});
  @override
  _CarouselPageViewState createState() => _CarouselPageViewState();
}

class _CarouselPageViewState extends State<CarouselPageView> {
  final TextEditingController _searchController = TextEditingController();
  CarouselWidgetController carouselController =
      Get.put(CarouselWidgetController());
  ImageController imageController = ImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carousels Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => CarouselDialogs.addEditCarouselDialog(
              context,
              carouselController: carouselController,
              imageController: imageController,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search carousels...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              onChanged: (v) {
                carouselController.filterCarousels(v);
              },
            ),
            const SizedBox(height: 16),
            // Carousels Data Table
            Obx(() {
              return Expanded(
                child: carouselController.state.value ==
                        CarouselWidgetControllerState.success
                    ? carouselController.filteredCarousels.value.isEmpty
                        ? const Center(
                            child: Text('No carousels found'),
                          )
                        : ListView.separated(
                            itemCount: carouselController
                                .filteredCarousels.value.length,
                            separatorBuilder: (context, index) =>
                                const Divider(height: 1),
                            itemBuilder: (context, index) {
                              CarouselModel carousel = carouselController
                                  .filteredCarousels.value[index];
                              return Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // Optional: Handle tap event
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Image with rounded corners
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Container(
                                            width: 120,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Image.network(
                                              carousel.image,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Container(
                                                color: Colors.grey.shade300,
                                                child: const Icon(
                                                    Icons.broken_image,
                                                    size: 40),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        // Title and subtitle
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                carousel.title,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                carousel.subTitle,
                                                style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontSize: 14,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        // Action buttons
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                CarouselDialogs
                                                    .addEditCarouselDialog(
                                                  context,
                                                  carouselController:
                                                      carouselController,
                                                  imageController:
                                                      imageController,
                                                  carousel: carousel,
                                                );
                                              },
                                              icon: const Icon(Icons.edit,
                                                  size: 18),
                                              label: const Text('Edit'),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                foregroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                _showDeleteConfirmation(
                                                    context, carousel);
                                              },
                                              icon: const Icon(Icons.delete,
                                                  size: 18),
                                              label: const Text('Delete'),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                    : carouselController.state.value ==
                            CarouselWidgetControllerState.error
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.error_outline,
                                    size: 48, color: Colors.red),
                                const SizedBox(height: 16),
                                Text(
                                  carouselController.error!,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () =>
                                      carouselController.getCarousels(),
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, CarouselModel carousel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Carousel'),
        content: Text('Are you sure you want to delete "${carousel.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              carouselController.deleteCarousel(carousel.id ?? "");
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
