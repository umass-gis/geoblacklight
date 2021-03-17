require "application_system_test_case"

class ShowPageTest < ApplicationSystemTestCase
  def setup
  end

  def test_basic_dom
    visit "/catalog/umass-mufs190-1951-dpn1k100-i001"

    within("section.show-document") do
      assert page.has_selector?("div#document")
    end
    within("section.show-document") do
      assert page.has_selector?("h2")                       # Title
      assert page.has_selector?("dl.document-metadata")     # Metadata
      assert page.has_selector?("div#viewer-container")     # Viewer
    end
    within("div#viewer-container") do
      assert page.has_selector?("h3.help-text")             # Help Text
      assert page.has_selector?("div#map")                  # Map
    end
    assert page.has_selector?("section.page-sidebar")       # Sidebar
    within("section.page-sidebar") do
      assert page.has_selector?("div.show-tools")           # Tools
      assert page.has_no_link?("Bookmark")
      assert page.has_selector?("div.downloads")            # Downloads
    end
  end

  def test_show_page_search_nav
    visit '/?utf8=✓&q=&search_field=all_fields'
    within("div#documents") do
      find("a", match: :first).click
    end

    within("#appliedParams") do
      assert page.has_link?("Start Over")                    # Start over
      assert page.has_link?("Back to Search")                # Back to search
    end

    within('.pagination-search-widgets') do
      assert page.has_selector?("div.page-links")            # Pagination
    end
  end
end
