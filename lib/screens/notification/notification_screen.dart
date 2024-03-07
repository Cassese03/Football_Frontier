import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/common/appbarnotify.dart';
import 'package:football_app/screens/notification/notification_bloc.dart';
import 'package:football_app/widgets/notify.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc(),
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NotificationInitial) {
            context.read<NotificationBloc>().add(NotificationInit());
          }
          if (state is NotificationReady) {
            return Scaffold(
              appBar: AppbarNotify(
                currentColor: state.currentColor,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Text(
                            "Notifiche",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(state.currentColor),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Notify(
                        currentColor: state.currentColor,
                        Logo: "assets/images/raimon_perde.jpg",
                        Title: "Dura Sconfitta",
                        Content:
                            "Dura sconfitta per la Raimon, IMMERITATA!!! Testa alla PROSSIMA!",
                        Read: 0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Notify(
                        currentColor: state.currentColor,
                        Logo: "assets/images/raimon.jpg",
                        Title: "Attilio Ma che Combini ?!",
                        Content:
                            "Attilio ha scopato una vecchia. Incredibile!!!",
                        Read: 0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Notify(
                        currentColor: state.currentColor,
                        Logo: "assets/images/raimon.jpg",
                        Title: "Capocannoniere Insolito",
                        Content:
                            "Per favore non fate segnare Agostino, mi sembra uno zoppo che corre.",
                        Read: 1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
