# Automount

In the previous sections we have mounted the remote storage manually
with the command `sshfs`. In this section we will see how to mount it
automatically. This section is optional and just for sake of
completeness.

1. Mount the cache directory for the first user:

   Go to the first terminal: `cd`{{execute T1}}

   Let's do a manual login first, so that the fingerprint of `host01`
   is added on the list of known hosts:
   
   `ssh user1@host01 -i ~first-user/.ssh/dvc-server`{{execute}}
   
   Get `uid` and `gid` of the first user:
   
   `su - first-user -c id`{{execute}}
   
   Add an entry on `/etc/fstab`:

   ```
   cat << EOF >> /etc/fstab
   user1@host01:/srv/project.cache  /home/first-user/project.cache  fuse.sshfs  noauto,x-systemd.automount,_netdev,user,idmap=user,follow_symlinks,identityfile=/home/first-user/.ssh/dvc-server,allow_other,default_permissions,uid=1001,gid=1001  0  0
   EOF
   ```{{execute}}
   
   Reload and restart systemctl:
   
   `systemctl daemon-reload`{{execute}}
   
   `systemctl list-unit-files --type automount`{{execute}}
   
   `systemctl restart 'home-first\x2duser-project.cache.automount'`{{execute}}
   
2. Mount the cache directory for the second user:

   Get `uid` and `gid` of the second user:
   
   `su - second-user -c id`{{execute}}
   
   Add an entry on `/etc/fstab`:

   ```
   cat << EOF >> /etc/fstab
   user2@host01:/srv/project.cache  /home/second-user/project.cache  fuse.sshfs  noauto,x-systemd.automount,_netdev,user,idmap=user,follow_symlinks,identityfile=/home/second-user/.ssh/dvc-server,allow_other,default_permissions,uid=1002,gid=1002  0  0
   EOF
   ```{{execute}}
   
   Reload and restart systemctl:
   
   `systemctl daemon-reload`{{execute}}
   
   `systemctl list-unit-files --type automount`{{execute}}
   
   `systemctl restart 'home-second\x2duser-project.cache.automount'`{{execute}}
