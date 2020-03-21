class HeatmapValue < ApplicationRecord
  # touch: true needed for caching
  # https://guides.rubyonrails.org/caching_with_rails.html
  belongs_to :heatmap, inverse_of: :heatmap_values, touch: true
end
