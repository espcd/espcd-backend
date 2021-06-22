require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'create, destroy' do
    url = session_url
    username = 'alice'
    password = '123456'

    post url, params: { username: username, password: password }
    assert_response :unauthorized

    User.create!(username: username, password: password)

    post url, params: { username: username, password: password }
    assert_response :success
  end

  test 'destroy' do
    url = session_url

    delete url
    assert_response :unauthorized

    delete "#{url}?api_key=#{get_session}"
    assert_response :success
  end
end
