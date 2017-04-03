def initialize(*args)
  super
  @action = :create
end

actions :create, :reload, :remove

attribute :device, kind_of: String, name_attribute: true
attribute :bridge_ports, kind_of: [Array]
attribute :bridge_stp, kind_of: [TrueClass, FalseClass]
attribute :bond_slaves, kind_of: Array
attribute :bond_master, kind_of: String
attribute :bond_miimon, kind_of: Integer
attribute :bond_lacp_rate, kind_of: Integer
attribute :bond_mode, kind_of: [String, Integer]
attribute :vlan_dev, kind_of: String
attribute :onboot, kind_of: [TrueClass, FalseClass], default: true
attribute :bootproto, kind_of: String
attribute :method, kind_of: String
attribute :family, kind_of: String, default: 'inet'
attribute :address, kind_of: String
attribute :gateway, kind_of: String
attribute :metric, kind_of: Integer
attribute :mtu, kind_of: Integer
attribute :broadcast, kind_of: String
attribute :pre_up, kind_of: String
attribute :up, kind_of: [String, Array]
attribute :post_up, kind_of: String
attribute :pre_down, kind_of: String
attribute :down, kind_of: [String, Array]
attribute :post_down, kind_of: String
attribute :custom, kind_of: Hash
