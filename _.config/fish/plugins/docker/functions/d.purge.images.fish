# Defined in - @ line 0
function d.purge.images --description 'alias d.purge.images=docker images -f dangling=true -q | xargs docker rmi'
	docker images -f dangling=true -q | xargs docker rmi $argv;
end
