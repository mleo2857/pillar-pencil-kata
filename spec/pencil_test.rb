require 'minitest/autorun'
require 'minitest/spec'

require '../lib/pencil'

describe Pencil do
  subject {Pencil.new 5, 20000, 5000}

  it 'must be instance of Pencil' do
    subject.must_be_instance_of Pencil
  end

  it 'must have a length' do
    subject.must_respond_to 'length'
  end

  it 'must have a durability' do
    subject.must_respond_to 'durability'
  end

  it 'must have eraser durability' do
    subject.must_respond_to 'eraserDurability'
  end

  it 'must initialize with a given length' do
    pencil = Pencil.new 10, 10000, 5000
    pencil.length.must_equal 10
  end

  it 'must initialize with a given durability' do
    pencil = Pencil.new 10, 10000, 5000
    pencil.durability.must_equal 10000
  end

  it 'must initialize with a given eraser durability' do
    pencil = Pencil.new 10, 10000, 5000
    pencil.eraserDurability.must_equal 5000
  end

  it 'should keep track of text' do
    subject.must_respond_to 'text'
  end

  it 'should begin with an empty text string' do
    subject.text.must_be_instance_of String
    subject.text.must_equal ""
  end

  describe '#write' do
    before do
      @pencil = Pencil.new 15, 10000, 5000
    end

    it 'responds to the write method' do
      @pencil.must_respond_to 'write'
    end

    it 'adds the write input to the text value' do
      @pencil.write('This is a test')
      @pencil.text.must_equal 'This is a test'
      @pencil.write(', this is another test')
      @pencil.text.must_equal 'This is a test, this is another test'
    end

    it 'only adds spaces if it is dull' do
      @pencil.setDurability(0)
      @pencil.write('This is a test')
      @pencil.text.must_equal "              "
    end

    it 'degrades durability' do
      @pencil.write('a')
      @pencil.durability.must_equal 9999
    end

    it 'should not degrade for spaces' do
      @pencil.write('a b')
      @pencil.durability.must_equal 9998
    end

    it 'should not degrade for line breaks' do
      @pencil.write("a\nb")
      @pencil.durability.must_equal 9998
    end

    it 'should degrade 1 durability point for lower case and 2 for upper case' do
      @pencil.write("aA!bB?")
      @pencil.durability.must_equal (10000-8)
    end

    it 'should only allow to write as much text as durability allows' do
      @pencil.setDurability(4)
      @pencil.write("Text")
      @pencil.text.must_equal "Tex "
    end
  end

  describe '#sharpen' do
    before do
      @pencil = Pencil.new 10, 40000, 5000
    end

    it 'responds to the sharpen method' do
      @pencil.must_respond_to 'sharpen'
    end

    it 'restores pencil to original durability' do
      @pencil.write('Text')
      @pencil.sharpen
      @pencil.durability.must_equal 40000
    end

    it 'reduces the pencil length by 1' do
      @pencil.sharpen
      @pencil.length.must_equal 9
    end

    it 'stops sharpening when length is 0' do
      pencil = Pencil.new 1, 10000, 5000
      pencil.write("text")
      pencil.sharpen
      pencil.length.must_equal 0
      pencil.durability.must_equal 0
    end
  end

  describe '#erase' do
    before do
      @pencil = Pencil.new 15, 10000, 5000
    end

    it 'responds to erase' do
      @pencil.must_respond_to 'erase'
    end

    it 'replaces last occurrence of word with spaces' do
      @pencil.write("How much wood would a woodchuck chuck if a woodchuck could chuck wood?")
      @pencil.erase("chuck")
      @pencil.text.must_equal("How much wood would a woodchuck chuck if a woodchuck could       wood?")
      @pencil.erase("chuck")
      @pencil.text.must_equal("How much wood would a woodchuck chuck if a wood      could       wood?")
    end

    it 'works with strings of any length' do
      @pencil.write("Buffallo Bill")
      @pencil.erase("Bill")
      @pencil.text.must_equal("Buffallo     ")
    end

    it 'reduces the eraser durability' do
      @pencil.write("Buffallo Bill")
      @pencil.erase("Bill")
      @pencil.eraserDurability.must_equal (5000-4)
    end

    it 'only erases as much as eraser durability allows' do
      pencil = Pencil.new 15, 10000, 3
      pencil.write("Buffallo Bill")
      pencil.erase("Bill")
      pencil.text.must_equal "Buffallo B"
    end
  end

  describe '#edit' do
    before do
      @pencil = Pencil.new 15, 10000, 5000
    end

    it 'responds to edit' do
      @pencil.must_respond_to 'edit'
    end

    it 'replaces whitespace with a given word' do
      @pencil.write("An       a day keeps the doctor away")
      @pencil.edit("onion")
      @pencil.text.must_equal "An onion a day keeps the doctor away"
    end

    it 'replaces existing text with an @ symbol' do
      @pencil.write("An       a day keeps the doctor away")
      @pencil.edit("artichoke")
      @pencil.text.must_equal "An artich@k@ay keeps the doctor away"
    end
  end
end
