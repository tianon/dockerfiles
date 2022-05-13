# How To Use

You will want to set a reasonable hostname of some kind (`--hostname`), since that's symlinked to `/etc/mailname` inside the image and used for outgoing mail metadata.

## sSMTP

If you want to use this with another container that has sSMTP or similar installed, here's a configuration you can adapt: (assuming your second container uses something like `--link some-exim4:smtp`)

```
Mailhub=smtp
FromLineOverride=Yes
```

Then `sendmail` in your linked container should work as expected.  You can also skip `FromLineOverride` in the second container if you want, but the alternative is sSMTP being weird about hostnames and forcing you into a box.

## Gmail / "smarthost" (external SMTP)

If you'd rather not relay mail directly (which is a smart thing to not want to do generally), you can trivially configure this container to relay via a Gmail account instead!  Just add `-e GMAIL_USER=youruser@yourdomain.com -e GMAIL_PASSWORD=yourpasswordhere` and the entrypoint will automatically preconfigure to relay via the Gmail account specified!

Alternatively, you can use this container as a proxy for another SMTP server via `-e EXIM4_SMARTHOST='smtp.yourdomain.com::587' -e EXIM4_SMARTHOST_USER='youruser@yourdomain.com' -e EXIM4_SMARTHOST_PASSWORD='yourpasswordhere'` (in fact, `GMAIL_*` are shorthand for `EXIM4_SMARTHOST='smtp.gmail.com::587'` 😄).
