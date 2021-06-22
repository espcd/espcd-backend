require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    url = products_url

    get url
    assert_response :unauthorized

    get "#{url}?api_key=#{get_session}"
    assert_response :success

    get "#{url}?api_key=#{get_token}"
    assert_response :unauthorized
  end

  test 'show' do
    product = Product.create!
    url = product_url(product.id)

    get url
    assert_response :unauthorized

    get "#{url}?api_key=#{get_session}"
    assert_response :success

    get "#{url}?api_key=#{get_token}"
    assert_response :unauthorized

    get "#{url}?api_key=#{get_token(product.id)}"
    assert_response :success
  end

  test 'create' do
    url = products_url

    post url
    assert_response :unauthorized

    post "#{url}?api_key=#{get_session}"
    assert_response :success

    post "#{url}?api_key=#{get_token}"
    assert_response :unauthorized
  end

  test 'update' do
    product = Product.create!
    url = product_url(product.id)
    params = { product: { title: 'test' } }

    patch url, params: params
    assert_response :unauthorized

    patch "#{url}?api_key=#{get_token}", params: params
    assert_response :unauthorized

    patch "#{url}?api_key=#{get_token(product.id)}", params: params
    assert_response :success
  end

  test 'destroy' do
    product = Product.create!
    url = product_url(product.id)

    delete url
    assert_response :unauthorized

    delete "#{url}?api_key=#{get_token}"
    assert_response :unauthorized

    delete "#{url}?api_key=#{get_token(product.id)}"
    assert_response :unauthorized

    delete "#{url}?api_key=#{get_session}"
    assert_response :success
  end
end
