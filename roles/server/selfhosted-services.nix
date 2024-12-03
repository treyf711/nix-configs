{config, pkgs, lib, ...}:
{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
             "plexmediaserver"
           ];

  services.jellyfin.enable = true;
  services.jellyfin.openFirewall = true;
  services.plex.enable = true;
  services.plex.openFirewall = true;
  services.plex.group = "media";
  services.radarr.enable = true;
  services.radarr.group = "media";
  services.sonarr.enable = true;
  services.sonarr.group = "media";
  
  virtualisation.oci-containers = {
      backend = "podman";
      containers = {
        qbittorrent = {
	  image = "lscr.io/linuxserver/qbittorrent:latest";
	  autoStart = true;
	  ports = [ "8080:8080" "6881:6881" "6881:6881/udp" ];
	  volumes = [ "qbittorrent-config:/config" ];
	  environment = {
	    PGID = "991";
	    TZ = "Etc/UTC";
	    WEBUI_PORT = "8080";
	    TORRENTING_PORT = "6881";
	  };
	};
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
	nzbget = {
	  image = "lscr.io/linuxserver/nzbget:latest";
	  autoStart = true;
	  volumes = [ "nzbget-config:/config" "/storage/downloads:/downloads" ];
	  ports = [ "6789:6789" ];
	  environment = {
	    PUID = "1000";
	    PGID = "991";
	    TZ = "Etc/UTC";
	  };
	};
      };
    };

}
