require"import"
import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.textfield.TextInputLayout"
import "android.widget.*"
import "android.view.WindowManager"
import "com.google.android.material.snackbar.Snackbar"
import "com.google.android.material.button.MaterialButton"
import "com.google.android.material.textfield.TextInputEditText"
import "android.graphics.Color"
import "net.fusionapp.core.ui.adapter.BasePagerAdapter"

Uri = luajava.bindClass("android.net.Uri")
Intent = luajava.bindClass("android.content.Intent")

--导入layout布局
import "layout"

--UI管理器
UiManager=this.UiManager
local viewPager=UiManager.viewPager

--加载layout
local list=ArrayList()
list.add(loadlayout(layout))
viewPager.setAdapter(BasePagerAdapter(list))

--设置卡片内容
local messageBuilder=StringBuilder()
messageBuilder.append("1.上网课时无聊写出来的小玩具\n")
messageBuilder.append("2.相比其它刷赞手段，最大特点就是可以自动获取UUID了\n")
messageBuilder.append("3.本应用使用Fusion制作，已开源至Github")
message.text=tostring(messageBuilder)

title.text="更新日志"
changelog.text=[[1.0.8
修复刷赞无效的问题
调整刷赞限制
更换更新方式

1.0.7
修改更新地址

1.0.6
加入检查更新

1.0.5
修改部分内容
添加常见问题页面

1.0.4
优化UI

1.0.3
修复无法获取最新UUID的问题

1.0.2
支持自动获取UUID

1.0.1
更改图标
加入侧滑栏

1.0.0
第一版]]

joinGroup.onClick = function()
  local s = "mqqapi://card/show_pslcard?src_type=internal&version=1&uin=164725525&card_type=group&source=qrcode"
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(s)))
end

checkUpdate.onClick = function()
  --检查更新
  print("正在检查更新")
  Http.get("https://raw.fastgit.org/Miaow233/Dingtalk_createLike/main/latest.txt",function(code,body)
    if code == 200 then
      local json = require "json"
      local data = json.decode(body)
      local newName = data["versionName"]
      local newCode = data["versionCode"]
      local url = data["url"]
      if this.getPackageManager().getPackageInfo(this.getPackageName(),64).versionCode ~= tonumber(newCode) then
        local parent=UiManager.coordinatorLayout
        local duration=Snackbar.LENGTH_SHORT
        import "androidx.appcompat.app.AlertDialog"
        AlertDialog.Builder(this)
        .setTitle("更新")
        .setMessage("检查到新版本：" .. newName)
        .setNegativeButton("取消",null)
        .setPositiveButton("加群获取更新",function()
          local s = "mqqapi://card/show_pslcard?src_type=internal&version=1&uin=164725525&card_type=group&source=qrcode"
          activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(s)))
        end)
        --[[
        .setPositiveButton("获取更新",function()
          --创建一个bundle，用于传递参数
          --如果没有参数，则不要传递bundle
          local Bundle = luajava.bindClass "android.os.Bundle"
          local bundle=Bundle()
          bundle.putString("key",url)
          activity.startFusionActivity("update", bundle)
        end)]]
        --.setCancelable(false)
        .create()
        .show()
       else
        弹窗("已是最新版本")
      end
     else
      print("检查更新失败")
    end
  end)
end

reportBugs.onClick = function()
  local s = "mqqwpa://im/chat?chat_type=wpa&uin=1293865264"
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(s)))
end
