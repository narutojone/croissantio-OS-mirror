module TopicsHelper
  def multiple_categories?(article)
    article.topic_name.include? ','
  end
end
