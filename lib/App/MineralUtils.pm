package App::MineralUtils;

use 5.010001;
use strict;
use utf8;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our %SPEC;

# BEGIN magnesium lexical
{

# good sources: pubchem
# not-so-good sources: american elements

my @magnesium_forms = (
    # ---- elemental
    {
        name => 'mg-mg-elem',
        magnesium_ratio => 1,
        summary => 'Elemental magnesium, in milligrams',
    },

    # ---- citrate
    {
        # source: pubchem
        name => 'mg-trimagnesium-dicitrate',
        magnesium_ratio => 24.305*3/451.12, # 16.16%
        summary => 'Magnesium citrate a.k.a trimagnesium dicitrate (C12H10Mg3O14), in milligrams',
    },
    {
        # source: pubchem
        name => 'mg-mg-citrate-dibasic',
        magnesium_ratio => 24.305/214.41, # 11.34%
        summary => 'Magnesium citrate dibasic (C6H6MgO7), in milligrams',
    },
    {
        # source: jungbunzlauer, fischer scientific
        name => 'mg-mg-citrate-anhydrous',
        magnesium_ratio => 24.305*3/457.16, # 15.95%
        summary => 'Magnesium citrate anhydrous ((C6H5O7)2Mg3, C12H16Mg3O14), in milligrams',
    },
    {
        # source: nowfoods, jungbunzlauer, fischer scientific
        name => 'mg-mg-citrate-anhydrous-nowfoods',
        magnesium_ratio => 24.305*3/457.16, # 15.95%
        purity => 0.9091, # 15.95% x 0.9091 = 14.5%
        summary=>'Magnesium citrate in NOW Foods supplement (anhydrous, C12H16Mg3O14, 90.9% pure, contains citric acid etc), in milligrams',
    },
    {
        # source: pubchem, jungbunzlauer
        name => 'mg-mg-citrate-nonahydrate',
        magnesium_ratio => 24.305/613.25, # 11.89%
        summary => 'Magnesium citrate nonahydrate ((C6H5O7)2Mg3 · 9H2O, C12H28Mg3O23) [most common hydrate form of Mg-citrate at room temp], in milligrams',
    },

    # ---- glycinate/bisglycinate
    {
        # source: pubchem
        name=>'mg-mg-glycinate-anhydrous',
        magnesium_ratio => 24.305/172.42, # 14.10%
        summary=>'Magnesium glycinate/bisglycinate anhydrous (C4H8MgN2O4) [most common hydrate form of Mg-glycinate], in milligrams',
    },
    {
        # alias for: mg-mg-glycinate
        # source: pubchem
        name=>'mg-mg-bisglycinate-anhydrous',
        magnesium_ratio => 24.305/172.42, # 14.1%
        summary=>'Magnesium glycinate/bisglycinate (C4H8MgN2O4) [most common hydrate form of Mg-glycinate], in milligrams',
    },
    {
        # source: nowfoods
        name=>'mg-mg-bisglycinate-nowfoods',
        magnesium_ratio => 24.305/172.42, # 14.1%
        purity => 0.7094, # 14.1% x 0.7094 = 10%
        summary=>'Magnesium bisglycinate in NOW Foods supplement (C4H8MgN2O4, 70.5% pure, contains citric acid etc), in milligrams',
    },

    # ---- ascorbate
    # TODO
    #{
    #    # source: pubchem
    #    name=>'mg-mg-ascorbate-anhydrous',
    #    magnesium_ratio => 24.305/, # %
    #    summary => 'Magnesium ascorbate anhydrous (C12H14MgO12) [this and dihydrate are the most common hydrate form of Mg-ascorbate at room temp], in milligrams',
    #},
    {
        # source: pubchem
        name=>'mg-mg-ascorbate-dihydrate',
        magnesium_ratio => 24.305/374.54, # 6.49%
        summary => 'Magnesium ascorbate hydrate (C12H14MgO12) [anhydrous and dihydrate are the most common hydrate forms of Mg-ascorbate at room temp], in milligrams',
    },

    # ---- pidolate
    {
        # source: pubchem
        name=>'mg-mg-pidolate',
        magnesium_ratio => 24.305/280.517, # 8.66%
        summary => 'Magnesium pidolate (C10H12MgN2O6), in milligrams',
    },

    # ---- l-threonate
    {
        # source: pubchem
        name=>'mg-mg-l-threonate',
        magnesium_ratio => 24.305/294.50, # 8.25%
        summary => 'Magnesium L-threonate (C8H14MgO10), in milligrams',
    },

    # ---- oxide
    {
        name=>'mg-mg-oxide-anhydrous',
        magnesium_ratio => 24.305 / 40.3044, # 60.3%
        summary => 'Magnesium oxide anhydrous (MgO) [most common hydrate form of MgO at room temp], in milligrams',
    },
    {
        name=>'mg-magshape',
        magnesium_ratio => 0.32, # 30-36.6% from COA
        summary => 'MAGSHAPE (microencapsulated form of magnesium oxide), in milligrams',
    },

    # ---- others
    {
        name=>'mg-mg-lactate-anhydrous',
        magnesium_ratio => 24.305 / 202.45, # 12.01%
        summary => 'Magnesium lactate dihydrate (C6H10MgO6), in milligrams',
    },
    {
        name=>'mg-mg-lactate-dihydrate',
        magnesium_ratio => 24.305 / 238.48, # 10.19%
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

    {
        name=>'mg-mg-sulfate-anhydrous',
        magnesium_ratio => 24.305/120.37, # 20.19%
        summary => 'Magnesium sulfate anhydrous (MgSO4), in milligrams',
    },
    {
        name=>'mg-mg-sulfate-monohydrate',
        magnesium_ratio => 24.305/138.39, # 17.56%
        summary => 'Magnesium sulfate monohydrate (MgSO4.H2O), in milligrams',
    },
    {
        name=>'mg-mg-sulfate-heptahydrate',
        magnesium_ratio => 24.305/246.48, # 9.86%
        summary => 'Magnesium sulfate heptahydrate (MgSO4.7H2O) a.k.a. Epsom salt, in milligrams',
    },

    {
        name=>'mg-mg-carbonate-anhydrous',
        magnesium_ratio => 24.305/84.31, # 28.83%
        summary => 'Magnesium carbonate anhydrous (MgCO3), in milligrams',
    },
    {
        name=>'mg-mg-carbonate-trihydrate',
        magnesium_ratio => 24.305/146.39, # 16.61%
        summary => 'Magnesium carbonate trihydrate (MgCO3.3H2O), in milligrams',
    },

    {
        name=>'mg-mg-hydroxide-anhydrous',
        magnesium_ratio => 24.305/58.32, # 41.68%
        summary => 'Magnesium hydroxide anhydrous (Mg(OH)2), in milligrams',
    },
    {
        name=>'mg-mg-hydroxide-pentahydrate',
        magnesium_ratio => 24.305/138.36, # 17.57%
        summary => 'Magnesium hydroxide pentahydrate (Mg(OH)2.5H2O), in milligrams',
    },

    {
        name=>'mg-mg-acetate-anhydrous',
        magnesium_ratio => 24.305/142.39, # 17.07%
        summary => 'Magnesium acetate anhydrous (Mg(CH3COO)2), in milligrams',
    },
    {
        name=>'mg-mg-acetate-tetrahydrate',
        magnesium_ratio => 24.305/214.45, # 11.33%
        summary => 'Magnesium acetate tetrahydrate (Mg(CH3COO)2.4H2O), in milligrams',
    },

    {
        name=>'mg-mg-gluconate-dihydrate',
        magnesium_ratio => 24.305/450.63, # 5.39%
        summary => 'Magnesium gluconate dihydrate (C12H26MgO16), in milligrams',
    },
    {
        name=>'mg-mg-gluconate-hydrate',
        magnesium_ratio => 24.305/432.62, # 5.62%
        summary => 'Magnesium gluconate dihydrate (C12H26MgO16), in milligrams',
    },

    {
        name=>'mg-mg-glycerophosphate-anhydrous',
        magnesium_ratio => 24.305/194.36, # 12.51%
        summary => 'Magnesium glycerophosphate anhydrous (C₃H₇MgO₆P), in milligrams',
    },
    {
        name=>'mg-mg-glycerophosphate-hydrate',
        magnesium_ratio => 24.305/212.3781, # 11.44%
        summary => 'Magnesium glycerophosphate anhydrous (C₃H₇MgO₆P.H2O, C3H9MgO7P), in milligrams',
    },
    # XXX Magnesium glycerophosphate dihydrate?
    # XXX magnesium phosphate?

    {
        name=>'mg-trimagnesium-orthophosphate-anhydrous',
        magnesium_ratio => 3*24.305/262.8577, # 27.74%
        summary => 'Trimagnesium orthophosphate (Mg3O8P2), in milligrams',
    },
    {
        name=>'mg-sunactive-mg',
        magnesium_ratio => 0.12, # >12% according to spec
        summary => 'SunActive Magnesium (a micronized, microencapsulated form of trimagnesium orthophosphate), in milligrams',
    },

    {
        name=>'mg-mg-taurate',
        magnesium_ratio => 24.305/272.6, # 8.92%
        summary => 'Magnesium taurate (C4H12MgN2O6S2), in milligrams',
    },
);

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
    description => <<'MARKDOWN',

If target unit is not specified, will show all known conversions.

MARKDOWN
    args => {
        %argspecs_magnesium,
    },
    examples => [
        {
            args=>{},
            summary=>'Show all possible conversions',
        },
        {
            args=>{quantity=>'350 mg-mg-oxide-anhydrous', to_unit=>'mg-mg-elem'},
            summary=>'How much of magnesium oxide provides 350 mg of elemental magnesium?',
        },
        {
            src_plang => 'bash',
            src=>'[[prog]] | td sort -- -pct_mg',
            summary=>'Sort by highest magnesium content',
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
                pct_mg => $u->{magnesium_ratio} * 100,
                purity => $u->{purity} // 1,
            };
        }
        [200, "OK", \@rows, {
            'table.fields' => [qw/amount pct_mg purity unit summary/],
            'table.field_formats'=>[[number=>{thousands_sep=>'', precision=>3}],
                                    [number=>{thousands_sep=>'', precision=>3}],
                                    [number=>{thousands_sep=>'', precision=>3}], undef, undef],
            'table.field_aligns' => [qw/number number left left/],
        }];
    }
}

} # END magnesium lexical

# BEGIN potassium lexical
{

my @potassium_forms = (
    {
        name => 'mg-k-elem',
        potassium_ratio => 1,
        summary => 'Elemental potassium, in milligrams',
    },

    # chloride
    {
        name => 'mg-k-chloride-anhydrous',
        potassium_ratio => 39.0983/74.5513, # 52.45%
        summary => 'Potassium chloride (KCl) anhydrous [most common hydrate form of KCl at room temp], in milligrams',
    },
    {
        name => 'mg-k-chloride-dihydrate',
        potassium_ratio => 39.0983/110.58, # 35.36%
        summary => 'Potassium chloride dihydrate (KCl.2H2O) [unstable at room temp], in milligrams',
    },

    # citrate
    {
        name => 'mg-k-citrate-anhydrous',
        potassium_ratio => 3*39.0983/306.395, # 38.28%
        summary => 'Tripotassium citrate anhydrous (K3C6H5O7), in milligrams',
    },
    {
        name => 'mg-k-citrate-monohydrate',
        potassium_ratio => 3*39.0983/324.41, # 36.16%
        summary => 'Tripotassium citrate monohydrate (K3C6H5O7.H2O) [most common hydrate form of K-citrate at room temp], in milligrams',
    },

    # carbonate
    {
        name => 'mg-k-carbonate-anhydrous',
        potassium_ratio => 2*39.0983/138.205, # 56.58%
        summary => 'Potassium carbonate anhydrous (K2CO3), in milligrams',
    },
    {
        name => 'mg-k-carbonate-dihydrate',
        potassium_ratio => 2*39.0983/174.24, # 44.88%
        summary => 'Potassium carbonate dihydrate (K2CO3.2H2O) [most common hydrate form of K-carbonate at room temp], in milligrams',
    },

    # bicarbonate
    {
        name => 'mg-k-bicarbonate-anhydrous',
        potassium_ratio => 39.0983/100.115, # 39.05%
        summary => 'Potassium bicarbonate anhydrous (KHCO3) [most common hydrate form of K-bicarbonate at room temp], in milligrams',
    },

    # acetate
    {
        name => 'mg-k-acetate-anhydrous',
        potassium_ratio => 39.0983/98.14, # 39.84%
        summary => 'Potassium acetate anhydrous (C2H3O2K), in milligrams',
    },
    {
        name => 'mg-k-acetate-monohydrate',
        potassium_ratio => 39.0983/116.16, # 33.66%
        summary => 'Potassium acetate monohydrate (C2H9KO5) [most common hydrate form of K-acetate at room temp], in milligrams',
    },
    {
        name => 'mg-k-acetate-trihydrate',
        potassium_ratio => 39.0983/152.19, # 25.69%
        summary => 'Potassium acetate trihydrate (C2H9KO5), in milligrams',
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

$SPEC{convert_potassium_unit} = {
    v => 1.1,
    summary => 'Convert a potassium quantity from one unit to another',
    description => <<'MARKDOWN',

If target unit is not specified, will show all known conversions.

MARKDOWN
    args => {
        %argspecs_potassium,
    },
    examples => [
        {
            args=>{},
            summary=>'Show all possible conversions',
        },
        {
            args=>{quantity=>'1000 mg-k-elem', to_unit=>'mg-k-chloride-anhydrous'},
            summary=>'How much of potassium chloride provides 1000 mg of elemental potassium?',
        },
        {
            args=>{quantity=>'1000 mg-k-chloride-anhydrous', to_unit=>'mg-k-elem'},
            summary=>'How much elemental potassium is in 1000mg (1g) of potassium chloride powder in capsule form?',
        },
        {
            args=>{quantity=>'600 mg-k-chloride-anhydrous', to_unit=>'mg-k-elem'},
            summary=>'A tablet supplement called KSR contains 600mg of potassium chloride; how much elemental potassium is that?',
        },
        {
            args=>{quantity=>'4700 mg-k-elem', to_unit=>'mg-k-chloride-anhydrous'},
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
                pct_k => $u->{potassium_ratio} * 100,
            };
        }
        [200, "OK", \@rows, {
            'table.fields' => [qw/amount pct_k unit summary/],
            'table.field_formats'=>[[number=>{thousands_sep=>'', precision=>3}], [number=>{thousands_sep=>'', precision=>3}], undef, undef],
            'table.field_aligns' => [qw/number number left left/],
        }];
    }
}

} # END potassium lexical

# --- sodium

my @sodium_forms = (
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
                pct_na => $u->{sodium_ratio} * 100,
            };
        }
        [200, "OK", \@rows, {
            'table.fields' => [qw/amount pct_na unit summary/],
            'table.field_formats'=>[[number=>{thousands_sep=>'', precision=>3}], [number=>{thousands_sep=>'', precision=>3}], undef, undef],
            'table.field_aligns' => [qw/number number left left/],
        }];
    }
}

# --- iron

our @iron_forms = (
    {
        name => 'mg-fe-elem',
        iron_ratio => 1,
        summary => 'Elemental iron, in milligrams',
    },

    # sulfate
    {
        name => 'mg-ferrous-sulfate-heptahydrate', # the natural hydrate form, loses water to tetrahydrate at 57C and monohydrate at 65C
        iron_ratio => 55.845/278.02, # 20.09%
        summary => 'Ferrous sulphate heptahydrate (FeSO4.7H2O), in milligrams',
    },

    # pyrophosphate
    {
        name => 'mg-fe-iii-pyrophosphate', #
        iron_ratio => 4*55.845/745.21, # 29.98%
        summary => 'Iron (III) pyrophosphate (Fe4O21P6), in milligrams',
    },
    {
        name => 'mg-lipofer', #
        iron_ratio => 8/100, # 8%, 7.8-9% according to spec
        summary => 'Lipofer (micronized, microencapsulated, water-soluble form of iron pyrophosphate), in milligrams',
    },
    {
        name => 'mg-sunactive-fe', #
        iron_ratio => 8/100, # >8% according to spec
        summary => 'SunActive Fe (micronized, microencapsulated form of iron pyrophosphate), in milligrams',
    },

    # glycinate
    {
        name => 'mg-fe-glycinate', #
        iron_ratio => 55.845/203.96, # 27.38%
        summary => 'Iron glycinate a.k.a. ferrous bisglycinate (C4H8FeN2O4), in milligrams',
    },
    {
        name => 'mg-fe-bisglycinate', #
        iron_ratio => 55.845/203.96, # 27.38%
        summary => 'Iron glycinate a.k.a. ferrous bisglycinate (C4H8FeN2O4), in milligrams',
    },

    # gluconate
    {
        name => 'mg-fe-gluconate', #
        iron_ratio => 55.845/448.156, # 12.46%
        summary => 'Iron (II) gluconate (C12H22FeO14), in milligrams',
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
        @iron_forms,
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
            @iron_forms,
        ) {
            push @rows, {
                amount => $quantity->convert($u->{name}),
                unit => $u->{name},
                summary => $u->{summary},
                pct_fe => $u->{iron_ratio} * 100,
            };
        }
        [200, "OK", \@rows, {
            'table.fields' => [qw/amount pct_fe unit summary/],
            'table.field_formats'=>[[number=>{thousands_sep=>'', precision=>3}], [number=>{thousands_sep=>'', precision=>3}], undef, undef],
            'table.field_aligns' => [qw/number number left left/],
        }];
    }
}

# --- calcium

our @calcium_forms = (
    {
        name => 'mg-ca-elem',
        calcium_ratio => 1,
        summary => 'Elemental calcium, in milligrams',
    },
    {
        name => 'mg-ca-carbonate',
        calcium_ratio => 40.078 / 100.0869, # 40.04%
        summary => 'Calcium carbonate (CaCO3), in milligrams',
    },
    {
        name => 'mg-ca-pidolate',
        calcium_ratio => 40.078 / 296.29, # 13.53%
        summary => 'Calcium pidolate (C10H12CaN2O6), in milligrams',
        tags => ['water-soluble'],
    },
    {
        name => 'mg-ca-lactate',
        calcium_ratio => 40.078 / 218.22, # 18.37%
        summary => 'Calcium lactate (C6H10CaO6), in milligrams',
        tags => ['water-soluble'],
    },
    { # source: pubchem
        name => 'mg-ca-citrate-anhydrous',
        calcium_ratio => 3*40.078 / 498.4, # 24.12%
        summary => 'Calcium citrate anhydrous (C12H10Ca3O14), in milligrams',
    },
    { # source: pubchem
        name => 'mg-ca-citrate-tetrahydrate',
        calcium_ratio => 3*40.078 / 570.5, # 21.08%
        summary => 'Calcium citrate tetrahydrate (C12H18Ca3O18) [most common hydrate form of Ca-citrate], in milligrams',
    },
    { # source: nih
        name => 'mg-ca-ascorbate-dihydrate',
        calcium_ratio => 40.078 / 426.34, # 9.40%
        summary => 'Calcium ascorbate dihydrate (C12H18CaO14), in milligrams',
    },
    { # source: nih
        name => 'mg-ca-gluconate',
        calcium_ratio => 40.078 / 430.37, # 9.31%
        summary => 'Calcium gluconate (C12H22CaO14), in milligrams',
    },
    { # source: nih
        name => 'mg-ca-glycerophosphate',
        calcium_ratio => 40.078 / 210.14, # 19.07%
        summary => 'Calcium glycerophosphate (C3H7CaO6P), in milligrams',
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
        map {([$_->{name}], sprintf("%.3f mg", $_->{calcium_ratio}*($_->{purity}//1)))}
        @calcium_forms,
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
            @calcium_forms,
        ) {
            push @rows, {
                amount => $quantity->convert($u->{name}),
                unit => $u->{name},
                summary => $u->{summary},
                pct_ca => $u->{calcium_ratio} * 100,
            };
        }
        [200, "OK", \@rows, {
            'table.fields' => [qw/amount pct_ca unit summary/],
            'table.field_formats'=>[[number=>{thousands_sep=>'', precision=>3}], [number=>{thousands_sep=>'', precision=>3}], undef, undef],
            'table.field_aligns' => [qw/number number left left/],
        }];
    }
}

# --- zinc


our @zinc_forms = (
    # source: chatgpt
    {
        name => 'mg-zn-elem',
        zinc_ratio => 1,
        summary => 'Elemental zinc, in milligrams',
    },
    # also has anhydrous, dihydrate, trihydrate
    {
        name => 'mg-zn-lactate-monohydrate',
        zinc_ratio => 65.38 / 243.5, # 26.9%
        summary => 'Zinc lactate monohydrate (Zn(C3H5O3)2.H2O), in milligrams',
    },
    {
        name => 'mg-zn-picolinate',
        zinc_ratio => 65.38 / 298.6, # 21.9%
        summary => 'Zinc picolinate (Zn(C6H4NO2)2), in milligrams',
    },
    # also has monohydrate, dihydrate
    {
        name => 'mg-zn-gluconate-anhydrous',
        zinc_ratio => 65.38 / 455.7, # 14.4%
        summary => 'Zinc gluconate anhydrous (Zn(C6H11O7)2), in milligrams',
    },
    {
        name => 'mg-zn-citrate',
        zinc_ratio => 3*65.38 / 574.3, # 31.1%
        summary => 'Zinc citrate (Zn3(C6H5O7)2, trizinc dicitrate), in milligrams',
    },
    {
        name => 'mg-zn-oxide',
        zinc_ratio => 65.38 / 81.38, # 80.3%
        summary => 'Zinc oxide (ZnO), in milligrams',
    },
    # there are also monohydrate, heptahydrate
    {
        name => 'mg-zn-sulfate-anhydrous',
        zinc_ratio =>  65.38 / 161.5, # 36.6%
        summary => 'Zinc sulfate (ZnSO4), in milligrams',
    },
);

our %argspecs_zinc = (
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
                    {alternative=>[map {$_->{name}} @zinc_forms]},
                ],
            );
        },
    },
    to_unit => {
        # schema => 'physical::unit', # IU hasn't been added
        schema => ['str*', in=>['mg', map {$_->{name}} @zinc_forms]],
        pos => 1,
    },
);

$SPEC{convert_zinc_unit} = {
    v => 1.1,
    summary => 'Convert a zinc quantity from one unit to another',
    description => <<'MARKDOWN',

If target unit is not specified, will show all known conversions.

MARKDOWN
    args => {
        %argspecs_zinc,
    },
    examples => [
        {
            args=>{},
            summary=>'Show all possible conversions',
        },
    ],
};
sub convert_zinc_unit {
    require Physics::Unit;

    Physics::Unit::InitUnit(
        map {([$_->{name}], sprintf("%.3f mg", $_->{zinc_ratio}*($_->{purity}//1)))}
        @zinc_forms,
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
            @zinc_forms,
        ) {
            push @rows, {
                amount => $quantity->convert($u->{name}),
                unit => $u->{name},
                summary => $u->{summary},
                pct_zn => $u->{zinc_ratio} * 100,
            };
        }
        [200, "OK", \@rows, {
            'table.fields' => [qw/amount pct_zn unit summary/],
            'table.field_formats'=>[[number=>{thousands_sep=>'', precision=>3}], [number=>{thousands_sep=>'', precision=>3}], undef, undef],
            'table.field_aligns' => [qw/number number left left/],
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
