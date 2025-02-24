module HasNormalizedId
  extend ActiveSupport::Concern

  def normalized_id
    id.to_s.rjust(4, '0')
  end
end
