require 'test_helper'

class DevicesControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    url = devices_url

    get url
    assert_response :unauthorized

    get "#{url}?api_key=#{get_session}"
    assert_response :success

    get "#{url}?api_key=#{get_token}"
    assert_response :unauthorized
  end

  test 'show' do
    device = Device.create!(fqbn: 'esp32:esp32:esp32')
    url = device_url(device.id)

    get url
    assert_response :unauthorized

    get "#{url}?api_key=#{get_session}"
    assert_response :success

    get "#{url}?api_key=#{get_token}"
    assert_response :success

    product = Product.create!
    get "#{url}?api_key=#{get_token(product.id)}"
    assert_response :unauthorized

    device.update!(product_id: product.id)
    get "#{url}?api_key=#{get_token(product.id)}"
    assert_response :success
  end

  test 'create' do
    url = devices_url
    params = { device: { fqbn: 'esp32:esp32:esp32' } }

    post url, params: params
    assert_response :unauthorized

    post "#{url}?api_key=#{get_session}", params: params
    assert_response :success

    post "#{url}?api_key=#{get_token}", params: params
    assert_response :success

    product = Product.create!
    post "#{url}?api_key=#{get_token(product.id)}", params: { device: { fqbn: 'esp32:esp32:esp32', product_id: product.id } }
    assert_response :success
  end

  test 'update' do
    device = Device.create!(fqbn: 'esp32:esp32:esp32')
    url = device_url(device.id)

    patch url, params: { device: { title: 'test' } }
    assert_response :unauthorized

    patch "#{url}?api_key=#{get_token}", params: { device: { title: 'test' } }
    assert_response :success

    product = Product.create!
    device.update!(product_id: product.id)

    patch "#{url}?api_key=#{get_token}", params: { device: { title: 'test' } }
    assert_response :unauthorized

    patch "#{url}?api_key=#{get_token(product.id)}", params: { device: { title: 'test' } }
    assert_response :success
  end

  test 'destroy' do
    device = Device.create!(fqbn: 'esp32:esp32:esp32')
    url = device_url(device.id)

    delete url
    assert_response :unauthorized

    delete "#{url}?api_key=#{get_token}"
    assert_response :unauthorized

    delete "#{url}?api_key=#{get_session}"
    assert_response :success
  end
end
