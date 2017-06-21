use_inline_resources
action :create do
  file '/etc/network/interfaces' do
    content "# Managed by cookbook network_interfaces\n"\
      "auto lo\niface lo inet loopback\n\nsource /etc/network/interfaces.d/*\n"
    mode '0644'
    owner 'root'
    group 'root'
  end

  directory '/etc/network/interfaces.d' do
    owner 'root'
    group 'root'
    mode '0755'
  end

  if node['network_interfaces']['autoinstall_packages']
    package 'ifmetric' if new_resource.metric
    package 'bridge-utils' if new_resource.bridge_ports
    package 'vlan' if new_resource.vlan_dev
    package 'ifenslave-2.6' if new_resource.bond_slaves
  end

  if node['network_interfaces']['autoload_modules']
    modules '8021q' if new_resource.vlan_dev
    modules 'bonding' if new_resource.bond_slaves
  end

  template "/etc/network/interfaces.d/#{new_resource.device}" do
    cookbook 'network_interfaces'
    source 'interfaces.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      auto:         new_resource.onboot,
      iface_method:       new_resource.iface_method,
      device:       new_resource.device,
      family:       new_resource.family,
      address:      new_resource.address,
      gateway:      new_resource.gateway,
      broadcast:    new_resource.broadcast,
      bridge_ports: new_resource.bridge_ports,
      bridge_stp:   new_resource.bridge_stp,
      vlan_dev:     new_resource.vlan_dev,
      bond_slaves:  new_resource.bond_slaves,
      bond_master:  new_resource.bond_master,
      bond_miimon:  new_resource.bond_miimon,
      bond_lacp_rate:  new_resource.bond_lacp_rate,
      bond_mode:    new_resource.bond_mode,
      metric:       new_resource.metric,
      mtu:          new_resource.mtu,
      pre_up:       new_resource.pre_up,
      up:           new_resource.up,
      post_up:      new_resource.post_up,
      pre_down:     new_resource.pre_down,
      down:         new_resource.down,
      post_down:    new_resource.post_down,
      custom:       new_resource.custom
    )
  end
end

action :reload do
  execute "reload #{new_resource.name}" do
    command "ifdown #{new_resource.device};ifup #{new_resource.device}"
  end
end

action :remove do
  execute "if_down #{new_resource.name}" do
    command "ifdown #{new_resource.device}"
  end

  file "/etc/network/interfaces.d/#{new_resource.device}" do
    action :delete
  end
end
