import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';
import '../../models/unopened_form.dart';
import '../../views/pages.dart';
import 'tooltip.dart';

class FormTile extends StatefulWidget {
  final int index;
  final SmartShedUnopenedForm form;
  final String onTapRoute;

  const FormTile({
    Key? key,
    required this.index,
    required this.form,
    this.onTapRoute = Pages.createForm,
  }) : super(key: key);

  @override
  State<FormTile> createState() => _FormTileState();
}

class _FormTileState extends State<FormTile> {
  bool isHovered = false;

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
          _buildName(context),
          const SizedBox(height: 4),
          _buildDescription(context),
        ],
      ),
    );
  }

  Widget _buildName(BuildContext context) {
    return MyTooltip(
      text: widget.form.title,
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      onDoubleTap: () => _onTap(context),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTooltip(
          texts: [
            widget.form.descriptionEnglish,
            widget.form.descriptionHindi,
          ],
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey[700],
          ),
          maxLines: 1,
          onDoubleTap: () => _onTap(context),
        ),
      ],
    );
  }

  void _onTap(BuildContext context) {
    switch (widget.onTapRoute) {
      case Pages.createForm:
        GoRouter.of(context).push(
          Pages.createForm,
          extra: widget.form,
        );
        break;
      case Pages.manageManageForm:
        GoRouter.of(context)
            .push("${Pages.manageManageForm}/${widget.form.id}");
        break;
      default:
        GoRouter.of(context).push(widget.onTapRoute);
    }
  }
}

class FormTileShimmer extends StatelessWidget {
  const FormTileShimmer({Key? key}) : super(key: key);

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
