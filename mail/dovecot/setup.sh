useradd test
passwd test
sudo usermod -a -G mail test
mkdir -p ~/mail/test/.INBOX/{cur,new,tmp}
touch ~/mail/test/.INBOX/{cur,new,tmp}/placeholder

useradd test2
passwd test2
sudo usermod -a -G mail test2
mkdir -p ~/mail/test2/.INBOX/{cur,new,tmp}
touch ~/mail/test2/.INBOX/{cur,new,tmp}/placeholder