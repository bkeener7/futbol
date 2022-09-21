module TeamId
    def team_id(id)
      @all_teams.each{ |row| return row[:teamname] if row[:team_id] == id }
    end
end
