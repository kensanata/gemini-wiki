#!/usr/bin/env perl
use Modern::Perl;
use Pod::Markdown;
use Text::Slugify qw(slugify);
use File::Slurper qw(read_text write_text);
my $pod = read_text('gemini-wiki.pl');
my $parser = Pod::Markdown->new;
my $markdown;
$parser->output_string(\$markdown);
$parser->parse_string_document($pod);
my @toc = $pod =~ /^=head2 (.*)/mg;
my $toc = "**Table of Contents**\n\n"
    . join("\n", map { "- [$_](#" . slugify($_) . ")" } @toc)
    . "\n\n";
$markdown =~ s/^## /$toc## /m;
write_text('README.md', $markdown);