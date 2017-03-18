class ArticleCategory < Category
  # This routes the /edit & /destroy action to the same destination
  # as its parent (https://goo.gl/Yfxmx5)
  def self.model_name
    Category.model_name
  end

  # Relation to articles
  has_many :articles, counter_cache: true, dependent: :destroy
end
