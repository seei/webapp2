FROM phusion/passenger-ruby23:0.9.19

ENV HOME /root

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y -o Dpkg::Options::="--force-confold" netcat

RUN rm -f /etc/service/nginx/down

RUN rm /etc/nginx/sites-enabled/default
ADD webapp2.conf /etc/nginx/sites-enabled/webapp2.conf

ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN bundle install

RUN mkdir /home/app/webapp2
COPY . /home/app/webapp2
RUN usermod -u 1000 app
RUN chown -R app:app /home/app/webapp2
WORKDIR /home/app/webapp2

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
