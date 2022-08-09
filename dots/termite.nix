# Termite

{ pkgs, ... }:

{
programs = {
    termite = {
            enable = true;
            allowBold = true;
            audibleBell = false;
            backgroundColor = "#000000";
            clickableUrl = true;
            cursorBlink = "off";
            cursorShape = "underline";
            cursorColor = "#d0d0d0";
            cursorForegroundColor = "#00ff00";
            dynamicTitle = true;
            filterUnmatchedUrls = true;
            fullscreen = true;
            geometry = "70x20";
            font = "codingfonttobi 19";
            highlightColor = "#2f2f2f";
            hintsActiveBackgroundColor = "#3f3f3f";
            hintsActiveForegroundColor = "#e68080";
            hintsBackgroundColor = "#dcdccc";
            hintsBorderColor = "#333232";
            hintsBorderWidth = "0.5";
            hintsExtra = ''
                padding = 2
                quick_url = true
                roundness = 2.0
            '';
            hintsFont = "Terminus 17";
            hintsForegroundColor = "#b1d0e8";
            iconName = "terminal";
            modifyOtherKeys = false;
            mouseAutohide = true;
            scrollOnKeystroke = true;
            scrollOnOutput = false;
            scrollbackLines = -1;
            scrollbar = "off";
            searchWrap = true;
            sizeHints = true;
            urgentOnBell = true;
      };
      };
}
