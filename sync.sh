#!/opt/local/bin/bash
#echo "Copying Files... (Zsh, Emacs, Vim)"
#echo "cp ~/.zshrc ./zsh_configs/zsh"
#cp ~/.zshrc ./zsh_configs/zsh
#echo "cp ~/.emacs ./emacs/emacs"
#cp ~/.emacs ./emacs/emacs
#echo "cp ~/.emacs.d ./emacs/emacs.d"
#cp ~/.emacs.d ./emacs/emacs.d
#echo "cp ~/.vimrc ./vim/vimrc"
#cp ~/.vimrc ./vim/vimrc
#echo "Done"

# Do not include the url folder from emacs.d!
REPO_FOLDER="./sync_delete"
all_files="$(find .)"
hashed_files_current=""
SEP="\n"

declare -A files

for line in $all_files
do
    # Skipping version control, dirs and backups  
    if [[ $line == *".git"* || -d $line || $line == *"~" ]]; then
	continue
    fi
    #hashed_files_current="${hashed_files_current} \n ${current_hash}"
    current_hash="$(openssl md5 $line)"

    val=true
    IFS='=' read -ra hash <<< "$current_hash"
    for i in "${hash[@]}"; do
	if [ "$val" == true  ]; then
	    val="${false}"
	    continue
	fi
	files[$line]=$i
	#echo ${files[$line]}
    done
done
#echo -e $hashed_files_current # DEBUG

git clone https://github.com/yashrao/configs.git $REPO_FOLDER
#cd $REPO_FOLDER
$all_files="$(find ${REPO_FOLDER})"
hashed_files_clone=""
declare -A files_hashed

for line in $all_files
do
    # Skipping version control, dirs and backups  
    if [[ $line == *".git"* || -d $line || $line == *"~" ]]; then
	continue
    fi
    #hashed_files_clone="${hashed_files_clone} \n ${current_hash}"
    current_hash="$(openssl md5 $line)"

    val=true
    IFS='=' read -ra hash <<< "$current_hash"
    for i in "${hash[@]}"; do
	if [ "$val" == true  ]; then
	    val="${false}"
	    continue
	fi
	files_hashed[$line]=$i
	#echo ${files[$line]}
    done
done

#for line in ${files[@]}

echo `$(${files[@]} ${files_hashed[@]} | tr ' ' '\n' | sort | uniq -u)`


# # Finish
echo "Cleaning up"
#rm -rf ./sync_delete
echo "Sync Complete"
