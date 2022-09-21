require 'csv'
require 'rspec'
require './lib/league_stats.rb'

RSpec.describe LeagueStats do
  before(:each) do
    @leaguestats = LeagueStats.from_csv_paths({game_csv:'./data/games.csv', gameteam_csv:'./data/game_teams.csv', team_csv:'./data/teams.csv'})
  end

  it 'calculates offensive percent'do

    expected = {"3"=>2.1261770244821094,
      "6"=>2.2627450980392156,
      "5"=>2.286231884057971,
      "17"=>2.0593047034764824,
      "16"=>2.1647940074906367,
      "9"=>2.105476673427992,
      "8"=>2.0461847389558234,
      "30"=>2.1155378486055776,
      "26"=>2.0841487279843443,
      "19"=>2.106508875739645,
      "24"=>2.1954022988505746,
      "2"=>2.184647302904564,
      "15"=>2.212121212121212,
      "20"=>2.0676532769556024,
      "14"=>2.2203065134099615,
      "28"=>2.186046511627907,
      "4"=>2.0377358490566038,
      "21"=>2.0658174097664546,
      "25"=>2.2243186582809225,
      "13"=>2.0581896551724137,
      "18"=>2.146198830409357,
      "10"=>2.1066945606694563,
      "29"=>2.166315789473684,
      "52"=>2.173277661795407,
      "54"=>2.343137254901961,
      "1"=>1.9352051835853132,
      "23"=>1.9722222222222223,
      "12"=>2.0436681222707422,
      "27"=>2.023076923076923,
      "7"=>1.8362445414847162,
      "22"=>2.0467091295116773,
      "53"=>1.8902439024390243}

      expect(@leaguestats.team_offense(:team_id, :goals, @leaguestats.all_game_teams)).to eq(expected)
  end

  it '#count_of_teams'do
    expect(@leaguestats.count_of_teams).to eq 32
  end

  it '#best_offense' do
    expect(@leaguestats.best_offense).to eq "Reign FC"
  end

  it '#worst_offense' do
    expect(@leaguestats.worst_offense).to eq "Utah Royals FC"
  end

  it '#highest_scoring_visitor' do
    expect(@leaguestats.highest_scoring_visitor).to eq "FC Dallas"
  end

  it '#highest_scoring_home_team' do
    expect(@leaguestats.highest_scoring_home_team).to eq "Reign FC"
  end

  it '#lowest_scoring_visitor' do
    expect(@leaguestats.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  end


  it '#lowest_scoring_home_team' do
    expect(@leaguestats.lowest_scoring_home_team).to eq "Utah Royals FC"
  end
end
