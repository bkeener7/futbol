require_relative 'csv_loader'
require_relative 'teamid'

class LeagueStats < CSV_loader
  include TeamId

  def team_offense(team_header, goals_header, csv)
    team_offense = Hash.new(0)
    games_played = Hash.new(0)
    csv.each { |row| team_offense[row[team_header]] += row[goals_header].to_f
    games_played[row[team_header]] += 1 }
    offense_percent = team_offense.merge(games_played) { |_, goals, games_played| goals / games_played }
  end   

  def count_of_teams
    @all_teams.length
  end

  def best_offense
    team_id(team_offense(:team_id, :goals, @all_game_teams).max_by { |_, percent| percent }.first)
  end

  def worst_offense
    team_id(team_offense(:team_id, :goals, @all_game_teams).min_by { |_, percent| percent }.first)
  end

  def highest_scoring_visitor
    team_id(team_offense(:away_team_id, :away_goals, @all_games).max_by { |_, percent| percent }.first)
  end

  def highest_scoring_home_team
    team_id(team_offense(:home_team_id, :home_goals, @all_games).max_by { |_, percent| percent }.first)
  end

  def lowest_scoring_visitor
    team_id(team_offense(:away_team_id, :away_goals, @all_games).min_by { |_, percent| percent }.first)
  end

  def lowest_scoring_home_team
    team_id(team_offense(:home_team_id, :home_goals, @all_games).min_by { |_, percent| percent }.first)
  end 
end