for i in $(ls); do
  cd "$i"
  echo "$PWD" | cut -d "/" -f6
  terraform apply -auto-approve
  cd ..
