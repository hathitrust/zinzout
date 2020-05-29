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

  it "works with Pathnames, too" do
    tplain, tgz = tempfile_pair
    gz_path = Pathname.new(tgz)
    Zinzout.zout(gz_path) do |out|
      out.puts "one"
    end

    # Is it really gzipped?
    expect(Zlib::GzipReader.open(gz_path.to_s).first.chomp).to eq("one")

    # Is it sniffed correctly?
    expect(Zinzout.zin(gz_path).first.chomp).to eq('one')
  end

end
