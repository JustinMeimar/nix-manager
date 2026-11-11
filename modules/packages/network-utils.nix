{ pkgs, ... }: {
  home.packages = with pkgs; [
    dnsutils
    iperf3
    lsof
    netcat-openbsd
    nmap
    tcpdump
    traceroute
  ];
}
