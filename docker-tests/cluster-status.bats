#! /usr/bin/env bats

# Variable SUT_IP should be set outside this script and should contain the IP
# address of the System Under Test.

user='travis'
pass='travispw'

# Tests
@test 'Anonymous access should not work' {
  run mysql -Bs -u'' -h ${SUT_IP} -e ';'

  echo "output: "$output
  echo "status: "$status

  [ ${status} -eq 1 ]
}

@test 'Travis user connection' {
  run mysql -Bs -u${user} -p${pass} -h ${SUT_IP} -e ';'

  echo "output: "$output
  echo "status: "$status

  [ "${status}" -eq "0" ]
}

@test 'Number of nodes in cluster' {
  run bash -c "mysql -Bs -u${user} -p${pass} -h ${SUT_IP} -e 'show global status where variable_name = \"wsrep_cluster_size\"' | tr -s '\t' ' '"

  echo "output: "${output: -1}
  echo "status: "$status

  [ "${status}" -eq "0" ]
  [ "${output: -1}" = "3" ]
}

@test 'The node can accept queries' {
  run bash -c "mysql -Bs -u${user} -p${pass} -h ${SUT_IP} -e 'show global status where variable_name = \"wsrep_ready\"' | tr -s '\t' ' '"

  echo "output: "${output: -2}
  echo "status: "$status

  [ "${status}" -eq "0" ]
  [ "${output: -2}" = "ON" ]
}

@test 'the node has network connectivity with any other nodes' {
  run bash -c "mysql -Bs -u${user} -p${pass} -h ${SUT_IP} -e 'show global status where variable_name = \"wsrep_connected\"' | tr -s '\t' ' '"

  echo "output: "${output: -2}
  echo "status: "$status

  [ "${status}" -eq "0" ]
  [ "${output: -2}" = "ON" ]
}
