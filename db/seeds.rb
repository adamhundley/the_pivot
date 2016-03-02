coffee = Category.create(name:"coffee")
tools = Category.create(name:"tools")
gifts = Category.create(name:"gifts")

tools.products.create(name: "Aeropress", price: 5000, description: "Single cup of awesome.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/Aeropress.png")

tools.products.create(name: "Baratza Esatto Accessory", price: 13000, description: "Weight-Based Grinding. Jib up.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/Baratza+Esatto+Accessory.png")

tools.products.create(name:"Bonavita Brewer", price: 15000, description: "Quality as fuh.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/Bonavita+1900TS+Brewer.png")

tools.products.create(name: "Dteaming Pitcher", price: 2000, description: "Tapered spout makes these pitchers ideal for pouring latte art.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/Dteaming+Pitcher%2C+12oz.png")

tools.products.create(name: "Hario Buono Kettle", price: 4000, description: "Hario took the classic pour over kettle and gave it a modern twist. Incred.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/Hario+Buono+Kettle.png")

tools.products.create(name: "Takahiro Kettle", price: 10000, description: "Ever-elusive Takahiro.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/Takahiro+Kettle.png")

tools.products.create(name: "The Automated", price: 5000, description: "Bye-bye 1970s coffeemaker, hello precision engineering.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/The+Automated.png")

tools.products.create(name: "The Durable Basic", price: 8900, description:"Suited up and ready for travel.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/The+Durable+Basic.png")

tools.products.create(name: "Tsuki Usagi Jirushi Slim Pot", price: 6000, description: "Pour in style.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/Tsuki+Usagi+Jirushi+Slim+Pot.png")

coffee.products.create(name:"Banko Gutiti Ethiopa", price: 2000, description:"Money in the Banko.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/banko_gutiti_ethiopia.jpg")

coffee.products.create(name:"Bola de Oro", price: 2500, description:"Coffee gold.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/bola_de_oro.jpg")

coffee.products.create(name:"Cheri Ethiopia", price: 1500, description:"Coffee sundae", image_url:"https://s3.amazonaws.com/littleowl-turing/products/cheri_ethiopia.jpg")

coffee.products.create(name:"Dera Ela Ethiopa", price: 2000, description:"Dera Dera. So good.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/derar_ela_ethiopia.jpg")

coffee.products.create(name:"Espresso Neat Blend", price: 2000, description:"Black tie event.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/espresso_neat_blend.jpg")

coffee.products.create(name:"Finca San Matias", price: 2500, description:"Es todo que necessita.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/finca_san_matias.jpg")

coffee.products.create(name:"Gatchatha AA Kenya", price: 2000, description:"Gatchatha have it.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/gatchatha_aa_kenya.jpg")

coffee.products.create(name:"Inter Continental Pack", price: 4000, description:"Study abroad.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/inter_continental_pack.jpg")

coffee.products.create(name:"Kiamabara", price: 2000, description:"Unicorn tears.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/kiamabara.jpg")

coffee.products.create(name:"Kiangoi Kenya", price: 2000, description:"Hemingway drinks the shit.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/kiangoi_kenya.jpg")

coffee.products.create(name:"Kii Kenya", price: 2000, description:"Aliteration is always good.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/kii_kenya.jpg")

coffee.products.create(name:"Los Carillos Guatemala", price: 2000, description:"Silky. Bold. Close to home.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/los_carillos_guatemala.jpg")

coffee.products.create(name:"Nitsu Ruz Ethiopia", price: 2000, description:"Not your typical Ethiopian blend.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/nitsu_ruz_ethiopia.jpg")

coffee.products.create(name:"Santa Clara Panama", price: 2000, description:"Not from Silicon Valley.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/santa_clara_panama.jpg")

coffee.products.create(name:"Tanzania", price: 2000, description:"Fortune favors the brave.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/tanzania.jpg")

coffee.products.create(name:"Terra Bella", price: 2000, description:"Gorgeous.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/terra_bella.jpg")

gifts.products.create(name:"Espresso Set", price: 4000, description:"Get fancy.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/espresso+set.jpg")

gifts.products.create(name:"Modern Art Desserts", price: 2000, description:"I heart dessert.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/gifts/Modern_Art_Desserts.jpg")

gifts.products.create(name:"Blue Mug", price: 1000, description:"Go classic.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/gifts/blue+mug.jpg")

gifts.products.create(name:"Chocolat", price: 2500, description:"Perfection.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/gifts/chocolat.jpg")

gifts.products.create(name:"Fancy Pourover", price: 2500, description:"For the special occasion, everyday.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/gifts/fancy+pourover.jpg")

gifts.products.create(name:"$20 Gift Card", price: 2000, description:"Share the Owl.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/gifts/gift+card+-+holiday.jpg")

gifts.products.create(name:"LO Ornaments", price: 1000, description:"Never too early.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/gifts/ornaments.jpg")

gifts.products.create(name:"Pitcher", price: 2500, description:"Chic all.", image_url:"https://s3.amazonaws.com/littleowl-turing/products/gifts/pitcher.jpg")
