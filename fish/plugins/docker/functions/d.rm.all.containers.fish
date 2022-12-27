# Defined in - @ line 0
function d.rm.all.containers --description 'alias d.rm.all.containers=docker ps -a -q | xargs docker rm --volumes -f'
	docker ps -a -q | xargs docker rm --volumes -f $argv;
end
