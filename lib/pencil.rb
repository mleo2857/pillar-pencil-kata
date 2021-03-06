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
      addFullText(text, degradePoints)
    else
      addPartialText(textCharacterArray,lettersArray)

      if @durability < 0
        @durability = 0
      end
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

  def addSpaces text
    text.length.times do
      @text += ' '
    end
  end

  def addPartialText textCharacterArray, lettersArray
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
    @text += textToAdd
  end

  def addFullText text, degradePoints
    @text += text
    @durability -= degradePoints
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
    if @eraserDurability <= 0
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
      @eraserDurability = 0
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

  def edit word
    whitespaceIndex = findWhiteSpaceIndex
    insertWord(word, whitespaceIndex)
  end

  def findWhiteSpaceIndex
    whitespaceIndex = 0
    i = 0
    while i < @text.length
      if @text[i] == " " && @text[i + 1] == " "
        whitespaceIndex = i + 1
        break
      end
      i += 1
    end

    return whitespaceIndex
  end

  def insertWord word, whitespaceIndex
    letter = 0
    while letter <= word.length - 1
      if @text[whitespaceIndex + letter] == " "
        @text[whitespaceIndex + letter] = word[letter]
      else
        @text[whitespaceIndex + letter] = "@"
      end
      letter += 1
    end
  end

end
