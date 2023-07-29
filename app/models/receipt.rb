class Receipt < ApplicationRecord
    mount_uploader :image, ImageUploader
    attr_accessor :current_user_id

    belongs_to :user
  end