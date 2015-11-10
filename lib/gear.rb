require 'git'

class Gear
  #======== attribute list ========#
  # name: name of the package
  # obtained: tracking flag indicating if sources have been obtained
  # built: tracking flag indicating if the build has been completed
  # installed: tracking flag indicating if installation/vendorization completed
  # checked: tracking flag indicating if an installation check succeeded
  #
  attr_reader :name, :obtained, :built, :installed, :checked, :install_path,
    :headers, :libs

  @@gear_install_target = './vendor'

  # define the default name
  # *OVERRIDE* with the name of the Gear/repo/project
  @name = 'Gear'

  def initializer(install_path = nil)
    @install_path = install_path || @@gear_install_target
    @obtained = @built = @installed = @checked = false
  end

  def obtain()
    puts "WARNING: Gear did not override obtain method. No sources were obtained."
    @obtained = false
    return false
  end

  def build()
    puts "WARNING: Gear did not override build method. Nothing was built."
    @built = false
    return false
  end

  def install()
    puts "WARNING: Gear did not override install method. Nothing has been installed."
    @installed = false
    return false
  end

  def check()
    puts "WARNING: Gear did not override check method. Status is unknown."
    @checked = false
    return false
  end

  def clean()
    FileUtils.
  end

  def engage()
    !check && # bail if already installed
    obtain &
    build &&
    install &&
    check &&
    clean
  end

  #======== obtain helpers ========#
  def git_obtain(repository, branch)
    begin
      @git = Git.clone(repository, build_path)
    rescue
      STDERR.puts "Could not clone repository #{repository}. Obtain failed."
      obtained = false
      return false
    end

    @git.checkout(branch)

    obtained = true
    return true
  end

  def github_obtain(user, repository, branch = 'master')
    git_obtain("https://github.com/#{user}/#{repository}.git", branch)
  end
end

