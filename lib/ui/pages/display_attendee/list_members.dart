import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rcf_attendance_generator/ui/widgets/input/general_input.dart';
import '../../layouts/base_scaffold.dart';
import '../../layouts/scrollable_base_scaffold_body.dart';
import 'view_model/list_member_controller.dart';

class ListUsersPage extends StatefulWidget {
  const ListUsersPage({Key? key}) : super(key: key);

  @override
  _GenerateQRPageState createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<ListUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DispController>(builder: (context, model, _) {
      return BaseScaffold(
        body: ScrollableBaseScaffoldBody(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Column(
              children: [
                GeneralInput(
                  appContext: context,
                  controller: model.searchController,
                  hintText: 'fsgaTRA2023',
                  label: "Search",
                  // onChanged: (val){
                  //   model.searchForCard(val!);
                  // },
                ),
                model.filteredCards.isNotEmpty ||
                        model.searchController.text.isNotEmpty
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: model.filteredCards.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              model.users[index].firstname!,
                            ),
                            subtitle: Text(
                              model.users[index].attending!.toString(),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        // gridDelegate:
                        // const SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 2,
                        //   crossAxisSpacing: 5,
                        //   mainAxisSpacing: 5,
                        // ),
                        itemCount: model.users.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              model.users[index].firstname!,
                            ),
                            subtitle: Text(
                              model.users[index].attending!.toString(),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
