Bundler.require(:default)

(Dir['./app/lib/*.rb'] + Dir['./app/models/*.rb'] + Dir['./app/controllers/*.rb']).each do |file|
  require file
end

class SinatraProject < Sinatra::Base
  set :root, Dir['./app']
  set :views, proc { File.join(root, 'views') }

  Dir['./app/controllers/*.rb'].each do |controller_name|
    controller_name = controller_name.split(%r{[\/\.]})[-2].split('_').map(&:capitalize).join
    register Object.const_get controller_name
  end
end

run SinatraProject
