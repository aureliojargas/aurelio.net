# To have a smaller diff for visual inspection in the redcarpet->kramdown
# migration, use tidy to normalize the generated site HTML code.

# Run once in ../aurelio.net.html
git status --short | grep '^ M ' | cut -c 4- | grep '\.html$' > ../changed-files.txt

# Run in ../aurelio.net.html for each state: redcarpet and markdown then
# compare the diff
cat ../changed-files.txt | while read file;
  echo $file;
  tidy -m -q --show-warnings no -i --wrap 0 --tidy-mark no $file;
end >out 2>&1
