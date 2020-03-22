namespace :heatmap do
  desc "Generate a heatmap once."
  task generate_once: :environment do
    GenerateHeatmapJob.perform_later
  end
end
