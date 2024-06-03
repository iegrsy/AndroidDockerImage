FROM openjdk:8-jdk

RUN apt-get --quiet update --yes && \
 export ANDROID_SDK_TOOLS="11076708_latest" && \
 export ANDROID_BUILD_TOOLS="34.0.0" && \
 export ANDROID_COMPILE_SDK="34" && \
 apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 curl && cd / && \
 wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}.zip && \
 unzip -d android-sdk-linux android-sdk.zip && \
 echo y | android-sdk-linux/cmdline-tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null && \
 echo y | android-sdk-linux/cmdline-tools/bin/sdkmanager "platform-tools" >/dev/null && \
 echo y | android-sdk-linux/cmdline-tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null && \
 /bin/bash -c "set +o pipefail && yes | android-sdk-linux/cmdline-tools/bin/sdkmanager --licenses && set -o pipefail"

 ENV ANDROID_HOME "/android-sdk-linux"
 ENV ANDROID_SDK_ROOT "/android-sdk-linux"
 ENV PATH "$PATH:/android-sdk-linux/platform-tools"
