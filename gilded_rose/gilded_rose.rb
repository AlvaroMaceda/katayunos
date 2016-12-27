

def decrease_quality!(item)
  if item.quality > 0
    if !legendary_item?(item)
      item.quality -= 1
    end
  end
end

def shell_date_passed?(item)
  item.sell_in < 0
end

def backstage?(item)
  item.name == 'Backstage passes to a TAFKAL80ETC concert'
end

def aged_brie?(item)
  item.name == 'Aged Brie'
end

def legendary_item?(item)
  item.name == 'Sulfuras, Hand of Ragnaros'
end

def increase_quality!(item)
  if item.quality < 50
    item.quality += 1
  end
end

def update_item_quality(item)

  if !aged_brie?(item) && !backstage?(item)
    decrease_quality!(item)
  else
    if item.quality < 50
      item.quality += 1
      if backstage?(item)
        if item.sell_in < 11
          increase_quality!(item)
        end
        if item.sell_in < 6
          increase_quality!(item)
        end
      end
    end
  end
  if !legendary_item?(item)
    item.sell_in -= 1
  end
  if shell_date_passed?(item)
    if !aged_brie?(item)
      if !backstage?(item)
        decrease_quality!(item)
      else
        item.quality = item.quality - item.quality
      end
    else
      increase_quality!(item)
    end
  end
end

def update_quality(items)
  items.each do |item|
    update_item_quality(item)
  end
end


# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]
