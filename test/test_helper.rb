ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def get_session
    user = get_or_create_user
    user.update!(session: SecureRandom.uuid)
    user.session
  end

  def get_token(product_id = nil)
    user = get_or_create_user
    user.update!(session: nil)
    token = Token.create!(title: 'test', expires_at: '2999-12-12T12:12:12+00:00', user_id: user.id, product_id: product_id)
    token.token
  end

  private

  def get_or_create_user
    user = User.find_by_username('alice')
    unless user
      user = User.create!(username: 'alice', password: '123456')
    end
    user
  end
end
