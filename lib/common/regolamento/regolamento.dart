import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/common/drawer/drawer_bloc.dart';
import 'package:football_app/widgets/loading.dart';

// ignore: must_be_immutable
class RegolamentoScreen extends StatelessWidget implements PreferredSizeWidget {
  RegolamentoScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawerBloc(),
      child: BlocConsumer<DrawerBloc, DrawerState>(
        builder: (context, state) {
          if (state is DrawerLoading) {
            return const Loading(
              duration: Duration(seconds: 1),
            );
          }
          return Scaffold(
            appBar: AppBar(),
            body: const SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    overflow: TextOverflow.clip,
                    '''Regolamento Football Frontier''',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      overflow: TextOverflow.clip,
                      '-Al torneo parteciperanno 8 squadre che si sfideranno in un girone unico'),
                  Text(
                      overflow: TextOverflow.clip,
                      '-Le prime 4 squadre si qualificheranno per le semifinali (1ª vs 4ª e 2ª vs 3ª). Successivamente si giocheranno la finale tra i vincenti e la finalina tra i perdenti della fase precedente'),
                  Text(
                      overflow: TextOverflow.clip,
                      '-Nella fase a girone non esistono pareggi. Finiti i tempi regolamentari (25 minuti a tempo), in caso di pareggio, si deciderà tutto ai calci di rigore '),
                  Text(
                      overflow: TextOverflow.clip,
                      '-La vittoria nei tempi regolamentari vale 3 punti e la sconfitta 0. Arrivati ai calci di rigore si assegneranno 2 punti ai vincitori e 1 punto ai perdenti'),
                  Text(
                      overflow: TextOverflow.clip,
                      '-Non esistono sostituzioni. I 7 giocatori che scendono in campo saranno gli stessi che finiranno la partita'),
                  Text(
                      overflow: TextOverflow.clip,
                      '-La quota di partecipazione sarà di 20€. Compresa nel prezzo dell\'iscrizione ci sarà anche la maglia ufficiale del torneo che obbligatoriamente deve essere messa ogni partita'),
                  Text(
                      overflow: TextOverflow.clip,
                      '-Non saranno tollerati in alcun modo eccessi di foga o insulti pena espulsione diretta (3 minuti fuori dal campo)'),
                  Text(
                      overflow: TextOverflow.clip,
                      '-In caso uno o più giocatori dei 7 che si sono iscritti inizialmente non possono partecipare ad una partita, deve essere comunicato il cambio al massimo 24 ore prima dell\'inizio del match'),
                  Text(
                      overflow: TextOverflow.clip,
                      '-Oltre ai trofei per 1°, 2° e 3° posto verranno assegnati al capocannoniere e all\'MVP del torneo due trofei personali '),
                  Text(
                      overflow: TextOverflow.clip,
                      '-Saranno riscossi 50€ da ogni squadra a inizio torneo per la cauzione. Nel caso non ci sia nessun problema nel corso del torneo verranno restituiti al termine'),
                  Text(
                      overflow: TextOverflow.clip,
                      '-Il calendario stilato può essere cambiato ma con grande preavviso'),
                  Text(
                      overflow: TextOverflow.clip,
                      '-Prima di ogni partita, il capitano raccoglie le quote (42€ a squadra) e le consegna agli organizzatori. Le quote comprenderanno il pagamento del campo e il pagamento dell\'arbitro'),
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, DrawerState state) {},
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  TextStyle textStyleListTile() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 18.0,
    );
  }
}
