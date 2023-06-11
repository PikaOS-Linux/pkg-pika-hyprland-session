# Sign the packages
dpkg-sig --sign builder ./output/pika-hyprland-session*.deb

# Pull down existing ppa repo db files etc
rsync -azP --exclude '*.deb' ferreo@direct.pika-os.com:/srv/www/pikappa/ ./output/repo

# Remove our existing package from the repo
reprepro -V --basedir ./output/repo/ removefilter lunar 'Package (% pika-hyprland-session*)'

# Add the new package to the repo
reprepro -V --basedir ./output/repo/ includedeb lunar ./output/pika-hyprland-session*.deb

# Push the updated ppa repo to the server
rsync -azP ./output/repo/ ferreo@direct.pika-os.com:/srv/www/pikappa/
