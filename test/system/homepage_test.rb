require "application_system_test_case"

class HomepageTest < ApplicationSystemTestCase
  def setup
    visit('/')
  end

  def test_basic_dom
    assert page.has_selector?('header')                 # Header
    assert page.has_selector?("[data-analytics-id]")    # Google Analytics
    assert page.has_selector?('ul.navbar-nav')          # Navbar
    assert page.has_selector?('footer')                 # Footer
  end

  def test_homepage_copy
    within('#application-nav ul.navbar-nav') do
      assert page.has_link?("About")
      assert page.has_link?("Get Help")
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
