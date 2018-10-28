require 'minitest/autorun'
require 'minitest/spec'

require '../lib/pencil'

describe Pencil do
  subject {Pencil.new}

  it 'must be instance of Pencil' do
    subject.must_be_instance_of Pencil
  end

end
