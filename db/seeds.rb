#super admin and moderator user
admin_user = User.create(first_name: 'Super Admin', last_name: 'User', email: 'admin@eat2040.com', password: 'Adm!ne@t204O', password_confirmation: 'Adm!ne@t204O', role: User.roles[:super_admin])
admin_user = User.create(first_name: 'Moderator', last_name: 'User', email: 'moderator@eat2040.com', password: 'M0de@t204O', password_confirmation: 'M0de@t204O', role: User.roles[:moderator_user])



#categories
# category_one = Category.create(title_en: 'Appetizers', description_en: 'Perfect party appetizers the easy way, see several tasty appetizers with photos and tips on how to eat them.', title_ar: 'مقبلات', description_ar: 'مشهيات حفلات مثالية بالطريقة السهلة ، شاهد العديد من المقبلات اللذيذة مع صور ونصائح حول كيفية تناولها.', avatar: File.open(File.join(Rails.root, "/app/assets/images/home/sandwich.png")))
# puts "Created Appetizers Category."

category_two = Category.create(title_en: 'Breakfast', description_en: 'Start your day with an easy pancake or omelet breakfast. Or plan a showstopping brunch with quiches, waffles, casseroles, and more!', title_ar: 'فطور', description_ar: 'ابدأ يومك مع فطيرة سهلة أو الإفطار العجة. أو خطط لتناول وجبة بين الإفطار والغداء مع الفطائر والوافل والكاسيرول وأكثر من ذلك!', avatar: File.open(File.join(Rails.root, "/app/assets/images/home/shake.png")))
puts "Created Breakfast Category."

category_three = Category.create(title_en: 'Lunch', description_en: 'Whether you crave sweet, savoury, decadent or healthy, we have hundreds of top-rated dessert recipes to satisfy your taste buds.', title_ar: 'الصحاري', description_ar: 'سواء أكنت تتوق للحلويات ، أو الحلويات ، أو منحلة ، أو صحية ، فإن لدينا المئات من وصفات الحلويات ذات التصنيف العالي لإرضاء ذوقك.', avatar: File.open(File.join(Rails.root, "/app/assets/images/home/desert.png")))
puts "Created Lunch Category."

category_four = Category.create(title_en: 'Dinner', description_en: 'Hundreds of main dish recipes, choose from top-rated comfort food, healthy, and vegetarian options.', title_ar: 'الطبق الرئيسي', description_ar: 'المئات من وصفات الأطباق الرئيسية ، اختر من بين أعلى مستويات الراحة للطعام والخيارات الصحية والنباتية.', avatar: File.open(File.join(Rails.root, "/app/assets/images/home/burger.png")))
puts "Created Dinner Category."



#sub_categories
# if category_one.present?
#   menu_items_data = [
#     { title_en: 'Halloumi Sticks', description_en: 'Thymed breaded halloumi sticks.', title_ar: 'أصابع جبن الحلوم', description_ar: 'أصابع جبن الحلوم بالزعتر', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/halloumi-sticks.png")) },
#     { title_en: 'Chicken Tenders', description_en: 'Breaded sliced chicken breast.', title_ar: 'قطع الدجاج تندرز', description_ar: 'شرائح الدجاج المقرمش', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/chicken-tenders.png")) },
#     { title_en: 'Fries', description_en: 'Crispy fries topped with putin sauce or melted cheese.', title_ar: 'بطاطا مقلية', description_ar: 'بطاطا مقرمشة مع صلصة بوتين أو جبنة', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/fries.png")) },
#     { title_en: 'Cheese/Putin Fries', description_en: 'Crispy fries topped with putin sauce or melted cheese.', title_ar: 'بطاطا مقلية مع الجبنة/ بطاطا بوتين', description_ar: 'بطاطا مقرمشة مع صلصة بوتين أو جبنة', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/cheese-fries.png")) }
#   ]
#   menu_items_data.each do |menu_item|
#     category_one.menu_items.create(menu_item)
#   end
# end

if category_two.present?
  menu_items_data = [
    { title_en: 'Egg Wrap', description_en: 'Scrambled eggs.', title_ar: 'لفائف البيض', description_ar: 'بيض مخفوق', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/egg-wrap.png")) },
    { title_en: 'Halloum', description_en: 'Freshly baked halloumi wrap, with mint, olives and cucumber.', title_ar: 'حلوم', description_ar: 'لفائف الحلوم المشوي مع النعنع والزيتون والخيار', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/halloum.png")) },
    { title_en: 'Turkey & Cheese', description_en: 'Freshly baked Turkey and halloumi wrap, with olives, mint and cucumber.', title_ar: 'حبش وجبنة', description_ar: 'لفائف الحبش والحلوم المشوي￼￼￼￼￼￼￼￼￼ مع النعنع والزيتون والخيار', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/turkey-n-cheese.png")) },
    { title_en: 'Zaatar Wrap', description_en: 'Freshly baked zaatar warap, with mint, olives and cucumber.', title_ar: 'لفائف الزعتر', description_ar: 'لفائف الزعتر الطازج مع النعنع￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼ والزيتون والخيار', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/zaatar-wrap.png")) }
  ]
  menu_items_data.each do |menu_item|
    category_two.menu_items.create(menu_item)
  end
end

if category_three.present?
  menu_items_data = [
    { title_en: 'Tamriya', description_en: 'Rakakat filled with tamrieh topped with powdered sugar.', title_ar: 'تمرية', description_ar: 'رقاقات محشوة بالتمريةومزينة بالسكر البودرة', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/tamriya.png")) },
    { title_en: 'Choco banana & Halawi', description_en: 'Nutella, halawi, and banana served on a sajj wrap.', title_ar: 'شوكولا وموز مع الحلاوة', description_ar: 'نوتيلا، حلاوة وموز مقدمةفي خبز الصاج', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/halawi.png")) }
  ]
  menu_items_data.each do |menu_item|
    category_three.menu_items.create(menu_item)
  end
end

if category_four.present?
  menu_items_data = [
    { title_en: 'Shrimp', description_en: 'Shrimp served with iceberg, tomato, pickles, cocktail sauce and tartar sauce.', title_ar: 'جمبري', description_ar: 'الروبيان خدم مع فيض، الطماطم، المخللات، صلصة الكوكتيل وصلصة التارتار.', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/shrimp.png")) },
    { title_en: 'Phily Steak', description_en: 'Steak meat mix, sered with ice berg, tomato and cheese mix.', title_ar: 'فيلي، بفتيك', description_ar: 'مزيج لحم اللحم، مسلوق مع مزيج بيرج الجليد والطماطم والجبن.', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/steak.png")) },
    { title_en: 'Crispy Chicken', description_en: 'Fried Chicken escalope served with tomato, pickles, iceberg and spicy sauce.', title_ar: 'دجاج مقرمش', description_ar: 'الدجاج المقلي إسكالوب خدم مع الطماطم والمخللات، فيض وصلصة حار.', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/crispy-chicken.png")) },
    { title_en: 'Mexican Chicken', description_en: 'A special chicken mix served with iceberg, cheese mic and two mustard sauce .', title_ar: 'المكسيكي، تشيكن', description_ar: 'مزيج خاص من الدجاج يقدم مع فيض، ميكروفون الجبن واثنين من صلصة الخردل .', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/mexican-chicken.png")) },
    { title_en: 'kafta spread', description_en: 'Kafta spread served with a cheese mix, tomato, ice berg, pickles and our special hommos dip.', title_ar: 'انتشار الكافتا', description_ar: 'كافتا انتشار خدم مع مزيج الجبن والطماطم والجليد بيرغ والمخللات ولدينا هوموس تراجع خاص.', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/pesto.png")) },
    { title_en: 'Taouk', description_en: 'Chicken breast taouk, served with coleslaw, pickles, french fries, ketchup and garlic paste.', title_ar: 'تاوك', description_ar: 'صدر دجاج طاووق، يقدم مع سلطة كولسلو، مخلل، بطاطا مقلية، صلصة الطماطم والثوم.', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/kofta.png")) },
    { title_en: 'Burger', description_en: 'Home made beef patty, served on a sajj dough, with colslaw, pickles, tomato, fresh onions, french fries and cocktail sauce.', title_ar: 'برغر', description_ar: 'قدم المنزل باتي لحم البقر، خدم على عجينة سج، مع الجرس والمخللات والطماطم والبصل الطازج والبطاطا المقلية وصلصة الكوكتيل.', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/taouk.png")) },
    { title_en: 'chicken pesto', description_en: 'Chicken breast, smoked turkey, served with edam cheese, ice berg, pickles, tomato, pesto mayo sauce and our special pink sauce.', title_ar: 'بيستو الدجاجة', description_ar: 'صدر دجاج، دجاج مدخن، يقدم مع جبنة ايدام، بيرج الجليد، المخللات، الطماطم، صلصة المايو بيستو وصلصة الوردي الخاصة لدينا.', price: 100, avatar: File.open(File.join(Rails.root, "/app/assets/images/seed/burger.png")) }
  ]
  menu_items_data.each do |menu_item|
    category_four.menu_items.create(menu_item)
  end
end



#about_us
about_us = About.create(heading_en: 'About us', is_active: true, description_en: 'Chefit 24 is a sandwich wrap concept serving delicious freshly made wraps over breakfast lunch dinner as both an eat in and take out service. Although the menu does include a selection of starters and sides, the main attraction and our core product is our hero wrap which comes in a variety of choices; cold, hot savory and sweet. The flavors of the menu are inspired from ever corner of the world and we tailored to the taste pallet that we know and love of the consumers of the middle east region. The menu is expertly crafted to be delicious, meet quality standards and be afforable and accessible to consumers across the social economic spectrum.', heading_ar: 'عنّا', description_ar: 'توينتي فورتي (20/40) هو مفهوم التفاف شطيرة خدمة لذيذة طازجة يلف على وجبة الإفطار الغداء العشاء على حد سواء لتناول الطعام في وإخراج الخدمة. على الرغم من أن القائمة لا تشمل مجموعة من المقبلات والجانبين، وجذب الرئيسي و لدينا المنتج الأساسي هو بطلنا التفاف الذي يأتي في مجموعة متنوعة من الخيارات؛ الباردة، الساخنة لذيذة وحلوة. النكهات من القائمة مستوحاة من ركن من أي وقت مضى من العالم، ونحن مصممة خصيصا للطعم البليت التي نعرفها ونحب المستهلكين في منطقة الشرق الأوسط. يتم إعداد القائمة بخبرة لتكون لذيذة، وتلبية معايير الجودة وتكون أفورابل و في متناول المستهلكين عبر الطيف الاقتصادي الاجتماعي. تبينتصحيححذف')



#menu_lists
menu_list = MenuList.create(menu_file: File.open(File.join(Rails.root, "/app/assets/images/home/Menu_Spreads.pdf")))
puts "Created Menu Brochure"



#locations
location_one = Location.create(title_en: "Dilawar Colony", address_en: "Unit # 1 - House No-11 Street No-8 Dilawar Colony Yazman Road Bahawalpur", country_en: "Pakistan", title_ar: "ميدان حطين", address_ar: "الوحدة رقم 3 - ميدان حطين طريق الأمير تركي بن ​​عبدالعزيز الأول", country_ar: "المملكة العربية السعودية", phone: "+92302-0075311", postal_code: "63100", lat: "29.246646", lng: "71.7272311")
# location_two = Location.create(title_en: "Al Maather Extension", address_en: "Al Maather Extension, Unit # 16 Takhassusi St, Al Maather", country_en: "Saudi Arabia", title_ar: "ملحق المعذر", address_ar: "امتداد المعذر ، الوحدة رقم 16 ، شارع التخصصي ، المعذر", country_ar: "المملكة العربية السعودية", phone: "", postal_code: "12714", lat: "24.6646", lng: "46.6809")
# location_three = Location.create(title_en: "Al Nada Plaza", address_en: "Al Nada Plaza, Unit # 3 An Nada", country_en: "Saudi Arabia", title_ar: "الندى بلازا", address_ar: "الندى بلازا ، الوحدة رقم 3 الندى", country_ar: "المملكة العربية السعودية", phone: "", postal_code: "13317", lat: "24.8061", lng: "46.6908")
