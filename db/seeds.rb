# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#

100.times do
name = Faker::Name.name
link = Faker::Internet.url
title = Faker::Book.title
description = Faker::Lorem.paragraph(2)
date = Faker::Date.between(2.months.ago, Date.today)
Resource.create!(
title: title,
description: description,
link: link,
website: link,
author: name,
resource_type: ["Article", "Presentation", "Link", "Other"].sample,
grade: (1..5).to_a.sample,
date: date
)
end

["marketing","newsletter","growthhacks","social media", "other"].each do |category|
  Category.create!(
  name: category
  )
end


20.times do
title = Faker::Book.title
description = Faker::Lorem.paragraph(2)
body = Faker::Lorem.paragraph(12)
category = (1..5).to_a.sample
category_name = Category.find(category).name
Article.create!(
title: title,
description: description,
body: body,
user_id: 1,
posted: true,
category_id: category,
category_name: category_name
)
end
