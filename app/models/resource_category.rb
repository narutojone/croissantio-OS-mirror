class ResourceCategory < Category
  # This routes the /edit & /destroy action to the same destination
  # as its parent
  def self.model_name
    Category.model_name
  end
end
