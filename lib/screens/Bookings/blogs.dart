import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/route_management/route_path.dart';
import 'package:my_global_tools/screens/BottomNav/dash_setting_page.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:share_plus/share_plus.dart';
import '../../utils/picture_utils.dart';
import '../../utils/text.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({super.key, this.backAllowed = true});
  final bool backAllowed;

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.backAllowed ? AppBar(title: Text('Blogs')) : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingDefault),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Read Daily Blogs',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                        'NFTs (Non-Fungible Tokens) can potentially generate money for individuals through several different mechanisms:'),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Icon(Icons.clear),
                  Expanded(child: Divider()),
                ],
              ),
              height10(),
              ...List.generate(
                  7,
                  (index) => BlogItem(
                        imageUrl:
                            "https://www.nathorizon.com/public/images/blogs/NFT Token Development Company in Mohali (2).jpg",
                        title: "How Does An NFT Make Money?",
                        link:
                            "https://www.nathorizon.com/blogs/how-does-an-nft-make-money",
                        content:
                            "It's important to note that while there are potential opportunities for making money with NFTs, the market can be highly speculative and volatile.",
                        author: "Admin",
                        date: "Aug 10, 2023",
                        last: index == 6,
                      )),
              // Add other BlogItem widgets for different articles
            ],
          ),
        ),
      ),
    );
  }
}

class BlogItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String link;
  final String content;
  final String author;
  final String date;
  final bool last;

  BlogItem({
    required this.imageUrl,
    required this.title,
    required this.link,
    required this.content,
    required this.author,
    required this.date,
    required this.last,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add navigation logic here
        context.pushNamed(RoutePath.blogDetails);
      },
      child: Container(
        margin: EdgeInsets.all(paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: getHeight > mobHeight ? 250 : 150,
                width: getWidth > mobWidth ? 600 : double.maxFinite,
                child: buildCachedNetworkImage(imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(content),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const Icon(Icons.person, size: 16),
                const SizedBox(width: 5.0),
                Text("By $author"),
              ],
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                const Icon(Icons.date_range, size: 16),
                const SizedBox(width: 5.0),
                Text(date),
              ],
            ),
            height10(),
            if (!last) const Divider(),
          ],
        ),
      ),
    );
  }
}

class BlogDetailsPage extends StatelessWidget {
  const BlogDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulating the data of a blog article
    const String imageUrl =
        "https://www.nathorizon.com/public/images/blogs/NFT Token Development Company in Mohali (2).jpg";
    const String title = "How Does An NFT Make Money?";
    const String content =
        r'''NFTs (Non-Fungible Tokens) can potentially generate money for individuals through several different mechanisms:

    1. Primary Sales: The most direct way for creators to make money with NFTs is through the initial sale of their NFTs. Artists, musicians, writers, and other creators tokenize their digital or physical creations as NFTs and sell them to collectors or fans on NFT marketplaces. The price of an NFT is determined by factors such as the creator's reputation, the perceived value of the artwork or item, and market demand.

    2. Secondary Sales: NFT creators can also earn money when their NFTs are resold in secondary markets. Some NFT marketplaces include a mechanism for creators to earn a percentage of the resale price each time their NFT changes hands. This is often implemented through a smart contract that automatically distributes royalties to the creator.

    3. Licensing and Royalties: Creators can embed royalty mechanisms into the smart contracts of their NFTs. This means that every time the NFT is sold or traded, a portion of the transaction value goes back to the creator. This ongoing income stream can continue for as long as the NFT is bought and sold in the market.

    4. Exclusive Content and Access: Some creators offer exclusive content, experiences, or access to events for those who own specific NFTs. This can be a way to incentivize purchases and offer additional value to NFT holders.

    5. Collaborations and Partnerships: NFT creators might collaborate with other artists, brands, or influencers to create joint NFT projects. These collaborations can lead to shared revenue from NFT sales.

    6. Virtual Real Estate Development: In virtual worlds and metaverse platforms, individuals who own NFTs representing virtual land or spaces can develop and monetize those spaces. They can build structures, host events, or sell or rent the spaces to other users.

    7. Participation in DAOs: Some NFTs are linked to decentralized autonomous organizations (DAOs) or other governance systems. Holding specific NFTs might grant individuals voting rights or other privileges within these systems.

    8. Speculative Investment: Some people buy NFTs as investments, hoping that the value of these tokens will increase over time. They might buy NFTs from artists they believe will become more famous in the future or based on trends they anticipate will gain popularity.

    It's important to note that while there are potential opportunities for making money with NFTs, the market can be highly speculative and volatile. Not all NFTs will appreciate in value, and there's a risk of loss just like any other investment. Additionally, the NFT space is still relatively new and evolving, so individuals should conduct thorough research and consider the potential risks before making any financial decisions involving NFTs.''';
    const String author = "Admin";
    const String date = "Aug 10, 2023";

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: (getWidth > 500 ? 180 : 150) + kToolbarHeight,
                actions: [
                  const ToggleBrightnessButton(),
                  IconButton.filledTonal(
                      onPressed: () {},
                      icon: const Icon(Icons.bookmark_add_outlined)),
                  IconButton.filledTonal(
                      onPressed: () {
                        Share.share(
                            'https://www.nathorizon.com/blogs/how-does-an-nft-make-money');
                      },
                      icon: const Icon(Icons.share)),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: buildCachedNetworkImage(imageUrl,
                      opacity: 1, fit: BoxFit.cover),
                ),
              ),
              buildBody(context, imageUrl, title, content, author, date)
            ],
          ),
          /* Positioned(
              top: kTextTabBarHeight,
              left: paddingDefault,
              right: paddingDefault,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton.filledTonal(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                  Row(
                    children: [
                      const ToggleBrightnessButton(),
                      IconButton.filledTonal(
                          onPressed: () {},
                          icon: const Icon(Icons.bookmark_add_outlined)),
                      IconButton.filledTonal(
                          onPressed: () {}, icon: const Icon(Icons.share)),
                    ],
                  ),
                ],
              )),*/
        ],
      ),
    );
  }

  SliverToBoxAdapter buildBody(BuildContext context, String imageUrl,
      String title, String content, String author, String date) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),*/
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  content,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    const Icon(Icons.person, size: 16),
                    const SizedBox(width: 5.0),
                    Text("By $author"),
                  ],
                ),
                const SizedBox(height: 5.0),
                Row(
                  children: [
                    const Icon(Icons.date_range, size: 16),
                    const SizedBox(width: 5.0),
                    Text(date),
                  ],
                ),
              ],
            ),
          ),
          height20(),
          SizedBox(
            height: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingDefault),
                  child: titleLargeText('Related Blogs', context),
                ),
                height10(),
                Expanded(
                    child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(paddingDefault),
                  children: [
                    ...List.generate(
                      5,
                      (index) => Card(
                        elevation: 8,
                        margin: EdgeInsets.only(
                            right: paddingDefault, bottom: paddingDefault),
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.all(paddingDefault / 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: buildCachedNetworkImage(
                                    'https://www.nathorizon.com/public/images/blogs/NFT%20Token%20Development%20Company%20in%20Mohali%20(1).jpg',
                                    borderRadius: 10,
                                    pw: double.maxFinite,
                                    ph: 75),
                              ),
                              height5(),
                              bodyMedText('This is considered', context,
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                              capText('New NFT', context,
                                  color: getTheme.colorScheme.primary,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
          height50(),
        ],
      ),
    );
  }
}
