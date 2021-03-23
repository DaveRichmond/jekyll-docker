FROM ruby:2.7 AS build

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV TZ=UTC
ENV LC_ALL=en_US
ARG BUILD_ENV=default

COPY Gemfile .
RUN bundle install \
		--with=${BUILD_ENV} && \
	rm Gemfile

FROM ruby:2.7
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY bin/ /usr/local/bin

RUN useradd -m jekyll

CMD ["jekyll", "--help"]
ENTRYPOINT ["/usr/local/bin/entrypoint"]
WORKDIR /srv/jekyll
VOLUME /srv/jekyll
EXPOSE 4000
