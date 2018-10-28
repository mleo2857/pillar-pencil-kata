class Pencil
  attr_reader :length, :text, :durability

  def initialize length
    @length = length
    @text = ''
  end

  def write text
    @text += text
  end
end
