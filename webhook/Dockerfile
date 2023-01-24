# First stage builds the application
FROM ubi8/nodejs-18 as builder

# Add application sources to a directory that the assemble script expects them
# and set permissions so that the container runs without root access
USER 0
ADD app-src /tmp/src
RUN chown -R 1001:0 /tmp/src
USER 1001

# Install the dependencies
RUN /usr/libexec/s2i/assemble

# Second stage copies the application to the minimal image
FROM ubi8/nodejs-18-minimal

# Copy the application source and build artifacts from the builder image to this one
COPY --from=builder $HOME $HOME

# Set the default command for the resulting image
CMD /usr/libexec/s2i/run
