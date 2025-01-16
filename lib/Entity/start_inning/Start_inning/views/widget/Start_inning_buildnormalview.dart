import 'package:cricyard/Utils/size_utils.dart';
import 'package:cricyard/theme/app_decoration.dart';
import 'package:cricyard/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/Start_inning_viewmodel.dart';
import '../../model/Start_inning_model.dart';

Widget buildNormalView(BuildContext context, StartInningModel entity) {
  final provider = Provider.of<StartInningProvider>(context, listen: false);
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
        children: [
          Padding(
            padding: getPadding(),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  margin: getMargin(left: 8, top: 3, bottom: 1),
                  child: Text(
                    entity.id.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.txtGreenSemiBold16,
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, size: 16),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: _menuItem('Edit', Icons.edit),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: _menuItem('Delete', Icons.delete),
                    ),
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
          _infoRow('Select Match:', entity.selectMatch ?? 'Not Available'),
          _infoRow('Select Team:', entity.selectTeam ?? 'Not Available'),
          _infoRow('Select Player:', entity.selectPlayer ?? 'Not Available'),
          _infoRow('Datetime Field:', entity.datetimeField ?? 'Not Available'),
        ],
      ),
    ),
  );
}

Widget _infoRow(String label, String value) {
  return Padding(
    padding: getPadding(top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppStyle.txtGilroyMedium16),
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
    BuildContext context, StartInningModel entity, StartInningProvider provider) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text('Are you sure you want to delete this item?'),
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
