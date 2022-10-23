require 'csv'
require 'rspec'
require './lib/game_stats'

RSpec.describe GameStats do
  before(:each) do
    @gamestats = GameStats.from_csv_paths({ game_csv: './data/games.csv', gameteam_csv: './data/game_teams.csv',
                                            team_csv: './data/teams.csv' })
  end

  it '#highest_total_score' do
    expect(@gamestats.highest_total_score).to eq 11
  end

  it '#lowest_total_score' do
    expect(@gamestats.lowest_total_score).to eq 0
  end

  it '#percentage_home_wins' do
    expect(@gamestats.percentage_home_wins).to eq 0.44
  end

  it '#percentage_visitor_wins' do
    expect(@gamestats.percentage_visitor_wins).to eq 0.36
  end

  it '#percentage_ties' do
    expect(@gamestats.percentage_ties).to eq 0.20
  end

  it '#count_of_games_by_season' do
    expected = {
      '20122013' => 806,
      '20162017' => 1317,
      '20142015' => 1319,
      '20152016' => 1321,
      '20132014' => 1323,
      '20172018' => 1355
    }
    expect(@gamestats.count_of_games_by_season).to eq expected
  end

  it '#average_goals_per_game' do
    expect(@gamestats.average_goals_per_game).to eq 4.22
  end

  it '#average_goals_by_season' do
    expected = {
      '20122013' => 4.12,
      '20162017' => 4.23,
      '20142015' => 4.14,
      '20152016' => 4.16,
      '20132014' => 4.19,
      '20172018' => 4.44
    }
    expect(@gamestats.average_goals_by_season).to eq expected
  end
end
