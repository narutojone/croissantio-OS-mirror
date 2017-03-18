module CategoriesHelper
 def set_category_path(category)
   category.type == "ArticleCategory" ? category_path(category) : resource_category_path(category)
 end
end
