require File.join( File.dirname(__FILE__) , '..' , 'lib' , 'rtsung' )
require 'spec'

describe "Rtsung" do
  it "should provide for attacks" do
    attack = Rtsung::Attack.new do
      get 'http://localhost:9292'
    end
    
    attack.run
    puts attack.results
  end
end
