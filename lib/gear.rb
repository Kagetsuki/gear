class Gear
  attr_accessor :name, :version
  attr_reader :obtained, :built, :installed, :checked

  def initializer()
    set_info
  end

  def obtain()
    @obtained = false
    return false
  end

  def build()
    @built = false
    return false
  end

  def install()
    @installed = false
    return false
  end

  def check()
    @checked = false
    return false
  end

  def engage()
    obtain &&
    build &&
    install &&
    check
  end

  #======== obtain helpers ========#
  def git_obtain(repository, branch)
  end

  def github_obtain(user, repository, branch = 'master')
  end

  private
  def set_info()
    @name = 'unknown'
    @version = '0.0.0'
  end
end

