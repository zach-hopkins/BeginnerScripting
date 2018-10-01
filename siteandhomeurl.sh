#!/bin/bash -e
# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"
clear
rm -f siteandhomeurl.sh
rm -f -
echo "============================================================================"
echo "Zach's WordPress Troubleshooter! [v1.1] - WORK IN PROGRESS - USE AT OWN RISK"
echo "============================================================================"
echo
echo "----------------------------------------------"
echo "USE HOTKEY CTRL + C TO EXIT SCRIPT AT ANY TIME"
echo "----------------------------------------------"
echo
echo -e "$COL_YELLOW Current Site URL - Please Wait...$COL_RESET"
echo
wp option get siteurl
echo
echo -e "$COL_YELLOW Current Home URL - Please Wait...$COL_RESET"
echo
wp option get home
echo
echo "Type New Site and Home URL - Press Enter To Skip (http://example.com)"
read -e siteurl
#echo "shall we begin? (y/n)"
#read -e shall
#if [ "$shall" == n ] ; then
#exit
#else
echo
echo "=================================================="
echo "Things are happening...fingers crossed ¯\_(O)_/¯"
echo "=================================================="
echo
wp option update home "$siteurl"
wp option update siteurl "$siteurl"
echo
echo "Home and Site URL Updated!"
echo
echo "Update Permalinks? (y/n)"
read -e permalinks
if [ "$permalinks" == y ] ; then
wp option update permalink_structure '/%postname%temp' >/dev/null
wp option update permalink_structure '/%postname%'
echo
echo "Permalinks Updated!"
echo
else
echo
fi
####FixPerms
echo "Fix Permissions? (y/n)"
read -e permissions
if [ "$permissions" == y ] ; then
find2perl . -type d -print -exec chmod 755 {} \; | perl; find2perl . -type f -print -exec chmod 644 {} \; | perl;
else
echo
fi
####Plugins Disable
echo "Disable Plugins? (y/n) (You can re-enable them later in script)"
read -e plugins
if [ "$plugins" == y ] ; then
mv wp-content/plugins wp-content/plugins-deactivated
echo
echo "Plugins folder succesfully disabled - renamed to plugins-deactivated"
echo
else
echo
fi
####Theme Reactivation
echo
echo "Update/Reactivate Theme? (y/n)"
read -e themeyes
if [ "$themeyes" == n ] ; then
echo
else
wp theme list
fi
if [ "$themeyes" == y ] ; then
echo
echo "Type Theme Name To Activate (CASE SENSITIVE)"
echo "OR: Would You Like To Re-Activate Current Theme - LOOK AT TABLE AND REMEMBER NAME OF ACTIVE THEME (y/n)?"
read -e theme
else
echo
fi
if [ "$theme" == y ] ; then
themereactivation=y
else
themereactivation=n
fi
if [ "$themereactivation" == y ] ; then
wp theme activate twentyfifteen > /dev/null
wp theme list
echo "Type The Original Theme Name To Reactivate (CASE SENSITIVE)"
read -e themeapply
echo
wp theme activate $themeapply
else
echo
fi
if [ "$themereactivation" == n ] ; then
wp theme activate $theme > /dev/null
echo "Success!" 
echo
echo "Confirm Correct Theme Is Active In Table Below (ignore if no theme update applied)"
wp theme list
echo
else
echo
fi
####htaccess stuff
echo "Would you like to replace .htaccess with default? (y/n) (customer .htaccess will become .htaccess.old)"
read -e run2
if [ "$run2" == y ] ; then
echo
echo "Is this a shared account? (y/n)"
read -e shared
echo
else
echo
fi
if [ "$shared" == y ] ; then
echo "Which PHP Version Do You Want To Apply? (a = 5.4 ; b = 5.6 ; c = 7.0) - Single php.ini"
read -e phpversion
else
echo
fi
if [ "$shared" == n ] ; then
echo "========================================"
echo "THIS COULD TAKE UP TO 72 BUSINESS HOURS!"
echo "========================================"
echo
#backing up htaccess
mv .htaccess .htaccess.old
wget -o - 108.167.154.205/coolbeans/zachscripts/htaccess.txt
cat htaccess.txt > .htaccess
rm -f htaccess.txt
rm -f -
echo "ALL DONE"
echo
else
echo
fi
if [ "$phpversion" == a ] ; then
#backing up htaccess
echo "========================================"
echo "THIS COULD TAKE UP TO 72 BUSINESS HOURS!"
echo "========================================"
mv .htaccess .htaccess.old
wget -o - 108.167.154.205/coolbeans/zachscripts/htaccess54.txt
cat htaccess54.txt > .htaccess
rm -f htaccess54.txt
rm -f -
echo "ALL DONE"
echo
echo
else
echo
fi
if [ "$phpversion" == b ] ; then
#backing up htaccess
echo "========================================"
echo "THIS COULD TAKE UP TO 72 BUSINESS HOURS!"
echo "========================================"
mv .htaccess .htaccess.old
wget -o - 108.167.154.205/coolbeans/zachscripts/htaccess56.txt
cat htaccess56.txt > .htaccess
rm -f htaccess56.txt
rm -f -
echo "ALL DONE"
echo
echo
else
echo
fi
if [ "$phpversion" == c ] ; then
#backing up htaccess
echo "========================================"
echo "THIS COULD TAKE UP TO 72 BUSINESS HOURS!"
echo "========================================"
mv .htaccess .htaccess.old
wget -o - 108.167.154.205/coolbeans/zachscripts/htaccess7.txt
cat htaccess7.txt > .htaccess
rm -f htaccess7.txt
rm -f -
echo "ALL DONE"
echo
echo
else
echo
fi
echo
sleep 1
clear
#### WP Restore
echo "[ADVANCED] - Would you like to restore core WP files [y/n]?"
echo "[Restores WP Core Files/WP-INCLUDES/WP-ADMIN of LATEST VERSION OF WP --- Preserves WP-CONTENT]"
read -e restoration
if [ "$restoration" == y ] ; then
echo
echo "Would you like to restore wp-config.php as well? (y/n) [Not Recommended: Requires Database Information]"
read -e wpconfigrestore
else
restoration=n
echo
fi
if [ "$wpconfigrestore" == y ] ; then
echo
clear
sed -n '20,32p' wp-config.php && sed -n '63,69p' wp-config.php
echo
echo "======================================"
echo "INSTRUCTIONS --- PLEASE READ CAREFULLY"
echo "======================================"
echo
echo "First, review the information pulled from customers wp-config.php above (or open wp-config.php manually) and type/write down the customers DB NAME, DB USER, and TABLE_PREFIX (IMPORTANT)"
echo "In the event of customer not having wp-config.php, you must ask customer to tell you which database is the correct one for his website (PHPMyAdmin)"
echo
echo "Next, navigate to cpanel > MySQL DB's ; change the password of the DB USER that you saved above to SecureServer2017@ (case sensitive)"
echo "Press Enter When You're Finished"
read -e thisdoesntmatter
echo "You're All Set! Answer The Following Prompts To Complete The Restoration"
echo "======================"
echo "WordPress Restoration"
echo "======================"
echo "WP Database Name (Press Enter To Continue): "
read -e dbname
echo "WP Database User (Press Enter To Continue): "
read -e dbuser
echo "WP Database Table Prefix - THERE IS ALWAYS AN UNDERSCORE AT THE END! (Press Enter To Continue): "
read -e dbtable
dbtable=${dbtable:-wp_}
echo "run restore? (y/n)"
read -e run
else
echo
fi
if [ "$run" == y ] ; then
echo
echo "====================================================================="
echo "A highly-skilled robot is now restoring WordPress core files for you."
echo "====================================================================="
#download wordpress
curl -O https://wordpress.org/latest.tar.gz
#unzip wordpress
tar -zxvf latest.tar.gz
#change dir to wordpress
cd wordpress
#remove wp-content folder
rm -rf wp-content
#copy file to parent dir
cp -rf . ..
#move back to parent dir
cd ..
#remove files from wordpress folder
rm -R wordpress
#create wp config
cp wp-config-sample.php wp-config.php
#set database details with perl find and replace
perl -pi -e "s/database_name_here/$dbname/g" wp-config.php
perl -pi -e "s/username_here/$dbuser/g" wp-config.php
perl -pi -e "s/password_here/SecureServer2017@/g" wp-config.php
perl -pi -e "s/\'wp_\'/\'$dbtable\'/g" wp-config.php

#set WP salts
perl -i -pe'
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php

echo "Cleaning..."
#remove zip file
rm latest.tar.gz
echo "========================="
echo "Installation is complete."
echo "========================="
echo "============================================================"
echo "P.S. That guy Zach Hopkins is the COOLEST! -Unbiased Source"
echo "============================================================"
echo
echo "Check that site is working properly, suggest customer change mysql db password in both wp-config.php and thru cpanel > mysql"
echo
else
echo
fi
if [ "$wpconfigrestore" == n ] ; then
echo
echo
echo "====================================================================="
echo "A highly-skilled robot is now restoring WordPress core files for you."
echo "====================================================================="
#download wordpress
curl -O https://wordpress.org/latest.tar.gz
#unzip wordpress
tar -zxvf latest.tar.gz
#change dir to wordpress
cd wordpress
#remove wp-content folder
rm -rf wp-content
#copy file to parent dir
cp -rf . ..
#move back to parent dir
cd ..
#remove files from wordpress folder
rm -R wordpress

echo "Cleaning..."
#remove zip file
rm latest.tar.gz
echo "========================="
echo "Installation is complete."
echo "========================="
echo "============================================================"
echo "P.S. That guy Zach Hopkins is the COOLEST! -Unbiased Source"
echo "============================================================"
echo
echo
else
echo
echo
fi

####Database Re-Establish
if [ "$wpconfigrestore" == y ] ; then
echo
else
echo "Re-Establish Database Connection? (y/n)"
read -e reestablish
fi
if [ "$reestablish" == y ] ; then
echo
clear
sed -n '20,32p' wp-config.php && sed -n '63,69p' wp-config.php
echo "======================================"
echo "INSTRUCTIONS --- PLEASE READ CAREFULLY"
echo "======================================"
echo
echo "First, review the information pulled from customers wp-config.php above (or open wp-config.php manually) and type/write down the customers DB NAME, DB USER, and TABLE_PREFIX (IMPORTANT)"
echo "In the event of customer not having wp-config.php, you must ask customer to tell you which database is the correct one for his website (PHPMyAdmin)"
echo
echo "Next, navigate to cpanel > MySQL DB's ; change the password of the DB USER that you saved above to SecureServer2017@ (case sensitive)"
echo "Press Enter When You're Finished"
read -e thisdoesntmatter
echo "You're All Set! Answer The Following Prompts To Complete The Database Reconnection"
echo "================================="
echo "Re-Establish Database Connection"
echo "================================="
echo "WP Database Name (Press Enter To Continue): "
read -e dbname
echo "WP Database User (Press Enter To Continue): "
read -e dbuser
echo "WP Database Table Prefix - THERE IS ALWAYS AN UNDERSCORE AT THE END! (Press Enter To Continue): "
read -e dbtable
dbtable=${dbtable:-wp_}
#get wp config
wget -o - 108.167.154.205/coolbeans/wp-config-sample1.php
#delete trace
rm -f -
#backup customer wpconfig
mv wp-config.php wp-configbackup.php
#move my config to primary
mv wp-config-sample1.php wp-config.php
#set database details with perl find and replace
perl -pi -e "s/database_name_here/$dbname/g" wp-config.php
perl -pi -e "s/username_here/$dbuser/g" wp-config.php
perl -pi -e "s/password_here/SecureServer2017@/g" wp-config.php
perl -pi -e "s/\'wp_\'/\'$dbtable\'/g" wp-config.php

#set WP salts
perl -i -pe'
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php

echo "=================================="
echo "Database Connection Re-Established."
echo "=================================="
echo "================================================================================="
echo "P.S. I hear that guy Zach Hopkins built the hospital he was born in  - True Story"
echo "================================================================================="
echo
echo "Check that site is working properly, suggest customer change mysql db password in both wp-config.php and thru cpanel > mysql"
echo
else
echo
fi
####Plugins Enable
if [ "$plugins" == y ] ; then
echo "Would you like to re-enable plugins now? (y/n)"
echo "Alternatively you can rename plugins-deactivated in wp-content folder back to plugins to re-enable manually later"
read -e pluginsenable
else
echo
fi
if [ "$pluginsenable" == y ] ; then
mv wp-content/plugins-deactivated wp-content/plugins
echo
echo "Plugins Folder Reactivated! (may have to manually re-enable through wp-tools or wp dashboard)"
echo "Script Completed!"
echo
echo "Tell the customer if their site's still broken they need to see a damn developer"
echo
else
echo
echo "Script Completed!"
echo
echo "Tell the customer if their site's still broken they need to see a damn developer"
echo
fi
