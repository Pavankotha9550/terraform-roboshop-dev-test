for i in 80-test-component 70-test-catalogue 60-test-database 50-test-flb 40-test-acm 30-test-vpn 20-test-alb 10-test-sg 01-test-vpcdo
do
    cd $i
    terraform destroy -auto-approve
    cd ..
done