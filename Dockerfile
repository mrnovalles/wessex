FROM trenpixster/elixir:latest

# Update packages
RUN apt-get update -y
RUN apt-get install build-essential --assume-yes

EXPOSE 8080
# Add all project files to src
ADD . /src

WORKDIR /src
# Install mix deps
RUN mix deps.get
RUN mix deps.compile
RUN mix compile

CMD ["mix", "run", "--no-halt"]


