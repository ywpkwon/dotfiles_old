if [[ "$TERM" != dumb ]] && (( $+commands[grc] )) ; then

  # Supported commands
  cmds=(
    cc \
    configure \
    cvs \
    df \
    diff \
    dig \
    gcc \
    gmake \
    ifconfig \
    last \
    ldap \
    ls \
    make \
    mount \
    mtr   \
    netstat \
    ping \
    ping6 \
    ps \
    traceroute \
    traceroute6 \
    wdiff \
    whois \
    iwconfig \
  );

  # Set alias for available commands.
  for cmd in $cmds ; do
    if (( $+commands[$cmd] )) ; then
      alias $cmd="grc --colour=auto $(whence $cmd)"
    fi
  done

  alias ls="grc ls --color=alway"
  alias lsa="grc ls -lah --color=alway"
  alias l="grc ls -lah --color=alway"
  alias ll='grc ls -lh --color=alway'
  alias la='grc ls -lAh --color=alway'

  # Clean up variables
  unset cmds cmd
fi
