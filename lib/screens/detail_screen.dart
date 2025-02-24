import 'package:flutter/material.dart';
import 'package:kiddocare/widgets/loading.dart';
import 'package:kiddocare/widgets/no_data.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/kindergarten_provider.dart';

class DetailScreen extends StatelessWidget {
  final int kindergartenId;

  const DetailScreen({
    Key? key,
    required this.kindergartenId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindergarten Details'),
      ),
      body: FutureBuilder(
        future: () async {
          final provider = context.read<KindergartenProvider>();
          try {
              return await provider.getKindergartenDetails(kindergartenId);
            } finally {
          }
        }(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const GlobalLoading();
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final kindergarten = snapshot.data;
          if (kindergarten == null) {
            return const NoKindergartens();
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Image of kindergarten
                CachedNetworkImage(
                  imageUrl: kindergarten.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),

                // body content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      // name and description
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          kindergarten.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        subtitle: Text(
                          kindergarten.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),

                      // city location
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.location_on),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              kindergarten.city,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // contact details
                      Text(
                        'Contact Details',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),

                      // contact details
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.person),
                        title: Text(kindergarten.contactPerson),
                        subtitle: Text(kindergarten.contactNo),
                      ),

                      // kindergarten location
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.location_city),
                        title: Text('${kindergarten.city}, ${kindergarten.state}'),
                      ),
                      const SizedBox(height: 16),
                      
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 