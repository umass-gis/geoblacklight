module ApplicationHelper

  # code from NYU to add curated collection to home page
  def construct_curated_collections
    collections = UMassGeoData::CuratedCollections.collections.shuffle[0..1]
    toReturn = "<div class=\"curated-collections\">
      <h4>Featured Collections</h4>
      <div class=\"row\">"
    collections.each do |collection|
      toReturn += create_collection_portion(collection)
    end
    toReturn += " </div>
    </div>"
    toReturn.html_safe
  end

  def create_collection_portion(collection)
    toReturn = link_to search_catalog_path({f: collection[:f]}), {class: "curated-card"} do
      "
    <div class=\"col-md-6\">
          <div class=\"card-collection\">
            <div class=\"card-block\">
              <h4 class=\"card-title\">#{collection[:title]}</h4>
              <p class=\"card-text\">#{collection[:description]}</p>
            </div>
          </div>
        </div>
    ".html_safe
    end
    toReturn.html_safe
  end

end
