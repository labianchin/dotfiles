"""
Convert and old shell Brewfile (install package) to new hombrew-budle Brewfile
ref: https://github.com/Homebrew/homebrew-bundle
"""

import fileinput


def process_install_line(line):
    spl = line.split(' ')
    packages = spl[1:]
    params = ''
    if (len(spl) > 2) and spl[2].startswith('--'):
        packages = [spl[1]]
        params = ', args: [%s]' % ', '.join(map(lambda x: "'"+x.lstrip('--')+"'", spl[2:]))
    return map(lambda package: "brew '%s'%s" % (package, params), packages)


def main():
    for line in fileinput.input():
        line = line.strip(' \n\t')
        if line.startswith('install'):
            print '\n'.join(process_install_line(line))
        elif line.startswith('cask install'):
            cmd, _, package = line.split(' ', 2)
            print "%s '%s'" % (cmd, package)
        elif line.startswith('tap'):
            cmd, tap = line.split(' ', 1)
            print "%s '%s'" % (cmd, tap)


if __name__ == "__main__":
    main()