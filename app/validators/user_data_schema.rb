UserDataSchema = Dry::Validation.Schema do
  required(:id).filled
  required(:url).filled
  required(:domain).filled
  required(:path).filled
  required(:visited_at).filled
end

