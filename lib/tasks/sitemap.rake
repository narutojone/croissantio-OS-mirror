# lib/sitemap.rake
require "time"

task :generate_sitemap do
  if Time.now.monday?
     Rake::Task["sitemap:refresh"].invoke
   end
end
