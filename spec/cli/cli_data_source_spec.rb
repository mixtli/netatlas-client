require 'spec_helper'
ENV['GLI_DEBUG'] = 'true'

describe "CLI data_source", :vcr, :integration do
  before do
    @aruba_timeout_seconds = 5
    @user = Fabricate(:admin)
  end

  context "list" do
    before do
      10.times { Fabricate(:data_source, :description => 'xyz')}
    end
    it "should display a table" do
      netatlas "data_source list"
      puts all_stdout
      puts all_stderr
      all_stdout.scan(/xyz/).size.should == 10
    end
    it "should display valid json" do
      netatlas "--format=json data_source list"
      puts all_stdout
      puts all_stderr
      result = JSON.parse(all_stdout)
      result.should be_kind_of(Array)
      result.size.should eql(10)
    end
  end

  context "show" do
    before do
      @data_source = Fabricate(:data_source, :id => 1, :description=> 'xyz')
    end

    it "should display a table" do
      netatlas "data_source show #{@data_source.id}"
      all_stdout.should match(/xyz/)
    end
    it "should display valid json" do
      netatlas "--format json data_source show #{@data_source.id}"
      puts all_stdout
      result = JSON.parse(all_stdout)
      result.should be_kind_of(Hash)
      result['description'].should eql('xyz')
    end
  end

  context "create" do
    it "should create a data_source from json" do
      node = Fabricate(:node)
      plugin = Fabricate(:plugin)
      json = {:label => 'Foo', :node_id => node.id, :plugin_id => plugin.id, :description => 'Foo Node', :description => 'xyz'}.to_json
      netatlas("--format json data_source create", json)
      puts all_stdout
      puts all_stderr
      JSON.parse(all_stdout)['description'].should eql('xyz')
    end
  end

  context "update" do
    it "should update a data_source from json" do
      node = Fabricate(:data_source, :id => 1) 
      json = node.values.merge(:description=> 'xyz').to_json
      netatlas("--format json data_source update #{node.id}", json)
      puts "STDOUT = #{all_stdout}"
      result = JSON.parse(all_stdout)
      result['description'].should eql('xyz')
    end
  end

  it "should delete a node" do
    data_source = Fabricate(:data_source, :id => 1)
    netatlas("data_source delete #{data_source.id}")
    puts all_output
    sleep 3
    NetAtlas::Model::DataSource[data_source.id].should be_nil
    all_stdout.should match('success')
    last_exit_status.should == 0
  end

end
