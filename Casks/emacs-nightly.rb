cask "emacs-nightly" do
  arch arm: "arm64-11", intel: "x86_64-10_11"

  version "2023-11-30_00-09-25,e87644baa3239ce57a5620d3d38352acc1113fa4"
  sha256 "296923b18b5a1a9e61f5c65d6482122fded2563c02a72f0d325110f72fd8c141"

  url "https://emacsformacosx.com/emacs-builds/Emacs-#{version.csv.first}-#{version.csv.second}-universal.dmg"
  name "Emacs"
  desc "GNU Emacs text editor"
  homepage "https://emacsformacosx.com/"

  livecheck do
    url "https://emacsformacosx.com/atom/daily"
    regex(/href=.*?Emacs[._-](\d+-\d+-\d+_\d+-\d+-\d+)[._-]([a-f0-9]+)[._-]universal\.dmg/i)
    strategy :page_match do |page|
      match = page.match(regex)
      next if match.blank?

      "#{match[1]},#{match[2]}"
    end
  end

  conflicts_with cask:    [
                   "emacs",
                   "emacs-pretest",
                 ],
                 formula: "emacs"

  app "Emacs.app"
  binary "#{appdir}/Emacs.app/Contents/MacOS/Emacs", target: "emacs"
  binary "#{appdir}/Emacs.app/Contents/MacOS/bin-#{arch}/ctags"
  binary "#{appdir}/Emacs.app/Contents/MacOS/bin-#{arch}/ebrowse"
  binary "#{appdir}/Emacs.app/Contents/MacOS/bin-#{arch}/emacsclient"
  binary "#{appdir}/Emacs.app/Contents/MacOS/bin-#{arch}/etags"
  manpage "#{appdir}/Emacs.app/Contents/Resources/man/man1/ctags.1.gz"
  manpage "#{appdir}/Emacs.app/Contents/Resources/man/man1/ebrowse.1.gz"
  manpage "#{appdir}/Emacs.app/Contents/Resources/man/man1/emacs.1.gz"
  manpage "#{appdir}/Emacs.app/Contents/Resources/man/man1/emacsclient.1.gz"
  manpage "#{appdir}/Emacs.app/Contents/Resources/man/man1/etags.1.gz"

  zap trash: [
    "~/Library/Caches/org.gnu.Emacs",
    "~/Library/Preferences/org.gnu.Emacs.plist",
    "~/Library/Saved Application State/org.gnu.Emacs.savedState",
  ]
end
