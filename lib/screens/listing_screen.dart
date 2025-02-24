import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      provider.fetchKindergartens(
        currentPage: provider.currentPage,
        perPage: provider.perPage,
      );
    });
    _scrollController.addListener(_scrollListener);
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Kiddocare - Kindergartens'),
        actions: [
          IconButton(
            onPressed: ()=> _showFilterDialog(), 
            icon: const Icon(Icons.filter_list))
        ],
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
                onChanged: (val){
                  Provider.of<KindergartenProvider>(context, listen: false)
                    .searchKindergartens(val);
                },
                decoration: InputDecoration(
                  hintText: 'Search nearest kindergartens ...',
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
                        );
                      }
                    ),
                  
                  // loading indicator
                  if (provider.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GlobalLoading(),
                    ),
                ],
            ),
          ],
        ),
      ),
    );
  }

  // scroll listener
  // fetch the next page of kindergartens when the user scrolls to the bottom of screens
  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final provider = Provider.of<KindergartenProvider>(context, listen: false);
      provider.fetchKindergartens(
        currentPage: provider.currentPage,
        perPage: provider.perPage,
      );
    }
  }

  // show the filter dialog
  // user can filter the data by page number and number of data per page
  void _showFilterDialog() {
    final provider = Provider.of<KindergartenProvider>(context, listen: false);
    TextEditingController pageController = TextEditingController(text: provider.currentPage.toString());
    TextEditingController perPageController = TextEditingController(text: provider.perPage.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const Text('Filter by', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            
            // page number
            TextField(
              controller: pageController,
              keyboardType: TextInputType.numberWithOptions(decimal: false, signed: true),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Page Number',
                border: OutlineInputBorder(),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // items per page
            TextField(
              controller: perPageController,
              keyboardType: TextInputType.numberWithOptions(decimal: false, signed: true),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Items per page',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // button to apply the filter function
            ElevatedButton(
              onPressed: () {
                // clear the list of kindergartens so that the new data will be fetched
                provider.kindergartens.clear();
                provider.currentPage = int.parse(pageController.text);
                provider.perPage = int.parse(perPageController.text);
                provider.fetchKindergartens(
                  currentPage: provider.currentPage,
                  perPage: provider.perPage,
                );
                Navigator.pop(context);
              },
              child: const Text('Apply Filter'),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
} 