colors: let
  inherit (colors) xcolors;
  stylesheet = ''
#window {
  margin: 0px;
  border-radius: 7px;
  font-family: "JetBrainsMono Nerd Font";
  font-size: 16px;
  background: ${xcolors.base01};
  border: 3px solid ${xcolors.base08};
}

#input {
  margin: 15px;
  border-radius: 10px;
  box-shadow: none;
}

#input:focus {
  border-image: none;
}
    
#inner-box {
  margin: 5px;
  border: none;
  padding-left: 10px;
  padding-right: 10px;
  border-radius: 7px;
  background-color: inherit;
}

#outer-box {
  margin: 5px;
  border: none;
  background-color: inherit;
  border-radius: 7px;
}

#scroll {
  margin: 0px;
  border: none;
}

#text {
  margin: 5px;
  border: none;
} 

#entry:selected {
	border-radius: 10px;
  background-color: ${xcolors.base08};
}

#text:selected {
	background-color: inherit;
	font-weight: normal;
  color: ${xcolors.base00};
}  
  '';
in
  stylesheet