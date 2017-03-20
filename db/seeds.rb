# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#

# require "csv"
# csv = CSV.read(Rails.root.join('db', 'file.csv'), headers: true, header_converters: :symbol)
#
# csv.each do |row|
#   next if row[:facebook_ads].blank?
#   category = row[:facebook_ads]
#   ResourceCategory.create!(name: category)
# end
#
# csv.each do |row|
#   title = row[:title]
#   author = row[:author]
#   category = row[:category]
#   grade = row[:grade]
#   resource_type = row[:type]
#   date = row[:date]
#   link = row[:link]
#   description = "no description"
#   website = row[:website_url]
#   Resource.create!(description: description, category_name: category, title: title, author: author, grade: grade.to_i, resource_type: resource_type, link: link, website: website, date: DateTime.parse(date))
#   @resource = Resource.last
#   category = [category]
#   category = category[0].split(",").collect{|a| a.strip} if category[0].include?(",")
#   if category.size > 1
#     category.each do |category|
#       c = Category.find_by(name: category.downcase)
#       @resource.categories << c
#     end
#   else
#     c = Category.find_by(name: category[0].downcase)
#     @resource.categories << c
#   end
# end

["marketing","newsletter","growthhacks","social media", "other"].each do |category|
  ArticleCategory.create!(
  name: category,
  )
end

["Growth Team", "Growth Model", "Retention", "Growth Process", "Growth Career"].each do |category|
  ResourceCategory.create!(
  name: category,
  )
end

User.create!(
email: "simon@test.be",
password: "password",
password_confirmation: "password",
admin: true
)

category = ResourceCategory.all.first
category2 = ResourceCategory.all.last
40.times do
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
resource_type: ["Article", "Presentation", "Link", "Video"].sample,
grade: (1..5).to_a.sample,
date: date
)
@resource = Resource.last
ResourcesCategory.create!(resource_id: @resource.id, category_id: category.id)
ResourcesCategory.create!(resource_id: @resource.id, category_id: category2.id)

end



40.times do
title = Faker::Book.title
description = Faker::Lorem.paragraph(2)
body = Faker::Lorem.paragraph(12)
category = ArticleCategory.all.sample.id
category_name = ArticleCategory.find(category).name
date = Faker::Date.between(2.months.ago, Date.today)

Article.create!(
title: title,
description: description,
body: body,
user_id: 1,
date: date,
posted: true,
category_id: category,
category_name: category_name
)
end
