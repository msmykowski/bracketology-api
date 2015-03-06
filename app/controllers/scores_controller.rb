class ScoresController < ApplicationController

  def seed
    html = RestClient.get "http://scores.espn.go.com/ncb/scoreboard"
    html = Nokogiri::HTML(html)
    games = html.css('.score-row > div')
    games_list = []
    games.each do |game|
      game_data = process_game game
      games_list.push(game_data)
    end
    render json: games_list
  end

  def process_game game
    game_id = parse_game_id game.css('span.sort')
    game_status = parse_game_status game.css('div.game-status')
    game_visitor = parse_game_team game.css('div.team.visitor')
    game_home = parse_game_team game.css('div.team.home')
    game = {
      id:game_id,
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
    score = team.css('.score')
    first_quarter = score.css('li[id*="ls2"]').text().to_i
    second_quarter = score.css('li[id*="ls3"]').text().to_i
    ot = score.css('li[id*="ls4"]').text().to_i
    if team.css('.winner-arrow').attr('style').text().match('none')
      outcome = 'loss'
    else
      outcome = 'win'
    end
    team_data = {
      rank:team_rank,
      name:team_name,
      id:team_id,
      score:{
        first:first_quarter,
        second:second_quarter,
        ot:ot,
        outcome:outcome
      }
    }
    team_data
  end

end
