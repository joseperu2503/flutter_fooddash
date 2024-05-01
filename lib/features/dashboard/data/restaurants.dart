import 'package:delivery_app/features/dashboard/models/restaurant.dart';
import 'package:delivery_app/features/restaurant/models/dish_category.dart';

const String urlImages = 'https://files.joseperezgil.com/images/delivery';

final List<Restaurant> restaurantsRecommended = [
  Restaurant(
    id: 1,
    name: 'Papas Queen \'s',
    image: '$urlImages/restaurants/papas_queens/image.jpeg',
    logo: '$urlImages/restaurants/papas_queens/logo.png',
    distance: 1.5,
    time: 27,
    sheeping: 4.49,
    record: 4.4,
    recordPeople: 59,
    tags: ['BURGER', 'CHICKEN', 'FAST FOOD'],
    address: 'Av. Gral. Antonio Alvarez de Arenales 2018, Lince, Perú',
    menu: [
      DishCategory(
        name: 'Burgers',
        dishes: [
          Dish(
            name: 'Classic burger',
            price: 19.90,
            description:
                'Hamburguesa de carne en pan artesanal y de lechuga, rodajas de tomate con jugosa salsa de la casa, junto a las cremas de tu elección.',
            image: '$urlImages/restaurants/papas_queens/dishes/dish1.png',
          ),
          Dish(
            name: 'Cheese burger',
            price: 21.90,
            description:
                'Hamburguesa de carne, pan artesanal, queso edam, fresca lechuga, rodajas de tomate, jugosa salsa de la casa y cremas a elección.',
            image: '$urlImages/restaurants/papas_queens/dishes/dish2.png',
          ),
          Dish(
            name: 'A lo pobre',
            price: 22.90,
            description:
                'Hamburguesa de carne, pan artesanal, dulce plátano, huevo frito, lechuga, rodajas de tomate y jugosa salsa de la casa, junto a cremas a elección.',
            image: '$urlImages/restaurants/papas_queens/dishes/dish3.png',
          ),
          Dish(
            name: 'Royal burger',
            price: 19.90,
            description:
                'Extra hamburguesa artesanal, doble queso cheddar, doble tocino, lechuga, rodajas de tomate, salsa de la casa, pan artesanal junto a cremas a elección.',
            image: '$urlImages/restaurants/papas_queens/dishes/dish4.png',
          ),
          Dish(
            name: 'Bacon burger',
            price: 23.90,
            description:
                'Hamburguesa de carne, tiras de tocino, queso edam, lechuga, rodajas de tomate, salsa de la casa, pan artesanal y cremas a elección.',
            image: '$urlImages/restaurants/papas_queens/dishes/dish5.png',
          ),
          Dish(
            name: 'John´s burger',
            price: 23.90,
            description:
                'Jugosa carne de la casa, esponjoso pan de la casa, plátano crispy, huevo frito, lechuga, tomate, cremas y bebida a tu elección.',
            image: '$urlImages/restaurants/papas_queens/dishes/dish6.png',
          ),
        ],
      ),
      DishCategory(
        name: 'Box',
        dishes: [
          Dish(
            name: 'Box Peruano',
            price: 29.90,
            description:
                'Chancho a la caja china acompañada de papas artesanales y cremas a tu elección.',
            image: '$urlImages/restaurants/papas_queens/dishes/dish7.png',
          ),
          Dish(
            name: 'Box Parrillero a lo Pobre',
            price: 31.90,
            description:
                'Chorizo parrillero suizo, jugosa hamburguesa de la casa, trozos de pollo parrillero, papas artesanales, huevo frito, plátano frito y salsa bbq.',
            image: '$urlImages/restaurants/papas_queens/dishes/dish8.png',
          ),
          Dish(
            name: 'Box Alitas',
            price: 29.90,
            description:
                '5 Alitas bañadas en salsa que más te guste acompañados de papas artesanales y cremas a tu elección.',
            image: '$urlImages/restaurants/papas_queens/dishes/dish9.png',
          ),
          Dish(
            name: 'Box Parrillero',
            price: 29.90,
            description:
                'Jugoso chorizo parrillero suizo, hamburguesa de la casa, trozos de pollos parrilleros, papas artesanales, cremas a elección, salsa bbq.',
            image: '$urlImages/restaurants/papas_queens/dishes/dish10.png',
          ),
          Dish(
            name: 'Box Anticuchero',
            price: 26.90,
            description:
                'Anticuchos + papas fritas artesanales + cremas a elección.',
            image: '$urlImages/restaurants/papas_queens/dishes/dish11.png',
          ),
          Dish(
            name: 'Box Anticuchero Mixto',
            price: 27.90,
            description:
                'HAnticuchos + mollejitas + papas fritas artesanales + cremas a elección.',
            image: '$urlImages/restaurants/papas_queens/dishes/dish11.png',
          ),
        ],
      ),
    ],
  ),
  Restaurant(
    id: 2,
    name: 'Ragazzi Pizza Artesanal',
    image: '$urlImages/restaurants/ragazzi/image.jpg',
    logo: '$urlImages/restaurants/ragazzi/logo.png',
    distance: 1.3,
    time: 20,
    record: 4.5,
    recordPeople: 627,
    tags: [],
    sheeping: 2.90,
    menu: [],
    address: 'Portocarrero 344, Surquillo',
  ),
  Restaurant(
    id: 3,
    name: "McDonald's",
    image: '$urlImages/restaurants/mc_donalds/image.jpg',
    logo: '$urlImages/restaurants/mc_donalds/logo.png',
    distance: 1.5,
    time: 20,
    record: 4.7,
    recordPeople: 59,
    tags: [],
    sheeping: 1.90,
    menu: [],
    address: "Av. Angamos 1803 LC 34 -Open Plaza Surquillo",
  ),
];

final List<Restaurant> restaurantsTop = [
  Restaurant(
    id: 100,
    name: 'Mad Burger',
    image: '$urlImages/restaurants/mad_burger/image.png',
    logo: '$urlImages/restaurants/mad_burger/logo.png',
    distance: 4.1,
    time: 35,
    sheeping: 4.49,
    record: 4.6,
    recordPeople: 3128,
    tags: ['BURGER', 'CHICKEN', 'FAST FOOD'],
    address: 'Avenida Aviación 4890, Surco',
    menu: [],
  ),
  Restaurant(
    id: 102,
    name: 'Groovy Greens',
    image: '$urlImages/restaurants/groovy_greens/image.png',
    logo: '$urlImages/restaurants/groovy_greens/logo.png',
    distance: 2.5,
    time: 53,
    record: 4.7,
    recordPeople: 316,
    tags: [],
    sheeping: 3.49,
    menu: [],
    address: 'Jirón Domingo Casanova 531, Lince, Peru',
  ),
];
