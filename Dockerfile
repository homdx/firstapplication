FROM homdx/kivymd-store:003-36

RUN sudo mkdir  app2

COPY . app2

ARG FOOD_VERSION=0.0.1
ARG FOOD_HASH=495c44bb6e4271b3052e2ff2407e0ba475d4f07909f158a328da86a6eb689ac8

RUN sudo chown user ${WORK_DIR}/app2 -Rv

RUN cd app2 && patch -p0 <buildozer-docker.patch && echo buildozer android update \
&&  set -ex \
&& wget --quiet https://github.com/homdx/firstapplication/releases/download/${FOOD_VERSION}/dot-buildozer.tar.gz \
&& echo "${FOOD_HASH}  dot-buildozer.tar.gz" | sha256sum -c \
&& tar -xf dot-buildozer.tar.gz && rm dot-buildozer.tar.gz \
&& buildozer android debug || echo "Copy result apk to home" && sudo cp /home/user/hostcwd/app2/.buildozer/android/platform/build/dists/foodoptions/bin/foodoptions*debug.apk ~/

CMD tail -f /var/log/faillog
