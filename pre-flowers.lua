-- Support for any mods that add flowers is added here. We check if a mod is enabled
-- then add it's flowers/plants to the mymonths.flosers table.

mymonths.flowers = {}

if minetest.get_modpath('flowers') then
   table.insert(mymonths.flowers,'flowers:dandelion_white')
   table.insert(mymonths.flowers,'flowers:dandelion_yellow')
   table.insert(mymonths.flowers,'flowers:geranium')
   table.insert(mymonths.flowers,'flowers:rose')
   table.insert(mymonths.flowers,'flowers:tulip')
   table.insert(mymonths.flowers,'flowers:viola')
end

if minetest.get_modpath('bakedclay') then
   table.insert(mymonths.flowers,'bakedclay:delphinium')
   table.insert(mymonths.flowers,'bakedclay:lazarus')
   table.insert(mymonths.flowers,'bakedclay:mannagrass')
   table.insert(mymonths.flowers,'bakedclay:thistle')
end

if minetest.get_modpath('moreplants') then
   table.insert(mymonths.flowers, 'moreplants:tallgrass')
   table.insert(mymonths.flowers, 'moreplants:aliengrass')
   table.insert(mymonths.flowers, 'moreplants:bulrush')
   table.insert(mymonths.flowers, 'moreplants:bigfern')
   table.insert(mymonths.flowers, 'moreplants:umbrella')
   table.insert(mymonths.flowers, 'moreplants:bigflower')
   table.insert(mymonths.flowers, 'moreplants:medflower')
   table.insert(mymonths.flowers, 'moreplants:spikefern')
   table.insert(mymonths.flowers, 'moreplants:weed')
   table.insert(mymonths.flowers, 'moreplants:bluespike')
   table.insert(mymonths.flowers, 'moreplants:blueflower')
   table.insert(mymonths.flowers, 'moreplants:eyeweed')
   table.insert(mymonths.flowers, 'moreplants:moonflower')
   table.insert(mymonths.flowers, 'moreplants:caveflower')
   table.insert(mymonths.flowers, 'moreplants:fireflower')
   table.insert(mymonths.flowers, 'moreplants:deadweed')
   table.insert(mymonths.flowers, 'moreplants:taigabush')
   table.insert(mymonths.flowers, 'moreplants:jungleflower')
   table.insert(mymonths.flowers, 'moreplants:curly')
   table.insert(mymonths.flowers, 'moreplants:clover')
end

mymonths.flower_number = table.getn(mymonths.flowers)
