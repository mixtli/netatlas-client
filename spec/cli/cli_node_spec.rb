require 'spec_helper'

ENV['GLI_DEBUG'] = 'true'

describe "CLI node", :integration do
  before do
    @aruba_timeout_seconds = 5
  end
  context "list" do
    before do
      10.times { Fabricate(:node) }
    end
    it "should display a table" do
      netatlas "node list"
      all_stdout.split("\n").size.should eql(23)
    end
    it "should display valid json" do
      netatlas "--format=json node list"
      result = JSON.parse(all_stdout)
      result.should be_kind_of(Array)
      result.size.should eql(10)
    end
  end

  context "show" do
    before do
      @node = Fabricate(:node, :label => 'Test Node')
    end
    it "should display a table" do
      netatlas "node show #{@node.id}"
      all_stdout.should match(/Test Node/)
    end
    it "should display valid json" do
      netatlas "--format json node show #{@node.id}"
      result = JSON.parse(all_stdout)
      result.should be_kind_of(Hash)
      result['label'].should eql('Test Node')
    end
  end

  context "create" do
    it "should create a node from json" do
      json = {:label => 'Foo', :description => 'Foo Node'}.to_json
      netatlas("--format json node create", json)
      JSON.parse(all_stdout)['label'].should eql('Foo')
    end
  end

  context "update" do
    it "should update a node from json" do
      node = Fabricate(:node) 
      json = node.values.merge(:label => 'Blah').to_json

      netatlas("--format json node update #{node.id}", json)
      result = JSON.parse(all_stdout)
      result['label'].should eql('Blah')
    end
  end

  it "should delete a node" do
    node = Fabricate(:node)
    netatlas("node delete #{node.id}")
    puts all_stdout
    NetAtlas::Model::Node[node.id].should be_nil
    all_stdout.should match('success')
  end

  def netatlas(args, input = nil)
    process = run_interactive("netatlas_test #{args}")
    if input
      process.stdin << input
      process.stdin.close
    end
    puts all_stderr
  end

end

