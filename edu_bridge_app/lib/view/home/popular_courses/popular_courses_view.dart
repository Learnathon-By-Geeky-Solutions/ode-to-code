import 'package:edu_bridge_app/resources/export.dart';

class PopularCoursesView extends StatefulWidget {
  const PopularCoursesView({super.key});

  @override
  State<PopularCoursesView> createState() => _PopularCoursesViewState();
}

class _PopularCoursesViewState extends State<PopularCoursesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const CustomText(
          text: "Popular Courses",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return popularCoursesCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget popularCoursesCard() {
    return Card(
      color: AppColors.white,
      elevation: 4,
      child: Container(
        width: 360,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                color: Colors.black,
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: "Graphic Design",
                            color: AppColors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.bookmark_add,
                          color: Colors.green,
                        )
                      ],
                    ),
                    CustomText(
                      text: "Graphic Design Advanced",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: "Price : 850/-",
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.themeColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
