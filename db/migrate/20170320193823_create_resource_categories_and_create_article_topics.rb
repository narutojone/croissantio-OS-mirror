class CreateResourceCategoriesAndCreateArticleTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :resource_categories do |t|
      t.integer :resource_id, index: true
      t.integer :category_id, index: true
    end
    create_table :article_topics do |t|
      t.integer :article_id, index: true
      t.integer :topic_id, index: true
    end
  end
end
