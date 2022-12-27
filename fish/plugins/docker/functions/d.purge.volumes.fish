# Defined in - @ line 0
function d.purge.volumes --description 'alias d.purge.volumes=docker volume ls -f dangling=true -q | xargs docker volume rm'
	docker volume ls -f dangling=true -q | xargs docker volume rm $argv;
end
