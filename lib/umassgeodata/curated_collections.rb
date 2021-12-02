module UMassGeoData
  class CuratedCollections

    def CuratedCollections.collections
      [
          {title: "New York City Open Data", description: "A collection of datasets related to NYC infrastructure, real estate, transportation, and political geography", f: { "dc_rights_s" => ["Public"], "dct_spatial_sm" => ["New York, New York, United States"]}},
          {title: "NYU Research Data", description: "Geospatial data submitted for preservation by NYU students, faculty, and staff", f: {"dct_isPartOf_sm" => ["NYU Research Data"]}},
          #{title: "U.S. Census Data", description: "Datasets which package data from the U.S. Census, or American Community Survey, along with geographic boundaries", f: {"dct_isPartOf_sm" => ["United States Census Data"]}},
          #{title: "Soviet Topographic Maps of the Arabian Peninsula", description: "Raster scans of Soviet military topographic maps produced in the late 1970s", f: { "dc_publisher_s" => ["Omni Resources (Firm)"]}}
          {title: "Latin American Census Geodatabases", description: "ESRI Geodatabases of census data from Latin American countries", f: {"dct_isPartOf_sm" => ["Latin American Census Data"]}},
          {title: "Vector Map 1 (VMap1) Layers", description: "Highly detailed vector layers depecting terrain, topology, transportation, and civil infrastructure", f: {"dct_isPartOf_sm" => ["VMap 1"]}},
      ]
    end

  end
end
