class PostsTag

  include ActiveModel::Model
  attr_accessor :image, :title, :category_id, :description, :day_time, :prefectures_id, :place, :budget, :user, :name

  with_options presence: true do
    validates :image
    validates :title
    validates :category_id, numericality: { other_than: 1 }
    validates :description
    validates :day_time
    validates :prefectures_id
    validates :place
    validates :budget
    validates :name
  end

  def save
    post = Post.create(image: image, title: title, category_id: category_id, description: description, day_time: day_time, prefectures_id: prefectures_id, place: place, budget: budget, user_id: current_user.id)
    tag = Tag.where(name: name).first_or_initialize
    Tag.save

    PostTag.create(post_id: post.id, tag_id: tag.id)
  
  end
end