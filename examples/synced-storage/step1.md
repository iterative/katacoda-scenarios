# Prepare

The setup of this example is similar to that of [using a SSH server
for data
sharing](https://katacoda.com/dvc/courses/examples/ssh-storage).

1. Setup of the server:

   `play setup-server.sh`{{execute}}
   
2. Click on this command to switch to the first user on another
   terminal tab: `su - first-user`{{execute T2}}
   
   Then run the setup commands:
   
   `play setup-first-user.sh`{{execute}}
   
3. Click on this command to switch to the second user on another
   terminal tab: `su - second-user`{{execute T3}}
   
   Then run the setup commands:
   
   `play setup-second-user.sh`{{execute}}
