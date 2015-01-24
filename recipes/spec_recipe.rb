## Just for testing the LWRP, do NOT try this at home kids :D

network_interfaces 'spec' do
  bridge_ports %w(spec1 spec2)
  bridge_stp true
  bond_slaves %w(spec3 spec4)
  bond_master 'spec5'
  bond_miimon 100
  bond_lacp_rate 1
  bond_mode 4
  vlan_dev 'spec6'
  onboot true
  bootproto 'dhcp'
  method 'dhcp'
  family 'inet'
  address '1.2.3.4/24'
  gateway '1.2.3.1'
  metric 1
  mtu 1500
  broadcast '1.2.3.255'
  pre_up 'pre_up'
  up 'up'
  post_up 'post_up'
  pre_down 'pre_down'
  down 'down'
  post_down 'post_down'
  custom(custom: 'hash')
end

network_interfaces 'specreload' do
  action :reload
end

network_interfaces 'specremove' do
  action :remove
end
