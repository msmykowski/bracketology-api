  page_html = RestClient.get "http://espn.go.com/mens-college-basketball/teams", :user_agent => 'chrome'
  page = Nokogiri::HTML(page_html)

  team_id_arr = []

  page.css('a').each do |link|
    if link.text == "Stats"
      team_id_arr.push(link.attr('href')[10..-1].gsub(/[^\d]/, ''))
    end
  end

  team_id_arr = team_id_arr[0..-2]

  team_main_link = "http://espn.go.com/mens-college-basketball/team/_/id/"

  ncaa_team_array = []

  team_id_arr.each do |link|
    team_array = []
    team_page = RestClient.get "#{team_main_link}#{link}"
    team_name = Nokogiri::HTML(team_page).css('#sub-branding b')
    noko_stats = Nokogiri::HTML(team_page).css('.mod-content')[3..10]

    team_array.push(team_name.text)
    team_array.push("http://a.espncdn.com/combiner/i?img=/i/teamlogos/ncaa/500/#{link}.png&w=80&h=80&transparent=true")

    noko_stats.css('.stat').each do |stat|
      team_array.push(stat.text)
    end

    noko_stats.css('strong').each do |ranking|
      team_array.push(ranking.text)
    end

    ncaa_team_array.push(team_array)
  end

  ncaa_team_array.each do |team|
    Team.update(name: team[0].encode( "UTF-8", "binary", :invalid => :replace, :undef => :replace), img_url: team[1], o_ppg: team[2], o_rpg: team[3], o_apg: team[4], o_fg: team[5], d_ppg: team[6], d_rpg: team[7], d_bpg: team[8], d_spg: team[9], o_ppg_rank: team[10], o_rpg_rank: team[11], o_apg_rank: team[12], o_fg_rank: team[13], d_ppg_rank: team[14], d_rpg_rank: team[15], d_bpg_rank: team[16], d_spg_rank: team[17])
  end

# add players

  def create_team(odd_array, even_array)
    team_players = []
    odd_array.each do |player|
      team_players.push(create_player(player))
    end

    even_array.each do |player|
      team_players.push(create_player(player))
    end

    team_players
  end

  def create_player(player)
    player_stats= []
    stats = player.css('td')
    stats.each do |stat|
      player_stats.push(stat.text)
    end
    player_stats
  end

  player_main_link = "http://espn.go.com/mens-college-basketball/team/stats/_/id/"

  ncaa_player_array = []

  team_id_arr.each do |link|
    restclient_link= RestClient.get "#{player_main_link}#{link}"
    stat = Nokogiri::HTML(restclient_link)
    table = stat.css('.tablehead')[0]
    odd_players = table.css('.oddrow')
    even_players = table.css('.evenrow')

    ncaa_player_array.push(create_team(odd_players, even_players))
    sleep(0.5)
  end

  team_index = 0
  player_id = 1
  ncaa_player_array.each do |team|
    team.each do |player|
      Player.create(name: player[0].encode( "UTF-8", "binary", :invalid => :replace, :undef => :replace), gp: player[1] , min: player[2] , ppg: player[3] , rpg: player[4] , apg: player[5] , spg: player[6] , bpg: player[7] , tpg: player[8] , fg: player[9] , ft: player[10] , threep: player[11], team_id: index )
    end
  end
