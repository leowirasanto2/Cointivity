//
//  ChartView.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    var dataPoints: [[Double]] = [[]]
    
    var body: some View {
        VStack(spacing: 16) {
            Text("chart")
            
            Chart {
                ForEach(dataPoints, id: \.self) { point in
                    let time = Date(timeIntervalSince1970: point.first.orZero / 1000)
                    LineMark(
                        x: .value("Date", time),
                        y: .value("Price", point.last.orZero)
                    )
                    .interpolationMethod(.cardinal)
                }
            }
            .chartXScale(domain: .automatic(dataType: Date.self) { _ in })
//            .chartXAxis {
//                AxisMarks(position: .bottom, values: dates()) { value in
//                    AxisGridLine()
//                    AxisValueLabel() {
//                        if let dateValue = value.as(Date.self) {
//                            Text(formattedDate(dateValue))
//                        }
//                    }
//                }
//            }
            .chartYScale(domain: ClosedRange(uncheckedBounds: (lower: prices().min().orZero, upper: prices().max().orZero)))
            .chartScrollableAxes(.horizontal)
            .frame(maxHeight: 300)
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
    func dates() -> [Date] {
        var result = [Date]()
        dataPoints.forEach { poin in
            if let timeStamp = poin.first {
                let time = Date(timeIntervalSince1970: timeStamp)
                result.append(time)
            }
        }
        return result
    }
    
    func prices() -> [Double] {
        var result: [Double] = []
        
        dataPoints.forEach { point in
            if let price = point.last {
                result.append(price)
            }
        }
        
        return result
    }
}

#Preview {
    ChartView(
        dataPoints: [
            [
                1713957318760,
                66376.59119413931
            ],
            [
                1713957651957,
                66390.70666659692
            ],
            [
                1713957951022,
                66368.63229062338
            ],
            [
                1713958308300,
                66583.78566151834
            ],
            [
                1713959464155,
                66460.29155920893
            ],
            [
                1713959733654,
                66451.24828229209
            ],
            [
                1713960032384,
                66611.8691758279
            ],
            [
                1713960322791,
                66570.63849086694
            ],
            [
                1713960696003,
                66753.73452448272
            ],
            [
                1713960992141,
                66595.03551156056
            ],
            [
                1713961281320,
                66687.95862398155
            ],
            [
                1713961517040,
                66570.94137861664
            ],
            [
                1713961888873,
                66653.93485591163
            ],
            [
                1713962137976,
                66651.69495964322
            ],
            [
                1713962461376,
                66556.59055009113
            ],
            [
                1713962767986,
                66502.01407214429
            ],
            [
                1713963084893,
                66377.04294135662
            ],
            [
                1713963390436,
                66417.88425404986
            ],
            [
                1713963690163,
                66319.37966624473
            ],
            [
                1713963907521,
                66031.77966695346
            ],
            [
                1713964211139,
                66108.79177693825
            ],
            [
                1713964591678,
                66141.45997977801
            ],
            [
                1713964846091,
                66090.23869993747
            ],
            [
                1713965130368,
                66090.34509357707
            ],
            [
                1713965461141,
                66035.90260086565
            ],
            [
                1713965764607,
                65843.63964726911
            ],
            [
                1713966067154,
                66196.61222078196
            ],
            [
                1713966382941,
                66183.86054679309
            ],
            [
                1713966700311,
                66112.33480842732
            ],
            [
                1713966966608,
                66093.96274633688
            ],
            [
                1713967219424,
                65939.34328499576
            ],
            [
                1713967562301,
                66159.90749822833
            ],
            [
                1713967823540,
                66158.44772728055
            ],
            [
                1713968116248,
                66130.25201428447
            ],
            [
                1713968486177,
                66029.70521184322
            ],
            [
                1713968720002,
                65834.74564043524
            ],
            [
                1713969037160,
                65305.735946687404
            ],
            [
                1713969328063,
                65104.467627523954
            ],
            [
                1713969665605,
                65020.25392660937
            ],
            [
                1713969977979,
                64935.930462704106
            ],
            [
                1713970217964,
                65038.424435816654
            ],
            [
                1713970489063,
                65106.21984427455
            ],
            [
                1713970836285,
                65162.40510947867
            ],
            [
                1713971216111,
                65084.50836507485
            ],
            [
                1713971462266,
                65119.65327978347
            ],
            [
                1713971742902,
                65095.12018631613
            ],
            [
                1713972029767,
                64968.07613213211
            ],
            [
                1713972361086,
                64852.24119995394
            ],
            [
                1713972762974,
                64819.926862344124
            ],
            [
                1713972958961,
                64955.15952039505
            ],
            [
                1713973239044,
                64902.087291361
            ],
            [
                1713973510515,
                64563.54471508256
            ],
            [
                1713973785210,
                64703.58410679343
            ],
            [
                1713974185526,
                64658.063302848095
            ],
            [
                1713974490421,
                64525.96551749807
            ],
            [
                1713974727369,
                64749.11323819757
            ],
            [
                1713975082668,
                64803.84433970333
            ],
            [
                1713975388607,
                64639.64714317125
            ],
            [
                1713975646074,
                64623.34212572789
            ],
            [
                1713975918605,
                64661.66223305202
            ],
            [
                1713976283831,
                64428.481803298986
            ],
            [
                1713976569815,
                64569.287720733366
            ],
            [
                1713976854962,
                64734.907796733736
            ],
            [
                1713977199075,
                64675.0157247887
            ],
            [
                1713977443269,
                64654.838393189624
            ],
            [
                1713977793558,
                64712.63472435223
            ],
            [
                1713978016236,
                64714.40857487322
            ],
            [
                1713978335385,
                64829.06270778162
            ],
            [
                1713978685967,
                64818.197496351895
            ],
            [
                1713978914932,
                64839.44467264141
            ],
            [
                1713979256499,
                64890.20271779097
            ],
            [
                1713979544396,
                64855.035146600996
            ],
            [
                1713979819111,
                64939.27685426741
            ],
            [
                1713980134042,
                65027.593657282225
            ],
            [
                1713980544502,
                64988.7023219908
            ],
            [
                1713980774170,
                64887.26762213543
            ],
            [
                1713981034355,
                64840.00554114517
            ],
            [
                1713981354172,
                64823.92306621507
            ],
            [
                1713981611614,
                64838.61212399471
            ],
            [
                1713981949600,
                64717.09009753154
            ],
            [
                1713982244233,
                64709.29104240619
            ],
            [
                1713982562382,
                64690.714675096235
            ],
            [
                1713982855624,
                64673.53366853612
            ],
            [
                1713983125078,
                64685.526265320346
            ],
            [
                1713983514751,
                64673.212452545245
            ],
            [
                1713983746326,
                64618.962873194316
            ],
            [
                1713984070357,
                64725.654071487275
            ],
            [
                1713984354985,
                64658.00421023583
            ],
            [
                1713984719894,
                64395.62833644276
            ],
            [
                1713984979432,
                64167.005383273165
            ],
            [
                1713985272856,
                64076.66656090625
            ],
            [
                1713985530599,
                63812.90739030732
            ],
            [
                1713985818261,
                64131.65069060268
            ],
            [
                1713986135511,
                64171.75953108593
            ],
            [
                1713986448330,
                64160.64519008753
            ],
            [
                1713986732893,
                64317.25655647991
            ],
            [
                1713987021116,
                64323.561486192986
            ],
            [
                1713987339522,
                64395.53523763876
            ],
            [
                1713987750443,
                64380.35616696093
            ],
            [
                1713987923620,
                64329.48556435794
            ],
            [
                1713988239786,
                64378.94100120509
            ],
            [
                1713988575284,
                64235.8636601094
            ],
            [
                1713988817440,
                63980.14781473364
            ],
            [
                1713989175266,
                64101.93188066035
            ],
            [
                1713989395396,
                63939.21429014373
            ],
            [
                1713989710153,
                64009.31153241648
            ],
            [
                1713990032836,
                63830.934754696376
            ],
            [
                1713990348125,
                63571.429105609175
            ],
            [
                1713990623426,
                63828.64528980083
            ],
            [
                1713990918710,
                63941.98304479915
            ],
            [
                1713991230998,
                63998.65178411387
            ],
            [
                1713991552933,
                64066.57444147332
            ],
            [
                1713991932351,
                64032.16846430822
            ],
            [
                1713992166285,
                64098.14982868873
            ],
            [
                1713992445899,
                64064.845007852666
            ],
            [
                1713992722644,
                64066.151345813625
            ],
            [
                1713993074391,
                64113.69741011486
            ],
            [
                1713993314534,
                64072.97438217346
            ],
            [
                1713993616937,
                64117.55188253756
            ],
            [
                1713993995264,
                64092.50919686869
            ],
            [
                1713994313172,
                64288.83290754851
            ],
            [
                1713994621461,
                64394.73820471935
            ],
            [
                1713994883983,
                64271.89540975295
            ],
            [
                1713995183391,
                64299.80132467103
            ],
            [
                1713995486078,
                64298.16182981211
            ],
            [
                1713995790517,
                64328.73979251295
            ],
            [
                1713996006383,
                64306.17796186013
            ],
            [
                1713996408951,
                64328.511662788784
            ],
            [
                1713996688269,
                64287.27504834569
            ],
            [
                1713996985708,
                64273.742605746214
            ],
            [
                1713997200644,
                64250.7354766076
            ],
            [
                1713997517453,
                64101.621698827876
            ],
            [
                1713997832333,
                64182.42936234932
            ],
            [
                1713998175136,
                64135.16446837969
            ],
            [
                1713998493799,
                64092.177999904365
            ],
            [
                1713998727446,
                64141.89411855135
            ],
            [
                1713999067305,
                63992.26348148822
            ],
            [
                1713999347326,
                63959.768697909814
            ],
            [
                1713999683730,
                64079.72006562455
            ],
            [
                1713999971418,
                63750.779328761215
            ],
            [
                1714000259305,
                64003.881567361925
            ],
            [
                1714000530028,
                64138.4013672651
            ],
            [
                1714000819358,
                64275.8962567533
            ],
            [
                1714001163945,
                64095.62306355721
            ],
            [
                1714001443122,
                64021.842130601784
            ],
            [
                1714001798279,
                64136.57025497176
            ],
            [
                1714002020195,
                64140.106405336235
            ],
            [
                1714002318961,
                64204.98370981598
            ],
            [
                1714002678088,
                64236.596962918025
            ],
            [
                1714002979902,
                64279.51812857524
            ],
            [
                1714003309808,
                64246.883372882185
            ],
            [
                1714003566141,
                64300.34948241482
            ],
            [
                1714003875821,
                64311.41189920699
            ],
            [
                1714004162462,
                64375.79956367502
            ],
            [
                1714004437195,
                64341.77197098401
            ],
            [
                1714004760240,
                64417.916072728454
            ],
            [
                1714005040230,
                64462.60862385437
            ],
            [
                1714005339689,
                64610.99321554567
            ],
            [
                1714005603524,
                64559.96313365035
            ],
            [
                1714005895470,
                64693.533970850345
            ],
            [
                1714006272445,
                64551.1136756691
            ],
            [
                1714006548943,
                64516.936252379855
            ],
            [
                1714006881066,
                64526.65700353316
            ],
            [
                1714007138084,
                64536.17352910564
            ],
            [
                1714007465781,
                64463.06288923585
            ],
            [
                1714007857860,
                64396.04325523729
            ],
            [
                1714008025998,
                64436.6364166504
            ],
            [
                1714008316294,
                64487.48534283353
            ],
            [
                1714008594141,
                64456.59521370207
            ],
            [
                1714008959378,
                64539.17903864315
            ],
            [
                1714009220234,
                64435.689362863726
            ],
            [
                1714009525101,
                64319.00066691108
            ],
            [
                1714009857979,
                64301.1926741527
            ],
            [
                1714010146281,
                64210.31921974033
            ],
            [
                1714010442710,
                64126.14632672102
            ],
            [
                1714010720325,
                63968.20527346231
            ],
            [
                1714011033974,
                64159.9319694569
            ],
            [
                1714011376366,
                64218.83658536634
            ],
            [
                1714011672919,
                64252.47213853412
            ],
            [
                1714011927058,
                64221.14910636024
            ],
            [
                1714012263120,
                64318.78188802003
            ],
            [
                1714012502390,
                64269.11102030065
            ],
            [
                1714012897886,
                64163.702620477365
            ],
            [
                1714013112876,
                64232.53098109286
            ],
            [
                1714013516132,
                64135.304177074395
            ],
            [
                1714013726253,
                64217.48083664106
            ],
            [
                1714014019105,
                64255.61302129936
            ],
            [
                1714014351094,
                64375.788242727045
            ],
            [
                1714014670481,
                64232.45011087774
            ],
            [
                1714014972206,
                64116.33715016859
            ],
            [
                1714015224202,
                64287.34627922141
            ],
            [
                1714015495288,
                64201.332197628355
            ],
            [
                1714015829021,
                64282.43878050332
            ],
            [
                1714016122045,
                64411.52232293084
            ],
            [
                1714016484275,
                64426.98645599039
            ]
            ,
            [
                1714016772701,
                64416.28799548315
            ],
            [
                1714017035821,
                64401.43383104988
            ],
            [
                1714017363050,
                64316.904616055836
            ],
            [
                1714017701030,
                64244.22225715455
            ],
            [
                1714017938541,
                64248.226473343144
            ],
            [
                1714018225054,
                64086.50052447734
            ],
            [
                1714018515543,
                64073.70003141928
            ],
            [
                1714018796616,
                64061.438415635756
            ],
            [
                1714019190004,
                64148.06015154709
            ],
            [
                1714019502706,
                64212.627628731825
            ],
            [
                1714019703907,
                64339.14014358724
            ],
            [
                1714020024276,
                64335.36779945184
            ],
            [
                1714020324645,
                64290.81613923176
            ],
            [
                1714020686206,
                64339.756572655744
            ],
            [
                1714020939365,
                64311.35187104497
            ],
            [
                1714021248451,
                64316.5497816889
            ],
            [
                1714021538522,
                64252.353258215466
            ],
            [
                1714021825027,
                64155.38084294189
            ],
            [
                1714022101794,
                64117.392150149535
            ],
            [
                1714022486863,
                64144.42398300842
            ],
            [
                1714022722679,
                64147.12104366433
            ],
            [
                1714023018761,
                64075.829380447314
            ],
            [
                1714023342922,
                64178.596249773815
            ],
            [
                1714023601758,
                64228.75011983432
            ],
            [
                1714023927380,
                64233.87738082964
            ],
            [
                1714024297025,
                64320.845135855605
            ],
            [
                1714024535196,
                64240.36241959461
            ],
            [
                1714024837516,
                64206.60951172509
            ],
            [
                1714025120250,
                64199.822784757955
            ],
            [
                1714025446395,
                64277.77075785862
            ],
            [
                1714025748641,
                64337.50654804343
            ],
            [
                1714026126479,
                64290.869493476195
            ],
            [
                1714026350702,
                64287.78170032035
            ],
            [
                1714026714629,
                64298.66848290198
            ],
            [
                1714026972026,
                64374.14123982348
            ],
            [
                1714027243405,
                64286.66521705103
            ],
            [
                1714027536656,
                64205.19539756285
            ],
            [
                1714027875407,
                64249.894028715644
            ],
            [
                1714028135191,
                64249.08020858146
            ],
            [
                1714028447728,
                64275.10392761468
            ],
            [
                1714028758665,
                64282.02859877761
            ],
            [
                1714029042378,
                64274.56453791518
            ],
            [
                1714029364285,
                64319.923084878246
            ],
            [
                1714029674731,
                64353.36044173944
            ],
            [
                1714029938151,
                64312.519577400446
            ],
            [
                1714030317749,
                64249.60258414204
            ],
            [
                1714030570559,
                64212.85287716251
            ],
            [
                1714030805753,
                63985.59171799716
            ],
            [
                1714031175015,
                63899.408576770584
            ],
            [
                1714031490556,
                63953.29943215715
            ],
            [
                1714031725549,
                64030.00424581426
            ],
            [
                1714032028657,
                63983.17829337444
            ],
            [
                1714032381842,
                64060.76025773421
            ],
            [
                1714032601960,
                63985.417072076685
            ],
            [
                1714032970833,
                64056.46951463208
            ],
            [
                1714033293994,
                64145.43479384756
            ],
            [
                1714033533516,
                64075.475418309165
            ],
            [
                1714033813620,
                63947.49446604232
            ],
            [
                1714034116634,
                63961.44100239074
            ],
            [
                1714034446318,
                63782.942500834884
            ],
            [
                1714034763292,
                63812.54396901831
            ],
            [
                1714035087364,
                63737.92524954581
            ],
            [
                1714035339834,
                63809.94504500022
            ],
            [
                1714035726814,
                63914.15498206869
            ],
            [
                1714036014531,
                64016.071222392784
            ],
            [
                1714036217221,
                64191.60500734553
            ],
            [
                1714036543028,
                64102.823371045575
            ],
            [
                1714036875225,
                64064.22596624147
            ],
            [
                1714037131672,
                64082.3096832226
            ],
            [
                1714037446920,
                64033.13649657483
            ],
            [
                1714037719991,
                63967.14075041411
            ],
            [
                1714038033520,
                63998.60820179861
            ],
            [
                1714038330075,
                63890.549335249634
            ],
            [
                1714038689296,
                63826.82124429779
            ],
            [
                1714038924752,
                63880.9524740261
            ],
            [
                1714039237691,
                63945.25451137906
            ],
            [
                1714039587505,
                63909.5649286045
            ],
            [
                1714039823116,
                63898.227899018886
            ],
            [
                1714040104314,
                63655.009111531916
            ],
            [
                1714040415756,
                63701.25905115175
            ],
            [
                1714040708837,
                63554.42508142769
            ],
            [
                1714041107429,
                63465.703086996946
            ],
            [
                1714041297764,
                63481.819799956815
            ],
            [
                1714041681023,
                63512.11603786525
            ],
            [
                1714041928674,
                63496.343745766375
            ],
            [
                1714042234731,
                63643.963245221035
            ],
            [
                1714042529824,
                63529.19027177486
            ],
            [
                1714042847343,
                63480.9814794963
            ],
            [
                1714043086629,
                63505.526167620825
            ],
            [
                1714043500000,
                63675.03005939824
            ]
        ]
    )
}
