// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive_tdo/core/utils/colors.dart';
import 'package:flutter_hive_tdo/core/utils/constanst.dart';
import 'package:flutter_hive_tdo/core/utils/strings.dart';
import 'package:flutter_hive_tdo/data/models/task.dart';
import 'package:flutter_hive_tdo/main.dart';
import 'package:flutter_hive_tdo/presentation/screens/home/widgets/task_widget.dart';
import 'package:flutter_hive_tdo/presentation/screens/tasks/task_view.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
// import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // GlobalKey<SliderDrawerState> dKey = GlobalKey<SliderDrawerState>();

  /// Checking Done Tasks
  int checkDoneTask(List<Task> task) {
    int i = 0;
    for (Task doneTasks in task) {
      if (doneTasks.isCompleted) {
        i++;
      }
    }
    return i;
  }

  /// Checking The Value Of the Circle Indicator
  dynamic valueOfTheIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    var textTheme = Theme.of(context).textTheme;

    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTask(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();

          /// Sort Task List
          tasks.sort(((a, b) => a.createdAtDate.compareTo(b.createdAtDate)));

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: MyAppBar(),

            /// Floating Action Button
            floatingActionButton: const FAB(),

            /// Body
            body: _buildBody(
              tasks,
              base,
              textTheme,
            ),
          );
        });
  }

  /// Main Body
  Column _buildBody(
    List<Task> tasks,
    BaseWidget base,
    TextTheme textTheme,
  ) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 20, right: 15, left: 15),
          // height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// CircularProgressIndicator
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Transform.scale(
                  scale: 0.8,
                  child: CircularProgressIndicator(
                    valueColor:
                        const AlwaysStoppedAnimation(MyColors.primaryColor),
                    backgroundColor: Colors.grey,
                    value: checkDoneTask(tasks) / valueOfTheIndicator(tasks),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              /// Texts
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    MyString.mainTitle,
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w800,
                        color: MyColors.primaryColor),
                  ),
                  const SizedBox(height: 3),
                  Text("${checkDoneTask(tasks)} of ${tasks.length} task",
                      style: textTheme.subtitle1),
                ],
              )
            ],
          ),
        ),

        /// Divider
        const Divider(
          thickness: 2,
          indent: 40,
          endIndent: 40,
        ),

        /// Bottom ListView : Tasks
        Expanded(
          // width: double.infinity,
          // height: 585,
          child: tasks.isNotEmpty
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: tasks.length,
                  padding: const EdgeInsets.only(top: 8.0),
                  itemBuilder: (BuildContext context, int index) {
                    var task = tasks[index];

                    return Dismissible(
                      direction: DismissDirection.horizontal,
                      background: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.delete_outline,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(MyString.deletedTask,
                              style: TextStyle(
                                color: Colors.grey,
                              ))
                        ],
                      ),
                      onDismissed: (direction) {
                        base.dataStore.deleteTask(task: task);
                      },
                      key: Key(task.id),
                      child: TaskWidget(
                        task: tasks[index],
                      ),
                    );
                  },
                )

              /// if All Tasks Done Show this Widgets
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Lottie
                    FadeIn(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Lottie.asset(
                          lottieURL,
                          animate: tasks.isNotEmpty ? false : true,
                        ),
                      ),
                    ),

                    /// Bottom Texts
                    FadeInUp(
                      from: 30,
                      child: const Text(MyString.doneAllTask),
                    ),
                  ],
                ),
        )
      ],
    );
  }
}

/// My App Bar
class MyAppBar extends StatefulWidget with PreferredSizeWidget {
  MyAppBar({
    Key? key,
    // required this.drawerKey,
  }) : super(key: key);
  // GlobalKey<SliderDrawerState> drawerKey;

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

class _MyAppBarState extends State<MyAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// toggle for drawer and icon aniamtion
  void toggle() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        controller.forward();
        // widget.drawerKey.currentState!.openSlider();
      } else {
        controller.reverse();
        // widget.drawerKey.currentState!.closeSlider();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var base = BaseWidget.of(context).dataStore.box;
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Animated Icon - Menu & Close
            IconButton(
              padding: const EdgeInsets.all(0),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: controller,
                size: 21,
              ),
              onPressed: toggle,
            ),

            /// Delete Icon
            IconButton(
              onPressed: () {
                base.isEmpty ? warningNoTask(context) : deleteAllTask(context);
              },
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                CupertinoIcons.trash,
                size: 21,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Floating Action Button
class FAB extends StatelessWidget {
  const FAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => TaskView(
              taskControllerForSubtitle: null,
              taskControllerForTitle: null,
              task: null,
            ),
          ),
        );
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: MyColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
              child: Icon(
            Icons.add,
            color: Colors.white,
          )),
        ),
      ),
    );
  }
}
