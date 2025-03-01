import 'package:edu_bridge_app/resources/export.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({
    super.key,
    required this.categoriesList,
  });

  final List<String> categoriesList;

  @override
  Widget build(BuildContext context) {
    if (categoriesList.isEmpty) {
      return const Center(
        child: Text(
          'No categories available',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 6.h,
        child: ListView.builder(
          itemCount: categoriesList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SvgPicture.asset(
                categoriesList[index],
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
