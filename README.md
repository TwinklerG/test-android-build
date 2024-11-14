# 基于Docker的安卓自动化构建工作流

将Dockerfile和compose.yml拷贝至安卓项目的根目录，执行命令

```bash
docker compose up
```

构建完成后会在项目根目录生成outputs文件夹

APK文件存在于`./outputs/apk/release/app-release-unsigned.apk`

> 提示: 第一次构建速度较慢，且需要科学上网。耐心等待即可