import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/collab_bloc/collab_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/collab_bloc/collab_event.dart';
import 'package:mirea_horizon/presentation/bloc/collab_bloc/collab_state.dart';
import 'package:mirea_horizon/presentation/features/widgets/custom_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Collaborators extends StatelessWidget {
  Future<void> _refreshData(BuildContext context) async {
    BlocProvider.of<CollabBloc>(context).add(RefreshCollab());
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      nameAppBar: 'Коллаборация',
      body: RefreshIndicator(
        onRefresh: () => _refreshData(context),
        child: BlocBuilder<CollabBloc, CollabState>(
          builder: (context, state) {
            if (state is CollabLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CollabError) {
              return ListView(
                children: [
                  Center(
                    child: Text('Error: ${state.message}'),
                  ),
                ],
              );
            } else if (state is CollabLoaded) {
              final directionResult = state.direct;
              if (directionResult.isEmpty) {
                return ListView(children: const [
                  Center(
                    child: Column(
                      children: [
                        Text('Направления недоступны.'),
                      ],
                    ),
                  ),
                ]);
              }
              return ListView.builder(
                itemCount: directionResult.length,
                itemBuilder: (context, index) {
                  final directResult = directionResult[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            directResult.imageUrl, // URL изображения
                            fit: BoxFit.fill,
                            height: 150, // Высота изображения
                            // width: double.infinity, // Ширина изображения
                            errorBuilder: (context, error, stackTrace) {
                              return const Text(
                                  'Ошибка загрузки изображения'); // Обработка ошибок загрузки изображения
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            directResult.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            directResult.description,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Направление: ${directResult.direction}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextButton(
                            onPressed: () async {
                              final url = directResult.url;
                              _launchInBrowser(Uri.parse(url));
                            },
                            child: const Text('Читать',
                                style: TextStyle(color: Colors.blue)),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
            // Добавляем возврат виджета для всех остальных случаев
            return Container();
          },
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
