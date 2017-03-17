# The Growth Bakery

> In all respects a standard, smallscale rails application using articles, resources, users (devise) and categories as database models + a pagescontroller for static pages. Admin panel is custom-built using the gentella theme  (https://colorlib.com/polygon/gentelella/general_elements.html) whilst the rest uses the stack theme from themeforest (http://trystack.mediumra.re/). Currently has no test coverage.

# Info

- Articles with a category_name of "newsletter" only show up on the /newsletter page. All other ones show up on the /blog page. Database query defined in articles_controller.
- The /search page form is send to the search action on the pages_controller where the params are used to filter resources by resource_type, date range and order them by date or grade. It also has an algolia autocomplete-search (https://www.algolia.com/) where the returned JSON suggestions are appended as the user types. These scripts are defined in search.html.erb and search.js
- Routes for articles and resources are shortened to mydomain.com/my-cool-article and mydomain.com/my-even-cooler-resource using friendly_id gem. Routes will friendly-search for /slug in articles table first, then in resources table as they "cascade" down the routes.rb file.
- Routes for categories are shortened to mydomain.com/categories/my-cool-category and are basically the same as the /blog but just only contains the articles for that category.
- Sitemap is automatically generated every week using the heroku scheduler and the sitemap_generator gem.

# Troubleshooting

> For more detailed info about problems or someone to blame when you encounter a bad design pattern, contact info@truetech.be.

# Active To Do/Reminders

- Configure sendgrid
- Verify 404 is working
- Configure search page with categories
- Upload resources to database through CSV file
