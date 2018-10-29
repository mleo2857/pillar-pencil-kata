class Pencil
  attr_reader :length, :text, :durability, :eraserDurability

  def initialize length, initialDurability, eraserDurability
    @length = length
    @initialDurability = initialDurability
    @durability = initialDurability
    @eraserDurability = eraserDurability
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

  def sharpen
    if @length > 1
      @durability = @initialDurability
      @length -= 1
    else
      @durability = 0
      @length = 0
    end
  end

  def erase text
    replacementSpace = getReplacementSpace(text)
    reprintTextWithoutLastWord(text, replacementSpace)
    @eraserDurability -= text.length
  end

  def getReplacementSpace text
    if @eraserDurability == 0
      replacementSpace = text
    elsif @eraserDurability > text.length
      replacementSpace = ""
      text.length.times do
        replacementSpace += " "
      end
    else
      textLettersToArray = text.split(%r{\s*})
      @eraserDurability.times do
        textLettersToArray.pop
      end
      replacementSpace = textLettersToArray.join
    end
    return replacementSpace
  end

  def reprintTextWithoutLastWord text, replacementSpace
    textWithWordRemovedArray = @text.split(text)
    @text = ""
    case textWithWordRemovedArray.length
    when 0
        @text += replacementSpace
    when 1
        @text += textWithWordRemovedArray[0]
        @text += replacementSpace
    when 2
        @text += textWithWordRemovedArray[0]
        @text += replacementSpace
        @text += textWithWordRemovedArray[1]
    else
        lastArrayElement = textWithWordRemovedArray.pop
        @text += textWithWordRemovedArray.join(text)
        @text += replacementSpace
        @text += lastArrayElement
    end

    return @text
  end

  def edit text

  end

end
