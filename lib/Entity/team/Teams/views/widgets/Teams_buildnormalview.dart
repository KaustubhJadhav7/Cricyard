import 'package:cricyard/Utils/size_utils.dart';
import 'package:cricyard/theme/app_decoration.dart';
import 'package:cricyard/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/Teams_viewmodel.dart';
import '../../model/Teams_model.dart';

Widget buildNormalView(BuildContext context, TeamsModel entity) {
  final provider = Provider.of<TeamsProvider>(context, listen: false);
  return SizedBox(
    width: double.maxFinite,
    child: Container(
      padding: getPadding(left: 16, top: 5, right: 5, bottom: 17),
      decoration: AppDecoration.outlineGray70011.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
        color: Colors.grey[100],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: getPadding(),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  margin: getMargin(left: 8, top: 3, bottom: 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entity.id.toString(),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtGreenSemiBold16,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.black, size: 16),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(value: 'edit', child: _menuItem('Edit', Icons.edit)),
                    PopupMenuItem(value: 'delete', child: _menuItem('Delete', Icons.delete)),
                  ],
                  onSelected: (value) {
                    if (value == 'edit') {
                      Navigator.pushNamed(context, '/edit', arguments: entity)
                          .then((_) => provider.fetchEntities());
                    } else if (value == 'delete') {
                      _showDeleteDialog(context, entity, provider);
                    }
                  },
                ),
              ],
            ),
          ),
          _infoRow('Team Name:', entity.teamName ?? 'No Team Name Available'),
          _infoRow('Description:', entity.description ?? 'No Description Available'),
          _infoRow('Members:', entity.members.toString() ?? 'No Members Available'),
          _infoRow('Matches:', entity.matches.toString() ?? 'No Matches Available'),
          _infoRow('Active:', entity.active.toString() ?? 'No Active Available'),
        ],
      ),
    ),
  );
}

Widget _infoRow(String title, String value) {
  return Padding(
    padding: getPadding(top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppStyle.txtGilroyMedium16),
        Text(value, style: AppStyle.txtGilroyMedium16Bluegray900),
      ],
    ),
  );
}

Widget _menuItem(String title, IconData icon) {
  return Row(
    children: [
      Icon(icon, size: 16),
      const SizedBox(width: 8),
      Text(title, style: AppStyle.txtGilroySemiBold16),
    ],
  );
}

void _showDeleteDialog(
    BuildContext context, TeamsModel entity, TeamsProvider provider) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text('Are you sure you want to delete?'),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Delete'),
          onPressed: () {
            Navigator.of(context).pop();
            provider.deleteEntity(entity).then((_) => provider.fetchEntities());
          },
        ),
      ],
    ),
  );
}
