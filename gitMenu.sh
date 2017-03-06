#!bin/bash
#init, commit, new branch, add
create(){
	echo -e "1.repo\n2.branch\n3.commit\n4.file\n5.remote repo"
	read action
	case $action in
	1)
	echo "enter the name for new repo"
	read name
	git init $name
	git status
	;;
	2)
	echo "enter the name for new branch"
	read name
	git branch $name
	;;
	3)
	git status
	echo "enter message"
	read msg
	git commit -m $msg
	;;
	4)
	echo "enter the file name"
	read name
	git add $name
	;;
	5)
	echo "enter name"
	read name
	echo "enter url"
	read url
	git remote add $name $url
	;;
esac
}
#del branch, commit, file, repo
remove(){
	echo -e "1.repo\n2.branch\n3.commit\n4.file"
	read action
	case $action in
	1)
	echo "enter name deleting repo"
	read name
#TODO
	;;
	2)
	echo "select branch for remove"
	read name
	git  branch -d $name
	git branch
	;;
	4)
	echo "enter filename"
	read name
	git rm $name
	git status
	;;
	3)
#TODO
	;;
esac
}
#status, switch branch, remote repo
edit(){
	echo -e "select the action\n1.switch branch\n2.status\n3.show remote repo\n4.show remote"
	read action
	case $action in
	1)
	echo "enter name branch"
	read name
	git checkout $name
	;;
	2)
	git status
	;;
	3)
	git remote
	;;
	4)
	git remote -v
	;;
esac
}
#pull, push, clone, fetch
content(){
	echo -e "1.fetch\n2.pull\n3.push\n4.clone"
	read action
	echo "enter url"
	read url
	case $action in
	1)
	git fetch $url
	;;
	2)
	echo "enter name branch"
	read name
	git pull $url $name
	;;
	3)
	echo "enter the name branch for push"
	read name
	git push $url $name
	;;
	4)
	echo "enter the name for cloning repo"
	read name
	git clone $url $name
	;;
esac
}

echo -e "select action:\n1.create\n2.remove\n3.content\n4.edit"
read action
case $action in
	1)
	create
	;;
	2)
	remove
	;;
	3)
	content
	;;
	4)
	edit
	;;
esac
