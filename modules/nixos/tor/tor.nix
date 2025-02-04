{ pkgs, lib, config, ... }:

let cfg = config.tor; in {
  options = {
    tor.enable = lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf cfg.enable {
    services.tor.enable = true;
    services.tor.client.enable = true;
    services.tor.settings = {
      AutomapHostsOnResolve = true;
      HardwareAccel = true;
      MaxClientCircuitsPending = 1;
      UseBridges = true;
      MapAddress = [
        "*.hdrezka.ag *.hdrezka.ag.B3DA6D0F4C5C67E1AE8E4DF20C832622A3FE2B76.exit"
        "*.hdrezka.ac *.hdrezka.ac.B3DA6D0F4C5C67E1AE8E4DF20C832622A3FE2B76.exit"
        "*.voidboost.cc *.voidboost.cc.B3DA6D0F4C5C67E1AE8E4DF20C832622A3FE2B76.exit"
        "*.clarity.ms *.clarity.ms.B3DA6D0F4C5C67E1AE8E4DF20C832622A3FE2B76.exit"
      ];

      MiddleNodes = "94.23.172.32, 145.239.41.102";

      ExitNodes = "8DB706C9B7ABA89F08FCE919DE18DAC63266EC8D";

      ClientTransportPlugin = [
        "meek_lite,obfs2,obfs3,obfs4,scramblesuit,webtunnel exec ${pkgs.obfs4}/bin/lyrebird"
      ];
      
      Bridge = [
        "webtunnel [2001:db8:1fc0:eebe:5e6e:d6ee:f53e:6889]:443 4A3859C089DF40A4FFADC10A79DFEBE4F8272535 url=https://verry.org/K2A2utQIMou4Ia2WjVseyDjV ver=0.0.1"
        "webtunnel [2001:db8:77cb:5ce6:9995:7466:7ffa:b3f8]:443 770EA6412C8D3997ABFFF7173A3E53F1D3660167 url=https://shallotfarm.org/jcHgyp7m90iQr9QaVSprq1wP ver=0.0.1"
      ];
    };
  };
}