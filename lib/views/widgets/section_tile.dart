import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/section.dart';
import '../../constants/colors.dart';
import '../../views/pages.dart';
import './tooltip.dart';

class SectionTile extends StatelessWidget {
  final int index;
  final SmartShedSection section;

  const SectionTile({
    Key? key,
    required this.index,
    required this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
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
          '${index + 1}',
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
      text: section.name,
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  void _onTap(BuildContext context) {
    Navigator.of(context).pushNamed(Pages.section, arguments: section.toJson());
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
        margin: const EdgeInsets.symmetric(vertical: 6),
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