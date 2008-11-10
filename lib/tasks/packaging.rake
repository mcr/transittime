# -*- ruby -*-

namespace :debian do
  desc "Package into a DEB file"
  task :package do
    instdir='/home/user/tt'
    targetdir="tmp/debian#{instdir}"
    system "mkdir -p #{targetdir}"
    system "tar cf - COPYING README app config db/migrate lib transittime vendor | (cd #{targetdir} && tar xf -)"
    system "tar cf - DEBIAN | (cd tmp/debian && tar xf -)"
    system "fakeroot sh -c 'chown -R root tmp/debian; dpkg-deb -b tmp/debian transittime.deb'"
    system "rm -rf tmp/debian"
  end
end

