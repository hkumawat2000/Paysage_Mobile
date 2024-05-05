# Author: Neel Bhanushali <neal.bhanushali@gmail.com>
# sauce (stats generation): https://stackoverflow.com/a/49481836/9403680
import click
import os

@click.command()
@click.option('--date', required=True, help='Enter date from which the commits are to be considered (YYYY-MM-DD)', prompt='Enter date from which the commits are to be considered (YYYY-MM-DD)')
@click.option('--author', is_flag=True, help='Stats for a particular author?', prompt="Stats for a particular author?")
def git_stats(date, author):
	cmd = ['git log', '--oneline', '--shortstat', '--after={}'.format(date)]
	if author:
		cmd.append('--author="{}"'.format(click.prompt('Enter email of the author')))
	cmd.append('> .git.log')
	cmd = ' '.join(cmd)
	os.system(cmd)
	with open('.git.log', 'r') as f:
		files = insertions = deletions = 0
		for line in f:
			if 'insertions(+)' in line:
				line = line.strip()
				spl = line.split(', ')
				if len(spl) > 0:
					files += int(spl[0].split(' ')[0])
				if len(spl) > 1:
					insertions += int(spl[1].split(' ')[0])
				if len(spl) > 2:
					deletions += int(spl[2].split(' ')[0])
	if author:
		click.echo('Stats for author {} from {} are'.format(author, date))
	else:
		click.echo('Stats from {} are'.format(date))
	click.echo('{} {} changed, {} insertions(+), {} deletions(-)'.format(
			files, 
			'file' if files == 1 else 'files',
			insertions, 
			deletions
		)
	)
	os.remove('.git.log')

if __name__ == '__main__':
    git_stats()