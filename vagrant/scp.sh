vagrant scp  ../quick-steps master-1:/home/vagrant
vagrant scp  ../quick-steps master-2:/home/vagrant
vagrant scp  ../quick-steps loadbalancer:/home/vagrant
vagrant scp  ../quick-steps worker-1:/home/vagrant
vagrant scp  ../quick-steps worker-2:/home/vagrant
vagrant scp  ../quick-steps worker-3:/home/vagrant

vagrant ssh master-1 -c 'ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""'

vagrant scp master-1:/home/vagrant/.ssh/id_rsa.pub ./id_rsa.pub.master-1

cat ./id_rsa.pub.master-1 | vagrant ssh master-2 -c "cat >> ~/.ssh/authorized_keys"
cat ./id_rsa.pub.master-1 | vagrant ssh loadbalancer -c "cat >> ~/.ssh/authorized_keys"
cat ./id_rsa.pub.master-1 | vagrant ssh worker-1 -c "cat >> ~/.ssh/authorized_keys"
cat ./id_rsa.pub.master-1 | vagrant ssh worker-2 -c "cat >> ~/.ssh/authorized_keys"
cat ./id_rsa.pub.master-1 | vagrant ssh worker-3 -c "cat >> ~/.ssh/authorized_keys"

rm -f id_rsa.pub.master-1

