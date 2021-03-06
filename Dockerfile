FROM quay.io/cuppett/ubi8-php:74

ENV DOCUMENTROOT="/public" \
    APP_NAME=Laravel \
    APP_DEBUG=true \
    APP_URL=http://localhost:8080 \
    LOG_CHANNEL=errorlog \
    DB_CONNECTION=sqlite \
    DB_DATABASE=":memory:"

USER root

# Copying in source code

COPY .. /tmp/src

# Change file ownership to the assemble user.

RUN chown -R 1001:0 /tmp/src

# Run assemble as non-root user

USER 1001

# Assemble script sourced from builder image based on user input or image metadata.

#RUN /usr/libexec/s2i/assemble
RUN /tmp/src/.s2i/bin/assemble

# Run script sourced from builder image based on user input or image metadata.

#CMD /usr/libexec/s2i/run
CMD /opt/app-root/src/.s2i/bin/run
