if defined?(ChefSpec)

  def create_network_interfaces(resource_name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:network_interfaces, :create, resource_name)
  end

  def reload_network_interfaces(resource_name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:network_interfaces, :reload, resource_name)
  end

  def remove_network_interfaces(resource_name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:network_interfaces, :remove, resource_name)
  end

end
