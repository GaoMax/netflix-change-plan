FROM python:3.8
ENV username=username
ENV password=password
WORKDIR /netflix-change-plan-master
COPY ./requirements.txt ./
RUN apt-get update && \
      apt-get -y install sudo
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
# Install Chrome.
RUN apt-get update && apt-get -y install google-chrome-stable

RUN wget https://chromedriver.storage.googleapis.com/94.0.4606.41/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN sudo chmod +x chromedriver
RUN sudo mv chromedriver /usr/bin/
RUN	rm chromedriver_linux64.zip

# Set display port as an environment variable
ENV DISPLAY=:99


RUN pip install --upgrade pip

RUN pip install -r requirements.txt

CMD ["python", "./netflix-change-plan.py -u ${username} -p ${password}"]

