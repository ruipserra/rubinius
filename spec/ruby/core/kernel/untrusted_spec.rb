require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe "Kernel#untrusted?" do
  it "returns the untrusted status of an object" do
    o = mock('o')
    o.untrusted?.should == false
    o.untrust
    o.untrusted?.should == true
  end

  it "has no effect on immediate values" do
    [nil, true, false, 1, :a].each do |obj|
      obj.untrust
      obj.untrusted?.should == false
    end
  end

  it "has no effect on floats" do
    obj = 1.1
    obj.untrust
    obj.untrusted?.should == false
  end

  it "has no effect on bignums" do
    obj = bignum_value
    obj.untrust
    obj.untrusted?.should == false
  end
end
