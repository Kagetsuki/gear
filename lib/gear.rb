require 'git'

class Gear
  #======== attribute list ========#
  # obtained: tracking flag indicating if sources have been obtained
  # built: tracking flag indicating if the build has been completed
  # installed: tracking flag indicating if installation/vendorization completed
  # checked: tracking flag indicating if an installation check succeeded
  # headers: an array of headers to check for (in include path)
  # libs: an array of libs to check for
  # build_path: the path where the build will occur
  attr_reader :obtained, :built, :installed, :checked,
    :headers, :libs, :build_path

  @@install_path = "#{Dir.pwd}/vendor"
  @@initialized = false

  @headers = []
  @libs = []

  class << self
    attr_accessor :gear_name
  end

  def self.install_path(new_path = nil)
    @@install_path = new_path unless new_path.nil?
    @@install_path
  end

  def self.initialized?
    @@initialized
  end

  # define the default name
  # *OVERRIDE* with the name of the Gear/repo/project
  @gear_name = 'Gear'

  def name()
    self.class.gear_name
  end

  def target(new_target = nil)
    @@install_path = new_target unless new_target.nil?
    @@install_path
  end

  def initialize()
    @obtained = @built = @installed = @checked = false
    @build_path = _root_dir() + "/build/#{name()}"
    _setup_paths()

    @@initialized = true
  end

  def obtain()
    STDERR.puts "WARNING: Gear did not override obtain method. No sources were obtained."
    @obtained = false
    return false
  end

  def build()
    STDERR.puts "WARNING: Gear did not override build method. Nothing was built."
    @built = false
    return false
  end

  def install()
    STDERR.puts "WARNING: Gear did not override install method. Nothing has been installed."
    @installed = false
    return false
  end

  def check()
    STDERR.puts "WARNING: Gear did not override check method. Status is unknown."
    @checked = false
    return false
  end

  def engage()
    !check && # bail if already installed
    obtain &
    build &&
    install &&
    check
  end

  def remove()
    FileUtils.rm_rf("#{@build_path}")
    @obtained = false
    return true
  end

  def uninstall()
    # set @installed to false on a succesfully uninstall
    STDERR.puts "WARNING: Gear did not override uninstall method."
    return false
  end

  def disengage()
    uninstall &&
    remove
  end

  #======== obtain helpers ========#
  def git_obtain(repository, branch)
    begin
      if Dir.exist? build_path
        @git = Git.open(build_path)
        @git.reset("HEAD", hard: true)
        @git.clean(force: true, d: true, x:true)
      else
        @git = Git.clone(repository, build_path)
      end
    rescue StandardError => e 
      STDERR.puts "Could not obtain repository #{repository}.\n#{e}"
      @obtained = false
      return false
    end

    @git.checkout(branch)
    @git.pull

    Dir.chdir(@build_path)
    `git submodule update --init --recursive`

    @obtained = true
    return true
  end

  def github_obtain(user, repository, branch = 'master')
    git_obtain("https://github.com/#{user}/#{repository}.git", branch)
  end

  def std_config_make(flags = "")
    Dir.chdir(@build_path)
    `autoconf` if !File.exist? 'configure'
    `./confirgure --prefix#{@@install_path}`
    `make`
  end

  def std_make_install()
    `make install`
    @installed = true
    return true
  end

  # Prefixes a command with the gearbox prefixed in the load path
  def gear_exec(command = "")
    `LD_LIBRARY_PATH=#{@@install_path}/lib:$LD_LIBRARY_PATH C_INCLUDE_PATH=#{@@install_path}/include:$C_INCLUDE_PATH PATH=#{@@install_path}/bin:$PATH #{command}`
  end

  private
  def _root_dir()
    File.expand_path('../..', __FILE__)
  end

  # sets up vendor/sub directories
  def _setup_paths()
    #puts "⚙Preparing directory structure in #{@@install_path}"
    return if @@initialized
    FileUtils.mkdir_p("#{@@install_path}/bin")
    FileUtils.mkdir_p("#{@@install_path}/include")
    FileUtils.mkdir_p("#{@@install_path}/lib")

    ENV['PATH'] = (ENV['PATH'].nil? ?
      "#{@@install_path}/bin" : ENV['PATH'] + ":#{@@install_path}/bin")
    #ENV['C_INCLUDE_PATH'] = ENV['C_INCLUDE_PATH'].to_s + ":#{@@install_path}/include"
    #ENV['CPLUS_INCLUDE_PATH'] = ENV['CPLUS_INCLUDE_PATH'].to_s + ":#{@@install_path}/include"
    ENV['CPATH'] = (ENV['CPATH'].nil? ?
      "#{@@install_path}/include" : ENV['CPATH'] + ":#{@@install_path}/include")
    ENV['LD_LIBRARY_PATH'] = (ENV['LD_LIBRARY_PATH'].nil? ?
      "#{@@install_path}/lib" : ENV['LD_LIBRARY_PATH'] + ":#{@@install_path}/lib")
  end
end
