# Write your code here!
require "pry"

def game_hash
  game = {}
  game[:home] = {}
  game[:away] = {}
  game[:home][:team_name] = "Brooklyn Nets"
  game[:away][:team_name] = "Charlotte Hornets"
  game[:home][:colors] = ["Black", "White"]
  game[:away][:colors] = ["Turquoise", "Purple"]
  game[:home][:players] = [
    {
      name: "Alan Anderson", 
      team: "Brooklyn Nets", 
      number: 0,
      shoe: 16,
      points: 22,
      rebounds: 12,
      assists: 12,
      steals: 3,
      blocks: 1,
      slam_dunks: 1
    },
    { 
      name: "Reggie Evans", 
      team: "Brooklyn Nets", 
      number: 30,
      shoe: 14,
      points: 12,
      rebounds: 12,
      assists: 12,
      steals: 12,
      blocks: 12,
      slam_dunks: 7
    },
    { 
      name: "Mason Plumlee", 
      team: "Brooklyn Nets", 
      number: 1,
      shoe: 19,
      points: 26,
      rebounds: 12,
      assists: 6,
      steals: 3,
      blocks: 8,
      slam_dunks: 5
    },
    { 
      name: "Brook Lopez", 
      team: "Brooklyn Nets", 
      number: 11,
      shoe: 17,
      points: 17,
      rebounds: 19,
      assists: 10,
      steals: 3,
      blocks: 1,
      slam_dunks: 15
    },    
    { 
      name: "Jason Terry", 
      team: "Brooklyn Nets", 
      number: 31,
      shoe: 15,
      points: 19,
      rebounds: 2,
      assists: 2,
      steals: 4,
      blocks: 11,
      slam_dunks: 1
    }              
  ]
  game[:away][:players] = [
    {
      name: "Jeff Adrien", 
      team: "Charlotte Hornets", 
      number: 4,
      shoe: 18,
      points: 10,
      rebounds: 1,
      assists: 1,
      steals: 2,
      blocks: 7,
      slam_dunks: 2
    },
    { 
      name: "Bismak Biyombo", 
      team: "Charlotte Hornets", 
      number: 0,
      shoe: 16,
      points: 12,
      rebounds: 4,
      assists: 7,
      steals: 7,
      blocks: 15,
      slam_dunks: 10
    },
    { 
      name: "DeSagna Diop", 
      team: "Charlotte Hornets", 
      number: 2,
      shoe: 14,
      points: 24,
      rebounds: 12,
      assists: 12,
      steals: 4,
      blocks: 5,
      slam_dunks: 5
    },
    { 
      name: "Ben Gordon", 
      team: "Charlotte Hornets", 
      number: 8,
      shoe: 15,
      points: 33,
      rebounds: 3,
      assists: 2,
      steals: 1,
      blocks: 1,
      slam_dunks: 0
    },
    { 
      name: "Brendan Haywood", 
      team: "Charlotte Hornets", 
      number: 33,
      shoe: 15,
      points: 6,
      rebounds: 12,
      assists: 12,
      steals: 22,
      blocks: 5,
      slam_dunks: 12
    }         
  ]
  game
end

def num_points_scored(player_name)
  if game_hash[:home][:players].any?{ |player| player[:name] == player_name}
    team = :home
  else
    team = :away
  end
  player_data = game_hash[team][:players].find {|player| player[:name] == player_name}
  player_data[:points]
end

def shoe_size(player_name)
  if game_hash[:home][:players].any?{ |player| player[:name] == player_name}
    team = :home
  else
    team = :away
  end
  player_data = game_hash[team][:players].find {|player| player[:name] == player_name}
  player_data[:shoe]  
end

def team_colors(team_name)
  if game_hash[:home][:team_name] == team_name
    team = :home
  else
    team = :away
  end
  game_hash[team][:colors]
end

def team_names
  [game_hash[:home][:team_name], game_hash[:away][:team_name]]
end

def player_numbers(team_name)
  if game_hash[:home][:team_name] == team_name
    team = :home
  else
    team = :away
  end  
  game_hash[team][:players].collect { |player| player[:number]  }
end

def player_stats(player_name)
   if game_hash[:home][:players].any?{ |player| player[:name] == player_name}
    team = :home
  else
    team = :away
  end
  player_data = game_hash[team][:players].find {|player| player[:name] == player_name}
  player_data.delete(:name)
  player_data.delete(:team)
  player_data
end

def big_shoe_rebounds
  shoe_sizes_home = game_hash[:home][:players].collect{|player| player[:shoe]}
  shoe_sizes_away = game_hash[:away][:players].collect{|player| player[:shoe]}
  all_shoe_sizes = shoe_sizes_home.concat(shoe_sizes_away)
  max_shoe_size = all_shoe_sizes.max
  if shoe_sizes_home.include?(max_shoe_size)
    player_data = game_hash[:home][:players].find{|player| player[:shoe] == max_shoe_size}
  else
    player_data = game_hash[:away][:players].find{|player| player[:shoe] == max_shoe_size}    
  end
  player_data[:rebounds]
end

def most_points_scored
  most_points = 0
  player_with_most_points = ""
  game_hash.each do |team_key, team|
    game_hash[team_key][:players].each do |stats|
      if stats[:points] > most_points
        most_points = stats[:points]
        player_with_most_points = stats[:name]
      end
    end
  end
  player_with_most_points
end

def winning_team
  home_points = game_hash[:home][:players].each_with_object([]){|data, arr| arr << data[:points]}.inject(0){|sum, points| sum + points}
  away_points = game_hash[:away][:players].each_with_object([]){|data, arr| arr << data[:points]}.inject(0){|sum, points| sum + points}
  if home_points > away_points
    game_hash[:home][:team_name]
  else
    game_hash[:away][:team_name]
  end
end

def player_with_longest_name
  player_names = []
  game_hash.each{|key, team| team[:players].each{|player| player_names << player[:name]}}
  longest_name = ""
  player_names.each do |player|
    if player.length > longest_name.length
      longest_name = player
    end
  end
  longest_name
end

def long_name_steals_a_ton?
  most_steals = 0
  player_with_most_steals = ""
  game_hash.each do |team_key, team|
    game_hash[team_key][:players].each do |stats|
      if stats[:steals] > most_steals
        most_steals = stats[:steals]
        player_with_most_steals = stats[:name]
      end
    end
  end 
  player_with_most_steals == player_with_longest_name
end