FROM debian:sid

RUN awk '$1 ~ "^deb" { $3 = "rc-buggy"; print }' /etc/apt/sources.list > /etc/apt/sources.list.d/experimental.list
