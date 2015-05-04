FROM debian:unstable

RUN awk '$1 ~ "^deb" { $3 = "experimental"; print }' /etc/apt/sources.list > /etc/apt/sources.list.d/experimental.list
