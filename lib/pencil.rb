class Pencil
  attr_reader :length, :text

  def initialize length
    @length = length
    @text = ''
  end

  def write text
    @text += text
  end
end
