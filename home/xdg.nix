{ pkgs, ... }:

{
  # usual xdg user dirs
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME/Bureau";
      download = "$HOME/Téléchargements";
      documents = "$HOME/Documents";
      templates = "$HOME/Modèles";
      music = "$HOME/Musiques";
      videos = "$HOME/Vidéos";
      pictures = "$HOME/Images";
      publicShare = "$HOME/Public";
    };
  };
}