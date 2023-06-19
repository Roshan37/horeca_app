import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/category.dart';
import '../model/product.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final List<Category> categories = [
    Category(name: 'Пекарни и кондитерские', image: 'https://fastly.picsum.photos/id/147/600/600.jpg?hmac=R0gsup77v6-N6zAFFlEbFM3SC-yYdz4Vq2fJ424XIzU', products: [
      Product(name: 'Круассан', image: 'https://picsum.photos/200', description: 'Сочный круассан с творожной начинкой', price: 70, tags: ['Круассан', 'Творог']),
      Product(name: 'Эклер', image: 'https://picsum.photos/200', description: 'Французский эклер с шоколадной глазурью', price: 90, tags: ['Эклер', 'Шоколад']),
      Product(name: 'Маффин', image: 'https://picsum.photos/200', description: 'Шоколадный маффин с орехами', price: 60, tags: ['Маффин', 'Шоколад', 'Орехи']),
    ]),
    Category(name: 'Фастфуд', image: 'https://fastly.picsum.photos/id/247/600/600.jpg?hmac=pZcBkwRClP5oEJ8z23ub9EonmQ37jS212yQWJf_NtN4', products: [
      Product(name: 'Гамбургер', image: 'https://picsum.photos/200', description: 'Классический гамбургер с сочной котлетой', price: 120, tags: ['Гамбургер', 'Котлета']),
      Product(name: 'Чизбургер', image: 'https://picsum.photos/200', description: 'Гамбургер с сыром и соусом BBQ', price: 140, tags: ['Гамбургер', 'Сыр', 'BBQ']),
      Product(name: 'Картошка фри', image: 'https://picsum.photos/200', description: 'Картофель фри с соусом кетчуп', price: 80, tags: ['Картофель фри', 'Кетчуп']),
    ]),
    Category(name: 'Азиатская кухня', image: 'https://fastly.picsum.photos/id/466/600/600.jpg?hmac=lhgcM2nLIxjGEIMiaYtbtMrDD6E7cGupCjxc-nQ7jeQ', products: [
      Product(name: 'Рамен', image: 'https://picsum.photos/200', description: 'Традиционный японский рамен с морепродуктами', price: 250, tags: ['Рамен', 'Морепродукты']),
      Product(name: 'Суши', image: 'https://picsum.photos/200', description: 'Набор классических суши с лососем и огурцом', price: 390, tags: ['Суши', 'Лосось', 'Огурец']),
      Product(name: 'Пекинская утка', image: 'https://picsum.photos/200', description: 'Традиционная китайская утка с овощами и соусом хойсин', price: 550, tags: ['Утка', 'Овощи', 'Хойсин']),
    ]),
    Category(name: 'Супы', image: 'https://fastly.picsum.photos/id/684/600/600.jpg?hmac=f9f-Lrm0iVtn6FM_E20zSQSJr5rsXQSC4TFnENfrejM', products: [
      Product(name: 'Борщ', image: 'https://picsum.photos/200', description: 'Классический украинский борщ с мясом и свеклой', price: 120, tags: ['Борщ', 'Мясо', 'Свекла']),
      Product(name: 'Щи', image: 'https://picsum.photos/200', description: 'Русские щи с картофелем и капустой', price: 100, tags: ['Щи', 'Картофель', 'Капуста']),
      Product(name: 'Куриный суп', image: 'https://picsum.photos/200', description: 'Сытный куриный суп с лапшой и овощами', price: 150, tags: ['Суп', 'Курица', 'Лапша']),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              context.goNamed('category', pathParameters: {'id': index.toString()}, extra: categories[index]);
              // Navigator.pushNamed(context, CategoryScreen.routeName, arguments: categories[index]);
            },
            child: Card(
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(categories[index].image),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Center(
                  child: Text(categories[index].name,
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
          );
        },
      );
  }
}