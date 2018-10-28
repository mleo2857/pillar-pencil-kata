class Pencil
  attr_reader :length, :text, :durability

  def initialize length, initialDurability
    @length = length
    @durability = initialDurability
    @text = ""
  end

  def write text
    degradePoints = 0
    textCharacterArray = text.split(%r{\s*})
    lettersArray = ('A'..'Z').to_a + ('a'..'z').to_a
    textCharacterArray.each do |character|
      if lettersArray.include?(character) && character == character.upcase
        degradePoints += 2
      else
        degradePoints += 1
      end
    end

    if @durability == 0
      addSpaces(text)
    elsif degradePoints < @durability
      @text += text
      @durability -= degradePoints
    else
      textCharacterArray.each do |character|
        if lettersArray.include?(character) && character == character.upcase
          @durability -= 2
        else
          @durability -= 1
        end

        if @durability >= 0
          @text += character
        else
          @text += " "
        end
      end
      if @durability < 0
        @durability = 0
      end
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
