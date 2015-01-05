class Model < ActiveRecord::Base
  url_attribute :url

  url_attribute :other_url, before: :validation
end
