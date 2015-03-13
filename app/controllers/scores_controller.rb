class ScoresController < ApplicationController

  def update_games
    last_game = Game.last
    if last_game.updated_at.to_i < (Time.now.to_i - 5)
      today_games = parse_games
      today_games.each do |game|
        update_game game
      end
    else
      today_games = Game.where("created_at>=? AND created_at<=?",last_game.created_at-5,last_game.created_at+5)
    end
    game_list = []
    today_games.each do |game|
      game = Game.find_by(espn_id:game[:espn_id])
      game_list.push(game.serialize)
    end
    render json: game_list
  end

  def update_game game
    db_game = Game.find_by(espn_id:game[:espn_id])
    if db_game
      bracket_check = BracketGame.where("(team_one_id=? AND team_two_id=?) OR (team_one_id=? AND team_two_id=?)",game[:home][:id],game[:away][:id],game[:away][:id],game[:home][:id])
      if bracket_check.length > 0
        bracket_check[0].update(game_id:db_game.id)
      end
      if game[:status].match(/[APM]{2}/)
      else
        home_score = game[:home][:score]
        db_game.home_obj[:team].update(wins:game[:home][:wins],losses:game[:home][:losses],rank:game[:home][:rank])
        db_game.home_obj[:score].update(first:home_score[:first],second:home_score[:second],ot:home_score[:ot],win:home_score[:win])
        away_score = game[:away][:score]
        db_game.away_obj[:team].update(wins:game[:away][:wins],losses:game[:away][:losses],rank:game[:away][:rank])
        db_game.away_obj[:score].update(first:away_score[:first],second:away_score[:second],ot:away_score[:ot],win:away_score[:win])
        db_game.update(status:game[:status])
      end
    else
      new_game = Game.new(espn_id:game[:espn_id],status:game[:status],home_team:game[:home][:id],away_team:game[:away][:id])
      if new_game.save
        bracket_check = BracketGame.where("(team_one_id=? AND team_two_id=?) OR (team_one_id=? AND team_two_id=?)",game[:home][:id],game[:away][:id],game[:away][:id],game[:home][:id])
        if bracket_check.length > 0
          bracket_check[0].update(game_id:new_game.id)
        end
        home_score = Score.new(game:new_game,first:0, second:0, ot:0, win:false,team:"home")
        away_score = Score.new(game:new_game,first:0, second:0, ot:0, win:false,team:"away")
        home_score.save
        away_score.save
        new_game.update(away_score:away_score.id,home_score:home_score.id)
      end
    end
  end

  def parse_games
    html = RestClient.get "http://scores.espn.go.com/ncb/scoreboard"
    html = Nokogiri::HTML(html)
    games = html.css('.score-row > div')
    games_list = []
    games.each do |game|
      game_data = process_game game
      games_list.push(game_data)
    end
    games_list
  end

  def process_game game
    game_id = parse_game_id game.css('span.sort')
    game_status = parse_game_status game.css('div.game-status')
    game_visitor = parse_game_team game.css('div.team.visitor')
    game_home = parse_game_team game.css('div.team.home')
    game = {
      espn_id:game_id,
      status:game_status,
      away:game_visitor,
      home:game_home
    }
    game
  end

  def parse_game_id id # don't want to chain all the functions because that looks kinda sorta dirty
    id = id[0]
    id = id.attr('id')
    id = id.split('-')
    id = id[0].to_i
  end

  def parse_game_status status
    status = status.css('p')
    status = status.text().strip()
    status
  end

  def parse_game_team team
    team_basic = team.css('.team-name')
    team_rank = team_basic.css('span')[0].text().to_i
    team_data = team_basic.css('span[id]')[0]
    team_name = team_data.text().strip()
    team_link = team_data.css('a')[0].attr('href')
    team_id = team_link.match(/\/id\/(\d+)\//)[1]
    record = team.css('.record').text()
    team_wins = record.match(/\((\d+-\d+),/)[1].split('-')[0].to_i
    team_losses = record.match(/\((\d+-\d+),/)[1].split('-')[1].to_i
    score = team.css('.score')
    first_quarter = score.css('li[id*="ls2"]').text().to_i
    second_quarter = score.css('li[id*="ls3"]').text().to_i
    ot = score.css('li[id*="ls4"]').text().to_i
    id = Team.find_by(espn_id:team_id).id
    if team.css('.winner-arrow').attr('style').text().match('none')
      outcome = false
    else
      outcome = true
    end
    team_data = {
      rank:team_rank,
      name:team_name,
      wins:team_wins,
      losses:team_losses,
      espn_id:team_id,
      id:id,
      score:{
        first:first_quarter,
        second:second_quarter,
        ot:ot,
        win:outcome
      }
    }
    team_data
  end

  def update_bracket game
    # teams = game.

  end

  # Team.all.each{|team| team.update(espn_id:team.img_url.match(/\/500\/(\d+).png/)[1]) }

end
