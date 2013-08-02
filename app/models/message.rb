class Message < ActiveRecord::Base
  attr_accessible :body

  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'

  scope :unread, -> { where(read: false) }


def deliver(sender, recipient)
Message.new(body: 'Hello there!').deliver!(sending: sender, receiving: recipient)
end


end
