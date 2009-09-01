require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'Fog::AWS::S3::Bucket' do

  describe "#initialize" do

    it "should return a Fog:AWS::S3::Bucket" do
      s3.buckets.new.should be_an(Fog::AWS::S3::Bucket)
    end

    it "should remap attributes from parser" do
      now = Time.now
      bucket = s3.buckets.new(
        'CreationDate' => now,
        'Name'         => 'bucketname'
      )
      bucket.creation_date.should == now
      bucket.name.should == 'bucketname'
    end

  end

  describe "#buckets" do

    it "should return a Fog::AWS::S3::Buckets" do
      s3.buckets.new.buckets.should be_a(Fog::AWS::S3::Buckets)
    end

  end

  describe "#destroy" do

    it "should return true if the object is deleted" do
      bucket = s3.buckets.create(:name => 'fogmodelbucket')
      bucket.destroy.should be_true
    end

    it "should return false if the object does not exist" do
      bucket = s3.buckets.new(:name => 'fogmodelbucket')
      bucket.destroy.should be_false
    end

  end

  describe "#location" do

    it "should return the location constraint"

  end

  describe "#objects" do

    it "should return a Fog::AWS::S3::Objects" do
      bucket = s3.buckets.new(:name => 'fogmodelbucket')
      bucket.objects.should be_an(Fog::AWS::S3::Objects)
    end

  end

  describe "#payer" do

    it "should return the request payment value"

  end

  describe "#payer=" do

    it "should set the request payment value"

  end

  describe "#reload" do

    before(:each) do
      @bucket = s3.buckets.create(:name => 'fogmodelbucket')
      @reloaded = @bucket.reload
    end

    after(:each) do
      @bucket.destroy
    end

    it "should return a Fog::AWS::S3::Bucket" do
      @reloaded.should be_a(Fog::AWS::S3::Bucket)
    end

    it "should have the same attributes as the bucket that created it" do
      @bucket.attributes.should == @reloaded.attributes
    end

  end

  describe "#save" do

    before(:each) do
      @bucket = s3.buckets.new(:name => 'fogmodelbucket')
    end

    it "should return true when it succeeds" do
      @bucket.save.should be_true
      @bucket.destroy
    end

    it "should not exist in buckets before save" do
      @bucket.buckets.key?(@bucket.name).should be_false
    end

    it "should exist in buckets after save" do
      @bucket.save
      @bucket.buckets.key?(@bucket.name).should be_true
      @bucket.destroy
    end

  end

end
