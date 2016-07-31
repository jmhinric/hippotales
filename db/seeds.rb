# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Subscription Cost
sc1 = SubscriptionCost.create!(
  cost: 29.95,
  duration: 1
)
sc2 = SubscriptionCost.create!(
  cost: 27.95,
  duration: 3
)
sc3 = SubscriptionCost.create!(
  cost: 25.95,
  duration: 6
)

SubscriptionPlan.create!(subscription_costs: [sc1, sc2, sc3])

# Publishers
dk_publisher = Publisher.create!(name: "DK Publishing")

# Creators
creator_nosy = Creator.create!(first_name: "Nosy", last_name: "Crow")
creator_sebastien = Creator.create!(first_name: "Sebastien", last_name: "Braun")
creator_jody = Creator.create!(first_name: "Jody", middle_name: "Fickes", last_name: "Shapiro")
creator_karen = Creator.create!(first_name: "Karen", last_name: "Katz")
creator_sandra = Creator.create!(first_name: "Sandra", last_name: "Boynton")
creator_jonathan = Creator.create!(first_name: "Jonathan", last_name: "Allen")
creator_cindy = Creator.create!(first_name: "Cindy", middle_name: "Post", last_name: "Senning")
creator_peggy = Creator.create!(first_name: "Peggy", last_name: "Post")
creator_leo = Creator.create!(first_name: "Leo", last_name: "Landry")
creator_alice = Creator.create!(first_name: "Alice", last_name: "Schertle")
creator_jill = Creator.create!(first_name: "Jill", last_name: "McElmurry")

# Authors
author_nosy = Author.create!(creator: creator_nosy)
author_jody = Author.create!(creator: creator_jody)
author_karen = Author.create!(creator: creator_karen)
author_sandra = Author.create!(creator: creator_sandra)
author_jonathan = Author.create!(creator: creator_jonathan)
author_cindy = Author.create!(creator: creator_cindy)
author_peggy = Author.create!(creator: creator_peggy)
author_alice = Author.create!(creator: creator_alice)

# Illustrators
illustrator_sebastien = Illustrator.create!(creator: creator_sebastien)
illustrator_karen = Illustrator.create!(creator: creator_karen)
illustrator_sandra = Illustrator.create!(creator: creator_sandra)
illustrator_leo = Illustrator.create!(creator: creator_leo)
illustrator_jill = Illustrator.create!(creator: creator_jill)

# Ages 0-1
Book.create!(
  title: "Baby Sophie la Girafe: First Words",
  image: "baby_sophie_la_girafe_first_words.jpg",
  description: "Sophie la girafe and friends are back in <i>Baby Sophie la girafe: First Words</i>. Packed with bright, lively illustrations and large, simple text, babies can discover the world around them in <i>Baby Sophie la girafe: First Words</i> board book. An ideal gift for new parents, this book will stimulate children's recognition of objects, as well as encourage talking and naming skills.",
  age: 0,
  gender: 0,
  publisher: dk_publisher
)

Book.create!(
  title: "Baby Touch and Feel: Numbers",
  image: "baby_touch_and_feel_numbers.jpg",
  description: "Baby Touch and Feel books are the perfect series for the very youngest readers. These small, padded books excite babies and toddlers with their foil and touch-and-feel covers. Each book in this affordable series contains twelve vibrant interior pages, with bold, engaging images. Containing large word labels, each page has foil or glitter to behold or a tantalizing texture to touch. These safe novelty textures immediately intrigue babies and are perfect for little fingers to feel.",
  age: 0,
  gender: 0,
  publisher: dk_publisher
)

Book.create!(
  title: "Can You Say It, Too? Arf! Arf!",
  image: "can_you_say_it_too_arf_arf.jpg",
  description: "Five lavishly illustrated spreads, big, recessed flaps, and a host of animals to spot, name, and mimic combine in these delightful little board books for the very young.",
  age: 0,
  gender: 0,
  authors: [author_nosy],
  illustrators: [illustrator_sebastien]
)

# Ages 1-2
Book.create!(
  title: "Family Lullaby",
  image: "family_lullaby.jpg",
  description: "Who loves Baby? Mama does. Who else loves Baby? Papa does. And who else?",
  age: 1,
  gender: 0,
  authors: [author_jody]
)

Book.create!(
  title: "Daddy Hugs 1 2 3",
  image: "daddy_hugs.jpg",
  description: "How many daddy hugs does it take to say I love you? Cuddle and count with this hug & read book!",
  age: 1,
  gender: 0,
  authors: [author_karen],
  illustrators: [illustrator_karen]
)

Book.create!(
  title: "Doggies",
  image: "doggies.png",
  description: "Count—and bark—with a fun pack of pups in this Sandra Boynton classic. Serious silliness for all ages. Artist Sandra Boynton is back and better than ever with completely redrawn versions of her multi-million selling board books. These whimsical and hilarious books, featuring nontraditional texts and her famous animal characters, have been printed on thick board pages, and are sure to educate and entertain children of all ages.",
  age: 1,
  gender: 0,
  authors: [author_sandra],
  illustrators: [illustrator_sandra]
)

# Ages 3-6
Book.create!(
  title: "Don't Copy Me!",
  image: "dont_copy_me.jpg",
  description: "\"Don't copy me!\" It's a refrain that's well-known to children, parents, and caregivers. Now it's Little Puffin's turn to say the words as three cheeky gull chicks follow him around, imitating his every word and step. And the more the puffin protests, the more the gulls enjoy their silly game. Can Little Puffin find a way to turn his frustration into a clever plan? With his usual wit and flair, author and artist Jonathan Allen turns a simple concept into a wildly entertaining tale.",
  age: 2,
  gender: 0,
  authors: [author_jonathan]
)

Book.create!(
  title: "Emily's Magic Words: Please, Thank You, and More",
  image: "emilys_magic_words.jpg",
  description: "It takes only a few magic words to have good manners. Let please, thank you, and excuse me act as your magic wand. Just by waving around these simple phrases, you can open doors, bring smiles to faces, and make friends. Try it and see! Thanks to the magical touch of Emily Post, the most trusted name in etiquette, learning good manners has never been more easy and fun.",
  age: 2,
  gender: 0,
  authors: [author_cindy, author_peggy],
  illustrators: [illustrator_leo]
)

Book.create!(
  title: "Little Blue Truck Board Book",
  image: "little_blue_truck.jpg",
  description: "Beep! Beep! Beep! Meet Blue. A muddy country road is no match for this little pick up--that is, until he gets stuck while pushing a dump truck out of the muck. Luckily, Blue has made a pack of farm animal friends along his route, and they're willing to do whatever it takes to get their pal back on the road. Filled with truck sounds and animal noises, here is a rollicking homage to the power of friendship and the rewards of helping others.",
  age: 2,
  gender: 0,
  authors: [author_alice],
  illustrators: [illustrator_jill]
)
