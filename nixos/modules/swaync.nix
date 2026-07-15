{ ... } :

{
  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";

      control-center-positionX = "right";
      control-center-positionY = "top";
      control-center-width = 420;
      control-center-height = 700;

      notification-window-width = 380;

      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;

      widgets = [
        "title"
        "dnd"
        "notifications"
      ];

      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear";
        };

        dnd = {
          text = "Do Not Disturb";
        };

	notifications = {
	  vexpand = true;
	};
      };
    };
  };
}
