import 'package:flutter/material.dart';
import 'package:kiddocare/utils/routes.dart';
import 'package:kiddocare/widgets/loading.dart';
import 'package:kiddocare/widgets/no_data.dart';
import 'package:provider/provider.dart';
import '../providers/kindergarten_provider.dart';
import '../widgets/kindergarten_card.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({Key? key}) : super(key: key);

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // fetch the first page of kindergartens
    Future.microtask(() {
      final provider = Provider.of<KindergartenProvider>(context, listen: false);
      provider.currentPage = 1; 
      provider.fetchKindergartens();
    });
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      Provider.of<KindergartenProvider>(context, listen: false).fetchKindergartens();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KindergartenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Kiddocare - Kindergartens'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // for searching kindergartens
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search kindergartens...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            
            provider.isLoading && provider.kindergartens.isEmpty 
              ? const GlobalLoading()
              : provider.kindergartens.isEmpty 
                ? const NoKindergartens()
                : Column(
                  children: [
                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 10,
                        childAspectRatio: .85,
                      ),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.kindergartens.length,
                      itemBuilder: (context, index) {
                        return KindergartenCard(
                          kindergarten: provider.kindergartens[index], 
                          onTap: ()=> Navigator.pushNamed(context, 
                            AppRoutes.detailScreen, 
                            arguments: {
                              "kindergartenId": provider.kindergartens[index].id
                            }
                          )
                        );
                      }
                    ),
                  
                  // loading indicator
                  if (provider.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
            ),
          ],
        ),
      ),
    );
  }
} 