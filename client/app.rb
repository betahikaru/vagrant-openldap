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

def json_list_wrapping(list)
  output = "{\"list\":["
  list.each do |str|
    output += str + ","
  end
  output.chop!
  output += "]}"
  return output
end

LDAP_HOST = "192.168.33.20"
LDAP_BASE_DN = "dc=betahikaru,dc=com"
LDAP_MANAGER_DN = "cn=Manager,dc=betahikaru,dc=com"
LDAP_MANAGER_PASS = "passwd"
ldap = Net::LDAP.new(
  host: LDAP_HOST,
  port: 389,
  auth: {
    method: :simple,
    username: LDAP_MANAGER_DN,
    password: LDAP_MANAGER_PASS
  }
)

begin
  if ldap.bind
    filter = Net::LDAP::Filter.eq("cn", "* Suzuki")
    serilized_entries = []
    ldap.search(base: LDAP_BASE_DN, filter: filter) do |entry|
      serilized_entries.push(serialize_ldap_entry(entry))
    end
    output = json_list_wrapping(serilized_entries)
  else
    output += "{ \"error\": \"authentication failed\" }"
    return
  end
rescue Net::LDAP::Error => e
  p e
end

puts output
