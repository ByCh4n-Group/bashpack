#! /bin/bash

printf "\r\n\e[0;92m- \e[0m\e[1;77mBashpack install\e[0m"
tput sc
printf "\r\n\e[0;92m? \e[0;96m#                          \e[0m"
mkdir ~/.bashpack || ( printf "\n\e[0;91mx \e[0m\e[1;77mError\e[0m";exit )
tput rc
printf "\r\n\e[0;92m? \e[0;96m###                        \e[0m"
cd ~/.bashpack || ( printf "\n\e[0;91mx \e[0m\e[1;77mError\e[0m";exit )
tput rc
printf "\r\n\e[0;92m? \e[0;96m#####                      \e[0m"
curl -s "https://bashpack.me/pckg/bashpack.sh" > bashpack || ( printf "\n\e[0;91mx \e[0m\e[1;77mError\e[0m";exit )
tput rc
printf "\r\n\e[0;92m? \e[0;96m################           \e[0m"
chmod +x bashpack || ( printf "\n\e[0;91mx \e[0m\e[1;77mError\e[0m";exit )
tput rc
printf "\r\n\e[0;92m? \e[0;96m###################        \e[0m"
tput rc
printf "\r\n\e[0;92m? \e[0;96m###########################\e[0m"
printf "\n\e[0;92m✓ \e[0m\e[1;77mbashpack is now succesfuly installed !\e[0m"
printf "\n\e[0;92m? \e[0m\e[1;77mYou should run : export PATH=\$PATH:~/.bashpack\e[0m"
printf "\n\e[0;92m? \e[0m\e[1;77mTo add bashpack and pckgs to your path\e[0m"
echo


