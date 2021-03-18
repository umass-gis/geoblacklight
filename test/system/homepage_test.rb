require "application_system_test_case"

class HomepageTest < ApplicationSystemTestCase
  def setup
    visit('/')
  end

  def test_basic_dom
    assert page.has_selector?('header') # Global Header
    assert page.has_selector?('ul.navbar-nav')          # Navbar
    assert page.has_selector?('footer') # Global Footer
  end

  def test_homepage_copy
    within('ul.navbar-nav') do
      assert page.has_link?("About")
      assert page.has_link?("Contact")
      assert page.has_link?("Help")
    end
  end

  def test_homepage_search
    within('form.search-query-form') do
      fill_in('q', with: 'water')
      click_button 'Search'
    end

    assert page.has_content?('Search Results')
  end
end
