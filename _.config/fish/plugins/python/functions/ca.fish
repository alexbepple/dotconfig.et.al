# Defined in - @ line 0
function ca --description 'alias ca=conda activate (less environment.yml | grep "name:" | cut -d" " -f2)'
	conda activate (less environment.yml | grep "name:" | cut -d" " -f2) $argv;
end
