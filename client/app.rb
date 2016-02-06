require 'rubygems'

# http://www.rubydoc.info/gems/net-ldap/Net/LDAP
require 'net/ldap'

def serialize_ldap_entry(entry)
  output = "{"
  output += "\"DN\":\"#{entry.dn}\","
  output += "\"attributes\":{"
  entry.each do |attribute, values|
    unless values.empty?
      output += "\"#{attribute}\":"
      output += "[" if values.length > 1
      values.each do |value|
        output += "\"#{value}\","
      end
      output.chop!
      output += "]" if values.length > 1
      output += ","
    end
  end
  output.chop!
  output += "}}"
  return output
end

ldap = Net::LDAP.new(
  host: "192.168.33.20",
  port: 389,
  auth: {
    method: :simple,
    username: "cn=Manager,dc=betahikaru,dc=com",
    password: "passwd"
  }
)

begin
  if ldap.bind
    filter = Net::LDAP::Filter.eq("cn", "* Suzuki")
    tree_base = "dc=betahikaru,dc=com"
    output = "{\"list\":["
    ldap.search(base: tree_base, filter: filter) do |entry|
      output += serialize_ldap_entry(entry)
      output += ","
    end
    output.chop!
    output += "]}"
  else
    output += "{ \"error\": \"authentication failed\" }"
    return
  end
rescue Net::LDAP::Error => e
  p e
end

puts output
