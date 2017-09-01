# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#

require 'csv'
csv = CSV.read(Rails.root.join('db', 'file.csv'), headers: true, header_converters: :symbol)

csv.each do |row|
  title = row[:title]
  author = row[:author]
  category = row[:category]
  resource_type = row[:type]
  date = row[:date]
  link = row[:link]
  description = 'no description'
  website = row[:website_url]
  Resource.create!(description: description, category_name: category, title: title, author: author, resource_type: resource_type ? resource_type : 'Undefined', link: link, website: website, date: date && DateTime.parse(date))
  @resource = Resource.last
  category = [category]
  category = category[0].split(',').collect(&:strip) if category[0].include?(',')
  if category.size > 1
    category.each do |category|
      c = Category.find_by(name: category.downcase)
      @resource.categories << c
    end
  else
    c = Category.find_by(name: category[0].downcase)
    @resource.categories << c
  end
end

AppSetting.create( refresh_token: nil, access_token: nil )
#
# ["marketing","newsletter","growthhacks","social media", "other"].each do |category|
#   Topic.create!(
#   name: category,
#   )
# end
#
# ["Growth Team", "Growth Model", "Retention", "Growth Process", "Growth Career"].each do |category|
#   Category.create!(
#   name: category,
#   )
# end
#
# User.create!(
# email: "simon@test.be",
# password: "password",
# password_confirmation: "password",
# admin: true
# )
#
# 40.times do
#   category, category2 = Category.all.sample(2)
# name = Faker::Name.name
# link = Faker::Internet.url
# title = Faker::Book.title
# description = Faker::Lorem.paragraph(2)
# date = Faker::Date.between(2.months.ago, Date.today)
#
# Resource.create!(
# title: title,
# description: description,
# link: link,
# website: link,
# author: name,
# resource_type: ["Article", "Presentation", "Link", "Video"].sample,
# grade: (1..5).to_a.sample,
# date: date
# )
# @resource = Resource.last
# ResourceCategory.create!(resource_id: @resource.id, category_id: category.id)
# ResourceCategory.create!(resource_id: @resource.id, category_id: category2.id)
# @resource.update_attributes(:category_name => @resource.categories.map{|c| Category.find(c).name.capitalize}.join(", "))
# end
#
#
# 40.times do
#   topic, topic2 = Topic.all.sample(2)
# title = Faker::Book.title
# description = Faker::Lorem.paragraph(2)
# body = Faker::Lorem.paragraph(12)
# topic_name = Topic.find(topic).name
# date = Faker::Date.between(2.months.ago, Date.today)
#
# Article.create!(
# title: title,
# description: description,
# body: body,
# user_id: 1,
# date: date,
# posted: true,
# topic_name: topic_name
# )
# @article = Article.last
# ArticleTopic.create!(article_id: @article.id, topic_id: topic.id)
# ArticleTopic.create!(article_id: @article.id, topic_id: topic2.id)
# @article.update_attributes(:topic_name => @article.topics.map{|c| Topic.find(c).name.capitalize}.join(", "))
# end
