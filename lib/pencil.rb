class Pencil
  attr_reader :length, :text, :durability

  def initialize length, initialDurability
    @length = length
    @durability = initialDurability
    @text = ""
  end

  def write text

    textCharacterArray = text.split(%r{\s*})
    lettersArray = ('A'..'Z').to_a + ('a'..'z').to_a
    degradePoints = getDegradePoints(textCharacterArray, lettersArray)

    if @durability == 0
      addSpaces(text)
    elsif degradePoints < @durability
      @text += text
      @durability -= degradePoints
    else
      @text += printPartialText(textCharacterArray,lettersArray)

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

  def getDegradePoints textCharacterArray, lettersArray
    degradePoints = 0
    textCharacterArray.each do |character|
      if lettersArray.include?(character) && character == character.upcase
        degradePoints += 2
      else
        degradePoints += 1
      end
    end
    return degradePoints
  end

  def printPartialText textCharacterArray, lettersArray
    textToAdd = ""
    textCharacterArray.each do |character|
      if lettersArray.include?(character) && character == character.upcase
        @durability -= 2
      else
        @durability -= 1
      end

      if @durability >= 0
        textToAdd += character
      else
        textToAdd += " "
      end
    end
    return textToAdd
  end

  def setDurability newDurability
    @durability = newDurability
  end
end
