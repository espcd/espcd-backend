require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'show' do
    user = User.find_by(session: get_session)
    url = user_url(user.id)

    get url
    assert_response :unauthorized

    get "#{url}?api_key=#{get_session}"
    assert_response :success

    get "#{url}?api_key=#{get_token}"
    assert_response :unauthorized
  end

  test 'update' do
    user = User.find_by(session: get_session)
    url = user_url(user.id)
    params = { password: '12345678' }

    patch url, params: params
    assert_response :unauthorized

    patch "#{url}?api_key=#{get_session}", params: params
    assert_response :success

    patch "#{url}?api_key=#{get_token}", params: params
    assert_response :unauthorized
  end
end
