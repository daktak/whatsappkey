<?php
//if they DID upload a file...
$valid_file = true;
if($_FILES['key']['name'])
{
	//if no errors...
	if(!$_FILES['key']['error'])
	{
		//now is the time to modify the future file name and validate the file
		$new_file_name = strtolower($_FILES['key']['tmp_name']); //rename file
		if($_FILES['key']['size'] > (1024000)) //can't be larger than 1 MB
		{
			$valid_file = false;
			$message = 'Oops!  Your file\'s size is to large.';
		}
		
		//if the file has passed the test
		if($valid_file)
		{
			//move it to where we want it to be
			$currentdir = getcwd();
			$target = $currentdir .'/tmp/uploads/' . basename($_FILES['key']['name']);
			move_uploaded_file($_FILES['key']['tmp_name'], $target);
			$message = 'Congratulations!  Your file was accepted.';
			exec('./step1.sh '.$target.' '.$_POST['phone']);
			echo exec('./step2.sh');
		}
	}
	//if there is an error...
	else
	{
		//set that to be the returned message
		$message = 'Ooops!  Your upload triggered the following error:  '.$_FILES['key']['error'];
	}
}
?>

