# Use:
#
#     # Model with string attributes called 'checkout_url' and 'homepage_url'
#     class Example < ActiveRecord::Base
#
#       urlify :checkout_url, :homepage_url
#
#     end
#
# The above will cause the attribute 'url' to be validated with URLValidator (NB
# the validation will pass if no URL is present), and it will have 'http://'
# added it to it if it's not provided.
module URLAttributes
  module ActiveRecord

    def urlify(*attributes)
      attributes.each do |url_attribute|

        validates url_attribute, :url => true, :if => "#{url_attribute}.present?"

        # Add "http://" to the URL if it's not already there.
        before_save do |record|
          url = record[url_attribute]
          if url.present? && !(url =~ /\A\s*https?:\/\//)
            url = "http://#{url.try(:strip)}"
          end
          record[url_attribute] = url
        end
      end
    end

  end
end

ActiveRecord::Base.send(:extend, URLify)
