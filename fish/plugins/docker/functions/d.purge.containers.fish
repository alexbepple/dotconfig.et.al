# Defined in - @ line 0
function d.purge.containers --description 'alias d.purge.containers=docker ps -f status=exited -q | xargs docker rm --volumes'
	docker ps -f status=exited -q | xargs docker rm --volumes $argv;
end
