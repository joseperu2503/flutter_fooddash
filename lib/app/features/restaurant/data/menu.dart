import 'package:fooddash/app/features/restaurant/models/dish_category.dart';

const String urlImages = 'https://files.joseperezgil.com/images/delivery';

final List<DishCategory> staticMenu = [
  DishCategory(
    name: 'Burgers',
    id: 1,
    dishes: [
      Dish(
        id: 1,
        stock: 15,
        name: 'Classic burger',
        price: 19.90,
        description:
            'Hamburguesa de carne en pan artesanal y de lechuga, rodajas de tomate con jugosa salsa de la casa, junto a las cremas de tu elección.',
        image: '$urlImages/restaurants/papas_queens/dishes/dish1.png',
      ),
      Dish(
        id: 1,
        stock: 15,
        name: 'Cheese burger',
        price: 21.90,
        description:
            'Hamburguesa de carne, pan artesanal, queso edam, fresca lechuga, rodajas de tomate, jugosa salsa de la casa y cremas a elección.',
        image: '$urlImages/restaurants/papas_queens/dishes/dish2.png',
      ),
      Dish(
        id: 1,
        stock: 15,
        name: 'A lo pobre',
        price: 22.90,
        description:
            'Hamburguesa de carne, pan artesanal, dulce plátano, huevo frito, lechuga, rodajas de tomate y jugosa salsa de la casa, junto a cremas a elección.',
        image: '$urlImages/restaurants/papas_queens/dishes/dish3.png',
      ),
      Dish(
        id: 1,
        stock: 15,
        name: 'Royal burger',
        price: 19.90,
        description:
            'Extra hamburguesa artesanal, doble queso cheddar, doble tocino, lechuga, rodajas de tomate, salsa de la casa, pan artesanal junto a cremas a elección.',
        image: '$urlImages/restaurants/papas_queens/dishes/dish4.png',
      ),
      Dish(
        id: 1,
        stock: 15,
        name: 'Bacon burger',
        price: 23.90,
        description:
            'Hamburguesa de carne, tiras de tocino, queso edam, lechuga, rodajas de tomate, salsa de la casa, pan artesanal y cremas a elección.',
        image: '$urlImages/restaurants/papas_queens/dishes/dish5.png',
      ),
      Dish(
        id: 1,
        stock: 15,
        name: 'John´s burger',
        price: 23.90,
        description:
            'Jugosa carne de la casa, esponjoso pan de la casa, plátano crispy, huevo frito, lechuga, tomate, cremas y bebida a tu elección.',
        image: '$urlImages/restaurants/papas_queens/dishes/dish6.png',
      ),
    ],
  ),
  DishCategory(
    id: 2,
    name: 'Box',
    dishes: [
      Dish(
        id: 1,
        stock: 15,
        name: 'Box Peruano',
        price: 29.90,
        description:
            'Chancho a la caja china acompañada de papas artesanales y cremas a tu elección.',
        image: '$urlImages/restaurants/papas_queens/dishes/dish7.png',
      ),
      Dish(
        id: 1,
        stock: 15,
        name: 'Box Parrillero a lo Pobre',
        price: 31.90,
        description:
            'Chorizo parrillero suizo, jugosa hamburguesa de la casa, trozos de pollo parrillero, papas artesanales, huevo frito, plátano frito y salsa bbq.',
        image: '$urlImages/restaurants/papas_queens/dishes/dish8.png',
      ),
      Dish(
        id: 1,
        stock: 15,
        name: 'Box Alitas',
        price: 29.90,
        description:
            '5 Alitas bañadas en salsa que más te guste acompañados de papas artesanales y cremas a tu elección.',
        image: '$urlImages/restaurants/papas_queens/dishes/dish9.png',
      ),
      Dish(
        id: 1,
        stock: 15,
        name: 'Box Parrillero',
        price: 29.90,
        description:
            'Jugoso chorizo parrillero suizo, hamburguesa de la casa, trozos de pollos parrilleros, papas artesanales, cremas a elección, salsa bbq.',
        image: '$urlImages/restaurants/papas_queens/dishes/dish10.png',
      ),
      Dish(
        id: 1,
        stock: 15,
        name: 'Box Anticuchero',
        price: 26.90,
        description:
            'Anticuchos + papas fritas artesanales + cremas a elección.',
        image: '$urlImages/restaurants/papas_queens/dishes/dish11.png',
      ),
      Dish(
        id: 1,
        stock: 15,
        name: 'Box Anticuchero Mixto',
        price: 27.90,
        description:
            'HAnticuchos + mollejitas + papas fritas artesanales + cremas a elección.',
        image: '$urlImages/restaurants/papas_queens/dishes/dish11.png',
      ),
    ],
  ),
];
