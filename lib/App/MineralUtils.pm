package App::MineralUtils;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

our %SPEC;

my @magnesium_forms = (
    {
        name => 'mg',
        magnesium_ratio => 1,
        summary => 'Elemental magnesium, in milligrams',
    },
    {
        name => 'mg-mg-elem',
        magnesium_ratio => 1,
        summary => 'Elemental magnesium, in milligrams',
    },
    {
        name => 'mg-mg-citrate',
        magnesium_ratio => 24.305/214.412, # 11.34%
        summary => 'Magnesium citrate (C6H6MgO7), in milligrams',
    },
    {
        name => 'mg-mg-citrate-ah',
        magnesium_ratio => 24.305/457.16*3, # 15.95%
        purity => 1,
        summary => 'Magnesium citrate anhydrous (C6H5Mg3O7), in milligrams',
    },
    {
        name => 'mg-mg-citrate-ah-nowfoods',
        magnesium_ratio => 24.305/457.16*3, # 15.95%
        purity => 0.9091, # 15.95% x 0.9091 =
        summary=>'Magnesium citrate in NOW Foods supplement (anhydrous, C6H5Mg3O7, contains citric acid etc, purity 90.9%), in milligrams'},
    {
        name=>'mg-mg-glycinate', magnesium_ratio => magnesium_ratio => 24.305/172.42, purity=>1, summary=>'Magnesium glycinate/bisglycinate (C4H8MgN2O4), in milligrams'},
    {
        name=>'mg-mg-bisglycinate', magnesium_ratio => 24.305/172.42, purity=>1, summary=>'Magnesium glycinate/bisglycinate (C4H8MgN2O4), in milligrams'},
    {
        name=>'mg-mg-bisglycinate-nowfoods', magnesium_ratio => 24.305/172.42, purity=>70.94, summary=>'Magnesium glycinate/bisglycinate (C4H8MgN2O4), in milligrams'},
    {
        name=>'mg-mg-l-threonate', magnesium_ratio => 24.305/294.50, purity=>1, C8H14MgO10,
     {
         name=>'mg-mg-oxide', magnesium_ratio => ,
);

# XXX share with App::VitaminUtils
our %argspecs_magnesium = (
    quantity => {
        # schema => 'physical::mass*', # XXX Perinci::Sub::GetArgs::Argv is not smart enough to coerce from string
        schema => 'str*',
        req => 1,
        pos => 0,
        completion => sub {
            require Complete::Sequence;

            my %args = @_;
            Complete::Sequence::complete_sequence(
                word => $args{word},
                sequence => [
                    # TEMP
                    #sub {
                    #    require Complete::Number;
                    #    my $stash = shift;
                    #    Complete::Number::complete_int(word => $stash->{cur_word});
                    #},
                    #' ',
                    {alternative=>\@magnesium_units},
                ],
            );
        },
    },
    to_unit => {
        # schema => 'physical::unit', # IU hasn't been added
        schema => ['str*', in=>\@magnesium_units],
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
        %argspecs_magnesium,
    },
    examples => [
        {args=>{quantity=>'mg'}, summary=>'Show all possible conversions'},
        {args=>{quantity=>'1000 mg-magnesium-l-threonate', to_unit=>'mg-magnesium-elemental'}, summary=>'Find out how many mg of elemental magnesium is in 1000mg of magnesium l-threonate'},
    ],
};
sub convert_magnesium_unit {
    require Physics::Unit;

    Physics::Unit::InitUnit(
        ['mg-magnesium-elemental'], '1 mg',
        ['mg-magnesium-citrate'], '0.1123 mg-magnesium-elemental',
        ['mg-magnesium-glycinate'], '0.141 mg-magnesium-elemental',
        ['mg-magnesium-bisglycinate'], '0.141 mg-magnesium-elemental',
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
            @magnesium_units,
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
#ABSTRACT: Utilities related to mineral supplements

=head1 DESCRIPTION

This distributions provides the following command-line utilities:

# INSERT_EXECS_LIST


=head1 SEE ALSO

L<App::VitaminUtils>

L<Physics::Unit>

=cut
