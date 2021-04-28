import 'package:flutter/material.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItemWidget extends StatefulWidget {
  final OrderItem order;

  OrderItemWidget(this.order);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy / hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.products.length * 20.0 + 100.0, 180.0),
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (ctx, i) => OrderTileBuilder(widget.order, i),
              ),
            ),
        ],
      ),
    );
  }
}

class OrderTileBuilder extends StatelessWidget {
  OrderItem orderItem;
  int index;

  OrderTileBuilder(this.orderItem, this.index);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(orderItem.products[index].title),
              Text('\$${orderItem.products[index].price}'),
            ],
          ),
          Text('x${orderItem.products[index].quantity}'),
          Text(' = '),
          Text(
              '\$${orderItem.products[index].price * orderItem.products[index].quantity}'),
        ],
      ),
      SizedBox(height: 10),
    ]);
  }
}
