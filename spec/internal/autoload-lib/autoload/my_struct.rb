module Autoload
  class MyStruct < Dry::Struct
    attribute :auto, Dry::Types["strict.string"]
  end
end
