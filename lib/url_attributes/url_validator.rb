class URLValidator < ActiveModel::EachValidator

  def validate_each(record, attribute_name, url)
    @record = record
    @attribute_name = attribute_name
    if url.blank? || !url.respond_to?(:strip) || !(url =~ /\./)
      invalid
      return
    end
    url = "http://#{url.strip}" unless /\Ahttps?:\/\// =~ url
    uri = URI.parse(url) # This can raise a URI::InvalidURIError
    invalid unless uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
  rescue URI::InvalidURIError
    invalid
  end

  private

  def invalid
    @record.errors.add @attribute_name, "is not a valid URL"
  end

end
