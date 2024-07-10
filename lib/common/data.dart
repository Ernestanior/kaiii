import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/store/store.dart';

List staticStyleList = [
  {
    'uri': 'assets/static/style/Japanese_design.jpg',
    'value': 'japanese design',
    'label': 'JAPANESE_DESIGN'
  },
  {
    'uri': 'assets/static/style/minimalist.jpg',
    'value': 'minimalist',
    'label': 'MINIMALIST'
  },
  {
    'uri': 'assets/static/style/Art_nouveau.jpg',
    'value': 'art nouveau',
    'label': 'ART_NOUVEAU'
  },
  {
    'uri': 'assets/static/style/Sketch.jpeg',
    'value': 'sketch',
    'label': 'SKETCH'
  },
  {
    'uri': 'assets/static/style/Bohemian.jpg',
    'value': 'bohemian',
    'label': 'BOHEMIAN'
  },
  {
    'uri': 'assets/static/style/Industrial.jpg',
    'value': 'industrial',
    'label': 'INDUSTRIAL'
  },
  {
    'uri': 'assets/static/style/Scandinavian.jpg',
    'value': 'scandinavian',
    'label': 'SCANDINAVIAN'
  },
  {
    'uri': 'assets/static/style/Baroque.jpg',
    'value': 'baroque',
    'label': 'BAROQUE'
  },
  {
    'uri': 'assets/static/style/Cottagecore.jpg',
    'value': 'cottagecore',
    'label': 'COTTAGECORE'
  },
  {
    'uri': 'assets/static/style/Maximalist.jpg',
    'value': 'maximalist',
    'label': 'MAXIMALIST'
  },
  {
    'uri': 'assets/static/style/Midcentury_modern.jpg',
    'value': 'midcentury modern',
    'label': 'MIDCENTURY_MODERN'
  },
  {
    'uri': 'assets/static/style/Neoclassic_(Pro).jpg',
    'value': 'neoclassic (Pro)',
    'label': 'NEOCLASSIC'
  },
  {
    'uri': 'assets/static/style/Vintage.jpg',
    'value': 'vintage',
    'label': 'VINTAGE'
  },
  {
    'uri': 'assets/static/style/Biophilic.jpg',
    'value': 'biophilic',
    'label': 'BIOPHILIC'
  },
  {
    'uri': 'assets/static/style/tropical.jpg',
    'value': 'tropical',
    'label': 'TROPICAL'
  },
  {'uri': 'assets/static/style/zen.jpg', 'value': 'zen', 'label': 'ZEN'},
  {
    'uri': 'assets/static/style/coastal.jpg',
    'value': 'coastal',
    'label': 'COASTAL'
  },
  {
    'uri': 'assets/static/style/farmhouse.jpg',
    'value': 'farmhouse',
    'label': 'FARMHOUSE'
  },
  {
    'uri': 'assets/static/style/frenchcountrydesign.jpg',
    'value': 'french country design',
    'label': 'FRENCH_COUNTRY_DESIGN'
  },
  {
    'uri': 'assets/static/style/Rustic.jpg',
    'value': 'rustic',
    'label': 'RUSTIC'
  },
  {
    'uri': 'assets/static/style/Ski_chalet.jpg',
    'value': 'ski chalet',
    'label': 'SKI_CHALET'
  },
  {
    'uri': 'assets/static/style/Tribal.jpg',
    'value': 'tribal',
    'label': 'TRIBAL'
  },
  {
    'uri': 'assets/static/style/Art_deco.jpg',
    'value': 'art deco',
    'label': 'ART_DECO'
  },
  {
    'uri': 'assets/static/style/Gaming_room.jpg',
    'value': 'gaming room',
    'label': 'GAMING_ROOM'
  },
  {
    'uri': 'assets/static/style/Chinese_New_Year.jpg',
    'value': 'chinese new year',
    'label': 'CHINESE_NEW_YEAR'
  },
  {
    'uri': 'assets/static/style/Christmas.jpg',
    'value': 'christmas',
    'label': 'CHRISTMAS'
  },
  {
    'uri': 'assets/static/style/Easter.jpg',
    'value': 'easter',
    'label': 'EASTER'
  },
  {
    'uri': 'assets/static/style/Halloween.jpg',
    'value': 'halloween',
    'label': 'HALLOWEEN'
  },
  {
    'uri': 'assets/static/style/Cyberpunk.jpg',
    'value': 'cyberpunk',
    'label': 'CYBERPUNK'
  },
];

List<Widget> styleList = staticStyleList
    .map(
      (e) => GestureDetector(
        onTap: () {
          Controller.c.style(e['value']);
        },
        child: Obx(() => Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Controller.c.style == e['value']
                      ? const Color.fromARGB(255, 113, 170, 216)
                      : const Color.fromARGB(255, 176, 176, 176)),
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Image.asset(
                    e['uri'],
                    height: 130,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    child: Text(
                      e['label'].toString().tr,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  )
                ],
              ),
            )),
      ),
    )
    .toList();

List staticRoomList = [
  {'uri': 'assets/static/room/attic.jpeg', 'label': 'ATTIC', 'value': 'attic'},
  {
    'uri': 'assets/static/room/bath_room.jpeg',
    'label': 'BATH_ROOM',
    'value': 'bath room'
  },
  {
    'uri': 'assets/static/room/bedroom.jpeg',
    'label': 'BEDROOM',
    'value': 'bedroom'
  },
  {
    'uri': 'assets/static/room/children_room.jpeg',
    'label': 'CHILDREN_ROOM',
    'value': 'children room'
  },
  {
    'uri': 'assets/static/room/clothing_store.jpeg',
    'label': 'CLOTHING_STORE',
    'value': 'clothing store'
  },
  {
    'uri': 'assets/static/room/coffee_shop.jpeg',
    'label': 'COFFEE_SHOP',
    'value': 'coffee shop'
  },
  {
    'uri': 'assets/static/room/coworking_space.jpeg',
    'label': 'COWORKING_SPACE',
    'value': 'coworking space'
  },
  {
    'uri': 'assets/static/room/dining_room.jpeg',
    'label': 'DINING_ROOM',
    'value': 'dining room'
  },
  {
    'uri': 'assets/static/room/drop_zone.png',
    'label': 'DROP_ZONE',
    'value': 'drop zone'
  },
  {
    'uri': 'assets/static/room/exhibition_space.jpeg',
    'label': 'EXHIBITION_SPACE',
    'value': 'exhibition space'
  },
  {
    'uri': 'assets/static/room/fitness_gym.jpeg',
    'label': 'FITNESS_GYM',
    'value': 'fitness gym'
  },
  {
    'uri': 'assets/static/room/gaming_room.jpeg',
    'label': 'GAMING_ROOM',
    'value': 'gaming room'
  },
  {
    'uri': 'assets/static/room/home_office.jpeg',
    'label': 'HOME_OFFICE',
    'value': 'home office'
  },
  {
    'uri': 'assets/static/room/hotel_bathroom.jpeg',
    'label': 'HOTEL_BATHROOM',
    'value': 'hotel bathroom'
  },
  {
    'uri': 'assets/static/room/hotel_lobby.jpeg',
    'label': 'HOTEL_LOBBY',
    'value': 'hotel lobby'
  },
  {
    'uri': 'assets/static/room/hotel_room.jpeg',
    'label': 'HOTEL_ROOM',
    'value': 'hotel room'
  },
  {
    'uri': 'assets/static/room/house_exterior.jpeg',
    'label': 'HOUSE_EXTERIOR',
    'value': 'house exterior'
  },
  {
    'uri': 'assets/static/room/kitchen.jpeg',
    'label': 'KITCHEN',
    'value': 'kitchen'
  },
  {
    'uri': 'assets/static/room/living_room.jpeg',
    'label': 'LIVING_ROOM',
    'value': 'living room'
  },
  {
    'uri': 'assets/static/room/meeting_room.jpeg',
    'label': 'MEETING_ROOM',
    'value': 'meeting room'
  },
  {
    'uri': 'assets/static/room/mudroom.jpeg',
    'label': 'MUDROOM',
    'value': 'mudroom'
  },
  {
    'uri': 'assets/static/room/office.jpeg',
    'label': 'OFFICE',
    'value': 'office'
  },
  {'uri': 'assets/static/room/onsen.jpeg', 'label': 'ONSEN', 'value': 'onsen'},
  {
    'uri': 'assets/static/room/outdoor_garden.jpeg',
    'label': 'OUTDOOR_GARDEN',
    'value': 'outdoor garden'
  },
  {
    'uri': 'assets/static/room/outdoor_patio.jpeg',
    'label': 'OUTDOOR_PATIO',
    'value': 'outdoor patio'
  },
  {
    'uri': 'assets/static/room/outdoor_pool_area.jpeg',
    'label': 'OUTDOOR_POOL_AREA',
    'value': 'outdoor pool area'
  },
  {
    'uri': 'assets/static/room/restaurant.jpeg',
    'label': 'RESTAURANT',
    'value': 'restaurant'
  },
  {
    'uri': 'assets/static/room/study_room.jpeg',
    'label': 'STUDY_ROOM',
    'value': 'study room'
  },
  {
    'uri': 'assets/static/room/toilet.jpeg',
    'label': 'TOILET',
    'value': 'toilet'
  },
  {
    'uri': 'assets/static/room/walk_in_closet.png',
    'label': 'WALK_IN_CLOSET',
    'value': 'walk in closet'
  },
  {
    'uri': 'assets/static/room/workshop.jpeg',
    'label': 'WORKSHOP',
    'value': 'workshop'
  }
];

List<Widget> roomList = staticRoomList
    .map(
      (e) => GestureDetector(
        onTap: () {
          Controller.c.room(e['value']);
        },
        child: Obx(() => Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Controller.c.room == e['value']
                      ? const Color.fromARGB(255, 113, 170, 216)
                      : const Color.fromARGB(255, 176, 176, 176)),
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Image.asset(
                    e['uri'],
                    height: 130,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    child: Text(
                      e['label'].toString().tr,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  )
                ],
              ),
            )),
      ),
    )
    .toList();
