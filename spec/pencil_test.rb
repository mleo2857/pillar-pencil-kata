require 'minitest/autorun'
require 'minitest/spec'

require '../lib/pencil'

describe Pencil do
  subject {Pencil.new 5, 20000}

  it 'must be instance of Pencil' do
    subject.must_be_instance_of Pencil
  end

  it 'must have a length' do
    subject.must_respond_to 'length'
  end

  it 'must have a durability' do
    subject.must_respond_to 'durability'
  end

  it 'must initialize with a given length' do
    pencil = Pencil.new 10, 10000
    pencil.length.must_equal 10
  end

  it 'must initialize with a given durability' do
    pencil = Pencil.new 10, 10000
    pencil.durability.must_equal 10000
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
      @pencil = Pencil.new 15, 10000
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

end
