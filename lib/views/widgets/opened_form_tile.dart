import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';
import '../../models/opened_form.dart';
import '../../views/pages.dart';
import 'tooltip.dart';

class OpenedFormTile extends StatefulWidget {
  final int index;
  final SmartShedOpenedForm openedForm;

  const OpenedFormTile({
    Key? key,
    required this.index,
    required this.openedForm,
  }) : super(key: key);

  @override
  State<OpenedFormTile> createState() => _OpenedFormTileState();
}

class _OpenedFormTileState extends State<OpenedFormTile> {
  bool isHovered = false;
  bool showInfo = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isHovered ? ColorConstants.hover : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: ColorConstants.shadow,
              offset: Offset(0, 1),
              blurRadius: 3,
            ),
          ],
          border: isHovered
              ? Border.all(
                  color: ColorConstants.primary,
                  width: 2,
                )
              : Border.all(
                  color: Colors.transparent,
                  width: 2,
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIndexBox(),
            const SizedBox(width: 16),
            _buildInfoColumn(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
      onTap: () => _onTap(context),
      onDoubleTap: () => _onTap(context),
      onLongPress: () => _onTap(context),
      onHover: (value) {
        setState(() {
          isHovered = value;
        });
      },
    );
  }

  Widget _buildIndexBox() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: ColorConstants.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          '${widget.index + 1}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildName(),
          const SizedBox(height: 4),
          _buildLocoDetails(),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              setState(() {
                showInfo = !showInfo;
              });
            },
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 12,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: const Size(0, 0),
              backgroundColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  showInfo ? "Hide Details" : "Show Details",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(
                  showInfo
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey.shade700,
                  size: 12,
                ),
              ],
            ),
          ),
          if (showInfo) _buildInfo(),
        ],
      ),
    );
  }

  Widget _buildName() {
    return MyTooltip(
      text: widget.openedForm.title,
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildLocoDetails() {
    return MyTooltip(
      text: '${widget.openedForm.locoName} (${widget.openedForm.locoNumber})',
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        MyTooltip(
          texts: [
            widget.openedForm.descriptionEnglish,
            widget.openedForm.descriptionHindi,
          ],
          textStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        MyTooltip(
          text: "Created At: ${widget.openedForm.createdAtString}",
          textStyle: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 2),
        MyTooltip(
          text: "Updated At: ${widget.openedForm.updatedAtString}",
          textStyle: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 2),
        MyTooltip(
          text: "Created By: ${widget.openedForm.createdBy}",
          textStyle: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  void _onTap(BuildContext context) {
    GoRouter.of(context).push(
      "${Pages.form}/${widget.openedForm.id}",
      extra: widget.openedForm,
    );
  }
}

class OpenedFormTileShimmer extends StatelessWidget {
  const OpenedFormTileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: ColorConstants.shadow,
              offset: Offset(0, 1),
              blurRadius: 3,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: ColorConstants.primary,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
