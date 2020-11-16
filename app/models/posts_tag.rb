class PostsTag

  include ActiveModel::Model
  attr_accessor :address, :image, :title, :category_id, :description, :day_time, :prefectures_id, :place, :budget, :user_id, :name, :id, :create_at, :updated_at

  with_options presence: true do
    validates :image
    validates :title
    validates :category_id, numericality: { other_than: 1 }
    validates :description
    validates :day_time
    validates :prefectures_id
    validates :place
    validates :budget
  end

  def save
    post = Post.create(image: image, title: title, category_id: category_id, description: description, day_time: day_time, prefectures_id: prefectures_id, place: place, budget: budget, user_id: user_id)
    tags = name.split(/[　| ]/)
    tags.each do |tag|
      tag = Tag.where(name: tag).first_or_initialize
      tag.save
      PostTag.create(post_id: post.id, tag_id: tag.id)
    end
    binding.pry
    Spot.create(address: address, post_id: post.id)
  end

  def update
    post = Post.find(id)
    # 画像がある場合にはimageを上書き、ない場合にはupdateには画像を含めない（画像が空にならないように）
    if image
      post.update(id: id, image: image, title: title, category_id: category_id, description: description, day_time: day_time, prefectures_id: prefectures_id, place: place, budget: budget, user_id: user_id)
    else
      post.update(id: id, title: title, category_id: category_id, description: description, day_time: day_time, prefectures_id: prefectures_id, place: place, budget: budget, user_id: user_id)
    end
    tags = name.split(/[ |　]/)
    tags.each do |tag|
      # 新たなタグの場合にはTagテーブルに追加
      up_tag = Tag.where(name: tag).first_or_initialize
      up_tag.update(name: tag)
      # postに紐づいているtagで保存されていないものがあればPostTagテーブルに保存
      post_tag = PostTag.find_by(post_id: post.id, tag_id: up_tag.id)
      PostTag.create(post_id: post.id, tag_id: up_tag.id) if post_tag == nil
    end
    # tagsとpostに紐づくtagの配列を比較してupdateの際に削除しているものがあればそれをPostTagテーブから削除
    post_tags = PostTag.where(post_id: post.id)
    alredy_tags = []
    post_tags.each do |t|
      alredy_tags << t.tag.name
    end
    delete_post_tags = alredy_tags - tags
    delete_post_tags.each do |delete_post_tag|
      delete_post_tag_id = Tag.find_by(name: delete_post_tag)
      delete_tag = PostTag.find_by(post_id: post.id, tag_id: delete_post_tag_id.id)
      delete_tag.destroy
    end
  end
  
end