require 'csv'
require_relative 'league_stats'
require_relative 'game_stats'
require_relative 'season_stats'
require_relative 'team_stats'
require_relative 'attr_readable'

class StatTracker
  include AttrReadable

  def initialize(game_path, team_path, game_teams_path)
    @locations = {
      game_csv: game_path,
      team_csv: team_path,
      gameteam_csv: game_teams_path
    }

    @league_stats = LeagueStats.from_csv_paths(@locations)
    @season_stats = SeasonStats.from_csv_paths(@locations)
    @team_stats = TeamStats.from_csv_paths(@locations)
    @game_stats = GameStats.from_csv_paths(@locations)

    @highest_total_score = @game_stats.highest_total_score
    @lowest_total_score = @game_stats.lowest_total_score
    @percentage_home_wins = @game_stats.percentage_home_wins
    @percentage_visitor_wins = @game_stats.percentage_visitor_wins
    @percentage_ties = @game_stats.percentage_ties
    @count_of_games_by_season = @game_stats.count_of_games_by_season
    @average_goals_per_game = @game_stats.average_goals_per_game
    @average_goals_by_season = @game_stats.average_goals_by_season
    @count_of_teams = @league_stats.count_of_teams
    @best_offense = @league_stats.best_offense
    @worst_offense = @league_stats.worst_offense
    @highest_scoring_visitor = @league_stats.highest_scoring_visitor
    @highest_scoring_home_team = @league_stats.highest_scoring_home_team
    @lowest_scoring_visitor = @league_stats.lowest_scoring_visitor
    @lowest_scoring_home_team = @league_stats.lowest_scoring_home_team
  end

  def self.from_csv(locations)
    StatTracker.new(locations[:games], locations[:teams], locations[:game_teams])
  end

  def winningest_coach(season)
    @season_stats.winningest_coach(season)
  end

  def worst_coach(season)
    @season_stats.worst_coach(season)
  end

  def most_accurate_team(season)
    @season_stats.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @season_stats.least_accurate_team(season)
  end

  def most_tackles(season)
    @season_stats.most_tackles(season)
  end

  def fewest_tackles(season)
    @season_stats.fewest_tackles(season)
  end

  def team_info(id)
    @team_stats.team_info(id)
  end

  def best_season(id)
    @team_stats.best_season(id)
  end

  def worst_season(id)
    @team_stats.worst_season(id)
  end

  def average_win_percentage(id)
    @team_stats.average_win_percentage(id)
  end

  def most_goals_scored(id)
    @team_stats.most_goals_scored(id)
  end

  def fewest_goals_scored(id)
    @team_stats.fewest_goals_scored(id)
  end

  def favorite_opponent(id)
    @team_stats.favorite_opponent(id)
  end

  def rival(id)
    @team_stats.rival(id)
  end
end
