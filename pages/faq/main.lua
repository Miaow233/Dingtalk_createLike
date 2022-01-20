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
messageBuilder.append("1.获取不了UUID\n")
messageBuilder.append("注意：目前安卓10以上无法使用\n先检查是否授予了储存权限\n打开一次直播（回放也行），把软件后台清掉再打开\n多试几次，把钉钉后台清掉，打开进直播，再打开软件\n若实在不行请告诉我\n\n")
messageBuilder.append("2.老师禁赞了还能用吗\n")
messageBuilder.append("当然可以的，点赞是直接提交到后台，禁赞并无作用，可以结束后看一下点赞数量\n\n")
messageBuilder.append("3.点赞数变成0了\n")
messageBuilder.append("由于钉钉限制点赞数最高为2^32-1（差不多为21亿）超过这个数量会发生错误所以看到的是0\n所以尽量不要点太多\n\n")
messageBuilder.append("4.老师能看的是谁点的吗\n")
messageBuilder.append("看不到的，放心用（顶多老师把你们全班骂一顿doge）")
message.text=tostring(messageBuilder)

