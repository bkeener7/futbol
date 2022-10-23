require 'csv'

class CSV_loader
  attr_reader :all_game_teams,
              :all_games,
              :all_teams

  @all_teams
  @all_games
  @all_game_teams

  def initialize(csvs)
    @all_teams = []
    @all_games = []
    @all_game_teams = []
    csvs[:game_csv].each { |row| @all_games << row }
    csvs[:gameteam_csv].each { |row| @all_game_teams << row }
    csvs[:team_csv].each { |row| @all_teams << row }
  end

  def self.from_csv_paths(file_paths)
    files = {
      game_csv: CSV.read(file_paths[:game_csv], headers: true, header_converters: :symbol),
      gameteam_csv: CSV.read(file_paths[:gameteam_csv], headers: true, header_converters: :symbol),
      team_csv: CSV.read(file_paths[:team_csv], headers: true, header_converters: :symbol)
    }
    new(files)
  end
end
