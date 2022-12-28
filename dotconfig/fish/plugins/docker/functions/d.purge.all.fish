# Defined in - @ line 0
function d.purge.all --description 'alias d.purge.all=d.purge.containers; and d.purge.volumes; and d.purge.images'
	d.purge.containers; and d.purge.volumes; and d.purge.images $argv;
end
