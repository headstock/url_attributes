require "rails_helper"

describe "ActiveRecord::Base#url_attribute" do

  let(:model) { Model.new } 

  describe "a string URL attribute" do

    context "when it is not a valid URL" do
      it "is invalid" do
        ["example.com!", "example dot com", "http:example.com",
            "example.com/ ioajweoirjaer"].each do |url|
          model.url = url
          expect(model).not_to be_valid
        end
      end

      context "is just 'http://'" do
        it "is invalid" do
          model.url = "http://"
          expect(model).not_to be_valid
        end
      end

      context "is a valid URL (with or without 'http://')" do
        it "is valid" do
          ["example.com", "http://example.com", "subdomain.example.com",
                "example.com/blahblahblah", "  https://example.com "].each do |url|
            model.url = url
            expect(model).to be_valid
          end
        end
      end
    end

  end

  describe "before the model is saved" do
    context "when url does not begin with 'http://' or 'https://'" do
      it "adds 'http://'" do
        model.url = "example.com/example"
        model.run_callbacks :save
        expect(model.url).to eq "http://example.com/example"
      end
    end

    context "when url already begins with 'http://' or 'https://" do
      it "doesn't add http://" do
        model.url = "http://example.com/example"
        model.run_callbacks :save
        expect(model.url).to eq "http://example.com/example"

        model.url = "https://example.com/example"
        model.run_callbacks :save
        expect(model.url).to eq "https://example.com/example"
      end
    end

    context "when url has trailing whitespace" do
      it "strips it BEFORE adding 'http://'" do
        model.url = "    example.com/example     "
        model.run_callbacks :save
        # Make sure whitespace gets stripped BEFORE http is added!
        expect(model.url).to eq "http://example.com/example"
      end
    end
  end
end
