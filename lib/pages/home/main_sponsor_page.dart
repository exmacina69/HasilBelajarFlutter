import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spontracker/pages/home/sponsor_page_body.dart';
import 'package:spontracker/utils/dimension.dart';
import 'package:spontracker/widgets/big_text.dart';
import 'package:spontracker/widgets/small_text.dart';

import '../../controllers/popular_sponsor_controller.dart';
import '../../controllers/recommended_sponsor_controller.dart';

class MainSponsorPage extends StatefulWidget {
  const MainSponsorPage({Key? key}) : super(key: key);

  @override
  State<MainSponsorPage> createState() => _MainSponsorPageState();
}

class _MainSponsorPageState extends State<MainSponsorPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  void _searchPressed() {
    setState(() {
      _searchText = _searchController.text;
    });

    Get.to(() => SearchPage(searchText: _searchText));
  }

  void mySearchFunction(String searchText) {
    print('Pencarian: $searchText');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                "assets/image/foto1.png"), // Ganti dengan URL gambar profil yang diinginkan
                            radius: 20,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                text: "Indonesia",
                                color: Color.fromARGB(255, 248, 107, 20),
                              ),
                              SmallText(
                                text: "Jakarta",
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      child: IconButton(
                        onPressed: _searchPressed,
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimensions.iconSize24,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: Color.fromARGB(255, 248, 107, 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SponsorPageBody(),
            ),
          ),
        ],
      ),
      onRefresh: _loadResource,
    );
  }
}

class SearchPage extends StatefulWidget {
  final String searchText;

  const SearchPage({Key? key, required this.searchText}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchText;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    String searchText = _searchController.text;
    // Panggil fungsi pencarian sesuai kebutuhan aplikasi Anda
    mySearchFunction(searchText);
  }

  void mySearchFunction(String searchText) {
    print('Pencarian: $searchText');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pencarian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Masukkan kata kunci',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _performSearch,
                ),
              ),
              onSubmitted: (value) => _performSearch(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _performSearch,
              child: Text('Cari'),
            ),
          ],
        ),
      ),
    );
  }
}
