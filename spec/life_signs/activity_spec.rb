require 'spec_helper'

describe LifeSigns::Activity, tag: :model do
  include Shoulda::Matchers::ActiveRecord
  subject { Activity.new }

  it { should belong_to(:content) }
  it { should belong_to(:actor) }
end
