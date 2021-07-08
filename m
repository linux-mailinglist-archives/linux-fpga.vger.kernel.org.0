Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F201B3BF967
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Jul 2021 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhGHMAU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Jul 2021 08:00:20 -0400
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:7137
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231347AbhGHMAU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 8 Jul 2021 08:00:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2zG1eTOhetsc9gwd/eKSZpjszvlX/NnWp1Iu015lkg4b97kV3iGRZjFl/Ho12x8lLY9nrA+PJP3gDBFCGb5H3z9n1KJrbPMWP7wVsl/abKgbsp/5l1qZ2tK4rRAFbsx367OydurA91N1owI3zib1SF7soVyJVqDqgn/oQKqn+w6btQq2/b7YV9+O6h686dlHthfq06M+hiQaFpKP9d6AwKpEGfR8TGS9ZCxJ7gq7zXhdwnDCRbOzQGkakFHfs78vrbN2rFYQva5b868BU0Hh1FS/H/R1rSBKHIc05UkdDWMvq4hMXXqNQfkvsP+L5jg2/e7QQE/RgHgSmF64m7Nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CYLwSl0IjE+IELV6toVTN9lSkCt20i9KJqwoJ4/E0Y=;
 b=Uj7msGVitvfZYldzkvs4/eaomWsZt4ffsgLhzyvUapJcPFZ1VIhCHtC8Qi0ASRg0M4VUtBo+A0O/lb6xev+Wh/3xrJ4dKjZ4E/dm2Zv2enqkdsKbA88RMyP7nLaECl8IZH6g5Q1ccfL81ryaXxFrS5aKqdvsWc9GbLVcVHYFo4k2R+JPIo1Kpi98IHtJbLaeUcVYE0VtgreEhHyl+MT1Av6P+sIBENbnylt8jEBt8o5pDyVg7B6SJK8iNyXiohNLvnLIrMYXj86X//Ts2C5io6jwcWvJp7AVJIC7MC1bBpEEddct0Pm16Xc3L68pvm4/vel+uSjj43StU4bj43Ca5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CYLwSl0IjE+IELV6toVTN9lSkCt20i9KJqwoJ4/E0Y=;
 b=R3Njf70NQU5r6OPc/4Sds6dlKvUZDhC9v9oxC8KjbmDV+SZkD12rVdyuCQVgl6Dlo3Yf0dxghu1t7CUmMrYd+OHtPcNLSZFqEcgpxaHHImAfouhEDdH274NlYayqTK4Tn9iPCmYKW4KQjEtTRxa+hytI7f4dFyASWq1M8mJWgHY=
Received: from PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) by
 PH0PR02MB7414.namprd02.prod.outlook.com (2603:10b6:510:1f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Thu, 8 Jul 2021 11:57:33 +0000
Received: from PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e]) by PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e%9]) with mapi id 15.20.4287.035; Thu, 8 Jul 2021
 11:57:33 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Tom Rix <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Ravi Patel <ravipate@xlnx.xilinx.com>,
        "iwamatsu@nigauri.org" <iwamatsu@nigauri.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
CC:     Appana Durga Kedareswara Rao <appanad@xilinx.com>
Subject: RE: [PATCH v8 5/5] fpga: versal-fpga: Add versal fpga manager driver
Thread-Topic: [PATCH v8 5/5] fpga: versal-fpga: Add versal fpga manager driver
Thread-Index: AQHXaqNsfadVFn7cU0OetyaN3QeZd6s2iBUAgAJ6vaA=
Date:   Thu, 8 Jul 2021 11:57:33 +0000
Message-ID: <PH0PR02MB73361D401D8CD00215AE62A8C2199@PH0PR02MB7336.namprd02.prod.outlook.com>
References: <20210626155248.5004-1-nava.manne@xilinx.com>
 <20210626155248.5004-6-nava.manne@xilinx.com>
 <4429c722-52f3-2e16-3a53-910345507d3e@redhat.com>
In-Reply-To: <4429c722-52f3-2e16-3a53-910345507d3e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 340f7c7c-e483-4f86-ebb9-08d942079213
x-ms-traffictypediagnostic: PH0PR02MB7414:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR02MB74142EAF4DEAF2410FEDE392C2199@PH0PR02MB7414.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3BCkJuWXebAS/smEd3VcUN20nDymo9E0K/ZbYc6V704jJH5JhYi7svmUv8WaNxevyVdEbWlxBdtNVK3HBMeulXMuubdAhIRnnL73LTeRU6ppGvUpXsnadiy4RMLhccdjAuChPop72RplBWGy5G0UcptKCpkz2qXzNjoTbU9VtMWwrsILDM2sdqT9FojQ9Gi/P3+CyyYAHVR/lHspJ0ejXHD0qRsfdp7kk2q4ESXj2WNhPJIBuvrd3jwPexgNuCqubmUOr6d3PDhGiLojTg7QPw+B05R9MjYw9sz+3dl2kT0uzH09DcDgdPSJTi8IUNGUm6dndFrPctov5ubyt2Nl0QeVoyn6DIFA4C7P1Hitde9MDCCh86yPcuKgNT6mNXS/EMc0e7Q7bIW2RbmJW4vT+3QuvMfF44qFLmTjDKsch6eKi5bPKPxrXaUjRXCG7TFpJDjo60lCpTsa/QYZIYJbDN912GfPtLpOGf6+RNNGq2ihIBZc7USPy1xYORIu3z82AluTnbuSkJQK1yDpueM5NGSVaUSLOJbi8UryV7uLkD4LKsgxOCQlNHqmswMmkhtYea/FvA1Z/Dl88aFrtJvFvhcqpdNxLIIgYkBZPdySPKKSloxThMnX5uOizj8S3lhfPTF0LmfSc5E+LRrrUbCR8JO7uUyy8x/1kb9WPw0HitC41CxjY/M4pnU84X/LiykTGkNOP5KM8Ymon2JqEX97aQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7336.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(2906002)(8676002)(55016002)(8936002)(76116006)(122000001)(921005)(71200400001)(38100700002)(5660300002)(186003)(9686003)(6506007)(53546011)(26005)(52536014)(478600001)(83380400001)(86362001)(66446008)(66556008)(110136005)(4326008)(7696005)(64756008)(66946007)(66476007)(33656002)(107886003)(7416002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGoxQ2NzV21yZzE4Qis0TXRCNUtvWnQ0M2N1MUhRQTQ5SXB5THBVc1c0Sk1G?=
 =?utf-8?B?M2xDY2w1TlhYZlNiZW16bU5TdnI5QnFHYnFmMDlDQUZtYkZOKzJJRXR1RFR2?=
 =?utf-8?B?dG5CWWdDb0pzWGZBV21HZm9reWFMemNpeG1zWlBiVXo3a2prMi84SHNFcUhy?=
 =?utf-8?B?bW9qYzAyRkt5NXRseDE3eEIyelFrMVVQUUNPdFVUZkxUN1BNT1VIWjZhWWxG?=
 =?utf-8?B?TXMyWWJOUE8zQnZ3U0ZuTEVEUXd5V3Awc0pZTGxRcTc5RmtibUxFdEtKUzl3?=
 =?utf-8?B?dnpLTEdIMkd6bEl0bUFHbUljTlExSlg0UUYyY1U5RmVhRDJ1Rnpqc1lMTURu?=
 =?utf-8?B?djdzZmIrTmdBcFMweGNJN1BZY0NJUXJRSDhXNnBnMUVRd3hVSlQ2Ry9jSmNm?=
 =?utf-8?B?SmVIYXJGenIxaER0UmtCVk5COVRMVGVmYmdMUG1CaGdyTmVTeXN4ckJwL1Zz?=
 =?utf-8?B?NFg0U0VMcWg4eTExU2k2VVlpRU84NG9QaHBwT0VKekhwTkQ3RUNmenhPM3Ev?=
 =?utf-8?B?L1NENDA5c2U4UzhWRTRaK1BPc2Y3ZDhTSUtkUjdQYXYraXVwcm5sVGVHaXA3?=
 =?utf-8?B?RmFXYTdsUW5QODRqNXZjOFB5NjRGdXU2R1JVWHI5MFJ3ZkVCR01vMVZOakpU?=
 =?utf-8?B?ODZpTENVQ0pzYnc5dVM5OFNLS0tjT0xZMTU5SzdOd0huQTRCWk5wZ1ZOM2JO?=
 =?utf-8?B?UE9sakZXK0xuYS9HVlp5NnZsci9jczdaM0JQK25DYjJkT3oyWjErT0VLcmdL?=
 =?utf-8?B?V0R2b01DQWg2TG5KRU03TzFhNGwxdHcyWk4rcWJ6ZjZDajg1SjVVTm8xcXo4?=
 =?utf-8?B?bTdZcjZJVWFRZlZNODFZTWkwNmNCY1NWUWRoYXYxalFUaHd6a1ovdnpXQTc5?=
 =?utf-8?B?ZEc3K0hCbThUYzRZTHc5SXVEbStNMkVQTytsOTJYSHlXajdLZVkyQXpPWUUz?=
 =?utf-8?B?OWViSFRGQlhEOCtRRzVoL0FCQ2JGQlpLQ1BpVEVkUVFXNGZtK3RBdmVLVmdi?=
 =?utf-8?B?UkNzOUdvbldRS3F3SklxV3ZJdWVKclpyd1pEdDNCb0p5NGpicmkwemp2SXJh?=
 =?utf-8?B?RlBFdmVWWGo0c1BZRzBkUnNUS3F6bC92NVJTRGhpb1FqUEQwZzFlRlljT2g3?=
 =?utf-8?B?M1hSalFHZ3VnNnRQTkRDdmxKdG44bnQxTENBZW9YY2xDeERKbUFOLzl6akRF?=
 =?utf-8?B?cHpTcDAyMVJ0RmJTQjhXNkdIMmFxTm9pSGdaN2g4WWxsbC8rSVVnUEYrQkJD?=
 =?utf-8?B?QVNwbXhwWTZpejA1ZXdRRkM0YWZOOGxVTVhEM2t4UE5yc2tNWjRmNVp1Skt1?=
 =?utf-8?B?MVZZUy9jcm1BYWU4T0ZPL0Z4QTJObDZFWGVkSW5IeHY1VnIwT0VnQWlvVWp2?=
 =?utf-8?B?ZWY2cm1xNmFNeEFTMGhqbVlxRVhXdHVsWFJxMG9sM1lJaFo4dURRWkw1YzFi?=
 =?utf-8?B?dERmVVFjMFNITHlUQm0wRWE1VzlpemVCdUxFZWxId240WkFTREE2SVptUEVw?=
 =?utf-8?B?d1Fhb0hJVnZwVzAzbjJUTVVSRm45cDlkaUQ0NzBrUFdmVm9Bclg1alZySkhh?=
 =?utf-8?B?L2dnakNYbkhxWGdhYkxKNFNCN05FSGxDRXFkZnJEanZiU2F2THJsU2xKUnI4?=
 =?utf-8?B?akdCMEhGUjMrQ2I3UUlRcEVpTzJaRndtMlpwc1N3eGFtYUhTb1E2c1NrTjlt?=
 =?utf-8?B?VDUrdnBsbGREQmwvWmUvaC93WTNTUFFiOW8wa1ZZOWRrOFY5NlFaR1lxdkdN?=
 =?utf-8?Q?0d6loeTqa1ln4XeI3Thauto51jwtr/606hXviWG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7336.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340f7c7c-e483-4f86-ebb9-08d942079213
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 11:57:33.0707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/rdFijLvZotD4VL3QS52q7twvL18kT0j9MCxSVpe5hctmWEJzeq3jFvsHSH4f98FY/hkkzPvq5p0OupPa6sbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7414
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgVG9tLA0KDQoJUGxlYXNlIGZpbmQgbXkgcmVzcG9uc2UgaW5saW5lLg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRvbSBSaXggPHRyaXhAcmVkaGF0LmNvbT4NCj4g
U2VudDogV2VkbmVzZGF5LCBKdWx5IDcsIDIwMjEgMzowNCBBTQ0KPiBUbzogTmF2YSBraXNob3Jl
IE1hbm5lIDxuYXZhbUB4aWxpbnguY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOyBNaWNoYWwNCj4g
U2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IG1kZkBrZXJuZWwub3JnOyBhcm5kQGFybmRiLmRl
OyBSYWphbiBWYWphDQo+IDxSQUpBTlZAeGlsaW54LmNvbT47IGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnOyBBbWl0IFN1bmlsIERoYW1uZQ0KPiA8YW1pdHN1bmlAeGxueC54aWxpbnguY29tPjsg
VGVqYXMgUGF0ZWwgPHRlamFzcEB4bG54LnhpbGlueC5jb20+Ow0KPiB6b3Vfd2VpQGh1YXdlaS5j
b207IFNhaSBLcmlzaG5hIFBvdHRodXJpIDxsYWtzaG1pc0B4aWxpbnguY29tPjsgUmF2aQ0KPiBQ
YXRlbCA8cmF2aXBhdGVAeGxueC54aWxpbnguY29tPjsgaXdhbWF0c3VAbmlnYXVyaS5vcmc7IEpp
YXlpbmcgTGlhbmcNCj4gPGpsaWFuZ0B4aWxpbnguY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBmcGdhQHZnZXIua2VybmVsLm9yZzsgZ2l0
IDxnaXRAeGlsaW54LmNvbT47IGNoaW5uaWtpc2hvcmUzNjlAZ21haWwuY29tDQo+IENjOiBBcHBh
bmEgRHVyZ2EgS2VkYXJlc3dhcmEgUmFvIDxhcHBhbmFkQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjggNS81XSBmcGdhOiB2ZXJzYWwtZnBnYTogQWRkIHZlcnNhbCBmcGdhIG1h
bmFnZXIgZHJpdmVyDQo+IA0KPiANCj4gT24gNi8yNi8yMSA4OjUyIEFNLCBOYXZhIGtpc2hvcmUg
TWFubmUgd3JvdGU6DQo+ID4gQWRkIHN1cHBvcnQgZm9yIFhpbGlueCBWZXJzYWwgRlBHQSBtYW5h
Z2VyLg0KPiA+DQo+ID4gUERJIHNvdXJjZSB0eXBlIGNhbiBiZSBERFIsIE9DTSwgUVNQSSBmbGFz
aCBldGMuLg0KPiA+IEJ1dCBkcml2ZXIgYWxsb2NhdGVzIG1lbW9yeSBhbHdheXMgZnJvbSBERFIs
IFNpbmNlIGRyaXZlciBzdXBwb3J0cw0KPiA+IG9ubHkgRERSIHNvdXJjZSB0eXBlLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogQXBwYW5hIER1cmdhIEtlZGFyZXN3YXJhIHJhbw0KPiA+IDxhcHBh
bmEuZHVyZ2EucmFvQHhpbGlueC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmF2YSBraXNob3Jl
IE1hbm5lIDxuYXZhLm1hbm5lQHhpbGlueC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE1vcml0eiBG
aXNjaGVyIDxtZGZAa2VybmVsLm9yZz4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGZvciB2MjoNCj4g
PiAgICAgICAgICAgICAgICAtVXBkYXRlZCB0aGUgRnBnYSBNZ3IgcmVnaXN0cmF0aW9ucyBjYWxs
J3MNCj4gPiAgICAgICAgICAgICAgICAgdG8gNS4xMQ0KPiA+ICAgICAgICAgICAgICAgIC1GaXhl
ZCBzb21lIG1pbm9yIGNvZGluZyBpc3N1ZXMgYXMgc3VnZ2VzdGVkIGJ5DQo+ID4gICAgICAgICAg
ICAgICAgIE1vcml0ei4NCj4gPg0KPiA+IENoYW5nZXMgZm9yIHYzOg0KPiA+ICAgICAgICAgICAg
ICAgIC1SZXdyaXR0ZW4gdGhlIFZlcnNhbCBmcGdhIEtjb25maWcgY29udGVudHMuDQo+ID4NCj4g
PiBDaGFuZ2VzIGZvciB2NDoNCj4gPiAgICAgICAgICAgICAgICAtUmViYXNlZCB0aGUgY2hhbmdl
cyBvbiBsaW51eC1uZXh0Lg0KPiA+ICAgICAgICAgICAgICAgICBObyBmdW5jdGlvbmFsIGNoYW5n
ZXMuDQo+ID4NCj4gPiBDaGFuZ2VzIGZvciB2NToNCj4gPiAgICAgICAgICAgICAgICAtTm9uZS4N
Cj4gPg0KPiA+IENoYW5nZXMgZm9yIHY2Og0KPiA+ICAgICAgICAgICAgICAgIC1Ob25lLg0KPiA+
DQo+ID4gQ2hhbmdlcyBmb3Igdjc6DQo+ID4gICAgICAgICAgICAgICAgLVVwZGF0ZWQgZHJpdmVy
IHRvIHJlbW92ZSB1bndhdGVkIHByaXYgc3RydWN0IGRlcGVuZGVuY3kuDQo+ID4NCj4gPiBDaGFu
Z2VzIGZvciB2ODoNCj4gPiAgICAgICAgICAgICAgICAtTm9uZS4NCj4gPg0KPiA+ICAgZHJpdmVy
cy9mcGdhL0tjb25maWcgICAgICAgfCAgOSArKysrDQo+ID4gICBkcml2ZXJzL2ZwZ2EvTWFrZWZp
bGUgICAgICB8ICAxICsNCj4gPiAgIGRyaXZlcnMvZnBnYS92ZXJzYWwtZnBnYS5jIHwgOTYNCj4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDMgZmlsZXMgY2hh
bmdlZCwgMTA2IGluc2VydGlvbnMoKykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L2ZwZ2EvdmVyc2FsLWZwZ2EuYw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9L
Y29uZmlnIGIvZHJpdmVycy9mcGdhL0tjb25maWcgaW5kZXgNCj4gPiA4Y2Q0NTRlZTIwYzAuLjE2
NzkzYmZjMmJiNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2ZwZ2EvS2NvbmZpZw0KPiA+ICsr
KyBiL2RyaXZlcnMvZnBnYS9LY29uZmlnDQo+ID4gQEAgLTIzNCw0ICsyMzQsMTMgQEAgY29uZmln
IEZQR0FfTUdSX1pZTlFNUF9GUEdBDQo+ID4gICAJICB0byBjb25maWd1cmUgdGhlIHByb2dyYW1t
YWJsZSBsb2dpYyhQTCkgdGhyb3VnaCBQUw0KPiA+ICAgCSAgb24gWnlucU1QIFNvQy4NCj4gPg0K
PiA+ICtjb25maWcgRlBHQV9NR1JfVkVSU0FMX0ZQR0ENCj4gPiArCXRyaXN0YXRlICJYaWxpbngg
VmVyc2FsIEZQR0EiDQo+ID4gKwlkZXBlbmRzIG9uIEFSQ0hfWllOUU1QIHx8IENPTVBJTEVfVEVT
VA0KPiBTaG91bGRuJ3QgdGhpcyBkZXBlbmQgb24gWllOUU1QX0ZJUk1XQVJFID8NCg0KWWVzIGl0
IGhhcyBhIGRlcGVuZGVuY3ksIHdpbGwgZml4DQoNCj4gPiArCWhlbHANCj4gPiArCSAgU2VsZWN0
IHRoaXMgb3B0aW9uIHRvIGVuYWJsZSBGUEdBIG1hbmFnZXIgZHJpdmVyIHN1cHBvcnQgZm9yDQo+
ID4gKwkgIFhpbGlueCBWZXJzYWwgU29DLiBUaGlzIGRyaXZlciB1c2VzIHRoZSBmaXJtd2FyZSBp
bnRlcmZhY2UgdG8NCj4gPiArCSAgY29uZmlndXJlIHRoZSBwcm9ncmFtbWFibGUgbG9naWMoUEwp
Lg0KPiA+ICsNCj4gPiArCSAgVG8gY29tcGlsZSB0aGlzIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBo
ZXJlLg0KPiA+ICAgZW5kaWYgIyBGUEdBDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9N
YWtlZmlsZSBiL2RyaXZlcnMvZnBnYS9NYWtlZmlsZSBpbmRleA0KPiA+IDE4ZGM5ODg1ODgzYS4u
MGJmZjc4M2QxYjYxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZnBnYS9NYWtlZmlsZQ0KPiA+
ICsrKyBiL2RyaXZlcnMvZnBnYS9NYWtlZmlsZQ0KPiA+IEBAIC0xOCw2ICsxOCw3IEBAIG9iai0k
KENPTkZJR19GUEdBX01HUl9UUzczWFgpCQkrPQ0KPiB0czczeHgtZnBnYS5vDQo+ID4gICBvYmot
JChDT05GSUdfRlBHQV9NR1JfWElMSU5YX1NQSSkJKz0geGlsaW54LXNwaS5vDQo+ID4gICBvYmot
JChDT05GSUdfRlBHQV9NR1JfWllOUV9GUEdBKQkrPSB6eW5xLWZwZ2Eubw0KPiA+ICAgb2JqLSQo
Q09ORklHX0ZQR0FfTUdSX1pZTlFNUF9GUEdBKQkrPSB6eW5xbXAtZnBnYS5vDQo+ID4gK29iai0k
KENPTkZJR19GUEdBX01HUl9WRVJTQUxfRlBHQSkgICAgICArPSB2ZXJzYWwtZnBnYS5vDQo+IFRo
ZSBvdGhlciBDT05GSUdfRlBHQV9NR1IqIGNvbmZpZ3MgYXJlIGFscGhhYmV0aWNhbCwgdmVyc2Fs
IHNob3VsZA0KPiBmb2xsb3cuDQoNCldpbGwgZml4Lg0KDQo+ID4gICBvYmotJChDT05GSUdfQUxU
RVJBX1BSX0lQX0NPUkUpICAgICAgICAgKz0gYWx0ZXJhLXByLWlwLWNvcmUubw0KPiA+ICAgb2Jq
LSQoQ09ORklHX0FMVEVSQV9QUl9JUF9DT1JFX1BMQVQpICAgICs9IGFsdGVyYS1wci1pcC1jb3Jl
LXBsYXQubw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS92ZXJzYWwtZnBnYS5j
IGIvZHJpdmVycy9mcGdhL3ZlcnNhbC1mcGdhLmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NCBp
bmRleCAwMDAwMDAwMDAwMDAuLjFiZDMxMmEzMWIyMw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiAr
KysgYi9kcml2ZXJzL2ZwZ2EvdmVyc2FsLWZwZ2EuYw0KPiA+IEBAIC0wLDAgKzEsOTYgQEANCj4g
PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArLyoNCj4gPiArICog
Q29weXJpZ2h0IChDKSAyMDE5LTIwMjEgWGlsaW54LCBJbmMuDQo+ID4gKyAqLw0KPiA+ICsNCj4g
PiArI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9m
cGdhL2ZwZ2EtbWdyLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiA+ICsjaW5jbHVk
ZSA8bGludXgva2VybmVsLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiAr
I2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3N0cmlu
Zy5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZmlybXdhcmUveGxueC16eW5xbXAuaD4NCj4gPiAr
DQo+ID4gK3N0YXRpYyBpbnQgdmVyc2FsX2ZwZ2Ffb3BzX3dyaXRlX2luaXQoc3RydWN0IGZwZ2Ff
bWFuYWdlciAqbWdyLA0KPiA+ICsJCQkJICAgICAgc3RydWN0IGZwZ2FfaW1hZ2VfaW5mbyAqaW5m
bywNCj4gPiArCQkJCSAgICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IHNpemUpIHsNCj4gPiAr
CXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiBUaGVzZSBlbXB0eSBvcHMgc2hvdWxkIGdvIGF3
YXkgd2l0aCBteSB3cmFwcGVycyBwYXRjaHNldA0KDQpPbmNlIHlvdXIgcGF0Y2hlcyBnb3QgaW50
ZWdyYXRlZCB3aWxsIHBvc3Qgb25lIG1vcmUgcGF0Y2ggdG8gcmVtb3ZlIHRoaXMgZW1wdHkgb3Bz
Lg0KDQo+ID4gK3N0YXRpYyBpbnQgdmVyc2FsX2ZwZ2Ffb3BzX3dyaXRlKHN0cnVjdCBmcGdhX21h
bmFnZXIgKm1nciwNCj4gPiArCQkJCSBjb25zdCBjaGFyICpidWYsIHNpemVfdCBzaXplKQ0KPiA+
ICt7DQo+ID4gKwlkbWFfYWRkcl90IGRtYV9hZGRyID0gMDsNCj4gPiArCWNoYXIgKmtidWY7DQo+
ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCWtidWYgPSBkbWFfYWxsb2NfY29oZXJlbnQobWdy
LT5kZXYucGFyZW50LCBzaXplLCAmZG1hX2FkZHIsDQo+IEdGUF9LRVJORUwpOw0KPiA+ICsJaWYg
KCFrYnVmKQ0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArCW1lbWNweShrYnVm
LCBidWYsIHNpemUpOw0KPiA+ICsJcmV0ID0genlucW1wX3BtX2xvYWRfcGRpKFBESV9TUkNfRERS
LCBkbWFfYWRkcik7DQo+IHdoeSBpc24ndCB0aGUgc2l6ZSBwYXNzZWQgPw0KDQoNClNpemUgaXMg
cGFydCBvZiBQREkgaW1hZ2VzIGhlYWRlciB1c2VycyBubyBuZWVkIHRvIHBhc3MgdGhpcyBpbmZv
IGV4cGxpY2l0bHkuDQoNCj4gPiArCWRtYV9mcmVlX2NvaGVyZW50KG1nci0+ZGV2LnBhcmVudCwg
c2l6ZSwga2J1ZiwgZG1hX2FkZHIpOw0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30N
Cj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgdmVyc2FsX2ZwZ2Ffb3BzX3dyaXRlX2NvbXBsZXRlKHN0
cnVjdCBmcGdhX21hbmFnZXIgKm1nciwNCj4gPiArCQkJCQkgIHN0cnVjdCBmcGdhX2ltYWdlX2lu
Zm8gKmluZm8pDQo+ID4gK3sNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtz
dGF0aWMgZW51bSBmcGdhX21ncl9zdGF0ZXMgdmVyc2FsX2ZwZ2Ffb3BzX3N0YXRlKHN0cnVjdCBm
cGdhX21hbmFnZXINCj4gPiArKm1ncikgew0KPiA+ICsJcmV0dXJuIEZQR0FfTUdSX1NUQVRFX1VO
S05PV047DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZnBnYV9tYW5h
Z2VyX29wcyB2ZXJzYWxfZnBnYV9vcHMgPSB7DQo+ID4gKwkuc3RhdGUgPSB2ZXJzYWxfZnBnYV9v
cHNfc3RhdGUsDQo+ID4gKwkud3JpdGVfaW5pdCA9IHZlcnNhbF9mcGdhX29wc193cml0ZV9pbml0
LA0KPiA+ICsJLndyaXRlID0gdmVyc2FsX2ZwZ2Ffb3BzX3dyaXRlLA0KPiA+ICsJLndyaXRlX2Nv
bXBsZXRlID0gdmVyc2FsX2ZwZ2Ffb3BzX3dyaXRlX2NvbXBsZXRlLCB9Ow0KPiA+ICsNCj4gPiAr
c3RhdGljIGludCB2ZXJzYWxfZnBnYV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KSB7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsJc3RydWN0
IGZwZ2FfbWFuYWdlciAqbWdyOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlyZXQgPSBk
bWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KCZwZGV2LT5kZXYsDQo+IERNQV9CSVRfTUFTSygzMikp
Ow0KPiA+ICsJaWYgKHJldCA8IDApIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgIm5vIHVzYWJsZSBE
TUEgY29uZmlndXJhdGlvblxuIik7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiAr
DQo+ID4gKwltZ3IgPSBkZXZtX2ZwZ2FfbWdyX2NyZWF0ZShkZXYsICJYaWxpbnggVmVyc2FsIEZQ
R0EgTWFuYWdlciIsDQo+ID4gKwkJCQkgICAmdmVyc2FsX2ZwZ2Ffb3BzLCBOVUxMKTsNCj4gPiAr
CWlmICghbWdyKQ0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArCXJldHVybiBk
ZXZtX2ZwZ2FfbWdyX3JlZ2lzdGVyKGRldiwgbWdyKTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNv
bnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgdmVyc2FsX2ZwZ2Ffb2ZfbWF0Y2hbXSA9IHsNCj4gPiAr
CXsgLmNvbXBhdGlibGUgPSAieGxueCx2ZXJzYWwtZnBnYSIsIH0sDQo+ID4gKwl7fSwNCj4gPiAr
fTsNCj4gPiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgdmVyc2FsX2ZwZ2Ffb2ZfbWF0Y2gpOw0K
PiBuZWVkcyAjaWYgZGVmaW5lZChDT05GSUdfT0YpIHdyYXBwZXINCg0KV2lsbCBmaXguDQoNCj4g
PiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHZlcnNhbF9mcGdhX2RyaXZl
ciA9IHsNCj4gPiArCS5wcm9iZSA9IHZlcnNhbF9mcGdhX3Byb2JlLA0KPiA+ICsJLmRyaXZlciA9
IHsNCj4gPiArCQkubmFtZSA9ICJ2ZXJzYWxfZnBnYV9tYW5hZ2VyIiwNCj4gPiArCQkub2ZfbWF0
Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIodmVyc2FsX2ZwZ2Ffb2ZfbWF0Y2gpLA0KPiA+ICsJfSwN
Cj4gPiArfTsNCj4gPiArbW9kdWxlX3BsYXRmb3JtX2RyaXZlcih2ZXJzYWxfZnBnYV9kcml2ZXIp
Ow0KPiA+ICsNCj4gPiArTU9EVUxFX0FVVEhPUigiTmF2YSBraXNob3JlIE1hbm5lIDxuYXZhLm1h
bm5lQHhpbGlueC5jb20+Iik7DQo+ID4gK01PRFVMRV9BVVRIT1IoIkFwcGFuYSBEdXJnYSBLZWRh
cmVzd2FyYSByYW8NCj4gPiArPGFwcGFuYWQuZHVyZ2EucmFvQHhpbGlueC5jb20+Iik7DQo+IA0K
PiBSYW8gLSBuZWVkcyB0byBiZSBjYXBpdGFsaXplZCA/DQo+IA0KDQpXaWxsIGZpeC4NCg==
