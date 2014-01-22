class Viewer < Thor
  include Thor::Actions

  source_root File.join(__FILE__, '../..')

  desc "update", "Update the harview webapp"
  def update
    run 'bower install'
    target = 'vendor/viewer'
    remove_dir target
    directory 'bower_components/harviewer/webapp', target

    Dir.glob(File.join(target, '*.php')) do |old_file|
      new_file = old_file.gsub '.php', '.html'

      copy_file old_file, new_file
      gsub_file new_file, /<\?php.+\?>/, ""
      remove_file old_file
    end
  end
end
