--[[
#
# Show users information in groups 
#
# Features added:
# -- setrank on reply
# -- get users info with their IDs and @username
#
]]

do
local iman = 152046992 --put your id here(BOT OWNER ID)

local function setrank(msg, name, value) -- setrank function
  local hash = nil
  if msg.to.type == 'chat' then
    hash = 'rank:'..msg.to.id..':variables'
  end
  if hash then
    redis:hset(hash, name, value)
	return send_msg('chat#id'..msg.to.id, '賲賯丕賲 讴丕乇亘乇 ('..name..') 亘賴 '..value..' 鬲睾蹖蹖乇 丿丕丿賴 卮丿 ', ok_cb,  true)
  end
end
local function res_user_callback(extra, success, result) -- /info <username> function
  if success == 1 then  
  if result.username then
   Username = '@'..result.username
   else
   Username = '賳丿丕乇丿'
  end
    local text = '賳丕賲 讴丕賲賱 : '..(result.first_name or '')..' '..(result.last_name or '')..'\n'
               ..'蹖賵夭乇: '..Username..'\n'
               ..'丕蹖丿蹖 讴丕乇亘乇蹖 : '..result.id..'\n\n'
	local hash = 'rank:'..extra.chat2..':variables'
	local value = redis:hget(hash, result.id)
    if not value then
	 if result.id == tonumber(Arian) then
	   text = text..'賲賯丕賲 : 賲丿蹖乇 讴賱 乇亘丕鬲 (Executive Admin) \n\n'
	  elseif is_admin2(result.id) then
	   text = text..'賲賯丕賲 : 丕丿賲蹖賳 乇亘丕鬲 (Admin) \n\n'
	  elseif is_owner2(result.id, extra.chat2) then
	   text = text..'賲賯丕賲 : 賲丿蹖乇 讴賱 诏乇賵賴 (Owner) \n\n'
	  elseif is_momod2(result.id, extra.chat2) then
	    text = text..'賲賯丕賲 : 賲丿蹖乇 诏乇賵賴 (Moderator) \n\n'
      else
	    text = text..'賲賯丕賲 : 讴丕乇亘乇 (Member) \n\n'
	 end
   else
   text = text..'賲賯丕賲 : '..value..'\n\n'
  end
  local uhash = 'user:'..result.id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..result.id..':'..extra.chat2
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'鬲毓丿丕丿 倬蹖丕賲 賴丕蹖 賮乇爻鬲丕丿賴 卮丿賴 : '..user_info_msgs..'\n\n'
  text = text..'https://telegram.me/BlacklifeTGch'
  send_msg(extra.receiver, text, ok_cb,  true)
  else
	send_msg(extra.receiver, extra.user..' 賳丕賲 讴丕乇亘乇蹖 賲賵乇丿 賳馗乇 蹖丕賮鬲 賳卮丿.', ok_cb, false)
  end
end

local function action_by_id(extra, success, result)  -- /info <ID> function
 if success == 1 then
 if result.username then
   Username = '@'..result.username
   else
   Username = '賳丿丕乇丿'
 end
    local text = '賳丕賲 讴丕賲賱 : '..(result.first_name or '')..' '..(result.last_name or '')..'\n'
               ..'蹖賵夭乇: '..Username..'\n'
               ..'丕蹖丿蹖 讴丕乇亘乇蹖 : '..result.id..'\n\n'
  local hash = 'rank:'..extra.chat2..':variables'
  local value = redis:hget(hash, result.id)
  if not value then
	 if result.id == tonumber(Arian) then
	   text = text..'賲賯丕賲 : 賲丿蹖乇 讴賱 乇亘丕鬲 (Executive Admin) \n\n'
	  elseif is_admin2(result.id) then
	   text = text..'賲賯丕賲 : 丕丿賲蹖賳 乇亘丕鬲 (Admin) \n\n'
	  elseif is_owner2(result.id, extra.chat2) then
	   text = text..'賲賯丕賲 : 賲丿蹖乇 讴賱 诏乇賵賴 (Owner) \n\n'
	  elseif is_momod2(result.id, extra.chat2) then
	   text = text..'賲賯丕賲 : 賲丿蹖乇 诏乇賵賴 (Moderator) \n\n'
	  else
	   text = text..'賲賯丕賲 : 讴丕乇亘乇 (Member) \n\n'
	  end
   else
    text = text..'賲賯丕賲 : '..value..'\n\n'
  end
  local uhash = 'user:'..result.id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..result.id..':'..extra.chat2
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'鬲毓丿丕丿 倬蹖丕賲 賴丕蹖 賮乇爻鬲丕丿賴 卮丿賴 : '..user_info_msgs..'\n\n'
  text = text..'@GPMod Team'
  send_msg(extra.receiver, text, ok_cb,  true)
  else
  send_msg(extra.receiver, '丕蹖丿蹖 卮禺氐 賲賵乇丿 賳馗乇 丿乇 爻蹖爻鬲賲 孬亘鬲 賳卮丿賴 丕爻鬲.\n丕夭 丿爻鬲賵乇 夭蹖乇 丕爻鬲賮丕丿賴 讴賳蹖丿\n/info @username', ok_cb, false)
  end
end

local function action_by_reply(extra, success, result)-- (reply) /info  function
		if result.from.username then
		   Username = '@'..result.from.username
		   else
		   Username = '賳丿丕乇丿'
		 end
    local text = '賳丕賲 讴丕賲賱 : '..(result.from.first_name or '')..' '..(result.from.last_name or '')..'\n'
               ..'蹖賵夭乇: '..Username..'\n'
               ..'丕蹖丿蹖 讴丕乇亘乇蹖 : '..result.from.id..'\n\n'
	local hash = 'rank:'..result.to.id..':variables'
		local value = redis:hget(hash, result.from.id)
		 if not value then
		    if result.from.id == tonumber(Arian) then
		       text = text..'賲賯丕賲 : 賲丿蹖乇 讴賱 乇亘丕鬲 (Executive Admin) \n\n'
		     elseif is_admin2(result.from.id) then
		       text = text..'賲賯丕賲 : 丕丿賲蹖賳 乇亘丕鬲 (Admin) \n\n'
		     elseif is_owner2(result.from.id, result.to.id) then
		       text = text..'賲賯丕賲 : 賲丿蹖乇 讴賱 诏乇賵賴 (Owner) \n\n'
		     elseif is_momod2(result.from.id, result.to.id) then
		       text = text..'賲賯丕賲 : 賲丿蹖乇 诏乇賵賴 (Moderator) \n\n'
		 else
		       text = text..'賲賯丕賲 : 讴丕乇亘乇 (Member) \n\n'
			end
		  else
		   text = text..'賲賯丕賲 : '..value..'\n\n'
		 end
         local user_info = {}
  local uhash = 'user:'..result.from.id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..result.from.id..':'..result.to.id
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'鬲毓丿丕丿 倬蹖丕賲 賴丕蹖 賮乇爻鬲丕丿賴 卮丿賴 : '..user_info_msgs..'\n\n'
  text = text..' source by Dawsh_iman'
  send_msg(extra.receiver, text, ok_cb, true)
end

local function action_by_reply2(extra, success, result)
local value = extra.value
setrank(result, result.from.id, value)
end

local function run(msg, matches)
 if matches[1]:lower() == 'setrank' then
  local hash = 'usecommands:'..msg.from.id..':'..msg.to.id
  redis:incr(hash)
  if not is_sudo(msg) then
    return "Only for Sudo"
  end
  local receiver = get_receiver(msg)
  local Reply = msg.reply_id
  if msg.reply_id then
  local value = string.sub(matches[2], 1, 1000)
    msgr = get_message(msg.reply_id, action_by_reply2, {receiver=receiver, Reply=Reply, value=value})
  else
  local name = string.sub(matches[2], 1, 50)
  local value = string.sub(matches[3], 1, 1000)
  local text = setrank(msg, name, value)

  return text
  end
  end
 if matches[1]:lower() == 'info' and not matches[2] then
  local receiver = get_receiver(msg)
  local Reply = msg.reply_id
  if msg.reply_id then
    msgr = get_message(msg.reply_id, action_by_reply, {receiver=receiver, Reply=Reply})
  else
  if msg.from.username then
   Username = '@'..msg.from.username
   else
   Username = '賳丿丕乇丿'
   end
   local text = '賳丕賲 : '..(msg.from.first_name or '賳丿丕乇丿')..'\n'
   local text = text..'賮丕賲蹖賱 : '..(msg.from.last_name or '賳丿丕乇丿')..'\n'	
   local text = text..'蹖賵夭乇 : '..Username..'\n'
   local text = text..'丕蹖丿蹖 讴丕乇亘乇蹖 : '..msg.from.id..'\n\n'
   local hash = 'rank:'..msg.to.id..':variables'
	if hash then
	  local value = redis:hget(hash, msg.from.id)
	  if not value then
		if msg.from.id == tonumber(Arian) then
		 text = text..'賲賯丕賲 : 賲丿蹖乇 讴賱 乇亘丕鬲 (Executive Admin) \n\n'
		elseif is_sudo(msg) then
		 text = text..'賲賯丕賲 : 丕丿賲蹖賳 乇亘丕鬲 (Admin) \n\n'
		elseif is_owner(msg) then
		 text = text..'賲賯丕賲 : 賲丿蹖乇 讴賱 诏乇賵賴 (Owner) \n\n'
		elseif is_momod(msg) then
		 text = text..'賲賯丕賲 : 賲丿蹖乇 诏乇賵賴 (Moderator) \n\n'
		else
		 text = text..'賲賯丕賲 : 讴丕乇亘乇 (Member) \n\n'
		end
	  else
	   text = text..'賲賯丕賲 : '..value..'\n'
	  end
	end
    
	 local uhash = 'user:'..msg.from.id
 	 local user = redis:hgetall(uhash)
  	 local um_hash = 'msgs:'..msg.from.id..':'..msg.to.id
	 user_info_msgs = tonumber(redis:get(um_hash) or 0)
	 text = text..'鬲毓丿丕丿 倬蹖丕賲 賴丕蹖 賮乇爻鬲丕丿賴 卮丿賴 : '..user_info_msgs..'\n\n'
	 if msg.to.type == 'chat' then
	 text = text..'賳丕賲 诏乇賵賴 : '..msg.to.title..'\n'
     text = text..'丕蹖丿蹖 诏乇賵賴 : '..msg.to.id
    end
	text = text..'\n\n https://telegram.me/BlacklifeTGch Team'
    return send_msg(receiver, text, ok_cb, true)
    end
  end
  if matches[1]:lower() == 'info' and matches[2] then
   local user = matches[2]
   local chat2 = msg.to.id
   local receiver = get_receiver(msg)
   if string.match(user, '^%d+$') then
	  user_info('user#id'..user, action_by_id, {receiver=receiver, user=user, text=text, chat2=chat2})
    elseif string.match(user, '^@.+$') then
      username = string.gsub(user, '@', '')
      msgr = res_user(username, res_user_callback, {receiver=receiver, user=user, text=text, chat2=chat2})
   end
  end
end

return {
  description = 'Know your information or the info of a chat members.',
  usage = {
	'info: Return your info and the chat info if you are in one.',
	'(Reply)!info: Return info of replied user if used by reply.',
	'info <id>: Return the info\'s of the <id>.',
	'info @<user_name>: Return the member @<user_name> information from the current chat.',
	'setrank <userid> <rank>: change members rank.',
	'(Reply)setrank <rank>: change members rank.',
  },
  patterns = {
	"^[Ii][Nn][Ff][Oo]$",
	"^[Ii][Nn][Ff][Oo] (.*)$",
	"^[Ss][Ee][Tt][Rr][Aa][Nn][Kk] (%d+) (.*)$",
	"^[Ss][Ee][Tt][Rr][Aa][Nn][Kk] (.*)$",
  },
  run = run
}

end
