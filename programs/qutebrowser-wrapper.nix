self: super: {
  qutebrowser = super.qutebrowser.overrideAttrs (oldAttrs: {
    installPhase = ''
      ${oldAttrs.installPhase}

      # Move the original binary
      mv $out/bin/qutebrowser $out/bin/qutebrowser-real

      # Install helper script as new qutebrowser
      mkdir -p $out/libexec
      cat > $out/libexec/qutebrowser-helper.sh <<EOF
      #!/usr/bin/env sh
      _url="\$1"
      _qb_version='1.0.4'
      _proto_version=1
      _ipc_socket="\${XDG_RUNTIME_DIR}/qutebrowser/ipc-\$(printf '%s' "\$USER" | md5sum | cut -d' ' -f1)"
      _qute_bin="\$out/bin/qutebrowser-real"

      printf '{"args": ["%s"], "target_arg": null, "version": "%s", "protocol_version": %d, "cwd": "%s"}\\n' \
             "\${_url}" \
             "\${_qb_version}" \
             "\${_proto_version}" \
             "\${PWD}" | ${super.socat}/bin/socat -lf /dev/null - UNIX-CONNECT:"\${_ipc_socket}" || "\${_qute_bin}" "\$@" &
      EOF
      chmod +x $out/libexec/qutebrowser-helper.sh

      # Create wrapper launcher
      cat > $out/bin/qutebrowser <<EOF
      #!/bin/sh
      exec $out/libexec/qutebrowser-helper.sh "\$@"
      EOF
      chmod +x $out/bin/qutebrowser
    '';
    buildInputs = oldAttrs.buildInputs or [] ++ [ super.socat ];
  });
}
