import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';
import '../../models/section.dart';
import '../../views/pages.dart';
import 'tooltip.dart';

class SectionTile extends StatefulWidget {
  final int index;
  final SmartShedSection section;

  const SectionTile({
    Key? key,
    required this.index,
    required this.section,
  }) : super(key: key);

  @override
  State<SectionTile> createState() => _SectionTileState();
}

class _SectionTileState extends State<SectionTile> {
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
            )
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
            _buildLeftRow(),
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

  Widget _buildLeftRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildIndexBox(),
        const SizedBox(width: 16),
        _buildName(),
      ],
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

  Widget _buildName() {
    return MyTooltip(
      text: widget.section.title,
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  void _onTap(BuildContext context) {
    GoRouter.of(context).push(
      "${Pages.section}/${widget.section.title}",
    );
  }
}

class SectionTileShimmer extends StatelessWidget {
  const SectionTileShimmer({Key? key}) : super(key: key);

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
            _buildIndexBoxShimmer(),
            const SizedBox(width: 16),
            _buildNameShimmer(),
            const Spacer(),
            _buildIconShimmer(),
          ],
        ),
      ),
    );
  }

  Widget _buildIndexBoxShimmer() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: ColorConstants.primary,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildNameShimmer() {
    return Container(
      width: 100,
      height: 20,
      decoration: BoxDecoration(
        color: ColorConstants.primary,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildIconShimmer() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: ColorConstants.primary,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
