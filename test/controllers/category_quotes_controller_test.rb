require "test_helper"

class CategoryQuotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category_quote = category_quotes(:one)
  end

  test "should get index" do
    get category_quotes_url
    assert_response :success
  end

  test "should get new" do
    get new_category_quote_url
    assert_response :success
  end

  test "should create category_quote" do
    assert_difference("CategoryQuote.count") do
      post category_quotes_url, params: { category_quote: { category_id: @category_quote.category_id, quote_id: @category_quote.quote_id } }
    end

    assert_redirected_to category_quote_url(CategoryQuote.last)
  end

  test "should show category_quote" do
    get category_quote_url(@category_quote)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_quote_url(@category_quote)
    assert_response :success
  end

  test "should update category_quote" do
    patch category_quote_url(@category_quote), params: { category_quote: { category_id: @category_quote.category_id, quote_id: @category_quote.quote_id } }
    assert_redirected_to category_quote_url(@category_quote)
  end

  test "should destroy category_quote" do
    assert_difference("CategoryQuote.count", -1) do
      delete category_quote_url(@category_quote)
    end

    assert_redirected_to category_quotes_url
  end
end
