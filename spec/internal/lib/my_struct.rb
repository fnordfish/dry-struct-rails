class MyStruct < Dry::Struct
  attribute :me, Dry::Types["strict.string"]
end
