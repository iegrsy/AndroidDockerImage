FROM openjdk:8-jdk

RUN apt-get --quiet update --yes && \
 export ANDROID_SDK_TOOLS="4333796" && \
 export ANDROID_BUILD_TOOLS="28.0.3" && \
 export ANDROID_COMPILE_SDK="28" && \
 apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 curl && cd / && \
 wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip && \
 unzip -d android-sdk-linux android-sdk.zip && \
 echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null && \
 echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null && \
 echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null && \
 /bin/bash -c "set +o pipefail && yes | android-sdk-linux/tools/bin/sdkmanager --licenses && set -o pipefail"

 ENV ANDROID_HOME "/android-sdk-linux"
 ENV ANDROID_SDK_ROOT "/android-sdk-linux"
 ENV PATH "$PATH:/android-sdk-linux/platform-tools"
