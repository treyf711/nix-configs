{config, pkg, lib, ...}:
{
  services.jellyfin.enable = true;
  services.radarr.enable = true;
  services.sonarr.enable = true;

  virtualisation.oci-containers = {
      backend = "podman";
      containers = {
        flare-solvarr = {
          image = "ghcr.io/flaresolverr/flaresolverr:latest";
          autoStart = true;
          ports = ["127.0.0.1:8191:8191"];
          environment = {
            LOG_LEVEL = "info";
            LOG_HTML = "false";
            CAPTCHA_SOLVER = "hcaptcha-solver";
            TZ="America/New_York";
          };
        };
        prowlarr = {
          image = "lscr.io/linuxserver/prowlarr:latest";
          autoStart = true;
	  volumes = [ "prowlarr-config:/config" ];
          ports = ["9696:9696"];
          environment = {
            TZ="America/New_York";
          };
        };
      };
    };

}
