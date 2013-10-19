class Minecalc
  @Packages: {}
  
  constructor: ->
    @packages = []
  
  package: (package) ->
    @packages.push(package)
  
  material: (name) ->
    [packageName, materialName] = name.toLowerCase().match(/^([^\.]+)\.(.+)$/)[1..2]
    package = _.find this.packages, (package) ->
      package.name.toLowerCase() is packageName
    if package
      package.materials[materialName]
    else
      null

class Stack
  constructor: (materialName, amount = 1) ->
    @materialName = materialName
    @amount = amount
  
  material: ->
    minecalc.material(@materialName)
  
  name: ->
    material().name

class Recipe
  constructor: (pattern, materials, creates, amount = 1) ->
    @pattern = pattern
    @materials = materials
    @creates = new Stack(creates, amount)
  
  requires: ->
    stacks = {}
    for line in @pattern
      for char in line.split("")
        if (material = @materials[char]) and (material = minecalc.material(material))
          stack = stacks[material] or new Stack(material, 0)
          stack.amount += 1
          stacks[material] = stack
    stacks
