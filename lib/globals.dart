library my_prj.globals;

import 'package:flutter/material.dart';
import 'gardens.dart';
import 'imageData.dart';
import 'timeline.dart';
import 'marker.dart';

enum PhotoModes{
  private,
  public,
}

PhotoModes mode = PhotoModes.private;

const List<Garden> gardens = [
  Garden(name: 'Jardim Botânico de Lisboa', id: 1),
  Garden(name: 'Estufa Fria', id: 2)
];

List<Marker> markers1 = [
  const Marker(position: Offset(2480.4, 1051.3), name: "Rose", id: 0,
    description: "A rose is either a woody perennial flowering plant of the genus Rosa, in the family Rosaceae, or the flower it bears. There are over three hundred species and tens of thousands of cultivars.[citation needed] They form a group of plants that can be erect shrubs, climbing, or trailing, with stems that are often armed with sharp prickles.[citation needed] Their flowers vary in size and shape and are usually large and showy, in colours ranging from white through yellows and reds. Most species are native to Asia, with smaller numbers native to Europe, North America, and northwestern Africa.[citation needed] Species, cultivars and hybrids are all widely grown for their beauty and often are fragrant. Roses have acquired cultural significance in many societies. Rose plants range in size from compact, miniature roses, to climbers that can reach seven meters in height.[citation needed] Different species hybridize easily, and this has been used in the development of the wide range of garden roses."),
  const Marker(position: Offset(840.3, 999.4), name: "Tree", id: 1,
    description: "In botany, a tree is a perennial plant with an elongated stem, or trunk, usually supporting branches and leaves. In some usages, the definition of a tree may be narrower, including only woody plants with secondary growth, plants that are usable as lumber or plants above a specified height. In wider definitions, the taller palms, tree ferns, bananas, and bamboos are also trees. Trees are not a taxonomic group but include a variety of plant species that have independently evolved a trunk and branches as a way to tower above other plants to compete for sunlight. The majority of tree species are angiosperms or hardwoods; of the rest, many are gymnosperms or softwoods. Trees tend to be long-lived, some reaching several thousand years old. Trees have been in existence for 370 million years. It is estimated that there are some three trillion mature trees in the world."
  ),
  const Marker(position: Offset(1108.9, 898.4), name: "Tulip", id: 2,
    description: "Tulips (Tulipa) are a genus of spring-blooming perennial herbaceous bulbiferous geophytes (having bulbs as storage organs). The flowers are usually large, showy and brightly coloured, generally red, pink, yellow, or white (usually in warm colours). They often have a different coloured blotch at the base of the tepals (petals and sepals, collectively), internally. Because of a degree of variability within the populations, and a long history of cultivation, classification has been complex and controversial. The tulip is a member of the lily family, Liliaceae, along with 14 other genera, where it is most closely related to Amana, Erythronium and Gagea in the tribe Lilieae.")
];

List<Marker> markers2 = [
  const Marker(position: Offset(867.9, 815.6), name: "Orchid", id: 0,
    description: "Orchids are plants that belong to the family Orchidaceae (/ɔːrkəˈdeɪʃiː/), a diverse and widespread group of flowering plants with blooms that are often colourful and fragrant."
"Along with the Asteraceae, they are one of the two largest families of flowering plants. The Orchidaceae have about 28,000 currently accepted species, distributed in about 763 genera.[2][3] The determination of which family is larger is still under debate, because verified data on the members of such enormous families are continually in flux. Regardless, the number of orchid species is nearly equal to the number of bony fishes, more than twice the number of bird species, and about four times the number of mammal species."),
  const Marker(position: Offset(966.2, 1196.6), name: "Daisy", id: 1,
  description: "Bellis perennis is a perennial herbaceous plant growing to 20 centimetres (8 inches) in height.[2] It has short creeping rhizomes and rosettes of small rounded or spoon-shaped leaves that are from 2 to 5 cm (3⁄4–2 in) long and grow flat to the ground. The species habitually colonises lawns, and is difficult to eradicate by mowing, hence the term 'lawn daisy'. It blooms from March to September[2] and exhibits the phenomenon of heliotropism, in which the flowers follow the position of the sun in the sky. The flowerheads are composite, about 2 to 3 cm (3⁄4–1+1⁄4 in) in diameter, in the form of a pseudanthium, consisting of many sessile flowers with white ray florets (often tipped red) and yellow disc florets. Each inflorescence is borne on a single leafless stem 2 to 10 cm (3⁄4–4 in), rarely 15 cm (6 in) tall. The capitulum, or disc of florets, is surrounded by two rows of green bracts known as phyllaries.[3] The achenes are without pappus.[4]"),
  const Marker(position: Offset(1322.3, 1048.8), name: "Peaches", id: 2,
  description: "The peach (Prunus persica) is a deciduous tree first domesticated and cultivated in Zhejiang province of Eastern China.[3] It bears edible juicy fruits with various characteristics, most called peaches and others (the glossy-skinned, non-fuzzy varieties), nectarines. The specific name persica refers to its widespread cultivation in Persia (modern-day Iran), from where it was transplanted to Europe. It belongs to the genus Prunus, which includes the cherry, apricot, almond, and plum, in the rose family. The peach is classified with the almond in the subgenus Amygdalus, distinguished from the other subgenera by the corrugated seed shell (endocarp).[4] Due to their close relatedness, the kernel of a peach stone tastes remarkably similar to almond, and peach stones are often used to make a cheap version of marzipan, known as persipan.[5]")
];

int currentGarden = 1;


final images1 = <List<ImageData>>[<ImageData>[], <ImageData>[], <ImageData>[]];
final images2 = <List<ImageData>>[<ImageData>[], <ImageData>[], <ImageData>[]];

final community1 = <List<ImageData>>[<ImageData>[], <ImageData>[], <ImageData>[]];
final community2 = <List<ImageData>>[<ImageData>[], <ImageData>[], <ImageData>[]];