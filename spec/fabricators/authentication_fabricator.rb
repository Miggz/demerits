Fabricator(:authentication) do
  uid { sequence(:uid) { |n| "uid-#{n}" } }
end
