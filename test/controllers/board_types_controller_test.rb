require 'test_helper'

class BoardTypesControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    url = board_types_url

    get url
    assert_response :unauthorized

    get "#{url}?api_key=#{get_session}"
    assert_response :success

    get "#{url}?api_key=#{get_token}"
    assert_response :unauthorized
  end

  test 'versions' do
    product = Product.create!
    board_type = BoardType.create!(fqbn: 'esp32:esp32:esp32', product_id: product.id)
    url = board_types_url(board_type.id)

    get url
    assert_response :unauthorized

    get "#{url}?api_key=#{get_session}"
    assert_response :success

    get "#{url}?api_key=#{get_token}"
    assert_response :unauthorized

    get "#{url}?api_key=#{get_token(product.id)}"
    assert_response :unauthorized
  end
end
