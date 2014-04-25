
-- Check package is not already loaded
local master = diffusion or {}
if master.utilities ~= nil then
	return master.utilities
end

local f_ip_dsthost  = Field.new("ip.dst_host")
local f_ip_srchost  = Field.new("ip.src_host")
local f_ipv6_dsthost  = Field.new("ipv6.dst_host")
local f_ipv6_srchost  = Field.new("ipv6.src_host")

-- Get the src host either from IPv4 or IPv6
local function srcHost()
	local ipv4SrcHost = f_ip_srchost()
	if ipv4SrcHost == nil then
		return f_ipv6_srchost().value
	else
		return ipv4SrcHost.value
	end
end

-- Get the dst host either from IPv4 or IPv6
local function dstHost()
	local ipv4DstHost = f_ip_dsthost()
	if ipv4DstHost == nil then
		return f_ipv6_dsthost().value
	else
		return ipv4DstHost.value
	end
end

local function dump(o)
	if type(o) == 'table' then
	local s = '{ '
	for k,v in pairs(o) do
	if type(k) ~= 'number' then k = '"'..k..'"' end
		s = s .. '['..k..'] = ' .. dump(v) .. ','
	end
		return s .. '} '
	else
		return tostring(o)
	end
end

-- Export package
master.utilities = {
	srcHost = srcHost,
	dstHost = dstHost,
	dump = dump,
	f_tcp_stream  = Field.new("tcp.stream"),
	f_tcp_srcport = Field.new("tcp.srcport"),
	f_frame_number = Field.new("frame.number"),
	RD = 1,
	FD = 2
}
diffusion = master
return master.utilities
