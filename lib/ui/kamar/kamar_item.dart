import 'package:flutter/material.dart';
import 'package:hotel_ayo/helpers/format.dart';
import 'package:hotel_ayo/model/kamar.dart';
import 'package:hotel_ayo/ui/kamar/kamar_detail.dart';

class KamarItem extends StatelessWidget {
  final Kamar kamar;
  const KamarItem({super.key, required this.kamar});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        height: 400,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KamarDetail(kamar: kamar),
              ),
            );
          },
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image(
                      width: double.maxFinite,
                      image: NetworkImage(kamar.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          kamar.namaKamar,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          kamar.deskripsi,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          MyFormatter().toRupiah(kamar.harga),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
