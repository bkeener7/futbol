require 'rspec'
require 'csv'
require './lib/csv_loader'

RSpec.describe CSV_loader do
    it 'exists' do
      @game_path = './data/games.csv'
      @team_path = './data/teams.csv'
      @game_teams_path = './data/game_teams.csv'

      @locations = {
          game_csv: @game_path,
          team_csv: @team_path,
          gameteam_csv: @game_teams_path
        }

      @csv_loader = CSV_loader.from_csv_paths(@locations)
      expect(@csv_loader).to be_an_instance_of(CSV_loader)
    end
end
