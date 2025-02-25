import 'package:flutter/material.dart';
import 'package:kiddocare/models/kindergarten.dart';
import 'package:kiddocare/widgets/kindergarten_image.dart';
import 'package:kiddocare/widgets/loading.dart';
import 'package:kiddocare/widgets/no_data.dart';
import 'package:provider/provider.dart';
import '../providers/kindergarten_provider.dart';

class DetailScreen extends StatefulWidget {
  final int kindergartenId;

  const DetailScreen({
    Key? key,
    required this.kindergartenId,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  
  bool _isLoading = true;
  dynamic _error;
  Kindergarten? _kindergarten;

  @override
  void initState() {
    super.initState();
    _fetchKindergartenDetails();
  }

  // fetch kindergarten details
  Future<void> _fetchKindergartenDetails() async {
    try {
      final provider = context.read<KindergartenProvider>();
      final kindergarten = await provider.getKindergartenDetails(widget.kindergartenId);
      
      if (mounted) {
        setState(() {
          _kindergarten = kindergarten;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindergarten Details'),
      ),
      body: _isLoading 
        ? const GlobalLoading()
        : _error != null
          ? Center(child: Text('Error: $_error'))
          : _kindergarten == null
            ? const NoKindergartens()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // image of kindergarten  
                    KindergartenImage(
                      imageUrl: _kindergarten?.imageUrl ?? '', 
                      height: 300,
                    ),

                    // name and description
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              _kindergarten?.name ?? '',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            subtitle: Text(
                              _kindergarten?.description ?? '',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // kindergarten city
                          Row(
                            children: [
                              const Icon(Icons.location_on),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _kindergarten?.city ?? '',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          Text(
                            'Contact Details',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),

                          // contact person and contact number
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.person),
                            title: Text(_kindergarten?.contactPerson ?? ''),
                            subtitle: Text(_kindergarten?.contactNo ?? ''),
                          ),

                          // city and state
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.location_city),
                            title: Text('${_kindergarten?.city}, ${_kindergarten?.state}'),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}