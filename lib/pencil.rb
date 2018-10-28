class Pencil
  attr_reader :length, :text, :durability

  def initialize length, initialDurability
    @length = length
    @durability = initialDurability
    @text = ""
  end

  def write text
    if @durability == 0
      addSpaces(text)
    else
      @text += text
      textCharacterArray = text.split(%r{\s*})
      @durability -= textCharacterArray.length
    end

  end

  def addSpaces text
    text.length.times do
      @text += ' '
    end
  end

  def setDurability newDurability
    @durability = newDurability
  end
end
