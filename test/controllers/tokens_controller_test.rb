require 'test_helper'

class TokensControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    url = tokens_url

    get url
    assert_response :unauthorized

    get "#{url}?api_key=#{get_session}"
    assert_response :success

    get "#{url}?api_key=#{get_token}"
    assert_response :unauthorized
  end

  test 'show' do
    token = Token.find_by(token: get_token)
    url = token_url(token.id)

    get url
    assert_response :unauthorized

    get "#{url}?api_key=#{get_session}"
    assert_response :success

    get "#{url}?api_key=#{token.token}"
    assert_response :unauthorized

    product = Product.create!
    token.update!(product_id: product.id)
    get "#{url}?api_key=#{token.token}"
    assert_response :unauthorized
  end

  test 'create' do
    url = tokens_url
    user = User.find_by(session: get_session)
    product = Product.create!
    params = { token: { title: 'test', expires_at: '2999-12-12T12:12:12+00:00', user_id: user.id, product_id: product.id } }

    post url, params: params
    assert_response :unauthorized

    post "#{url}?api_key=#{user.session}", params: params
    assert_response :success

    post "#{url}?api_key=#{get_token}", params: params
    assert_response :unauthorized
  end

  test 'update' do
    token = Token.find_by(token: get_token)
    url = token_url(token.id)
    params = { token: { title: 'test' } }

    patch url, params: params
    assert_response :unauthorized

    patch "#{url}?api_key=#{get_session}", params: params
    assert_response :success

    patch "#{url}?api_key=#{get_token}", params: params
    assert_response :unauthorized
  end

  test 'destroy' do
    token = Token.find_by(token: get_token)
    url = token_url(token.id)

    delete url
    assert_response :unauthorized

    delete "#{url}?api_key=#{get_token}"
    assert_response :unauthorized

    delete "#{url}?api_key=#{get_session}"
    assert_response :success
  end
end
