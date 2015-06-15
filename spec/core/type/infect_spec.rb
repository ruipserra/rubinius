require File.expand_path('../../../spec_helper', __FILE__)

describe "Rubinius::Type.infect" do
  before do
    @tainted = Object.new.taint
  end

  it "returns the first argument" do
    a = Object.new
    b = Object.new
    Rubinius::Type.infect(a, b).should equal(a)
  end

  it "doesn't taint the first argument if the second is untainted" do
    Rubinius::Type.infect(Object.new, Object.new).tainted?.should be_false
  end

  it "taints the first argument if the second is tainted" do
    Rubinius::Type.infect(Object.new, @tainted).tainted?.should be_true
  end

  ruby_version_is "1.9" do
    it "doesn't untrust the first argument if the second is trusted" do
      Rubinius::Type.infect(Object.new, Object.new).untrusted?.should be_false
    end

    it "untrusts the first argument if the second is untrusted" do
      Rubinius::Type.infect(Object.new, Object.new.untrust).untrusted?.should be_true
    end
  end

  it "is a no-op for Fixnum" do
    Rubinius::Type.infect(1,  @tainted).tainted?.should be_false
  end

  it "is a no-op for Bignum" do
    Rubinius::Type.infect(bignum_value,  @tainted).tainted?.should be_false
  end

  it "is a no-op for Float" do
    Rubinius::Type.infect(2.0,  @tainted).tainted?.should be_false
  end

  it "is a no-op for Symbol" do
    Rubinius::Type.infect(:a,  @tainted).tainted?.should be_false
  end

  it "is a no-op for true" do
    Rubinius::Type.infect(true,  @tainted).tainted?.should be_false
  end

  it "is a no-op for false" do
    Rubinius::Type.infect(false, @tainted).tainted?.should be_false
  end

  it "is a no-op for nil" do
    Rubinius::Type.infect(nil, @tainted).tainted?.should be_false
  end
end
