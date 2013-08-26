require 'spec_helper'

describe TwitterAuthentication do
  let(:user) { Fabricate(:user) }

  let(:omniauth) do
    Hashie::Mash.new(
      uid: '123',
      provider: 'twitter',
      info: {
        name: 'Twitter User',
        image: 'http://www.twitter.com/user.png'
      }
    )
  end

  subject do
    TwitterAuthentication.new(
      user_id: user.id, provider: 'twitter', uid: '123'
    )
  end

  describe 'validations' do
    it 'should have unique pair of uid and provider' do
      subject.save
      TwitterAuthentication.new(provider: 'twitter', uid: '123').should_not be_valid
    end
  end

  describe '#dsl' do
    it 'should be a Proc' do
      subject.dsl.should be_a Proc
    end

    it 'should extract name and image' do
      user.populate_from_auth(omniauth, &subject.dsl)
      user.name.should == 'Twitter User'
      user.image.should == 'http://www.twitter.com/user.png'
    end
  end
end
