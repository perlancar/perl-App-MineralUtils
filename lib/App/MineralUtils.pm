package App::MineralUtils;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our %SPEC;

my @magnesium_forms = (
    #{
    #    name => 'mg',
    #    magnesium_ratio => 1,
    #    summary => 'Elemental magnesium, in milligrams',
    #},
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
        summary => 'Magnesium citrate anhydrous (C6H5Mg3O7), in milligrams',
    },

    {
        name => 'mg-mg-citrate-ah-nowfoods',
        magnesium_ratio => 24.305/457.16*3, # 15.95%
        purity => 0.9091, # 15.95% x 0.9091 = 14.5%
        summary=>'Magnesium citrate in NOW Foods supplement (anhydrous, C6H5Mg3O7, 90.9% pure, contains citric acid etc), in milligrams'},
    {
        name=>'mg-mg-glycinate',
        magnesium_ratio => 24.305/172.42, # 14.1%
        summary=>'Magnesium glycinate/bisglycinate (C4H8MgN2O4), in milligrams',
    },
    {
        name=>'mg-mg-bisglycinate',
        magnesium_ratio => 24.305/172.42, # 14.1%
        summary=>'Magnesium glycinate/bisglycinate (C4H8MgN2O4), in milligrams',
    },
    {
        name=>'mg-mg-bisglycinate-nowfoods',
        magnesium_ratio => 24.305/172.42, # 14.1%
        purity => 0.7094, # 14.1% x 0.7094 = 10%
        summary=>'Magnesium bisglycinate in NOW Foods supplement (C4H8MgN2O4, 70.5% pure, contains citric acid etc), in milligrams',
    },

    {
        name=>'mg-mg-ascorbate',
        magnesium_ratio => 24.305/327.53, # 7.42%
        summary => 'Magnesium ascorbate/pidolate (C11H13MgNO9), in milligrams',
    },

    {
        name=>'mg-mg-pidolate',
        magnesium_ratio => 24.305/327.53, # 7.42%
        summary => 'Magnesium ascorbate/pidolate (C11H13MgNO9), in milligrams',
    },

    {
        name=>'mg-mg-l-threonate',
        magnesium_ratio => 24.305/294.50, # 8.25%
        summary => 'Magnesium L-threonate (C8H14MgO10), in milligrams',
    },

    {
        name=>'mg-mg-oxide',
        magnesium_ratio => 24.305 / 40.3044, # 60.3%
        summary => 'Magnesium oxide (MgO), in milligrams',
    },

    {
        name=>'mg-mg-lactate-dihydrate',
        magnesium_ratio => 24.305 / 238.48, # 10.2%
        summary => 'Magnesium lactate dihydrate (C6H14MgO8), in milligrams',
    },
);

# XXX share with App::VitaminUtils
our %argspecs_magnesium = (
    quantity => {
        # schema => 'physical::mass*', # XXX Perinci::Sub::GetArgs::Argv is not smart enough to coerce from string
        schema => 'str*',
        default => '1 mg',
        req => 0,
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
                    {alternative=>[map {$_->{name}} @magnesium_forms]},
                ],
            );
        },
    },
    to_unit => {
        # schema => 'physical::unit', # IU hasn't been added
        schema => ['str*', in=>['mg', map {$_->{name}} @magnesium_forms]],
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
        {
            args=>{},
            summary=>'Show all possible conversions',
        },
        {
            args=>{quantity=>'1000 mg-mg-l-threonate', to_unit=>'mg-mg-elem'},
            summary=>'Find out how many milligrams of elemental magnesium is in 1000mg of pure magnesium l-threonate (but note that a supplement product might not contain 100%-pure compound)',
        },
        {
            args=>{quantity=>'3000 mg-mg-citrate-ah-nowfoods', to_unit=>'mg-mg-elem'},
            summary=>'Find out how many milligrams of elemental magnesium is in 3g (1 recommended serving) of NOW Foods magnesium citrate powder (magnesium content is as advertised on the label)',
        },
        {
            args=>{quantity=>'2500 mg-mg-bisglycinate-nowfoods', to_unit=>'mg-mg-elem'},
            summary=>'Find out how many milligrams of elemental magnesium is in 2.5g (1 recommended serving) of NOW Foods magnesium bisglycinate powder (magnesium content is as advertised on the label)',
        },
    ],
};
sub convert_magnesium_unit {
    require Physics::Unit;

    Physics::Unit::InitUnit(
        map {([$_->{name}], sprintf("%.3f mg", $_->{magnesium_ratio}*($_->{purity}//1)))}
        @magnesium_forms,
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
            @magnesium_forms,
        ) {
            push @rows, {
                amount => $quantity->convert($u->{name}),
                unit => $u->{name},
                summary => $u->{summary},
            };
        }
        [200, "OK", \@rows, {
            'table.fields' => [qw/amount unit summary/],
            'table.field_formats'=>[[number=>{thousands_sep=>'', precision=>3}], undef, undef],
            'table.field_aligns' => [qw/number left left/],
        }];
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
