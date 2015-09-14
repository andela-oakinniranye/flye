require 'rails_helper'

RSpec.describe Passenger, type: :model do
  let(:passenger){ Passenger.new }
  let(:with_first_name){ passenger.first_name= ['Kay', 'Stephen', 'Alex'].sample; passenger }
  let(:with_email){ passenger.email = Faker::Internet.email; passenger }
  let(:valid_passenger){
    with_email
    with_first_name
  }

  it 'is invalid without an email and name' do
    passenger.save

    expect(passenger).to be_invalid
  end

  it 'is invalid without a first name or last name' do
    with_email.save

    expect(with_email).to be_invalid
  end

  it 'is valid with name and email' do
    valid_passenger.save

    expect(valid_passenger).to be_valid
  end
end
