local intent=activity.getIntent()
local uiManager=activity.getUiManager()

--获取当前页面的WebView
local webView=uiManager.getCurrentFragment().getWebView()

webView.loadUrl(intent.getStringExtra("key"))
--print(intent.getStringExtra("key"))