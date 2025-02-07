# frozen_string_literal: true
class SolrDocument
  include Blacklight::Solr::Document
  include Geoblacklight::SolrDocument

  # self.unique_key = 'id'
  self.unique_key = Settings.FIELDS.UNIQUE_KEY

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  use_extension(Blacklight::Document::DublinCore)

  # Add method to retrieve IIIF manifest URL
  def iiif_manifest_url
    self['iiif_manifest_url_ssi']
  end
end
