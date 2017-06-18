# config/sitemap.rb
SitemapGenerator::Sitemap.default_host = 'https://www.growthbakery.com' # Your Domain Name
SitemapGenerator::Sitemap.public_path = 'tmp/sitemap'
# Where you want your sitemap.xml.gz file to be uploaded.
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(
  aws_access_key_id: ENV['S3_ACCESS_KEY'],
  aws_secret_access_key: ENV['S3_SECRET_KEY'],
  fog_provider: 'AWS',
  fog_directory: ENV['S3_BUCKET_NAME'],
  fog_region: ENV['S3_REGION']
)

# The full path to your bucket/
SitemapGenerator::Sitemap.sitemaps_host = 'https://thegrowthbakeryblog.s3.amazonaws.com'
# The paths that need to be included into the sitemap.
SitemapGenerator::Sitemap.create do
  Article.find_each do |article|
    add articles_show_path(article.slug.parameterize)
  end
  Resource.find_each do |resource|
    add resources_show_path(resource.slug.parameterize)
  end
  Category.find_each do |category|
    add category_path(category.name.parameterize)
  end
  Topic.find_each do |topic|
    add topic_path(topic.name.parameterize)
  end

  add '/thanks'
  add '/newsletter'
  add '/search'
  add '/blog'
  add '/about'
end
