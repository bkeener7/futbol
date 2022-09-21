require_relative 'csv_loader'

class TeamStats < CSV_loader

  def team_info(id)
    team_hash = Hash.new(0)
    @all_teams.each { |row|
      if row[:team_id] == id
        team_hash['team_id'] = row[:team_id]
        team_hash['franchise_id'] = row[:franchiseid]
        team_hash['team_name'] = row[:teamname]
        team_hash['abbreviation'] = row[:abbreviation]
        team_hash['link'] = row[:link]
      end
    }
    team_hash
  end

  def best_season(id)
    team_seasons = Hash.new(0)
    @all_game_teams.each do |row|
    if row[:team_id] == id && row[:result] == "WIN"
      season = @all_games.find { |game| game[:game_id] == row[:game_id] }
      team_seasons[season[:season]] += 1
      end
    end
    team_seasons.key(team_seasons.values.max)
  end

  def worst_season(id)
    team_seasons = Hash.new(0)
    @all_game_teams.each do |row|
    if row[:team_id] == id
      if row[:result] == "WIN"
        season = @all_games.find { |game| game[:game_id] == row[:game_id] }
        team_seasons[season[:season]] += 1
        end
      end
    end
    team_seasons.key(team_seasons.values.min)
  end

  def average_win_percentage(id)
    total_games = 0 && total_wins = 0
    @all_game_teams.each do |row|
    if row[:team_id] == id
      total_games += 1
      total_wins += 1 if row[:result] == "WIN"
      end
    end
    (total_wins.to_f / total_games.to_f).round(2)
  end

  def most_goals_scored(id)
    highest_score = 0
    @all_game_teams.each { |row| if row[:team_id] == id
    highest_score = row[:goals].to_i if row[:goals].to_i > highest_score end }
    highest_score
  end

  def fewest_goals_scored(id)
    lowest_score = self.most_goals_scored(id)
    @all_game_teams.each { |row| if row[:team_id] == id
    lowest_score = row[:goals].to_i if row[:goals].to_i < lowest_score end }
    lowest_score
  end

  def favorite_opponent(id)
    games_played = []
    @all_game_teams.each { |row| games_played << row[:game_id] if row[:team_id] == id }
    opponent_history = Hash.new {|h, k| h[k] = {"wins"=>0, "losses"=>0, "ties"=>0, "total games played" => 0}}
    @all_game_teams.each do |row|
    if games_played.include?(row[:game_id]) && if row[:team_id] != id
      opponent_history[row[:team_id]]["wins"] += 1 if row[:result] == "WIN"
      opponent_history[row[:team_id]]["losses"] += 1 if row[:result] == "LOSS"
      opponent_history[row[:team_id]]["ties"] += 1 if row[:result] == "TIE"
      opponent_history[row[:team_id]]["total games played"] += 1
      end
     end
    end
    winless_opponents = Hash.new {|h, k| h[k] = 0}
    win_ratios_against_opponents = Hash.new {|h, k| h[k] = 0.0}
    opponent_history.each do |team_id, opponent_results|
    if opponent_results["wins"] == 0 && opponent_results["losses"] > 0
      winless_opponents[team_id] += 1
      else
        win_ratios_against_opponents[team_id] = opponent_results["losses"].to_f / opponent_results["wins"].to_f
      end
    end
    if winless_opponents.length > 0
      sorted_winless_opponents = winless_opponents.sort_by {|k, v| v}
      favorite_id = sorted_winless_opponents.first[0]
      return @all_teams.find {|row| row[:team_id] == favorite_id}[:teamname]
    else
      win_ratios_against_opponents.sort_by {|k, v| v}
      favorite_id = sorted_winless_opponents.first[0]
      return @all_teams.find {|row| row[:team_id] == favorite_id}[:teamname]
    end
  end

  def rival(id)
    games_played = []
    @all_game_teams.each { |row| games_played << row[:game_id] if row[:team_id] == id }
    opponent_history = Hash.new {|h, k| h[k] = {"wins"=>0, "losses"=>0, "ties"=>0, "total games played" => 0}}
    @all_game_teams.each do |row|
    if games_played.include?(row[:game_id]) && row[:team_id] != id
      opponent_history[row[:team_id]]["wins"] += 1 if row[:result] == "WIN"
      opponent_history[row[:team_id]]["losses"] += 1 if row[:result] == "LOSS"
      opponent_history[row[:team_id]]["ties"] += 1 if row[:result] == "TIE"
      opponent_history[row[:team_id]]["total games played"] += 1
     end
    end
    winless_opponents = Hash.new {|h, k| h[k] = 0}
    win_ratios_against_opponents = Hash.new {|h, k| h[k] = 0.0}
    opponent_history.each do |team_id, opponent_results|
    if opponent_results["losses"] == 0 && opponent_results["wins"] > 0
      winless_opponents[team_id] += 1
     else
      win_ratios_against_opponents[team_id] = opponent_results["wins"].to_f / opponent_results["total games played"].to_f
     end
    end
    if winless_opponents.length > 0
      sorted_winless_opponents = winless_opponents.sort_by {|k, v| v}
      favorite_id = sorted_winless_opponents.last[0]
      return @all_teams.find {|row| row[:team_id] == favorite_id}[:teamname]
    else
      sorted_opponents = win_ratios_against_opponents.sort_by {|k, v| v}
      favorite_id = sorted_opponents.last[0]
      return @all_teams.find {|row| row[:team_id] == favorite_id}[:teamname]
    end
  end
end
