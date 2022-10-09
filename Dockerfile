FROM alpine AS fetch
WORKDIR /fetch

RUN apk add curl

RUN mkdir -p themes/bluehat \
    && cd themes/bluehat \
    && curl -L https://github.com/hbjydev/keycloak-theme-bluehat/releases/download/v0.0.3/bluehat.tar.gz \
    | tar -xz

FROM quay.io/keycloak/keycloak:19.0.3 AS run

COPY --from=fetch /fetch/themes/bluehat /opt/keycloak/themes/bluehat

RUN /opt/keycloak/bin/kc.sh build --metrics-enabled=true --health-enabled=true
