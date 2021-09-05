-- @author 寒歌
-- @description Main是应用的主模块，其中注册了应用运行中UI事件的回调、Activity生命周期的回调等
-- 你也可以在此编写启动事件代码，或控制应用运行逻辑、自定义应用UI等等。
-- @other 本模版已为你编写好基础事件，建议在阅读注释并理解相关参数意义后再进行扩展编写
-- 特别注意：本初始化模板为自定义视图演示模板，未提供其它功能使用示例，如需了解其它内置UI组件使用示例，请创建其它对应模板
--
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
messageBuilder.append("3.本应用使用Fusion制作，需要源码请联系我\n")
message.text=tostring(messageBuilder)

title.text="更新日志"
changelog.text=[[1.0.4
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

--设置按钮事件，弹出Snackbar
button.onClick=function()
  local File=luajava.bindClass("java.io.File")
  local Uri=luajava.bindClass("android.net.Uri")
  local Intent=luajava.bindClass("android.content.Intent")
  local s = "mqqwpa://im/chat?chat_type=wpa&uin=1293865264"
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(s)))
end
