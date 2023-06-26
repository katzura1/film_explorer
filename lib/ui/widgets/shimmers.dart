import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class ShimmerLine extends StatelessWidget {
  const ShimmerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      width: MediaQuery.of(context).size.width * 0.9,
      color: grayColor,
    );
  }
}

class ShimmerParagraph extends StatelessWidget {
  const ShimmerParagraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerLine(),
        ShimmerLine(),
        ShimmerLine(),
        const SizedBox(
          height: 5,
        ),
        ShimmerLine(),
        ShimmerLine(),
        ShimmerLine(),
        const SizedBox(
          height: 5,
        ),
        ShimmerLine(),
        ShimmerLine(),
        ShimmerLine(),
        const SizedBox(
          height: 5,
        ),
        ShimmerLine(),
        ShimmerLine(),
        ShimmerLine(),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

class ShimmerSearchCardMovie extends StatelessWidget {
  const ShimmerSearchCardMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 24,
      ),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 95,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: grayColor),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLine(),
                ShimmerLine(),
                ShimmerLine(),
                const SizedBox(
                  height: 20,
                ),
                ShimmerLine(),
                ShimmerLine(),
                const SizedBox(
                  height: 5,
                ),
                ShimmerLine(),
                ShimmerLine(),
                const SizedBox(
                  height: 5,
                ),
                ShimmerLine(),
                ShimmerLine(),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
