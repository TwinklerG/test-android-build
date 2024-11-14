############################################################################
#  Based on: https://blog.csdn.net/hbdatouerzi/article/details/135146593   #
############################################################################

# 基于ubuntu基础镜像
FROM ubuntu:latest

# 安装常用命令
RUN apt-get update \
&& apt-get install -y curl \
    && apt-get install -y wget \
    && apt-get install -y zip \
    && apt-get install -y unzip \
    && apt-get install -y tar \
    && apt-get install -y lsof \
    && apt-get install -y git \
    && apt-get install -y git-lfs \
    && git lfs install \
    && apt-get install -y tar \
    && apt-get install -y python3 \
    && apt-get clean all


#设置工作目录
WORKDIR /home

# 下载jdk和android commandline-tools
RUN wget https://download.oracle.com/java/23/latest/jdk-23_linux-x64_bin.tar.gz \
&& wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip

# 设置java环境
RUN wget https://download.oracle.com/java/23/latest/jdk-23_linux-x64_bin.tar.gz \
&& mkdir -p /opt/app/jdk \
&& tar -xzvf jdk-23_linux-x64_bin.tar.gz -C /opt/app/jdk \
&& rm jdk-23_linux-x64_bin.tar.gz
ENV JAVA_HOME=/opt/app/jdk/jdk-23.0.1
ENV PATH=$PATH:$JAVA_HOME/bin

# 设置android环境
RUN mkdir -p /opt/app/android-sdk \
&& ls && unzip commandlinetools-linux-11076708_latest.zip -d /opt/app/android-sdk/ \
&& rm commandlinetools-linux-11076708_latest.zip \
&& mkdir -p /opt/app/android-sdk/cmdline-tools/latest \
&& find /opt/app/android-sdk/cmdline-tools/ -maxdepth 1 -mindepth 1 -not -name 'latest' -exec mv {} /opt/app/android-sdk/cmdline-tools/latest/ \;
ENV ANDROID_HOME=/opt/app/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

# 安装需要的platforms和build-tools版本
RUN yes | /opt/app/android-sdk/cmdline-tools/latest/bin/sdkmanager "platforms;android-34" \
    && yes | /opt/app/android-sdk/cmdline-tools/latest/bin/sdkmanager "build-tools;30.0.3"

# # 设置工作目录
# WORKDIR /app

# # 复制项目文件到容器
# COPY . .

# # 给予 gradlew 执行权限
# RUN chmod +x gradlew
#
# # 使用 Gradle 构建项目
# RUN ./gradlew assembleRelease
#
# # 定义输出路径，方便用户获取构建产物
# CMD cp ./app/build/outputs/apk/release/app-release-unsigned.apk /output/product.apk && echo "Build complete. Check /output directory for APK."

# 指定构建产物输出目录（挂载卷时可以使用）
# VOLUME ["/output"]