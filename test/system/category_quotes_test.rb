require "application_system_test_case"

class CategoryQuotesTest < ApplicationSystemTestCase
  setup do
    @category_quote = category_quotes(:one)
  end

  test "visiting the index" do
    visit category_quotes_url
    assert_selector "h1", text: "Category quotes"
  end

  test "should create category quote" do
    visit category_quotes_url
    click_on "New category quote"

    fill_in "Category", with: @category_quote.category_id
    fill_in "Quote", with: @category_quote.quote_id
    click_on "Create Category quote"

    assert_text "Category quote was successfully created"
    click_on "Back"
  end

  test "should update Category quote" do
    visit category_quote_url(@category_quote)
    click_on "Edit this category quote", match: :first

    fill_in "Category", with: @category_quote.category_id
    fill_in "Quote", with: @category_quote.quote_id
    click_on "Update Category quote"

    assert_text "Category quote was successfully updated"
    click_on "Back"
  end

  test "should destroy Category quote" do
    visit category_quote_url(@category_quote)
    click_on "Destroy this category quote", match: :first

    assert_text "Category quote was successfully destroyed"
  end
end
