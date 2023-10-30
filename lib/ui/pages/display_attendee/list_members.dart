import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rcf_attendance_generator/ui/widgets/input/general_input.dart';
import 'package:rcf_attendance_generator/ui/widgets/loader.dart';
import 'package:rcf_attendance_generator/utils/app_response.dart';
import '../../../core/models/personal_data.dart';
import '../../layouts/base_scaffold.dart';
import '../../layouts/scrollable_base_scaffold_body.dart';
import 'view_model/list_member_controller.dart';

class ListUsersPage extends StatefulWidget {
  const ListUsersPage({Key? key}) : super(key: key);

  @override
  State<ListUsersPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<ListUsersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  _init() async {
      await context.read<DispController>().getUsers(false);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DispController>(builder: (context, model, _) {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: const SizedBox.shrink(),
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  physics: const NeverScrollableScrollPhysics(),
                  onTap: (index){
                    if(index == 0){
                      model .getUsers(false);
                    } else if(index == 1){
                      model .getUsers(true);
                    }else{
                      model .getUsers(null);
                    }
                  },
                  tabs: const [
                    Tab(text: "Pending"),
                    Tab(text: "Approved"),
                    Tab(text: "All"),
                  ],
                ),
              ],
            ),
          ),
          body:  model.loading == true?Center(child: buildLoaderWidget()): const ListUserCategory(),
        ),
      );
    },
    );
  }
}



class ListUserCategory extends StatelessWidget {
  const ListUserCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DispController>(builder: (context, model, _) {
      return ScrollableBaseScaffoldBody(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Column(
              children: [
                GeneralInput(
                  appContext: context,
                  controller: model.searchController,
                  hintText: 'fsgaTRA2023',
                  label: "Search",
                  onChanged: (val) {
                    model.searchForCard();
                  },
                ),
                model.filteredCards.isNotEmpty ||
                        model.searchController.text.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: model.filteredCards.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              model.users[index].firstname!,
                            ),
                            subtitle: Text(
                              model.users[index].uuid!.toString(),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: model.users.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.users[index].fullname??"Nil",
                                ),
                              ],
                            ),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AcceptUser(
                                  user: model.users[index],
                                  onTap: () {
                                    model.updateStatus(model.users[index].id!);
                                  },
                                ),
                              );
                            },
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.users[index].fellowshipName!.toString(),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        );
    },
    );
  }
}
class AcceptUser extends StatelessWidget {
  const AcceptUser({super.key, required this.user, required this.onTap});

  final PersonalDataForm user;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Verify User"),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width * .8,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  user.fullname??"Nil",
                  style:
                      const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Text(
                  user.email??"Nil",
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 5),
                Text(
                  user.uuid??"Nil",
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    _InfoCard(
                      tag: 'Gender',
                      value: user.gender.toString(),
                    ),
                    _InfoCard(
                      tag: 'Attending',
                      value: user.attending.toString(),
                    ),
                    _InfoCard(
                      tag: 'Zone',
                      value: user.zone.toString(),
                    ),
                    _InfoCard(
                      tag: 'Fellowship',
                      value: user.fellowshipName.toString(),
                    ),
                    _InfoCard(
                      tag: 'Phone Number',
                      value: user.phoneNumber.toString(),
                    ),
                    _InfoCard(
                      tag: 'Unit',
                      value: user.unit.toString(),
                    ),
                    _InfoCard(
                      tag: 'Portfolio',
                      value: user.portfolio.toString(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        MaterialButton(
          elevation: 0,
          onPressed: onTap,
          color: Colors.blue,
          textColor: Colors.white,
          child: const Text("Verify"),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({super.key, required this.value, required this.tag});

  final String value;
  final String tag;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "$tag:",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10)
                ],
              ),
              Flexible(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
