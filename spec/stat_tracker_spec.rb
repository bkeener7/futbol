require 'rspec'
require 'csv'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:each) do
      @game_path = './data/games.csv'
      @team_path = './data/teams.csv'
      @game_teams_path = './data/game_teams.csv'

      @locations = {
          games: @game_path,
          teams: @team_path,
          game_teams: @game_teams_path
      }

      @stat_tracker = StatTracker.from_csv(@locations)
  end

  it '1. exists' do
      expect(@stat_tracker).to be_an_instance_of(StatTracker)
  end

  it '2. knows CSV locations' do
      expect(@stat_tracker.game_path).to eq('./data/games.csv')
  end

  it '3. can read the CSV files' do
      expect(@stat_tracker.list_team_ids.length).to eq(32)
  end

  it '4. can return team name from id' do
      expect(@stat_tracker.list_team_names_by_id(13)).to eq("Houston Dash")
  end

end
