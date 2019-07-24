![sim]https://github.com/Projects-OC/Objc/screenshots/Simulator.png




# 1、Build自增

Build Settings 配置项中，设置 Current Project Version 为选定的值（新工程一般设为 1）
agvtool 命令会根据这个值来递增 “Build” 号
另外需要再选择 Versioning System 的值为 Apple Generic
然后，在 Build Phases 中，点击 “+” 号，选择 “New Run Script Phase” 添加一个执行脚本，并设置以下脚本代码：
xcrun agvtool next-version -all
