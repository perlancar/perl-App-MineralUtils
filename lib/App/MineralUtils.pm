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
        magnesium_ratio => 24.305/374.54, # 6.49%
        summary => 'Magnesium ascorbate (C12H14MgO12), in milligrams',
    },

    {
        name=>'mg-mg-pidolate',
        magnesium_ratio => 24.305/280.517, # 8.66%
        summary => 'Magnesium pidolate (C10H12MgN2O6), in milligrams',
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

    {
        name=>'mg-mg-chloride-ah',
        magnesium_ratio => 24.305/95.211, # 25.5%
        summary => 'Magnesium chloride (anhydrous, MgCl2), in milligrams',
    },
    {
        name=>'mg-mg-chloride-hexahydrate',
        magnesium_ratio => 24.305/203.31, # 12.0%
        summary => 'Magnesium chloride (hexahydrate, H12Cl2MgO6), in milligrams',
    },
    {
        name=>'mg-mg-malate',
        magnesium_ratio => 24.305/156.376, # 15.5%
        summary => 'Magnesium malate (C4H4MgO5), in milligrams',
    },
    {
        name=>'mg-mg-malate-trihydrate',
        magnesium_ratio => 24.305/210.40, # 11.6%
        summary => 'Magnesium malate (MgC4H4O5.3H2O), in milligrams',
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

our @potassium_forms = (
    {
        name => 'mg-k-elem',
        potassium_ratio => 1,
        summary => 'Elemental potassium, in milligrams',
    },
    # note: unlike magnesium (MgCl hexahydrate), KCl and NaCl does not form hydrates
    {
        name => 'mg-k-chloride',
        potassium_ratio => 39.0983/74.5513, # 52.45%
        summary => 'Potassium chloride (KCl), in milligrams',
    },
    {
        name => 'mg-k-cl',
        potassium_ratio => 39.0983/74.5513, # 52.45%
        summary => 'Potassium chloride (KCl), in milligrams',
    },
    {
        name => 'mg-k-citrate',
        potassium_ratio => 3*39.0983/306.395, # 12.76%
        summary => 'Potassium citrate (K3C6H5O7), in milligrams',
    },
);

our %argspecs_potassium = (
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
                    {alternative=>[map {$_->{name}} @potassium_forms]},
                ],
            );
        },
    },
    to_unit => {
        # schema => 'physical::unit', # IU hasn't been added
        schema => ['str*', in=>['mg', map {$_->{name}} @potassium_forms]],
        pos => 1,
    },
);

our @sodium_forms = (
    {
        name => 'mg-na-elem',
        sodium_ratio => 1,
        summary => 'Elemental sodium, in milligrams',
    },
    # note: unlike magnesium (MgCl hexahydrate), KCl and NaCl does not form hydrates
    {
        name => 'mg-na-chloride',
        sodium_ratio => 22.989769/58.44, # 39.34%
        summary => 'Sodium chloride (NaCl), in milligrams',
    },
    {
        name => 'mg-na-cl',
        sodium_ratio => 22.989769/58.44, # 39.34%
        summary => 'Sodium chloride (NaCl), in milligrams',
    },
    {
        name => 'mg-na-citrate',
        sodium_ratio => 22.989769/258.06, # 8.909%
        summary => 'Sodium citrate (Na3C6H5O7), in milligrams',
    },
);

our %argspecs_sodium = (
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
                    {alternative=>[map {$_->{name}} @sodium_forms]},
                ],
            );
        },
    },
    to_unit => {
        # schema => 'physical::unit', # IU hasn't been added
        schema => ['str*', in=>['mg', map {$_->{name}} @sodium_forms]],
        pos => 1,
    },
);

$SPEC{convert_potassium_unit} = {
    v => 1.1,
    summary => 'Convert a potassium quantity from one unit to another',
    description => <<'_',

If target unit is not specified, will show all known conversions.

_
    args => {
        %argspecs_potassium,
    },
    examples => [
        {
            args=>{},
            summary=>'Show all possible conversions',
        },
        {
            args=>{quantity=>'1000 mg-k-elem', to_unit=>'mg-k-cl'},
            summary=>'How much of potassium chloride provides 1000 mg of elemental potassium?',
        },
        {
            args=>{quantity=>'1000 mg-k-chloride', to_unit=>'mg-k-chloride'},
            summary=>'How much elemental potassium is in 1000mg (1g) of potassium chloride powder in capsule form?',
        },
        {
            args=>{quantity=>'600 mg-k-chloride', to_unit=>'mg-k-elem'},
            summary=>'A tablet supplement called KSR contains 600mg of potassium chloride; how much elemental potassium is that?',
        },
        {
            args=>{quantity=>'4700 mg-k-elem', to_unit=>'mg-k-chloride'},
            summary=>'Recommended daily intake (DV) of (elemental) potassium for adults and children 4 years or older is 4,700mg according to US FDA; how much is that equivalent to in KCl? Note that it is *NOT* recommended (and most probably dangerous) to take KCl supplement that much as potassium is contained in other sources too',
        },
    ],
};
sub convert_potassium_unit {
    require Physics::Unit;

    Physics::Unit::InitUnit(
        map {([$_->{name}], sprintf("%.3f mg", $_->{potassium_ratio}*($_->{purity}//1)))}
        @potassium_forms,
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
            @potassium_forms,
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

$SPEC{convert_sodium_unit} = {
    v => 1.1,
    summary => 'Convert a sodium quantity from one unit to another',
    description => <<'_',

If target unit is not specified, will show all known conversions.

_
    args => {
        %argspecs_sodium,
    },
    examples => [
        {
            args=>{},
            summary=>'Show all possible conversions',
        },
        {
            args=>{quantity=>'1000 mg-na-elem', to_unit=>'mg-na-cl'},
            summary=>'How much of sodium chloride provides 1000 mg of elemental sodium?',
        },
    ],
};
sub convert_sodium_unit {
    require Physics::Unit;

    Physics::Unit::InitUnit(
        map {([$_->{name}], sprintf("%.3f mg", $_->{sodium_ratio}*($_->{purity}//1)))}
        @sodium_forms,
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
            @sodium_forms,
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

our @iron_forms = (
    {
        name => 'mg-fe-elem',
        iron_ratio => 1,
        summary => 'Elemental iron, in milligrams',
    },
    # note: unlike magnesium (MgCl hexahydrate), KCl and NaCl does not form hydrates
    {
        name => 'mg-na-chloride',
        iron_ratio => 22.989769/58.44, # 39.34%
        summary => 'Sodium chloride (NaCl), in milligrams',
    },
);

our %argspecs_iron = (
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
                    {alternative=>[map {$_->{name}} @iron_forms]},
                ],
            );
        },
    },
    to_unit => {
        # schema => 'physical::unit', # IU hasn't been added
        schema => ['str*', in=>['mg', map {$_->{name}} @iron_forms]],
        pos => 1,
    },
);

$SPEC{convert_iron_unit} = {
    v => 1.1,
    summary => 'Convert an iron quantity from one unit to another',
    description => <<'_',

If target unit is not specified, will show all known conversions.

_
    args => {
        %argspecs_iron,
    },
    examples => [
        {
            args=>{},
            summary=>'Show all possible conversions',
        },
    ],
};
sub convert_iron_unit {
    require Physics::Unit;

    Physics::Unit::InitUnit(
        map {([$_->{name}], sprintf("%.3f mg", $_->{iron_ratio}*($_->{purity}//1)))}
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

our @calcium_forms = (
    {
        name => 'mg-ca-elem',
        iron_ratio => 1,
        summary => 'Elemental calcium, in milligrams',
    },
    {
        name => 'mg-ca-carbonate',
        iron_ratio => 40.078 / 100.0869, # 40.04%
        summary => 'Calcium carbonate (CaCO3), in milligrams',
    },
    {
        name => 'mg-ca-pidolate',
        iron_ratio => 40.078 / 296.29, # 13.53%
        summary => 'Calcium pidolate (C10H12CaN2O6), in milligrams',
        tags => ['water-soluble'],
    },
    {
        name => 'mg-ca-lactate',
        iron_ratio => 40.078 / 218.22, # 18.37%
        summary => 'Calcium lactate (C6H10CaO6), in milligrams',
        tags => ['water-soluble'],
    },
);

our %argspecs_calcium = (
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
                    {alternative=>[map {$_->{name}} @calcium_forms]},
                ],
            );
        },
    },
    to_unit => {
        # schema => 'physical::unit', # IU hasn't been added
        schema => ['str*', in=>['mg', map {$_->{name}} @calcium_forms]],
        pos => 1,
    },
);

$SPEC{convert_calcium_unit} = {
    v => 1.1,
    summary => 'Convert an iron quantity from one unit to another',
    description => <<'_',

If target unit is not specified, will show all known conversions.

_
    args => {
        %argspecs_iron,
    },
    examples => [
        {
            args=>{},
            summary=>'Show all possible conversions',
        },
    ],
};
sub convert_calcium_unit {
    require Physics::Unit;

    Physics::Unit::InitUnit(
        map {([$_->{name}], sprintf("%.3f mg", $_->{iron_ratio}*($_->{purity}//1)))}
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
