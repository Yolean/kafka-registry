# Development dockerfile, actually

# Some jdk with the required build tool
FROM maven:3.5.2-jdk-9-slim

# The version to use for dependencies
# Is a source version because confluent.maven.repo only contains releases
# (for example http://packages.confluent.io/maven/io/confluent/rest-utils-parent/maven-metadata.xml)
# Confluent uses consistent branch naming across repositories, so see https://github.com/confluentinc/schema-registry/branches
ARG confluent_version=4.0.x

# The uid and gid of the current user, so resulting maven artifacts can be managed locally too
# Use for example $(id -u) and $(id -g) to get these values
ARG dev_uid=1000
ARG dev_gid=1000

USER ${dev_uid}:${dev_gid}

RUN echo "To cache maven artifacts, mount a host dir at:" && env | grep MAVEN_CONFIG

# Fetch and build + install each of the dependencies

# https://github.com/confluentinc/common

# https://github.com/confluentinc/rest-utils

# For rest-proxy: https://github.com/confluentinc/schema-registry

WORKDIR /usr/src/schema-registry

RUN echo "Mount source at:" && pwd

# Generate eclipse project, with 
# (note that the host's .m2 must be set as maven repository in Eclipse)

