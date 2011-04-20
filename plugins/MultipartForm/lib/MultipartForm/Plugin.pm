package MultipartForm::Plugin;

use strict;

sub _multipart_form {
    my ( $cb, $app, $tmpl ) = @_;
    my $meth = $cb->{ method };
    my $type = $app->param( '_type' );
    my $class = ucfirst( $type );
    if ( $app->config( 'MultipartForm' . $class ) ) {
        $meth =~ s/^template_source\.edit_//;
        my $search = '<form';
        if ( $meth eq 'entry' ) {
            $search = quotemeta( '<form name="entry_form"' );
        } elsif ( $meth eq 'author' ) {
            $search = quotemeta( '<form name="profile"' );
        }
        if ( $$tmpl =~ /($search.*?">)/ ) {
            if ( $1 !~ m!multipart\/form\-data! ) {
                $$tmpl =~ s!($search)!$1 enctype="multipart/form-data"!;
            }
        }
    }
    return 1;
}

1;