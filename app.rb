require("bundler/setup")
Bundler.require(:default)


Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }



get('/') do
  erb(:index)
end

get("/recipes") do
  @recipes = Recipe.all()
  @categories = Category.all()

  # # ... VERY general 'pseudo-code' on how to iterate
  # # ... thru categories and all recipes tied to them
  # @categories = Category.all()
  #
  # @categories.each() do |category|
  #   category.name() + '\n'
  #   category.recipes().each() do |recipe|
  #     '\t' + recipe.name() + '\n'
  #   end
  # end

  erb(:recipe)
end

post("/recipes") do
  recipe_name = params.fetch("recipe_name")
  recipe_desc = params.fetch("recipe_desc")
  recipe = Recipe.create({ :name => recipe_name,
    :description => recipe_desc })
  category = Category.find(params.fetch("category_id").to_i())
  recipe.categories().push(category)
  redirect("/recipes")
end

get("/recipes/:id") do
  @recipe = Recipe.find(params.fetch("id").to_i)
  @ingredients = @recipe.ingredients()
  @instructions = @recipe.instructions()
  erb(:recipe_detail)
end

patch("/recipes/:id") do
  recipe_id = params.fetch("id").to_i()
  recipe_name = params.fetch("recipe_name")
  @recipe = Recipe.find(recipe_id)
  @recipe.update({:name => recipe_name})
  redirect("/recipes/" + recipe_id.to_s())
end

delete("/recipes/:id") do
  recipe_id = params.fetch("id").to_i()
  @recipe = Recipe.find(recipe_id)
  @recipe.delete()
  redirect("/recipes")
end

post("/recipes/:id/ingredients") do
  ingredient_name = params.fetch("ingredient_name")
  recipe_id = params.fetch("id").to_i()
  @recipe = Recipe.find(recipe_id)
  @recipe.ingredients().create({ :name => ingredient_name })
  redirect("/recipes/" + recipe_id.to_s())
end

post("/recipes/:id/instructions") do
  instruction_name = params.fetch("instruction_name")
  recipe_id = params.fetch("id").to_i()
  @recipe = Recipe.find(recipe_id)
  @recipe.instructions().create({ :name => instruction_name })
  redirect("/recipes/" + recipe_id.to_s())
end

get("/categories") do
  @categories = Category.all()
  erb(:category)
end

post("/categories") do
  category_name = params.fetch("category")
  Category.create({ :name => category_name })
  redirect("/categories")
end
