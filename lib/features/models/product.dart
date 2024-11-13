import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id;
  final String? uid;
  final String name;
  final String description;
  final double price;
  final String? image;
  final String category;
  final String? userName;
  int quantity;
  bool isFavorite;
  bool isbought;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    this.image,
    required this.category,
    this.userName,
    this.uid,
    this.isFavorite = false,
    this.isbought = false,
    this.quantity = 0,
  });

  Product copyWith({
    String? name,
    String? description,
    double? price,
    String? image,
    String? category,
    bool? isFavorite,
    bool? isbought,
    int? quantity,
    String? uid,
    String? userName,
  }) {
    return Product(
      id: id ?? id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
      isbought: isbought ?? this.isbought,
      quantity: quantity ?? this.quantity,
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
    );
  }

  //
  factory Product.fromFirestore(DocumentSnapshot doc) {
    return Product(
      id: doc.id,
      uid: doc['uid'],
      userName: doc['userName'],
      name: doc['name'],
      description: doc['description'],
      price: doc['price'],
      category: doc['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
    };
  }
}

final List<Product> products = [
  // Dormitorios
  Product(
    name: 'Ropero Siena 6 Puertas 2 Cajones',
    description:
        'El Ropero Siena se diseñó pensando en aquellos que no pueden prescindir de un buen espacio para tender la ropa. Clásico y con gran configuración interna, este armario destaca principalmente por su capacidad para almacenar prendas más largas. Tenemos 4 colores disponibles. El color blanco cuenta con la tecnología flex, es decir algunas de sus piezas son reversibles.',
    price: 349.90,
    image:
        'https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaPE/882947876_1/w=1500,h=1500,fit=pad',
    category: 'Dormitorio',
  ),
  Product(
    name: 'Ropero Reversible Padua 3 Puertas Corredizas 2 Cajones',
    description:
        'El Ropero Padua ofrece una atractiva configuración exterior e interior, es versátil y tiene capacidad para atender a niños, jóvenes y adultos. Cuenta con dos puertas correderas, sobre rieles metálicos que facilitan el acceso al interior del producto, al que se suma dos cajones de excelente profundidad con correderas de metal y estantes para acomodar varias pertenencias. Cuenta también con perchas de aluminio dispuestas a dos alturas diferentes y un portaequipajes que le agrega funcionalidad.',
    price: 699.00,
    image:
        'https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaPE/882947866_1/w=1500,h=1500,fit=pad',
    category: 'Dormitorio',
  ),
  Product(
    name: 'Ropero 6 Puertas 1 Cajon 1 Zapatera Blanco',
    description:
        'El armario RP3611 es la opción perfecta para quien busca un armario bonito, elegante, funcional y súper práctico. Producida en MDP, es espaciosa y tiene sus divisiones internas muy bien distribuidas, cuenta con 6 puertas batientes, 1 perchero y 1 zapatera. Todas las piezas del producto están numeradas para facilitar el montaje.',
    price: 329.00,
    image:
        'https://images.pexels.com/photos/2082090/pexels-photo-2082090.jpeg?auto=compress&cs=tinysrgb&w=600',
    category: 'Dormitorio',
  ),
  Product(
    name: 'Ropero Brescia 4 Puertas 2 Cajones',
    description:
        'El Ropero Brescia tiene un acabado estampado de alta calidad que garantiza mayor resistencia al mueble, además de un espejo central que le dará ese toque refinado a tu habitación. Cajones exteriores con perfecto deslizamiento y pies en PVC de serie. Se tiene la opción de elegir entre 3 colores.',
    price: 599.00,
    image:
        'https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaPE/882947901_1/w=1500,h=1500,fit=pad',
    category: 'Dormitorio',
  ),
  Product(
    name: 'Ropero Zapatera Rimini 2 Puertas',
    description:
        'La versatilidad es la característica principal del Ropero con Zapatera Rimini, la disposición de los estantes en el exterior y en el interior sugiere usabilidad, permitiendo acomodar objetos pequeños y grandes de forma organizada. Lo tenemos disponible en 2 colores.',
    price: 349.90,
    image:
        'https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaPE/882947911_1/w=1500,h=1500,fit=pad',
    category: 'Dormitorio',
  ),

  // Comedores
  Product(
    name: 'Juego de Comedor Jaíne con 6 Sillas',
    description:
        'El Juego de Comedor Jaíne de Madesa, proporciona mucha practicidad y belleza al ambiente. La mesa de madera con patas estructurales es más firme y segura y el tablero de madera transmite robustez y firmeza. Las sillas se fabrican en MDF/MDP, con respaldo de madera y asientos tapizados en material sintético que tiene un tacto suave y se adapta bien a cualquier tipo de decoración.',
    price: 929.00,
    image:
        'https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaPE/121041301_01/w=1500,h=1500,fit=pad',
    category: 'Comedor',
  ),
  Product(
    name: 'Juego de Comedor Lorena con 4 Sillas Marron/Imperial',
    description:
        'Para traer más comodidad, belleza y calidad a su cocina o comedor, la opción perfecta es el Juego de Comedor Madesa Lorena. La mesa cuenta con un pedestal de diseño moderno y tiene capacidad para hasta cuatro personas. La base de la mesa tiene encaje firme y cuenta con tablero de madera reforzada.',
    price: 1599.00,
    image:
        'https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaPE/129752661_03/w=1500,h=1500,fit=pad',
    category: 'Comedor',
  ),

  Product(
    name: 'Juego de Comedor Lousiana con 6 Sillas',
    description:
        'El Juego de Comedor Lousiana combina calidez y belleza. El acabado de amaderado rústico es versátil y combina con maderas claras u oscuras y prácticamente con todos los tonos. Su diseño exclusivo imita el tacto de la madera natural. La mesa con pedestal es más cómoda y el tablero rectangular de madera transmite robustez y firmeza. Además, permite una gran circulación en la habitación y acomoda muy bien a 6 personas.',
    price: 1399.00,
    image:
        'https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaPE/121034646_01/w=1500,h=1500,fit=pad',
    category: 'Comedor',
  ),
  Product(
    name: 'Juego de Comedor Alana con 4 Sillas',
    description:
        'Una cena puede convertirse en un momento más placentero cuando se realiza en un espacio acogedor, bello y confortable. El Juego de Comedor Alana de Madesa proporciona estos diferenciales para usted. La mesa con pedestal de madera es un diferencial por ser más confortable. Con opciones de combinación de colores. Tiene capacidad para 4 personas. Es la opción ideal para quien tiene poco espacio y queda perfecta en cualquier ambiente: cocina, sala o comedor.',
    price: 1399.00,
    image:
        'https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaPE/130412808_04/w=1500,h=1500,fit=pad',
    category: 'Comedor',
  ),
  Product(
    name: 'Juego de Comedor Britney con 6 Sillas',
    description:
        'La mesa tiene una base de pedestal y un tablero rectangular en MDP, lo que garantiza mucho espacio y resistencia para sentar cómodamente hasta seis personas. Las sillas son resistentes y duraderas gracias a su estructura de MDP/MDF y asiento de polipropileno. Y lo mejor de todo es que son ¡muy cómodas!',
    price: 1459.00,
    image:
        'https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaPE/130412930_041/w=1500,h=1500,fit=pad',
    category: 'Comedor',
  ),

  // Sala
  Product(
    name: 'Juego de Sala Sprinfield 3-2-1 Color Verde Militar',
    description:
        'El Juego de Sala Sprinfield 3-2-1 es una excelente opción para quienes buscan un conjunto de muebles elegante y cómodo. Este juego está construido con una estructura de madera Tornillo, conocida por su durabilidad y resistencia. El tapiz de Iker ofrece una textura suave y atractiva, mientras que el relleno de espuma Zebra - Paraíso proporciona un confort excepcional.',
    price: 3079.00,
    image:
        'https://images.pexels.com/photos/280471/pexels-photo-280471.jpeg?auto=compress&cs=tinysrgb&w=600',
    category: 'Sala',
  ),
  Product(
    name: 'Juego de Sala 3 2 1 Alyz Azul',
    description:
        'ALTO HOGAR presenta el Juego de Sala 3 2 1 Alyz, la elegancia y confort se conjugan en este fantástico juego de sala. Su suave tapizado y firme estructura invitan al descanso en cualquier momento. No lo pienses más y déjate consentir por su comodidad y excelente diseño.',
    price: 1799.00,
    image:
        'https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaPE/119660786_01/w=1500,h=1500,fit=pad',
    category: 'Sala',
  ),
  Product(
    name: 'Juego de Sala Vintage 3 2 1 Kayruth Gris Oscuro',
    description:
        'ALTO HOGAR ofrece el hermoso Juego de Sala Vintage 3 2 1 Kayruth, con sus hermosos acabados y estilo vintage la elegancia y buen gusto se reflejarán en cada rincón de tu hogar, gracias a su agradable textura se convierte en el elemento perfecto para complementar tu decoración. Déjate consentir por su comodidad y dale una nueva vida a tu espacio.',
    price: 1729.00,
    image:
        'https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaPE/119662493_01/w=1500,h=1500,fit=pad',
    category: 'Sala',
  ),
  Product(
    name: 'Juego de Sala Sprinfield 3-2-1 Color Gris Plata',
    description:
        'Estructura: Madera Tornillo Material del Tapiz: Iker Relleno: Espuma Zebra - Paraíso Patas: Madera Respaldo: Fijos Cortesía: 1 Cojín Decorativo Por Asiento Las patas de madera aseguran estabilidad y resistencia, mientras que los respaldos fijos ofrecen un soporte adicional para una comodidad óptima. Este juego de sala es perfecto para crear un ambiente acogedor y relajante en tu sala de estar o área de entretenimiento, brindando un espacio cómodo y funcional para disfrutar con familia y amigos.',
    price: 3079.00,
    image:
        'https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaPE/121763933_01/w=1500,h=1500,fit=pad',
    category: 'Sala',
  ),
  Product(
    name: 'Juego de Sala Pisa 3-2-1 Cuerpos',
    description:
        'Asegúrate de medir bien los espacios para que el mueble luzca como esperas en tu hogar. Revisa en detalle las medidas, el espacio dónde irá y los accesos por donde tendremos que pasar para dejarlo en su lugar. ',
    price: 2199.00,
    image:
        'https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaPE/15870118_1/w=1500,h=1500,fit=pad',
    category: 'Sala',
  ),
];
