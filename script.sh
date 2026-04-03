# for i in $(ls); do
#   cd "$i"
#   echo "$PWD" | cut -d "/" -f6
#   terraform apply -auto-approve
#   cd ..
# done

for i in 01-test-vpc 10-test-sg 20-test-alb 30-test-vpn 40-test-acm 50-test-flb 60-test-database 70-test-catalogue 80-test-component
do
    cd $i
    terraform apply -auto-approve
    cd ..
done

