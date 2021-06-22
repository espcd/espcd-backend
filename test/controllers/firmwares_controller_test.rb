require 'test_helper'

class FirmwaresControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    url = firmwares_url

    get url
    assert_response :unauthorized

    get "#{url}?api_key=#{get_session}"
    assert_response :success

    get "#{url}?api_key=#{get_token}"
    assert_response :unauthorized
  end

  test 'show' do
    firmware = create_firmware
    url = firmware_url(firmware.id)

    get url
    assert_response :unauthorized

    get "#{url}?api_key=#{get_session}"
    assert_response :success

    get "#{url}?api_key=#{get_token}"
    assert_response :unauthorized

    product = Product.create!
    get "#{url}?api_key=#{get_token(product.id)}"
    assert_response :unauthorized

    BoardType.create!(fqbn: 'esp32:esp32:esp32', product_id: product.id, firmware_id: firmware.id)
    get "#{url}?api_key=#{get_token(product.id)}"
    assert_response :success
  end

  test 'create' do
    url = firmwares_url
    params = {
      firmware: {
        fqbn: 'esp32:esp32:esp32',
        version: '1.0',
        content: fixture_file_upload('testfw.bin', 'application/octet-stream')
      }
    }

    post url, params: { firmware: { fqbn: 'esp32:esp32:esp32', version: '1.0' } }
    assert_response :unauthorized

    post "#{url}?api_key=#{get_session}", params: params
    assert_response :success

    post "#{url}?api_key=#{get_token}", params: params
    assert_response :success

    product = Product.create!
    post "#{url}?api_key=#{get_token(product.id)}", params: params
    assert_response :success
  end

  test 'update' do
    firmware = create_firmware
    url = firmware_url(firmware.id)

    patch url, params: { firmware: { title: 'test' } }
    assert_response :unauthorized

    patch "#{url}?api_key=#{get_session}", params: { firmware: { title: 'test' } }
    assert_response :success

    patch "#{url}?api_key=#{get_token}", params: { firmware: { title: 'test' } }
    assert_response :unauthorized

    product = Product.create!
    patch "#{url}?api_key=#{get_token(product.id)}", params: { firmware: { title: 'test' } }
    assert_response :unauthorized

    BoardType.create!(fqbn: 'esp32:esp32:esp32', product_id: product.id, firmware_id: firmware.id)
    patch "#{url}?api_key=#{get_token(product.id)}", params: { firmware: { title: 'test' } }
    assert_response :success
  end

  test 'destroy' do
    firmware = create_firmware
    url = firmware_url(firmware.id)

    delete url
    assert_response :unauthorized

    delete "#{url}?api_key=#{get_token}"
    assert_response :unauthorized

    delete "#{url}?api_key=#{get_session}"
    assert_response :success
  end

  test 'content' do
    firmware = create_firmware
    url = "#{firmware_url(firmware.id)}/content"

    get url
    assert_response :unauthorized

    get "#{url}?api_key=#{get_session}"
    assert_response :bad_request

    product = Product.create!(auto_update: false)
    BoardType.create!(fqbn: 'esp32:esp32:esp32', product_id: product.id, firmware_id: firmware.id)

    get "#{url}?api_key=#{get_session}"
    assert_response :bad_request

    product.update!(auto_update: true)

    get "#{url}?api_key=#{get_session}"
    assert_response :redirect

    get "#{url}?api_key=#{get_token}"
    assert_response :unauthorized

    get "#{url}?api_key=#{get_token(product.id)}"
    assert_response :redirect
  end

  private

  def create_firmware
    Firmware.create!(
      fqbn: 'esp32:esp32:esp32',
      version: '1.0',
      content: fixture_file_upload('testfw.bin', 'application/octet-stream')
    )
  end
end
