require 'spec_helper'

describe Message do
  describe '.deliver!' do
    let(:message) { Message.new(body: "Hello, Monkey") }
    let(:sender) { mock_model(User) }
    let(:recipient) { mock_model(User) }

    context 'when both the sender and recipient are specified' do
      before(:each) do
        message.deliver! sending: sender, receiving: recipient
      end

      it 'should set the sender of the message' do 
        expect(message.sender).to eq(sender)
      end

      it 'should set the recipient of the message' do 
        expect(message.recipient).to eq(recipient)
      end

      it 'should persist the message to the database' do
        expect(message.persisted?).to be_true
      end
    end

    context 'when neither the sender or recipient is specified' do
      it 'should raise an error' do
        expect {message.deliver! }.to raise_error ArgumentError
      end
    end

    context 'when only the sender is specified' do
      it 'should raise an error' do
        expect {message.deliver! sending: sender}.to raise_error ArgumentError
      end
    end

    context 'when only the recipient is specified' do
      it 'should raise an error' do
        expect { message.deliver! receiving: recipient }.to raise_error ArgumentError
      end
    end

  context 'when the message body is empty' do 
    let(:message) { Message.new }
    it 'should raise an error' do
      #another way to improve this is to remove the variable from let(:message) since were not using this statement. Then we can do something like expect {Message.new(body: nil).deliver!}
      expect { message.deliver! }.to raise_error 

      # We changed below to message.deliver! as seen above
      # expect { message.body.empty? }.to raise_error 

      # another way to do it. In this case StandardError is created by us similarly to ArgumentError
      # expect { Message.new(body: nil).deliver! }.to raise_error StandardError
    end
  end
    

  end
end