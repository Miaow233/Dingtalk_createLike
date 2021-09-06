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

Uri=luajava.bindClass("android.net.Uri")
Intent=luajava.bindClass("android.content.Intent")

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
messageBuilder.append("3.本应用使用Fusion制作，源码已开源至Github")
message.text=tostring(messageBuilder)

title.text="更新日志"
changelog.text=[[1.0.7
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

reportBugs.onClick=function()
  local s = "mqqwpa://im/chat?chat_type=wpa&uin=1293865264"
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(s)))
end

joinGroup.onClick=function()
  local s = "mqqapi://card/show_pslcard?src_type=internal&version=1&uin=164725525&card_type=group&source=qrcode"
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(s)))
end
