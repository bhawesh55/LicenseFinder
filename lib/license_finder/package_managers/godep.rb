require 'json'

module LicenseFinder
  class Godep < PackageManager

    def current_packages
      json = JSON.parse(IO.read(package_path))
      json['Deps'].map { |dep| GodepPackage.new(dep, install_prefix: "#{install_prefix}/src") }
    end

    def package_path
      project_path.join('Godeps/Godeps.json')
    end

    private

    def workspace_dir
      project_path.join('Godeps/_workspace')
    end

    def install_prefix
      File.exist?(workspace_dir) ? workspace_dir : ENV['GOPATH']
    end
  end
end
