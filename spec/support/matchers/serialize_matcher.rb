RSpec::Matchers.define :serialize do |attribute_name|
  match do |target|
    target.class.serialized_attributes.symbolize_keys.include?(attribute_name.to_sym)
  end
end