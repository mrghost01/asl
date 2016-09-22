local function kmake(rows)
local kb = {}
kb.keyboard = rows
kb.resize_keyboard = true
kb.selective = true
return kb
end
local function kmakerow(texts)
local row = {}
for i=1 , #texts do
row[i] = {text=URL.escape(texts[i])}
end
return row
end
local function start_menu()
local rw1_texts = {'Record or edit information'}
local rw2_texts = {'Direction for use','About us'}
local rows ={kmakerow(rw1_texts),kmakerow(rw2_texts)}
return kmake(rows)
end
local function asl_menu()
local rw1_texts = {'Main Menu','My information'}
local rw2_texts = {'Name','Age','Location'}
local rw3_texts = {'Education','Phone number','Marital status'}
local rw4_texts = {'Channel','Instagram','Website'}
local rows ={kmakerow(rw1_texts),kmakerow(rw2_texts),kmakerow(rw3_texts),kmakerow(rw4_texts)}
return kmake(rows)
end
local function back_menu()
local rw1_texts = {'Cancel'}
local rows ={kmakerow(rw1_texts)}
return kmake(rows)
end
local function bn_menu()
local rw1_texts = {'Cancel','I dont have'}
local rows ={kmakerow(rw1_texts)}
return kmake(rows)
end
local function age_menu()
local rw1_texts = {'Cancel','Dont show'}
local rw2_texts = {'10','11','12','13','14'}
local rw3_texts = {'15','16','17','18','19'}
local rw4_texts = {'20','21','22','23','24'}
local rw5_texts = {'25','26','27','28','29'}
local rw6_texts = {'30','31','32','33','34'}
local rw7_texts = {'36','37','38','39','40'}
local rw8_texts = {'41','42','43','44','45'}
local rw9_texts = {'46','47','48','49','50'}
local rows ={kmakerow(rw1_texts),kmakerow(rw2_texts),kmakerow(rw3_texts),kmakerow(rw4_texts),kmakerow(rw5_texts),kmakerow(rw6_texts),kmakerow(rw7_texts),kmakerow(rw8_texts),kmakerow(rw9_texts)}
return kmake(rows)
end
local function loc_menu()
local rw1_texts = {'Cancel','Dont show'}
local rw2_texts = {'Iran','United states','Russa'}
local rw3_texts = {'England','France','Canada'}
local rw4_texts = {'Itly','Netherland','Germany'}
local rw5_texts = {'Soain','China','Thialand'}
local rw6_texts = {'Jepan','North Korea','Suoth Korea'}
local rw7_texts = {'Poland','Brazil','Argentina'}
local rw8_texts = {'Chile','Portugal','Austrail'}
local rw9_texts = {'Turkey','Denmark','Sweden','Slovaki'}
local rw10_texts = {'Greece','Swazland','Vitnam','Mexico'}
local rows ={kmakerow(rw1_texts),kmakerow(rw2_texts),kmakerow(rw3_texts),kmakerow(rw4_texts),kmakerow(rw5_texts),kmakerow(rw6_texts),kmakerow(rw7_texts),kmakerow(rw8_texts),kmakerow(rw9_texts),kmakerow(rw10_texts)}
return kmake(rows)
end
local function rabete_menu()
local rw1_texts = {'Cancel','Dont show'}
local rw2_texts = {'Single','Married','Divorced'}
local rw3_texts = {'Engaged','In relationship'}
local rows ={kmakerow(rw1_texts),kmakerow(rw2_texts),kmakerow(rw3_texts)}
return kmake(rows)
end
local function savad_menu()
local rw1_texts = {'Cancel','Dont show'}
local rw2_texts = {'Student','collegian'}
local rw3_texts = {'Diploma','Associate Degree','licentiate'}
local rw4_texts = {'MA','PhD'}
local rows ={kmakerow(rw1_texts),kmakerow(rw2_texts),kmakerow(rw3_texts),kmakerow(rw4_texts)}
return kmake(rows)
end
local function action(msg)
if msg.text == '/start' then
db:hset('bot:waiting',msg.chat.id,'main')
local start = [[
`Instruction for use:
There are two steps to use this bot.
The first step :you should register your information like your name,age etc.
The second step :
You need your information to send it in the group ,chanels,chatrooms etc.
You should receive your information from this bot
*Expect of your name record the another thing is optional
It means you have to press your name but press another thing such as :age or sth like this
Is completely optional
*The intsruction for use( inline)
And wait till the option of bot coming
You can select the options and use it in the privacy chat ,groups,chanel etc.`
]]
api.sendMessage(msg.chat.id, start, true,msg.message_id, true,start_menu())
return
elseif msg.text == '/init' and msg.chat.id == bot_sudo then
bot_init(true)
api.sendReply(msg, '*Reloaded!*', true)
return
elseif msg.text == 'Direction for use' then
local help = [[
`Instruction for use:
There are two steps to use this bot.
The first step :you should register your information like your name,age etc.
The second step :
You need your information to send it in the group ,chanels,chatrooms etc.
You should receive your information from this bot
*Expect of your name record the another thing is optional
It means you have to press your name but press another thing such as :age or sth like this
Is completely optional
*The intsruction for use( inline)
And wait till the option of bot coming
You can select the options and use it in the privacy chat ,groups,chanel etc.`
]]
api.sendMessage(msg.chat.id, help, true,msg.message_id, true,start_menu())
return
elseif msg.text == 'About us' then
local pms = [[
*ASL Robot* _v beta_

`Robot share Profile product of` [GHOST Team](https://telegram.me/gpfmod)
Devloper: @mrghost_01
Tnx @sindex for Translation
tnx for umberllacopy team
]]
local keyboard = {}
    keyboard.inline_keyboard = {
{
{text = "Channel" , url = 'https://telegram.me/gpfmod'},
{text = "RoBoT" , url = 'https://telegram.me/aboutme_bot'}
}
}
api.sendMessage(msg.chat.id, pms, true,msg.message_id, true,keyboard)
return
end
local setup = db:hget('bot:waiting',msg.chat.id)
if setup == 'main' then
if msg.text == 'Record or edit information' then
local edit_asl = '`One of the options for recording, enter or edit information:`'
api.sendMessage(msg.chat.id, edit_asl, true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
end
elseif setup == 'editing' then
if msg.text == 'Main Menu' then
api.sendMessage(msg.chat.id, '`Main Menu:`', true,msg.message_id, true,start_menu())
db:hset('bot:waiting',msg.chat.id,'main')
elseif msg.text == 'My information' then
if not db:hget('bot:name',msg.chat.id) then
api.sendMessage(msg.chat.id, '`The name must be registered at least, is not currently registered with your specifications.`',true)
return
end
local name = db:hget('bot:name',msg.chat.id)
local age = db:hget('bot:age',msg.chat.id)
local loc = db:hget('bot:loc',msg.chat.id)
local savad = db:hget('bot:savad',msg.chat.id)
local rabete = db:hget('bot:rabete',msg.chat.id)
local site = db:hget('bot:site',msg.chat.id)
local channel = db:hget('bot:channel',msg.chat.id)
local insta = db:hget('bot:instagram',msg.chat.id)
local text = name
if age then
text = text .. '\n'..age..
end
if loc then
text = text .. '\nfrom '..loc
end
if savad then
text = text .. '\n'..savad
end
if rabete then
text = text .. '\n'..rabete
end
local keyboard = {}
local inkb = {}
if site then
inkb[(#inkb + 1)] = {text='Website',url='http://'..site}
end
if insta then
inkb[(#inkb + 1)] = {text='Instagram',url='http://instagram.com/'..insta}
end
if channel then
inkb[(#inkb + 1)] = {text='Channel',url='https://telegram.me/'..channel}
end
keyboard.inline_keyboard={inkb}
if channel or insta or site then
api.sendMessage(msg.chat.id,text..'\n.', true,nil, nil,keyboard)
else
api.sendMessage(msg.chat.id,text..'\n.')
end
elseif msg.text == 'Name' then
db:hset('bot:waiting',msg.chat.id,'membername')
api.sendMessage(msg.chat.id, 'Enter your name up to 50 characters:\nName may Persian characters and English letters and emoji, etc.', true,msg.message_id, true,back_menu())
elseif msg.text == 'Age' then
db:hset('bot:waiting',msg.chat.id,'memberage')

api.sendMessage(msg.chat.id,'Enter your age:\nIs allowed only between 10 to 50 years ...', true,msg.message_id, true,age_menu())
elseif msg.text == 'Marital status' then
db:hset('bot:waiting',msg.chat.id,'memberrabete')
api.sendMessage(msg.chat.id,'Select your Marital status:', true,msg.message_id, true,rabete_menu())
elseif msg.text == 'Location' then
db:hset('bot:waiting',msg.chat.id,'memberloc')
api.sendMessage(msg.chat.id,'Select your location:\nIf not on the list can send their name and type ...', true,msg.message_id, true,loc_menu())
elseif msg.text == 'Education' then
db:hset('bot:waiting',msg.chat.id,'membersavad')
api.sendMessage(msg.chat.id,'Enter your education:', true,msg.message_id, true,savad_menu())
elseif msg.text == 'Website' then
db:hset('bot:waiting',msg.chat.id,'membersite')
api.sendMessage(msg.chat.id,'Enter your blog or website:\nEnter No http: // , for example,:\nmrghost.ir', true,msg.message_id, true,bn_menu())

elseif msg.text == 'Channel' then
db:hset('bot:waiting',msg.chat.id,'memberchannel')
api.sendMessage(msg.chat.id,'Enter your channel username :\nLinks are not accepted, example:\n@gpfmod', true,msg.message_id, true,bn_menu())

elseif msg.text == 'Instagram' then
db:hset('bot:waiting',msg.chat.id,'memberinstagram')
api.sendMessage(msg.chat.id,'Enter your Instagram username :\nexample:\ngpfmod', true,msg.message_id, true,bn_menu())

elseif msg.text == 'Phone number' then
db:hset('bot:waiting',msg.chat.id,'membernumber')
api.sendMessage(msg.chat.id,'Enter your Phone number\nThis number is not send in your information so To connect your key', true,msg.message_id, true,bn_menu())
end
elseif setup == 'membername' then
if msg.text then
if msg.text == 'Cancel' then
local edit_asl = '`One of the options for recording, enter or edit information:`'
api.sendMessage(msg.chat.id, edit_asl, true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
return
end
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hset('bot:name',msg.chat.id,msg.text)
end
elseif setup == 'memberage' then
if msg.text then
if msg.text == 'Cancel' then
local edit_asl = '`One of the options for recording, enter or edit information:`'
api.sendMessage(msg.chat.id, edit_asl, true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
return
end
if msg.text == 'Dont show' then
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hdel('bot:age',msg.chat.id)
return
end
if msg.text:match('^%d+$') and tonumber(msg.text) <= 50 and tonumber(msg.text) >= 10 then
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hset('bot:age',msg.chat.id,msg.text)
else 
api.sendMessage(msg.chat.id,'`Minimum age is 10 and a maximum of 50 years..`',true)
end
end
elseif setup == 'memberloc' then
if msg.text then
if msg.text == 'Cancel' then
local edit_asl = '`One of the options for recording, enter or edit information:`'
api.sendMessage(msg.chat.id, edit_asl, true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
return
end
if msg.text == 'Dont show' then
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hdel('bot:loc',msg.chat.id)
return
end
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hset('bot:loc',msg.chat.id,msg.text)
end
elseif setup == 'memberrabete' then
if msg.text then
if msg.text == 'Cancel' then
local edit_asl = '`One of the options for recording, enter or edit information:`'
api.sendMessage(msg.chat.id, edit_asl, true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
return
end
if msg.text == 'Dont show' then
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hdel('bot:rabete',msg.chat.id)
return
end
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hset('bot:rabete',msg.chat.id,msg.text)
end
elseif setup == 'membersavad' then
if msg.text then
if msg.text == 'Cancel' then
local edit_asl = '`One of the options for recording, enter or edit information:`'
api.sendMessage(msg.chat.id, edit_asl, true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
return
end
if msg.text == 'Dont show' then
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hdel('bot:savad',msg.chat.id)
return
end
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hset('bot:savad',msg.chat.id,msg.text)
end
elseif setup == 'memberchannel' then
if msg.text then
if msg.text == 'Cancel' then
local edit_asl = '`One of the options for recording, enter or edit information:`'
api.sendMessage(msg.chat.id, edit_asl, true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
return
end
if msg.text == 'I dont have' then
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hdel('bot:channel',msg.chat.id)
return
end
local chusername = msg.text:match('^@([a-zA-Z0-9]+)$')
if chusername then
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hset('bot:channel',msg.chat.id,chusername)
end
end
elseif setup == 'memberinstagram' then
if msg.text then
if msg.text == 'Cancel' then
local edit_asl = '`One of the options for recording, enter or edit information:`'
api.sendMessage(msg.chat.id, edit_asl, true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
return
end
if msg.text == 'I dont have' then
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hdel('bot:instagram',msg.chat.id)
return
end
local chusername = msg.text:match('^([a-zA-Z0-9%._]+)$')
if chusername then
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hset('bot:instagram',msg.chat.id,chusername)
end
end
elseif setup == 'membersite' then
if msg.text then
if msg.text == 'Cancel' then
local edit_asl = '`One of the options for recording, enter or edit information:`'
api.sendMessage(msg.chat.id, edit_asl, true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
return
end
if msg.text == 'I dont have' then
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hdel('bot:site',msg.chat.id)
return
end
local chusername = msg.text:match('^https?://([%w-_%.%?%.:/%+=&]+)$')
if chusername then
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hset('bot:site',msg.chat.id,chusername)
end
end
elseif setup == 'membernumber' then
if msg.text then
if msg.text == 'Cancel' then
local edit_asl = '`One of the options for recording, enter or edit information:`'
api.sendMessage(msg.chat.id, edit_asl, true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
return
end
if msg.text == 'I dont have' then
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hdel('bot:number',msg.chat.id)
return
end
if msg.text:match('^[1-9][0-9]+$') and msg.text:len() == 10 then
local num = ..msg.text
api.sendMessage(msg.chat.id ,'Information was recorded.\n`One of the options for recording, enter or edit information:`', true,msg.message_id, true,asl_menu())
db:hset('bot:waiting',msg.chat.id,'editing')
db:hset('bot:number',msg.chat.id,num)
end
end
end
end

local function iaction(inline)
local qresult = {}
local name = db:hget('bot:name',inline.from.id)
if name then
local number = db:hget('bot:number',inline.from.id)
if number then
local result = {}
result.id = tostring(#qresult + 1)
 result.type = 'contact'
 result.thumb_url = URL.escape('http://apktools.ir/wp-content/uploads/2016/07/telegram-icon.png')
 result.first_name = URL.escape(name)
 result.phone_number = URL.escape(number)
  qresult[#qresult + 1] = result
end
local result = {}
result.id = tostring(#qresult + 1)
 result.type = 'article'
 result.thumb_url = URL.escape('http://opload.ir/im/6m95/bf945d3115d93.jpg')
 result.description = URL.escape('Click here to view your information')
 result.title = URL.escape('Send profile')
local age = db:hget('bot:age',inline.from.id)
local loc = db:hget('bot:loc',inline.from.id)
local savad = db:hget('bot:savad',inline.from.id)
local rabete = db:hget('bot:rabete',inline.from.id)
local site = db:hget('bot:site',inline.from.id)
local channel = db:hget('bot:channel',inline.from.id)
local insta = db:hget('bot:instagram',inline.from.id)
local text = name
if age then
text = text .. '\n'..age.. 
end
if loc then
text = text .. '\nfrom '..loc
end
if savad then
text = text .. '\n'..savad
end
if rabete then
text = text .. '\n'..rabete
end
local keyboard = {}
local inkb = {}
if site then
inkb[(#inkb + 1)] = {text=URL.escape('Website'),url=URL.escape('http://'..site)}
end
if insta then
inkb[(#inkb + 1)] = {text=URL.escape('Instagram'),url=URL.escape('http://instagram.com/'..insta)}
end
if channel then
inkb[(#inkb + 1)] = {text=URL.escape('Channel'),url=URL.escape('https://telegram.me/'..channel)}
end
keyboard.inline_keyboard={inkb}
if channel or insta or site then
result.reply_markup = keyboard
end
 result.message_text = URL.escape(text..'\n⛱ @aboutme_bot')
 qresult[#qresult + 1] = result
api.sendInline(inline.id, qresult,0)
else
local result = {}
result.id = tostring(#qresult + 1)
 result.type = 'article'
 result.thumb_url = URL.escape('http://seemorgh.com/images/content/news/1394/02/0000000000000000000000000011errrrerW.jpg')
 result.description = URL.escape('You still have to register, please visit the robot to register their information')
 result.title = URL.escape('No information available')
result.message_text = URL.escape('You still have to register, please visit the robot to register their information')
keyboard = {}
keyboard.inline_keyboard = {{{text=URL.escape('Registration at Robot'),url=URL.escape('https://telegram.me/aboutme_bot')}}}
result.reply_markup = keyboard
 qresult[#qresult + 1] = result
api.sendInline(inline.id, qresult,0)
end
end


return {
action = action,
iaction = iaction
}
