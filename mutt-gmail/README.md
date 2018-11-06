# mutt-gmail

    docker run -it --rm \
        -e TERM \
        -e GMAIL=jsmith@gmail.com \
        -e GMAIL_NAME='John Smith' \
        -u "$(id -u):$(id -g)" \
        -e HOME=/home/user \
        -v "$HOME/.signature:/home/user/.signature" \
        -v "$HOME/.muttrc:/home/user/.muttrc.local" \
        -v "$HOME/.mutt/cache:/home/user/.mutt/cache" \
        tianon/mutt-gmail

If you wish to avoid the password prompt, use https://support.google.com/accounts/answer/185833?hl=en to generate an "app password" and set `GMAIL_PASS`.
