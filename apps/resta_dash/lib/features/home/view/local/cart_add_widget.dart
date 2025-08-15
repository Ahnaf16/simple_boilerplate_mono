import 'package:flutter/material.dart';
import 'package:resta_dash/main.export.dart';

class CartAddWidget extends StatefulWidget {
  const CartAddWidget({
    super.key,
    this.onAdd,
    this.onRemove,
    this.onDelete,
    this.initialQuantity = 0,
    this.maxWidth = 100,
  });

  final Function(int qty)? onAdd;
  final Function(int qty)? onRemove;
  final Function()? onDelete;
  final int initialQuantity;
  final double maxWidth;

  @override
  State<CartAddWidget> createState() => _CartAddWidgetState();
}

class _CartAddWidgetState extends State<CartAddWidget> with SingleTickerProviderStateMixin {
  late int _quantity;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;

    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _widthAnimation = Tween<double>(
      begin: 30,
      end: widget.maxWidth,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (_quantity > 0) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleAdd() async {
    if (_controller.isAnimating) return;
    setState(() {
      if (_quantity == 0) {
        _quantity = 1;
        _controller.forward();
      } else {
        _quantity++;
      }
    });

    await widget.onAdd?.call(_quantity);
  }

  void _handleRemove() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      } else {
        _quantity = 0;
        _controller.reverse();
      }
    });
    widget.onRemove?.call(_quantity);
  }

  void _handleDelete() {
    setState(() {
      _quantity = 0;
      _controller.reverse();
    });
    widget.onDelete?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          height: 30,
          width: _widthAnimation.value,
          child: Container(
            padding: Pads.xs(),
            decoration: BoxDecoration(color: context.colors.primary, borderRadius: Corners.circleBorder),
            child: _quantity == 0 ? _buildAddButton() : _buildQuantityControls(),
          ),
        );
      },
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: _handleAdd,
      child: DecoContainer(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Icon(Icons.add_rounded, size: 20, color: context.colors.onPrimary),
      ),
    );
  }

  Widget _buildQuantityControls() {
    return Builder(
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: Insets.xs,
          children: [
            const Gap(0),
            Expanded(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: GestureDetector(
                  onTap: _quantity == 1 ? _handleDelete : _handleRemove,
                  child: DecoContainer(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Icon(
                      _quantity == 1 ? Icons.close_rounded : Icons.remove,
                      color: context.colors.onPrimary,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Text(
                  _quantity.compact(),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: context.text.labelMedium?.textColor(context.colors.onPrimary),
                ),
              ),
            ),
            Expanded(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: GestureDetector(
                  onTap: _handleAdd,
                  child: DecoContainer(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Icon(Icons.add, color: context.colors.onPrimary, size: 20),
                  ),
                ),
              ),
            ),
            const Gap(0),
          ],
        );
      },
    );
  }
}
