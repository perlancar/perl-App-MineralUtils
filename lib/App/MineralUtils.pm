package App::MineralUtils;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

our %SPEC;

# XXX share with App::VitaminUtils
our %args_common = (
    quantity => {
        # schema => 'physical::mass*', # XXX Perinci::Sub::GetArgs::Argv is not smart enough to coerce from string
        schema => 'str*',
        req => 1,
        pos => 0,
    },
    to_unit => {
        # schema => 'physical::unit', # IU hasn't been added
        schema => 'str*',
        pos => 1,
    },
);

$SPEC{convert_magnesium_unit} = {
    v => 1.1,
    summary => 'Convert a magnesium quantity from one unit to another',
    description => <<'_',

If target unit is not specified, will show all known conversions.

_
    args => {
        %args_common,
    },
    examples => [
        {args=>{quantity=>'mg'}, summary=>'Show all possible conversions'},
        {args=>{quantity=>'1000 mg', to_unit=>'IU'}, summary=>'Find out how many elemental magnesium is in 1000mg of magnesium l-threonate'},
    ],
};
sub convert_vitamin_a_unit {
    require Physics::Unit;

    Physics::Unit::InitUnit(
        ['mg-magnesium-elemental'], '1 mg',
        ['mg-magnesium-citrate'], '0.1123 mg-magnesium-elemental',
        ['mg-magnesium-glycinate'], '0.141 mg-magnesium-elemental',
        ['mg-magnesium-l-threonate'], '0.072 mg-magnesium-elemental',
        ['mg-magnesium-oxide'], '0.603 mg-magnesium-elemental',
    );

    my %args = @_;
    my $quantity = Physics::Unit->new($args{quantity});
    return [412, "Must be a Mass quantity"] unless $quantity->type eq 'Mass';

    if ($args{to_unit}) {
        my $new_amount = $quantity->convert($args{to_unit});
        return [200, "OK", $new_amount];
    } else {
        my @rows;
        for my $u (
            'mg',
            'mg-magnesium-elemental',
            'mg-magnesium-citrate',
            'mg-magnesium-glycinate',
            'mg-magnesium-l-threonate',
            'mg-magnesium-oxide',
        ) {
            push @rows, {
                unit => $u,
                amount => $quantity->convert($u),
            };
        }
        [200, "OK", \@rows];
    }
}

1;
#ABSTRACT: Utilities related to minerals (and mineral supplements)

=head1 DESCRIPTION

This distributions provides the following command-line utilities:

# INSERT_EXECS_LIST


=head1 SEE ALSO

L<App::VitaminUtils>

L<Physics::Unit>

Online vitamin converters:
L<https://www.rfaregulatoryaffairs.com/vitamin-converter>,
L<https://avsnutrition.com.au/wp-content/themes/avs-nutrition/vitamin-converter.html>.

=cut
