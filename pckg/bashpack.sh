#! /bin/bash
version=0.1
tput civis

############# Make cursor to normal when exit
exitt(){
	tput cnorm
	echo
	exit
}

############# Trap ctrl+c
trap ctrl_c INT
function ctrl_c() {
  tput rc
  tput ed
  printf "\r\e[0;91mx \e[0m\e[1;77mGood Bye!                                                               \e[0m"
  exitt
}

############# Update bashpack
update(){
	if [[ $version != "$versionup" ]]; then 
		printf "\n\e[0;91mx \e[0m\e[1;77mThere is a new bashpack update, \e[0;96m wait.\e[0m"
		curl -s https://bashpack.me/pckg/bashpack.sh > ~/.bashpack/bashpack || ( printf "\n\e[0;91mx \e[0m\e[1;77mError\e[0m";exitt )
		printf "\n\e[0;92m✓ \e[0m\e[1;77mSuccessfully Updated\e[0m"
	fi
	exitt
}

############# Check version when no args
empty () {
	versionup=$(curl -s https://bashpack.me/pckg/bashpack.sh | grep "version=" | sed 's/version=//' | sed '1q;d')
	printf "\e[0;92m✓ \e[0m\e[1;77mbashpack\e[0;96m [v%s]\e[0m" "$version"
	if [[ $version != "$versionup" ]]; then 
		update
	fi
	printf "\n\e[0;92m? \e[0m\e[1;77mfor help type :\e[0;96m bashpack -h\e[0m"
	exitt
}
[ -z "$1" ] && empty

############# Args
while test $# -gt 0; do
  case "$1" in

	-h|--help)
		printf "\e[0;92m✓ \e[0m\e[1;77mbashpack\e[0;96m [By @HadrienAka]\e[0m"
		printf "\n"
		printf "\n\e[1;77mArguments :\e[0m"
		printf "\n\e[1;92m-h, --help            \e[0m\e[1;77mShow brief help\e[0m"
		printf "\n\e[1;92m-i, --install         \e[0m\e[1;77mInstall packages\e[0m"
		printf "\n\e[1;92m-u, --update          \e[0m\e[1;77mUpdate packages and bashpack\e[0m"
		printf "\n\e[1;92m-d, --delete          \e[0m\e[1;77mDelete packages\e[0m"
		printf "\n\e[1;92m-s, --search          \e[0m\e[1;77mSearch packages\e[0m"
		printf "\n\e[1;92m-rf                   \e[0m\e[1;77mDelete everythings (all packages and bashpack)\e[0m"
		printf "\n"
		printf "\n\e[0;92m? \e[0m\e[1;77mMore information on\e[0;96m bashpack.me\e[0m"
		printf "\n\e[0;92m? \e[0m\e[1;77mDo you want to open it?\e[0;96m [y/n] \e[0m"
		read -r -n1 yn
		if [[ $yn == y ]]; then
			open https://bashpack.me/
		fi
		exitt
	  ;;
	  
	-i|--install)
	shift
		option=1
		if test $# -gt 0; then
			export install=$1
		else
			printf "\n\e[0;91mx \e[0m\e[1;77mError\e[0m"
			exitt
	  	fi
	shift
	;;

	-d|--delete)
	shift
		option=2
		if test $# -gt 0; then
			export delete=$1
		else
			printf "\n\e[0;91mx \e[0m\e[1;77mError\e[0m"
			exitt
		fi
	shift
	;;

	-s|--search)
	shift
		option=4
		if test $# -gt 0; then
			export search=$1
		else
			printf "\n\e[0;91mx \e[0m\e[1;77mError\e[0m"
			exitt
		fi
	shift
	;;

	-u|--update)
	shift
		option=3
		if test $# -gt 0; then
			export update=$1
				versionup=$(curl -s https://bashpack.me/pckg/bashpack.sh | grep "version=" | sed 's/version=//' | sed '1q;d')
				if [[ $version != "$versionup" ]]; then 
					printf "\n\e[0;91mx \e[0m\e[1;77mThere is a new bashpack update, \e[0;96m wait..\e[0m"
					update
				fi
		else
			versionup=$(curl -s https://bashpack.me/pckg/bashpack.sh | grep "version=" | sed 's/version=//' | sed '1q;d')
			if [[ $version == "$versionup" ]]; then 
				printf "\e[0;92m✓ \e[0m\e[1;77mbashpack is already up to date\e[0m"
				echo
				exitt
			else
				update
			fi
			exitt
		fi
	  shift
	  ;;

	-rf)
	shift
		option=5
	shift
	  ;;
	
	*)
	  break
	  ;;
  esac
done

case "$option" in

	1) ######## Install
		install=$(echo "$install" | tr '[:upper:]' '[:lower:]')
		tput sc
		printf "\e[0;92m? \e[0m\e[1;77mSearching for \e[0;96m$install\e[0m...       \e[0m"
		search=$(curl -s -L https://bashpack.me/pckg/$install | grep "404")
		
		if [ -z "$search" ]; then
			tput rc
			printf "\e[0;92m✓ \e[0m\e[1;77m$install found                            \e[0m\n"
			tput sc

			printf "\e[0;92m? \e[0m\e[1;77mInstalling \e[0;96m$install\e[0m...        \e[0m"
			curl -s https://bashpack.me/pckg/"$install" > ~/.bashpack/"$install"
			chmod +x ~/.bashpack/"$install"
			tput rc
			printf "\e[0;92m✓ \e[0m\e[1;77m\e[0;96msuccessfully installed    \e[0m\e[0m"
			exitt

		else
			tput rc
			printf "\e[0;91mx \e[0m\e[1;77m$install not found                          \e[0m"
			exitt
		fi
		

	;;

	2) ######## Delete
		delete=$(echo "$delete" | tr '[:upper:]' '[:lower:]')
		tput sc
		printf "\e[0;92m? \e[0m\e[1;77mSearching for \e[0;96m$delete\e[0m...      \e[0m"
		if [ -f ~/.bashpack/$delete ]; then
			tput rc
			printf "\e[0;92m✓ \e[0m\e[1;77m$delete found                          \e[0m\n"
			tput sc

			printf "\e[0;92m? \e[0m\e[1;77mDeleting \e[0;96m$delete\e[0m...       \e[0m"
			rm -rf ~/.bashpack/$delete
			tput rc
			printf "\e[0;92m✓ \e[0m\e[1;77m\e[0;96msuccessfully deleted     \e[0m\e[0m"
			exitt

		else
			tput rc
			printf "\e[0;91mx \e[0m\e[1;77m$delete not found                         \e[0m"
			exitt
		fi
	;;

	3) ######## Update
		update=$(echo "$update" | tr '[:upper:]' '[:lower:]')
		versionpckgup=$(curl -s https://bashpack.me/pckg/$update | grep "#### Version//:" | sed 's/#### Version\/\/: //')
		versionpckg=$(cat ~/.bashpack/$update 2>/dev/null | grep "#### Version//:" | sed 's/#### Version\/\/: //')
		if [ -z "$versionpckgup" ]; then
			printf "\e[0;91mx \e[0m\e[1;77m$search not found on bashback.me    \e[0m"
		else
			if [ -z "$versionpckg" ]; then
				printf "\e[0;91mx \e[0m\e[1;77mYou don't have any packages named $update.\e[0m"
			else
				if [[ $versionpckg != "$versionpckgup" ]]; then 
					printf "\n\e[0;91mx \e[0m\e[1;77mThere is a new $update update, \e[0;96m wait..\e[0m"
					curl -s https://bashpack.me/pckg/"$update" > ~/.bashpack/"$update" || ( printf "\n\e[0;91mx \e[0m\e[1;77mError\e[0m";exitt )
					printf "\n\e[0;92m✓ \e[0m\e[1;77mSuccessfully Updated\e[0m"
				else
					printf "\e[0;91mx \e[0m\e[1;77mNo update founded for $update.\e[0m"
				fi
			fi
		fi
		exitt
	;;

	4) ######## Search

		search=$(echo "$search" | tr '[:upper:]' '[:lower:]')
		tput sc
		printf "\e[0;92m? \e[0m\e[1;77mSearching for \e[0;96m$search\e[0m...             \e[0m"
		searchs=$(curl -s https://bashpack.me/pckg/$search | grep "404")
		
		if [ -z "$searchs" ]; then
			tput rc
			printf "\e[0;92m✓ \e[0m\e[1;77m$search found                                  \e[0m\n"
			author=$(curl -s https://bashpack.me/pckg/$search | grep "#### Author//: " | sed 's/#### Author\/\/: //')
			desc=$(curl -s https://bashpack.me/pckg/$search | grep "#### Description//: " | sed 's/#### Description\/\/: //')
			title=$(curl -s https://bashpack.me/pckg/$search | grep "#### Title//: " | sed 's/#### Title\/\/: //')

			printf "\n\e[0;92m- \e[0m\e[1;77mtitle\e[0m\e[0;77m: \e[1;96m$title\e[0m\e[0m"
			printf "\n\e[0;92m- \e[0m\e[1;77mauthor\e[0m\e[0;77m: \e[0m\e[0;77m$author\e[0m\e[0m"
			printf "\n\e[0;92m- \e[0m\e[1;77mdescription\e[0m\e[0;77m: $desc\e[0m\e[0m"
			printf "\n\n\e[0;92m+ \e[0m\e[1;77minstall\e[0m\e[0;77m: \e[0;96mbashpack -i $search\e[0m\e[0m"
			exitt

		else
			tput rc
			printf "\e[0;91mx \e[0m\e[1;77m$search not found                                 \e[0m"
			exitt
		fi 
	;;

	5) ######## Delete Everything
		printf "\e[0;92m? \e[0m\e[1;77mYou will remove bashpack and all pckgs\e[0m"
		printf "\n\e[0;92m? \e[0m\e[1;77mAre you sure?\e[0;96m [y/n]\e[0m"
		read -r -n1 yn
		if [[ $yn == y ]]; then
			rm -rf ~/.bashpack
			exitt
		else
			exitt
		fi
	;;
	*) 
		:
	;;
esac
