require "spec_helper"

RSpec.describe Dry::Struct::Rails::Railtie do
  def clear_autoload
    Rails.application.reloader.reload!
    ActiveSupport::Dependencies.clear
  end

  before(:each) do |example|
    if example.metadata[:clear_autoload]
      clear_autoload
    end
  end

  describe "non-autoload" do
    context "schema" do
      it "has a schema" do
        expect(MyStruct.schema).to_not be_empty
      end

      it "does not loose the schema", :clear_autoload do
        expect(MyStruct.schema).to_not be_empty
        clear_autoload
        expect(MyStruct.schema).to_not be_empty
      end
    end

    context "attribute_names" do
      it "has attribute name foo" do
        expect(MyStruct.attribute_names).to contain_exactly(:me)
        clear_autoload
        expect(MyStruct.attribute_names).to contain_exactly(:me)
      end

      it "does not loose attribute name foo", :clear_autoload do
        expect(MyStruct.attribute_names).to contain_exactly(:me)
        clear_autoload
        expect(MyStruct.attribute_names).to contain_exactly(:me)
      end
    end

    context "Equalizer" do
      it "has Equalizer keys" do
        expect(MyStruct.equalizer.instance_variable_get(:@keys)).to contain_exactly(:me)
      end

      it "does not loose Equalizer keys", :clear_autoload do
        expect(MyStruct.equalizer.instance_variable_get(:@keys)).to contain_exactly(:me)
        clear_autoload
        expect(MyStruct.equalizer.instance_variable_get(:@keys)).to contain_exactly(:me)
      end
    end
  end

  describe "autoload" do
    before(:each) do
      Autoload::MyStruct
    end

    context "schema" do
      it "has a schema" do
        expect(Autoload::MyStruct.schema).to_not be_empty
      end

      it "does not loose the schema", :clear_autoload do
        expect(Autoload::MyStruct.schema).to_not be_empty
        clear_autoload
        expect(Autoload::MyStruct.schema).to_not be_empty
      end
    end

    context "attribute_names" do
      it "has attribute name foo" do
        expect(Autoload::MyStruct.attribute_names).to contain_exactly(:auto)
        clear_autoload
        expect(Autoload::MyStruct.attribute_names).to contain_exactly(:auto)
      end

      it "does not loose attribute name foo", :clear_autoload do
        expect(Autoload::MyStruct.attribute_names).to contain_exactly(:auto)
        clear_autoload
        expect(Autoload::MyStruct.attribute_names).to contain_exactly(:auto)
      end
    end

    context "Equalizer" do
      it "has Equalizer keys" do
        expect(Autoload::MyStruct.equalizer.instance_variable_get(:@keys)).to contain_exactly(:auto)
      end

      it "does not loose Equalizer keys", :clear_autoload do
        expect(Autoload::MyStruct.equalizer.instance_variable_get(:@keys)).to contain_exactly(:auto)
        clear_autoload
        expect(Autoload::MyStruct.equalizer.instance_variable_get(:@keys)).to contain_exactly(:auto)
      end
    end

    it "doesn't retain a refernce to the previous class" do
      class Autoload::MyStruct < Dry::Struct
        attribute :other, Dry::Types["strict.string"]
      end

      expect(Autoload::MyStruct.attribute_names).to contain_exactly(:auto, :other)
      clear_autoload
      expect(Autoload::MyStruct.attribute_names).to contain_exactly(:auto)
    end
  end
end
