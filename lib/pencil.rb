class Pencil
  attr_reader :length, :text, :durability

  def initialize length, durability
    @length = length
    @durability = durability
    @text = ''
  end

  def write text
    @text += text
  end
end
