require_relative 'spec_helper'

describe 'network_interfaces::spec_recipe' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: ['network_interfaces'])
      .converge(described_recipe)
  end

  it 'creates a network interface with the lwrp' do
    expect(chef_run).to create_network_interfaces('spec')
      .with(device: 'spec',
            bridge_ports: %w(spec1 spec2),
            bridge_stp: true,
            bond_slaves: %w(spec3 spec4),
            bond_master: 'spec5',
            bond_miimon: 100,
            bond_lacp_rate: 1,
            bond_mode: 4,
            vlan_dev: 'spec6',
            onboot: true,
            bootproto: 'dhcp',
            method: 'dhcp',
            family: 'inet',
            address: '1.2.3.4/24',
            gateway: '1.2.3.1',
            metric: 1,
            mtu: 1500,
            broadcast: '1.2.3.255',
            pre_up: 'pre_up',
            up: 'up',
            post_up: 'post_up',
            pre_down: 'pre_down',
            down: 'down',
            post_down: 'post_down',
            custom:  { custom: 'hash' }
           )
  end

  it 'create the /etc/network/interfaces.d/directory' do
    expect(chef_run).to create_directory('/etc/network/interfaces.d')
      .with(mode: '0755', owner: 'root', group: 'root')
  end

  it 'creates the /etc/network/interfaces file' do
    expect(chef_run).to create_file('/etc/network/interfaces')
      .with_content "# Managed by cookbook network_interfaces\n"\
      "auto lo\niface lo inet loopback\n\nsource /etc/network/interfaces.d/*\n"
  end

  it 'renders the template for the interface correctly' do
    [/^auto spec$/,
     /^iface spec inet dhcp$/,
     /address 1.2.3.4\/24$/,
     /broadcast 1.2.3.255$/,
     /gateway 1.2.3.1$/,
     /vlan_raw_device spec6$/,
     /bridge_ports spec1 spec2$/,
     /bridge_stp on$/,
     /bond-slaves spec3 spec4$/,
     /bond-master spec5$/,
     /bond-miimon 100$/,
     /bond-lacp-rate 1$/,
     /bond-mode 4$/,
     /metric 1$/,
     /mtu 1500$/,
     /pre-up pre_up$/,
     /up up$/,
     /post-up post_up$/,
     /pre-down pre_down$/,
     /down down$/,
     /post-down post_down$/,
     /custom hash$/].each do |line|
       expect(chef_run).to render_file('/etc/network/interfaces.d/spec')
         .with_content(line)
     end
  end

  it 'reloads the interface with the lwrp' do
    expect(chef_run).to reload_network_interfaces('specreload')
  end

  it 'executes the reload' do
    expect(chef_run).to run_execute('reload specreload')
      .with(command: 'ifdown specreload;ifup specreload')
  end

  it 'removes the interface with the lwrp' do
    expect(chef_run).to remove_network_interfaces('specremove')
  end

  it 'executes the ifdown before removing' do
    expect(chef_run).to run_execute('ifdown specremove')
  end

  it 'removes the interface file' do
    expect(chef_run).to delete_file('/etc/network/interfaces.d/specremove')
  end
end
