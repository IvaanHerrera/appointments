FactoryBot.define do
  factory :address do
    street { 'EJERCITO NACIONAL SN' }
    city { 'SAN CRISTOBAL DE LAS CASAS' }
    state { 'CHIAPAS' }
    zip_code { 29200 }
    country { 'MX' }
    primary { true }
  end
end
