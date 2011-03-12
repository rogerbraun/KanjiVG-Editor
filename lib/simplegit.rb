class SimpleGit

  %w{log diff status}.each do |cmd|
    class_eval %Q?
      def #{cmd}
        `\#{preambel} #{cmd}`   
      end
    ?
  end

  def initialize(dir, url = nil, user = nil)
    @dir = dir
    @user = user
    if not File.exists?(File.join(dir, ".git")) and url then
      self.clone(url)
    end
  end

  def clone(url)
    `git clone #{url} #{@dir}`
  end

  def preambel
    "git --work-tree=#{@dir} --git-dir=#{@dir}/.git"
  end

  def add(*files)
    files.flatten!
    `#{preambel} add #{files.join(" ")}`
  end

  def commit_all(message)
    `#{preambel} commit -a -m "#{message.gsub('"','\"') }" #{@user ? "--author=\"#{@user}\"" : ""}`
  end

end
