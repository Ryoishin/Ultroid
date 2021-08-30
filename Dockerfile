# Ultroid - UserBot
# Copyright (C) 2021 TeamUltroid
# This file is a part of < https://github.com/TeamUltroid/Ultroid/ >
# PLease read the GNU Affero General Public License in <https://www.github.com/TeamUltroid/Ultroid/blob/main/LICENSE/>.

FROM theteamultroid/ultroid:main

# set timezone
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# clone the repo and change workdir
RUN git clone -b dev https://github.com/TeamUltroid/Ultroid.git /root/TeamUltroid/
WORKDIR /root/TeamUltroid/

# install main requirements.
COPY requirements.txt /deploy/
RUN pip3 install --no-cache-dir -r /deploy/requirements.txt

# install addons requirements
RUN wget --progress=dot:giga -O /deploy/addons.txt https://git.io/JWdOk && pip3 install --no-cache-dir -r /deploy/addons.txt

# remove wheel coz of warning
RUN rm -rf /usr/local/lib/python3.9/site-packages/.wh

RUN pip3 uninstall pytgcalls -y
RUN pip3 install -U pytgcalls==3.0.0.dev9

# start the bot
CMD ["bash", "resources/startup/startup.sh"]
