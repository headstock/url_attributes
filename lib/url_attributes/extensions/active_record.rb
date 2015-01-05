# Use:
#
#     # Model with string attributes called 'checkout_url' and 'homepage_url'
#     class Example < ActiveRecord::Base
#
#       url_attribute :checkout_url, :homepage_url
#
#     end
#
# The above will cause the attribute 'url' to be validated with URLValidator (NB
# the validation will pass if no URL is present), and it will have 'http://'
# added it to it if it's not provided.
module URLAttributes
  module ActiveRecord

    def url_attribute(attribute_name, before: :save)
      validates attribute_name, :url => true, :if => "#{attribute_name}.present?"

      callback_method = :"before_#{before}"
        
      # Add "http://" to the URL if it's not already there.
      send(callback_method) do |record|
        url = record[attribute_name]
        if url.present? && !(url =~ /\A\s*https?:\/\//)
          url = "http://#{url.try(:strip)}"
        end
        record[attribute_name] = url
      end

    end

  end
end

ActiveRecord::Base.send(:extend, URLAttributes::ActiveRecord)
