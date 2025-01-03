class Product < ApplicationRecord
   
    validates :name, presence: true
    has_rich_text :description
    validates :inventory_count, numericality: { greater_than_or_equal_to: 0 }
    has_one_attached :featured_image
    has_many :subscribers, dependent: :destroy
    after_update_commit :notify_subscribers, if: :back_in_stock?

  def back_in_stock?
    inventory_count_previously_was.zero? && inventory_count > 0
  end

  def notify_subscribers
    subscribers.each do |subscriber|
      ProductMailer.with(product: self, subscriber: subscriber).in_stock.deliver_later
    end
  end
end
