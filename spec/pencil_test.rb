require 'minitest/autorun'
require 'minitest/spec'

require '../lib/pencil'

describe Pencil do
  subject {Pencil.new 5}

  it 'must be instance of Pencil' do
    subject.must_be_instance_of Pencil
  end

  it 'must have a length' do
    subject.must_respond_to 'length'
  end

  it 'must initialize with a given length' do
    pencil = Pencil.new 10
    pencil.length.must_equal 10
  end

  it 'should keep track of text' do
    subject.must_respond_to 'text'
  end

  it 'should begin with an empty text string' do
    subject.text.must_be_instance_of String
    subject.text.must_equal ''
  end

  describe '#write' do
    before do
      @pencil = Pencil.new 15
    end

    it 'responds to the write method' do
      @pencil.must_respond_to 'write'
    end

    it 'adds the write entry to the text value' do
      @pencil.write('This is a test')
      @pencil.text.must_equal 'This is a test'
    end
  end

end
