import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/CustomButton.dart';
import 'package:carrent/Models/Package.dart';
import 'package:carrent/Shared/AppColors.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class PackageWidget extends StatelessWidget {
  const PackageWidget({super.key, required this.package});

  final Package package;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mode == ThemeMode.light
            ? AppColors.instance.textInvert
            : AppColors.instance.secondary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.solidStar,
              ),
              const Gap(10),
              Flexible(
                child: AppText(
                  package.name,
                  overflow: TextOverflow.ellipsis,
                  style: FontStyles.title.copyWith(
                    color: AppColors.instance.text,
                  ),
                ),
              ),
            ],
          ),
          const Gap(15),
          const Divider(),
          const Gap(15),
          AppText(
            'Yearly',
            style: FontStyles.p.copyWith(
              color: AppColors.instance.text,
            ),
          ),
          AppText(
            '\$${package.price.toStringAsFixed(2)}/Year',
            style: FontStyles.title.copyWith(
              color: AppColors.instance.text,
            ),
          ),
          if (package.freePeriod > 0) const Gap(5),
          if (package.freePeriod > 0)
            AppText(
              'Get ${package.freePeriod} Month${package.freePeriod > 1 ? "s" : ""} free',
              style: FontStyles.body.copyWith(
                color: AppColors.instance.text,
              ),
            ),
          const Gap(10),
          for (int i = 0; i < package.advantages.length; i++)
            Row(
              children: [
                Icon(
                  package.advantages[i].active
                      ? FontAwesomeIcons.check
                      : FontAwesomeIcons.xmark,
                ),
                const Gap(10),
                Flexible(
                  child: AppText(
                    package.advantages[i].description,
                    style: FontStyles.body.copyWith(
                      color: AppColors.instance.text,
                    ),
                  ),
                ),
              ],
            ),
          const Gap(20),
          CustomButton(
            text: 'Subscribe Now',
            onTap: () {},
            borderRadius: 20,
          )
        ],
      ),
    );
  }
}
