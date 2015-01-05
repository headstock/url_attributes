if defined?(RSpec)
  RSpec::Matchers.define :have_url_attribute do |attribute_name|
    # This matcher is an ugly piece of shit
    match do |model|
      model.send :"#{attribute_name}=", "notavalidurl"
      model.valid?
      test_0 = model.errors[attribute_name].include?("is not a valid URL")
      model.send :"#{attribute_name}=", "http://validurl.com"
      model.valid?
      test_1 = !model.errors[attribute_name].include?("is not a valid URL")
      model.send :"#{attribute_name}=", "nohttp.com"
      if @checked_before
        model.run_callbacks @checked_before
      else
        model.run_callbacks :save
      end
      test_2 = model.send(attribute_name) == "http://nohttp.com"
      test_0 && test_1 && test_2
    end

    failure_message do |model|
      "expected that #{model} would have a URL attribute called #{attribute_name}, but it doesn't look like a URL"
    end

    chain(:checked_before) { |callback| @checked_before = callback }
  end
end
