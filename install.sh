# 
# install.sh
#
# This 'installs' files by first removing existing versions and then
# linking them to the versions provided in this little repository.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

remove_files ()
{
    echo "Removing existing files..."
    rm -fv ~/.bash_profile
    rm -fv ~/.bashrc
    rm -fv ~/.gemrc
}

link_files ()
{
    echo "Linking files..."
    ln -sv $DIR/bash_profile ~/.bash_profile
    ln -sv $DIR/bashrc ~/.bashrc
    ln -sv $DIR/gemrc ~/.gemrc
}


echo "This will erase your ~/.bash_profile, .bashrc, and .gemrc files"
echo "and create symlinks to the versions in this directory:"
echo $DIR
echo ""
echo "Do you want to continue?"

select yn in "Yes" "No"; do
case $yn in
    Yes )
	remove_files;
	link_files;
	echo "Done.";
	exit;;
    No )
	echo "Not installing. Have a nice day.";
	exit;;
esac
done
