minecalc = new Minecalc
minecalc.package(Minecalc.Packages.Vanilla)

onReady = ->
  for package in minecalc.packages
    item = $("<li>").append("<h3>#{package.name}</h3>")
    
    materials = $("<ul>")
    for key, material of package.materials
      materials.append("<li>#{material.name}</li>")
    item.append("<h4>Materials</h4>").append(materials)
    
    recipesList = $("<ul>")
    for recipe in package.recipes
      recipeListItem = $("<li>")
      recipeListItem.append("<p>#{recipe.creates.amount} #{recipe.creates.name()}</p>")
      requiresList = $("<ul>")
      for material, stack of recipe.requires()
        requiresList.append("<li>#{stack.amount} #{stack.name()}</li>")
      recipeListItem.append(requiresList)
      recipesList.append(recipeListItem)
    item.append("<h4>Recipes</h4>").append(recipesList)
    
    $("#packages").append(item)

$(onReady)
