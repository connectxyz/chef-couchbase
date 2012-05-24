require "spec_helper"
require "node_provider"
require "node_resource"

describe Chef::Resource::CouchbaseNode do
  let(:resource) { described_class.new("self") }

  describe ".ancestors" do
    it { described_class.ancestors.should include Chef::Resource }
  end

  describe "#action" do
    it "defaults to :modify" do
      resource.action.should == :modify
    end
  end

  describe "#allowed_actions" do
    subject { resource.allowed_actions }
    it { should include :nothing }
    it { should include :modify }
  end

  describe "#id" do
    it "can be assigned" do
      resource.id "10.0.1.20"
      resource.id.should == "10.0.1.20"
    end

    it "cannot be assigned an Integer" do
      expect { resource.id 42 }.to raise_error Chef::Exceptions::ValidationFailed
    end

    it "defaults to the name attribute" do
      resource.id.should == resource.name
    end
  end

  describe "#database_path" do
    it "can be assigned" do
      resource.database_path "/mnt/couchbase-server/data"
      resource.database_path.should == "/mnt/couchbase-server/data"
    end

    it "cannot be assigned an Integer" do
      expect { resource.database_path 42 }.to raise_error Chef::Exceptions::ValidationFailed
    end

    it "defaults to /opt/couchbase/var/lib/couchbase/data" do
      resource.database_path.should == "/opt/couchbase/var/lib/couchbase/data"
    end
  end

  describe "#name" do
    it "assigns the given name attribute" do
      described_class.new("self").name.should == "self"
    end
  end

  describe "#provider" do
    it "defaults to the CouchbaseNode provider class" do
      resource.provider.should == Chef::Provider::CouchbaseNode
    end
  end

  describe "#resource_name" do
    subject { resource.resource_name }
    it { should == :couchbase_node }
  end
end