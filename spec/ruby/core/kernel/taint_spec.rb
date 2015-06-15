require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe "Kernel#taint" do
  it "returns self" do
    o = Object.new
    o.taint.should equal(o)
  end

  it "sets the tainted bit" do
    o = Object.new
    o.taint
    o.tainted?.should == true
  end

  it "raises RuntimeError on an untainted, frozen object" do
    o = Object.new.freeze
    lambda { o.taint }.should raise_error(RuntimeError)
  end

  it "does not raise an error on a tainted, frozen object" do
    o = Object.new.taint.freeze
    o.taint.should equal(o)
  end

  it "has no effect on immediate values" do
    [nil, true, false, 1, :a].each do |v|
      v.taint
      v.tainted?.should == false
    end
  end

  it "has no effect on Float" do
    obj = 1.1
    obj.taint
    obj.tainted?.should == false
  end

  it "has no effect on Bignum" do
    obj = bignum_value
    obj.taint
    obj.tainted?.should == false
  end
end
