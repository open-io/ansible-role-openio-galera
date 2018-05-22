
[![Build Status](https://travis-ci.org/open-io/ansible-role-openio-galera.svg?branch=master)](https://travis-ci.org/open-io/ansible-role-openio-galera)
# Ansible role `galera`

An Ansible role for install and configure a MariaDB Galera Cluster. Specifically, the responsibilities of this role are to:

- Install packages
- Configure the replication

## Requirements

- Ansible 2.4+

## Role Variables


| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `openio_galera_bind_interface` | `eth0` | By default, the role retrieves IP addresses from the nodes group from the default network interface. |
| `openio_galera_bind_address` | `hostvars[inventory_hostname]['ansible_' + openio_galera_bind_interface]['ipv4']['address']` | Overrides the IP address used to setup the cluster. |
| `openio_galera_binlog_format` | `ROW` | ... |
| `openio_galera_cluster_name` | `openio` | ... |
| `openio_galera_databases` | `[]` | Creates databases for your cluster. |
| `openio_galera_data_dir` | `/var/lib/mysql` | ... |
| `openio_galera_default_storage_engine` | `InnoDB` | ... |
| `openio_galera_innodb_autoinc_lock_mode` | `2` | ... |
| `openio_galera_innodb_flush_log_at_trx_commit` | `0` | ... |
| `openio_galera_master_node` | `groups[openio_galera_nodes_group][0]` | By default, the master node is the first node defined in the nodes group. |
| `openio_galera_mysql_user` | `mysql` | ... |
| `openio_galera_nodes_group` | `openio_galera` | ... |
| `openio_galera_root_user` | `root` | ... |
| `openio_galera_root_password` | `root` | Required. Please change the default root password. |
| `openio_galera_sst_user` | `sstuser` | ... |
| `openio_galera_sst_password` | `sstpassword` | Required. Please change the default sstpassword. |
| `openio_galera_swappiness` | `0` | ... |
| `openio_galera_sync_binlog` | `0` | ... |
| `openio_galera_users` | `[]` | Creates users for your cluster. |
| `openio_galera_version` | `10.1` | ... |
| `openio_galera_wsrep_certify_nonPK` | `ON` | ... |
| `openio_galera_wsrep_cluster_address` | `` | ... |
| `openio_galera_wsrep_max_ws_rows` | `"131072"` | ... |
| `openio_galera_wsrep_max_ws_size` | `"1073741824"` | ... |
| `openio_galera_wsrep_sst_method` | `xtrabackup-v2` | ... |

## Dependencies

- You have to use this role after the role `ansible-role-openio-repository` (like [this](https://github.com/open-io/ansible-role-openio-gridinit/blob/docker-tests/test.yml#L7)).

## Example Playbook

```yaml
- hosts: all
  gather_facts: true
  become: true
  roles:
    - role: openio-repo
    - role: openio-galera
      openio_galera_bind_interface: bond0
      openio_galera_root_password: mysecretrootpassword
      openio_galera_wsrep_sst_password: mysecretsstpassword
      openio_galera_cluster_name: myclustername
```

```yaml
- hosts: all
  gather_facts: true
  become: true
  roles:
    - role: openio-repo
    - role: openio-galera
      openio_galera_root_password: mysecretrootpassword
      openio_galera_wsrep_sst_password: mysecretsstpassword
      openio_galera_cluster_name: myclustername
      openio_galera_master_node: 172.17.0.2
      openio_galera_wsrep_cluster_address: gcomm://172.17.0.2,172.17.0.3,172.17.0.4

```


```ini
[openio_galera]
node1 ansible_host=192.168.1.173
node2 ansible_host=192.168.1.174
node3 ansible_host=192.168.1.175
```

## Contributing

Issues, feature requests, ideas are appreciated and can be posted in the Issues section.

Pull requests are also very welcome.
The best way to submit a PR is by first creating a fork of this Github project, then creating a topic branch for the suggested change and pushing that branch to your own fork.
Github can then easily create a PR based on that branch.

## License

Apache License, Version 2.0

## Contributors

- [Cedric DELGEHIER](https://github.com/cdelgehier/) (maintainer)
- [Romain Acciari](https://github.com/racciari/) (maintainer)
