require "import"
import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.textfield.TextInputLayout"
import "android.widget.*"
import "android.view.WindowManager"
import "com.google.android.material.snackbar.Snackbar"
import "com.google.android.material.button.MaterialButton"
import "com.google.android.material.textfield.TextInputEditText"
import "android.graphics.Color"
import "net.fusionapp.core.ui.adapter.BasePagerAdapter"
import "android.os.Build"

--导入layout布局
import "layout"

--UI管理器
UiManager=this.UiManager
local viewPager=UiManager.viewPager

--加载layout
local list=ArrayList()
list.add(loadlayout(layout))
viewPager.setAdapter(BasePagerAdapter(list))

--设置卡片标题
title.text="钉钉点赞 by Miaow"

--设置卡片内容
Http.get("https://v1.jinrishici.com/all.txt",function(_, body)
  local messageBuilder=StringBuilder()
  messageBuilder.append("1.第一次启动请授予储存权限\n")
  messageBuilder.append("2.通过日志文件自动获取UUID\n")
  messageBuilder.append("3.合理使用,请勿传播\n")
  messageBuilder.append("4.如有问题请联系我")
  if body ~= "" then messageBuilder.append("\n\n" .. body:gsub("\n","")) end
  message.text=tostring(messageBuilder)
end)

--设置按钮事件
button_get_uuid.onClick=function()
  autoGetUuid()
end

--设置按钮事件
TotalCount = 0
button.onClick=function()
  local Uuid = getUuid()
  if Uuid == nil then return end
  local Count = getCount()
  if Count == nil
    return
   else
    remains = math.floor(Count % 100)
    times = math.floor(Count/100)
  end
  import "http"
  base_url = "https://lv.dingtalk.com/interaction/createLike?uuid=" .. Uuid .. "&count="
  s_times = 0
  function post(num)
    body = http.get(base_url .. tostring(num))
    if body:find("success")
      TotalCount = TotalCount + num
      s_times = s_times + 1
    end
  end
  if times ~= 0 then
    for i=1, times do
      post(100)
    end
  end
  if remains ~= 0 then post(tonumber(remains)) end
  --print(times, remains)
  --print(Count, s_times, TotalCount)

  if s_times ~= 0 then
     弹窗("成功")
     button.text = "GKD " .. TotalCount
   end
end

--侧滑栏点击事件
local functions={}
functions["常见问题"]=function()
  activity.newActivity("faq")
end
functions["关于"]=function()
  activity.newActivity("about")
end
--注册点击事件，如无其它需求，不用扩展写
function onDrawerListItemClick(data, recyclerView, listIndex, itemIndex)
  --侧滑栏列表的数据是二维结构，所以需要先获取到点击项目所在列表的数据
  local listData = data.get(listIndex);
  --获取到所在列表的数据后获取点击项目的数据
  local itemData = listData.get(itemIndex);
  --最后获取到点击的项目的标题
  local title = itemData.getTitle();
  local event=functions[title]
  if(event~=nil)then
    event()
  end
end

--获取编辑框输入的文本
function getUuid()
  local text= edit_text_uuid.text
  if text == "" then
    弹窗("请输入UUID")
    return
   elseif #text ~= 36 then
    弹窗("UUID不正确")
    return
   else
    return text
  end
end

function getCount()
  local text = edit_text_count.text
  if text == "" then
    弹窗("请输入数量")
    return
   elseif tonumber(text) < 0 or tonumber(text) > 1000 then
    弹窗("数量应在0 ~ 1000之间")
    return
   else
    return text
  end
end

--从日志文件获取UUID
function getUuidFromLog()
  local path = "/storage/emulated/0/Android/data/com.alibaba.android.rimet/files/logs"
  local function exec(cmd)
    local p=io.popen(string.format('%s',cmd))
    local s=p:read("*a")
    p:close()
    return s
  end

  local function getNewestFile(path)
    list = exec("ls " .. path)
    return list:sub(-18,-2)
  end

  local function getUserUid()
    for c in io.lines(path .. "/lwp_sdk/" .. getNewestFile(path .. "/lwp_sdk")) do
      if c:find("k_cookie")
        return c:match("k_cookie(.+)@dingding"):gsub("_","")
      end
    end
  end

  local UserUid = getUserUid()
  if UserUid == nil then return end
  local LiveLogPath = path .. "/trace/" .. UserUid .. "/live"
  local LiveLog = path .. "/trace/" .. UserUid .. "/live/" .. getNewestFile(LiveLogPath)
  local list = {}
  for c in io.lines(LiveLog) do
    if c:find("uuid = ")
      table.insert(list,c:match("uuid = (.+)"):sub(1, -2))
    end
  end
  return list[#list]
end

--弹窗函数
function 弹窗(text)
  local parent=UiManager.coordinatorLayout
  local duration=Snackbar.LENGTH_SHORT
  Snackbar.make(parent,text, duration)
  .setActionTextColor(Color.parseColor(UiManager.getColors().getColorAccent()))
  .setAction("OK",{onClick=function()
      --print("OK")
    end})
  .show()
end

--尝试自动获取UUID
function autoGetUuid()
  Uuid = getUuidFromLog()
  if Uuid == nil or Uuid == "" then
    弹窗("获取UUID失败，请手动填写")
   else
    弹窗("已为您自动获取UUID")
    edit_text_uuid.text = Uuid
  end

end

import "android.Manifest"
import "androidx.core.content.PermissionChecker"
if PermissionChecker.checkSelfPermission(activity,Manifest.permission.READ_EXTERNAL_STORAGE) == 0 then
  --autoGetUuid()
 else
  --申请储存权限
  import 'androidx.core.app.ActivityCompat'
  ActivityCompat.requestPermissions(activity,{Manifest.permission.READ_EXTERNAL_STORAGE}, 0)
end

if Build.VERSION.SDK_INT >= 30 then
  print("此应用在安卓10以上版本可能无法正常工作，请悉知")
end

