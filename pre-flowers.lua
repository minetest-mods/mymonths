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

mymonths.flower_number = table.getn(mymonths.flowers)
