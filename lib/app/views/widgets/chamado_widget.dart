import 'package:flutter/material.dart';
import 'package:flutter_techhelp_app/app/utils/app_colors.dart';
import 'package:flutter_techhelp_app/app/views/widgets/edit_chamado_widget.dart';

class ChamadoWidget extends StatelessWidget {
  final Map chamado;
  const ChamadoWidget({super.key, required this.chamado});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${chamado["titulo"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Status: ${chamado["status"]}",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      chamado["descricao"],
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.clip,
                      maxLines: 3,
                      softWrap: true,
                    ),
                  ],
                ),
              ),

              VerticalDivider(),

              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Prioridade:${chamado["prioridade"]}",
                      style: TextStyle(fontSize: 10),
                    ),
                    LinearProgressIndicator(
                      value: _getPriority(chamado["prioridade"]),
                      minHeight: 4,
                      color: _getColorPriority(chamado["prioridade"]),
                      borderRadius: BorderRadius.circular(3),
                    ),

                    SizedBox(height: 8),

                    IconButton(
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => EditChamadoWidget(),
                      ),
                      icon: Icon(Icons.edit, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

double _getPriority(String priority) {
  switch (priority) {
    case 'Baixa':
      return 1 / 4;

    case 'Media':
      return 2 / 4;

    case 'Alta':
      return 3 / 4;

    case 'Critica':
      return 4 / 4;

    default:
      return 0;
  }
}

Color _getColorPriority(String priority) {
  switch (_getPriority(priority)) {
    case 0.25:
      return AppColors.success;

    case 0.5:
      return AppColors.secondary;

    case 0.75:
      return AppColors.warning;

    case 1:
      return AppColors.error;

    default:
      return AppColors.success;
  }
}
