namespace :seed_data do
  desc "Delete simulated questionnaires."
  task delete_questionnaires: :environment do
    Questionnaire.where(simulated: true).delete_all
  end

  desc "Delete simulated heatmaps."
  task delete_heatmaps: :environment do
    # Will also propagate and delete the associated HeatmapValues due
    # to dependent: :delete_all
    Heatmap.where(simulated: true).destroy_all
  end
end
