#!/opt/local/bin/bash

# Do not include the url folder from emacs.d!
REPO_FOLDER="./sync_delete"
#all_files="$(find .)"
all_files="$(find . -type f -follow -print)"
hashed_files_current=""
SEP="\n"

declare -A files

function check_file_dir {
    res="?"
    if [ ! -d "$1" ]; then
	res="dir"
    elif [ ! -f "$1" ]; then
	res="file"
    fi
    echo $res
}

echo "Copying current config files"
check_file ~/.zshrc
cp ~/.zshrc ./zsh_configs/zshrc
cp ~/.emacs ./emacs/emacs
cp -r ~/.emacs.d/* ./emacs/emacs.d
cp ~/.vimrc ./vim/vimrc
echo "Done"

for line in $all_files
do
    # Skipping version control, dirs and backups  
    if [[ $line == *".git"* || -d $line || $line == *"~" || $line == *".swp" ]]; then
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
echo "Grabbing updated configs"
git clone https://github.com/yashrao/configs.git $REPO_FOLDER
echo "Done"
#cd $REPO_FOLDER
#$all_files="$(find ${REPO_FOLDER})"
#all_files_clone="$(find ${REPO_FOLDER})"
cd ${REPO_FOLDER}
all_files_clone="$(find . -type f -follow -print)"
#cd .. 
#echo $all_files
hashed_files_clone=""
declare -A files_git

for line in $all_files_clone
do
    # Skipping version control, dirs and backups  
    if [[ $line == *".git"* || -d $line || $line == *"~" || $line == *".swp" ]]; then
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
	#echo $i $line
	files_git[$line]=$i
	#echo ${files[$line]}
    done
done

#check all the existing files for changes
for key in ${!files[@]}; do
    if [ "${files_git[${key}]}" != "${files[${key}]}" ]; then
	echo ${key} has changed "(${files_git[${key}]} ${files[${key}]})"
    fi
done

for key in ${!files_git[@]}; do
    if [ "${files_git[${key}]}" != "${files[${key}]}" ]; then
	echo ${key} has changed "(${files_git[${key}]} ${files[${key}]})"
    fi
done

#for line in ${files[@]}

# # Finish
echo "Cleaning up"
cd ..
rm -rf ./sync_delete
echo "Sync Complete"

