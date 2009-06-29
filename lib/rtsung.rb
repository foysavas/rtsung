require 'erb'

module Rtsung ; end

class Rtsung::Config

  attr_accessor :settings, :file

  def defaults
    @defaults ||= {
      :max_users => 800,
      :duration => 30,
      :rate => 0.1,
      :name => 'attack',
      :requests => []
    }
  end

  def initialize(&block)
    @settings = {}
    @settings.merge!(defaults)
    ConfigBlock.new(self, &block)
    self
  end

  def finalize
    template = ERB.new( File.read( File.join(File.dirname(__FILE__), 'rtsung_template.xml.erb') ) )
    doc = template.result(binding)
    @file = "attack-#{Time.now.to_i}"
    File.open(@file+'.xml', 'w') { |f| f.write(doc) }
  end

  def method_missing(method, *args)
    if method.to_s[-1,1] == '='
      @settings[method.to_s.tr('=','').to_sym] = *args
    else
      @settings[method]
    end
  end

  class ConfigBlock
    def get(url)
      @obj.settings[:requests] << { :path => url, :method => 'GET' }
    end

    def initialize(obj, &block)
      @obj = obj
      instance_eval(&block)
    end

    def method_missing(method, *args)
      @obj.settings[method] = *args
    end
  end

end

class Rtsung::Attack
  attr_accessor :config, :state, :results

  def initialize(&block)
    @config = Rtsung::Config.new(&block)
    self
  end

  def run
    @config.finalize
    system("mkdir -p log/#{@config.file}")
    cmd = "tsung stop ; tsung -f #{Dir.pwd}/#{@config.file}.xml -l #{Dir.pwd}/log/#{config.file}/tsung.log start"
    thread = Thread.new do
      system(cmd)
    end
    sleep 10
    File.delete("#{Dir.pwd}/#{@config.file}.xml")
    Dir.chdir("log/#{@config.file}")
    Dir.chdir(Dir.entries('.')[2])
    begin 
      puts Dir.pwd
      system('/usr/local/lib/tsung/bin/tsung_stats.pl')
      sleep 10
    end until !thread.status
    system('/usr/local/lib/tsung/bin/tsung_stats.pl')
  end

end
