class Article < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :likes, dependent: :destroy
  has_many :iine_users, through: :likes, source: :user


  # マイクロポストをいいねする
  def iine(user)
    likes.create(user_id: user.id)
  end

  # マイクロポストのいいねを解除する（ネーミングセンスに対するクレームは受け付けません）
  def uniine(user)
    likes.find_by(user_id: user.id).destroy
  end

  def iine?(user)
    iine_users.include?(user)
  end

end
