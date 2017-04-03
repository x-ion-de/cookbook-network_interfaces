Description
===========

Manage /etc/network/interfaces on Debian / Ubuntu

Requirements
============

Tested on:
* Ubuntu 12.04 and 14.04

Attributes
==========

Usage
=====
To use the LWRP provided by this cookbook, you just need to depend on it (no need to include the empty default recipe). The LWRP provides the actions:

* `:create` - overrides the original /etc/network/interfaces, creates /etc/network/interfaces.d/ and a file for each interface you want to create
* `:reload` - ifup;ifdown on the mentioned interface
* `:remove` - ifdown on the mentioned interface and removes the file in /etc/network/interfaces.d/

Simple example:

``` ruby
network_interfaces 'eth0' do
  address '172.16.88.2/24'
  gateway '172.16.88.1'
  method 'static'
end
```

It will be converted to:

```
auto eth0
iface eth0 inet static
  address 172.16.88.2/24
  gateway 172.16.88.1
```
