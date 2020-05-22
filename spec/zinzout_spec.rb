require_relative('spec_helper')

RSpec.describe Zinzout do

  it "has a version number" do
    expect(Zinzout::VERSION).not_to be nil
  end

  it "reads a plain file" do
    expect(Zinzout.zin(plain).first.chomp).to eq("one")
  end

  it "reads a gzipped file" do
    expect(Zinzout.zin(gzipped).first.chomp).to eq("one")
  end

  it "writes to, then reads from, a gzipped file" do
    plain, gz = tempfile_pair
    Zinzout.zout(gz) do |out|
      out.puts "one"
    end

    # Is it really gzipped?
    expect(Zlib::GzipReader.open(gz).first.chomp).to eq("one")

    # Is it sniffed correctly?
    expect(Zinzout.zin(gz).first.chomp).to eq('one')
  end

end
