require_relative 'csv_loader'

class GameStats < CSV_loader

  def highest_total_score
    @all_games.map { |row| row[:away_goals].to_i + row[:home_goals].to_i }.max
  end

  def lowest_total_score
    @all_games.map { |row| row[:away_goals].to_i + row[:home_goals].to_i }.min
  end

  def percentage_home_wins
    home_wins = 0 && total_wins = 0
    @all_games.each { |row| home_wins += 1 if row[:home_goals].to_f > row[:away_goals].to_f
      total_wins += 1 }
    (home_wins.to_f/total_wins.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0 && total_wins = 0
    @all_games.each { |row|visitor_wins += 1 if row[:home_goals].to_f < row[:away_goals].to_f
    total_wins += 1 }
    (visitor_wins.to_f/total_wins.to_f).round(2)
  end

  def percentage_ties
    ties = 0 && total_wins = 0
    @all_games.each { |row| ties += 1 if row[:home_goals].to_f == row[:away_goals].to_f
      total_wins += 1 }
    (ties.to_f/total_wins.to_f).round(2)
  end

  def count_of_games_by_season
    seasons_with_games = Hash.new(0)
    @all_games.each { |row| seasons_with_games[row[:season]] += 1 }
    seasons_with_games
  end

  def average_goals_per_game
    total_games = 0 && average = 0 && total_goals = 0
    @all_games.each { |row| total_goals += row[:home_goals].to_i + row[:away_goals].to_i
    total_games += 1 }
    (total_goals.to_f / total_games.to_f).round(2)
  end

  def average_goals_by_season
    seasons_with_games = Hash.new(0) && seasons_averages = Hash.new(0)
    @all_games.each { |row| seasons_with_games[row[:season]] += (row[:away_goals].to_f + row[:home_goals].to_f) }
    seasons_with_games.map { |season_id, total_games| seasons_averages[season_id] = (total_games / self.count_of_games_by_season[season_id]).round(2) }
    seasons_averages
  end
end
