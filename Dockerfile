FROM docksal/cli:2.4-php7.1

# Install tools needed later
RUN apt-get update -y >/dev/null; apt-get install -y build-essential

# Further RUN commands for software installations will run as the "docker" user
USER docker

ENV \
    NODE_VERSION=9.4.0 \
    RUBY_VERSION=1.9.3

# Install NVM, required Node version and grunt
RUN set -e; \
	# NVM and a defaut Node.js version
	export PROFILE="$HOME/.profile"; \
        export NVM_DIR="$HOME/.nvm" \
        && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
        && nvm install ${NODE_VERSION} \
        # set default node version
        && nvm alias ${NODE_VERSION} \
        # use this node version for grunt install
        && nvm use ${NODE_VERSION} \
        # install grunt
        && npm install -g grunt

# Install RVM
RUN set -e; \
    cd "$HOME"; \
    curl -#LO https://rvm.io/mpapis.asc; \
    gpg --import mpapis.asc; \
    sudo curl -fsSL "https://get.rvm.io" | bash -s stable --auto-dotfiles --autolibs=enable; \
    # Make RVM to be bash function in future shells
    echo 'source /home/docker/.rvm/scripts/rvm' >> ~/.bashrc; 

# Install required Ruby version
RUN bash -l -c "rvm install ${RUBY_VERSION}"

# Install bundler
RUN sudo gem install bundler;

# Return user to root for correct startup sequence
USER root