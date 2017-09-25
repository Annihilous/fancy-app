puts
puts '*' * 144
puts '*' * 144
puts 'PumpRocket!!!!'
puts '*' * 144
puts '*' * 144
puts
puts 'Input project name:'
project_name = gets.chomp

puts 'Input github username:'
github_username = gets.chomp

puts 'Is this a PolarNotion app? (y/n)'
polar_notion_app_input = gets.chomp.to_s[0].downcase
is_polar_notion_app    = polar_notion_app_input == 'y' ? true : false

command_1  = %Q<  curl -u '#{github_username}' https://api.github.com/user/repos -d '{ "name" : "#{project_name}" }'  >
command_2  = %Q<  git remote remove origin  >
command_3  = %Q<  git remote add origin git@github.com:#{github_username}/#{project_name}.git  >
command_4  = %Q<  git push -u origin master  >
command_5  = %Q<  heroku create #{project_name}-staging    --remote staging                 #{'--org polarnotion' if is_polar_notion_app}  >
command_6  = %Q<  heroku create #{project_name}-production --remote production              #{'--org polarnotion' if is_polar_notion_app}  >
command_7  = %Q<  heroku pipelines:create -a #{project_name}-staging    --stage staging     #{'--org polarnotion' if is_polar_notion_app}  >
command_8  = %Q<  heroku pipelines:add #{project_name} -a #{project_name}-production --stage production  >
command_9  = %Q<  git push staging     >
command_10 = %Q<  git push production  >

def execute_with_starz(command)
  puts
  puts '*' * 144
  puts "Running command..."
  puts command
  puts '*' * 144

  system( command )
end

[ #command
  command_1,
  command_2,
  command_3,
  command_4,
  command_5,
  command_6,
  command_7,
  command_8,
  command_9,
  command_10,
].each do |command|
  execute_with_starz(command)
end
