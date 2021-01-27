class Tagging < ApplicationRecord
  belongs_to :product
  belongs_to :tag

  validates :tag_id, uniqueness: {scope: :product_id}
  # Each tag can only be applied to a question once
end
