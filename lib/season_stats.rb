require_relative 'csv_loader'
require_relative 'teamid'

class SeasonStats < CSV_loader
  include TeamId

  def coach_stats(season)
    coach_records = Hash.new { |coach, outcomes| coach[outcomes] = [] }
    @all_game_teams.each do |row|
      coach_records[row[:head_coach]].push(row[:result]) if row[:game_id].start_with?(season[0..3])
    end
    coach_records.map { |coach, outcomes| [coach, outcomes = (outcomes.count('WIN').to_f / outcomes.count)] }
  end

  def team_accuracy(season)
    team_goals = Hash.new { |team, goals| team[goals] = [] }
    team_shots = Hash.new { |team, shots| team[shots] = [] }
    @all_game_teams.each do |row|
      if row[:game_id].start_with?(season[0..3])
        team_goals[row[:team_id]].push(row[:goals].to_f) && team_shots[row[:team_id]].push(row[:shots].to_f)
      end
    end
    team_goals.transform_values(&:sum).merge(team_shots.transform_values(&:sum)) { |_team, goals, shots| goals / shots }
  end

  def tackle_stats(season)
    tackle_records = Hash.new(0)
    @all_game_teams.each do |row|
      tackle_records[row[:team_id]] += row[:tackles].to_i if row[:game_id].start_with?(season[0..3])
    end
    tackle_records
  end

  def winningest_coach(season)
    coach_stats(season).max_by { |_, percent| percent }.first
  end

  def worst_coach(season)
    coach_stats(season).min_by { |_, percent| percent }.first
  end

  def most_accurate_team(season)
    team_id(team_accuracy(season).max_by { |_, percent| percent }.first)
  end

  def least_accurate_team(season)
    team_id(team_accuracy(season).min_by { |_, percent| percent }.first)
  end

  def most_tackles(season)
    team_id(tackle_stats(season).max_by { |_, tackles| tackles }.first)
  end

  def fewest_tackles(season)
    team_id(tackle_stats(season).min_by { |_, tackles| tackles }.first)
  end
end
