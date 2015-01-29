require("bundler/setup")
Bundler.require(:default)


Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }



get('/') do
  erb(:index)
end

get("/recipes") do
  @recipes = Recipe.all()
  erb(:recipe)
end

post("/recipes") do
  recipe_name = params.fetch("recipe_name")
  recipe_desc = params.fetch("recipe_desc")
  recipe = Recipe.create({ :name => recipe_name,
    :description => recipe_desc })
  @recipes = Recipe.all()
  erb(:recipe)
end
