{ config, pkgs, ... }:

{
	services.picom = {
		shadow = true;
		experimentalBackends = true;
		blur = true;
		fade = true;
		fadeDelta = 5;
		backend = "glx";
		vSync = true;
		refreshRate = 60;
		fadeSteps = [ "0.3" "0.3" ];
		shadowOffsets = [ (-10) (-10) ];
		shadowOpacity = "0.3";
		shadowExclude = [ "name = 'stalonetray'" "name = 'polybar'" "name = 'Notification'" "class_g = 'bspwm'"  ];
		activeOpacity = "1.0";
		inactiveOpacity = "1.0";
		opacityRule = [ "10:class_g = 'Bspwm'" ];
		menuOpacity = "1.0";
		noDockShadow = true;
		noDNDShadow = true;
		extraOptions = ''
			blur-method = "dual_kawase";
			clear-shadow = true;
			shadow-radius = 10;
			shadow-red = 0.0;
			shadow-green = 0.0;
			shadow-blue = 0.0;
		'';
	};
}

