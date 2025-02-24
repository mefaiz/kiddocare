import 'package:flutter/material.dart';
import 'package:kiddocare/utils/routes.dart';
import 'package:kiddocare/widgets/kindergarten_image.dart';
import '../models/kindergarten.dart';

class KindergartenCard extends StatelessWidget {
  final Kindergarten kindergarten;

  const KindergartenCard({
    Key? key,
    required this.kindergarten,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: ()=> Navigator.pushNamed(context, 
          AppRoutes.detailScreen, 
          arguments: {
            "kindergartenId": kindergarten.id
          }
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              child: KindergartenImage(
                imageUrl: kindergarten.imageUrl,
                height: 100,
              ),
            ),

            // name and location
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    kindergarten.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          kindergarten.city,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 