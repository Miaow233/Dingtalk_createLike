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


--设置卡片标题
title.text="常见问题解答"
--设置卡片内容
local messageBuilder=StringBuilder()
messageBuilder.append("Q：我获取不了UUID\n")
messageBuilder.append("A：检查是否授予了储存权限")
messageBuilder.append("2.Support all widgets from androidx and design package")
message.text=tostring(messageBuilder)
