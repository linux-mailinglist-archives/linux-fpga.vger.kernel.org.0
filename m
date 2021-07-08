Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1528F3BF933
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Jul 2021 13:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhGHLna (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Jul 2021 07:43:30 -0400
Received: from mail-bn1nam07on2042.outbound.protection.outlook.com ([40.107.212.42]:24345
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231748AbhGHLna (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 8 Jul 2021 07:43:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiNJa26+Kqw8/SOPgksqyumJrN9I0R2l1dsa8HH9+ozdxQGAwbsd5FIapNhTiAxS46VMKNYyOvvP3kP+PArcBBFmEF+sQLPJrLLNn3ma9/kcCBWqu9mgiRtT1zkKMBY9voGaFAVzaP4dmQfETelqOVNl3vMVYfkEzcajvkeE8hhOckqcc64pbz4dxRUY4ahofJvW6mvHgwlSIZ32isTbW2qAXYDuLRr4ORaPlL8rbJpL8xI2rxppJWSj9MAgcWu13bJ7Z+tp/rDVpC6n9EwowGjnHUUvzhC7kYt3By3v/9TWzYuxyNrMuJdYeVh1Pbti9sHsAWEiom/XMhPy+rnmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QquvMSKl039J5iGFw+GAoXAo5dpgFmBnf+YFgxWda+g=;
 b=nAn+AQUf6huuo/mYoutyvpSAegE616VYdhcCihhNJ/qX8FDgRxM9NhtrbbLWAfl8rJeMzhJnAunam+6BakF9l3ICGh8NOUCBHTTYT7k2Mo0PvIRDzZICoOtot6rpkKoYJlg7mDz07Z92r0c4+auGvldUZPw2Ji/ZxtORzowrnOwDympQZ0vA4WxMpNtoljpgf7j+89ol36GF/vOku1bAkfE1TuEM39v9UbpMwukoBdEp64y5cGvK0Qg0ciVa1xu1+ey7cgVi/s092GKrveVBA7KvcWJJToZHFeLzoIvAO85J/K58IIoETTDbVjFJiCRPSpyDiOkj3mQAnv3fl0tEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QquvMSKl039J5iGFw+GAoXAo5dpgFmBnf+YFgxWda+g=;
 b=l40sWjmuWeFu7PYKjTkFQfymzFGDRU90ElYeB2/Y+A6jmj4MGiFZ4r0M0Z+fCB8WDZbPEXWLl/Bkk4qfay/S5oedlJthYI/A5IZwAreWjDfkwOtSvtFzYtC22ofecI3XDKdjmrTdOXwnFP5rlB4N6g9wyryFknXw48uWUG9Ja7w=
Received: from PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) by
 PH0PR02MB7734.namprd02.prod.outlook.com (2603:10b6:510:53::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.21; Thu, 8 Jul 2021 11:40:27 +0000
Received: from PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e]) by PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e%9]) with mapi id 15.20.4287.035; Thu, 8 Jul 2021
 11:40:27 +0000
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
Subject: RE: [PATCH v8 1/5] drivers: firmware: Add PDI load API support
Thread-Topic: [PATCH v8 1/5] drivers: firmware: Add PDI load API support
Thread-Index: AQHXaqNd6MAYR/kNnkSGYIOO9ehfOas2f5iAgAKArRA=
Date:   Thu, 8 Jul 2021 11:40:26 +0000
Message-ID: <PH0PR02MB733670F40206C4AC019448C2C2199@PH0PR02MB7336.namprd02.prod.outlook.com>
References: <20210626155248.5004-1-nava.manne@xilinx.com>
 <20210626155248.5004-2-nava.manne@xilinx.com>
 <c2c06484-556d-1003-ad45-301e5b22210b@redhat.com>
In-Reply-To: <c2c06484-556d-1003-ad45-301e5b22210b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ddded2d-4535-4671-1145-08d942052e91
x-ms-traffictypediagnostic: PH0PR02MB7734:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR02MB7734D97AC29D0D896C0B9272C2199@PH0PR02MB7734.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:556;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nlz4tcDWtbYtAq2nWGVGSItufrlUjrw786W548IdONP6B2+uk4zJCIApwW92X1lT7ZjPnKnm2JcSq8AHI/b8v6lJEFdX+RctttORe3Bo5VsdsypM7Yi6ovEI4ydRx83Wk/4+IOUSToi42xqK405MJHYK7veKL0vsMNTW1Ll5816V6YDxmnxNq5+MNYDJfT0YSFERShgO9yx3XciXXpmNrT9GXmT06Q0BaGp1ruhKbmyZ1UPdeULUkuEWUurQ2g6naG9wgjpQR+NAEJhpKt64lXno18jK8JnCEf5KYdddsPVbVhU2dmsGrYkvAAX6C0g4gPTmyU5Avk6pziUMIaYQEUg9GkNtW8PhY2deA3H34EwSCe+zwtlmCgsAEbbFNCTVZ4yUcBD/UMsG4/u3N+OFH6cgHASj2hMIM7gJTUd7JFvsGxpH6JEOmPTDH+E5eefABZLw0Abz/98DVWh89WOeCeUptgjQ+1c0QvY4oEGnQf2Z3C/r+JDey4AEn+jEZLBAscQZWURCNvA7H+VpvdDbIFreMtiYxmO15iu8XehZaXL8r2ZgDm0UCGMclNI9KYhG080OceskoC65FPQPPLD0/TTyQnfi9a3+u831XCG+CoDxmKHFX00voG5kBvfm2F3jLqJwQxZJZGLf1ffN1qwAz47oWfacthhkTv3ZNZzEdvfa96oUvIxSCnI5iJKSB+16618EQzaog9FEHcPUDV1Rrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7336.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(52536014)(9686003)(316002)(86362001)(122000001)(33656002)(2906002)(7416002)(7696005)(38100700002)(55016002)(71200400001)(66446008)(8676002)(478600001)(66946007)(76116006)(110136005)(83380400001)(186003)(26005)(53546011)(8936002)(5660300002)(921005)(6506007)(64756008)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YSt6SjRxc3FoeThOT2ZjV2lMc21sQUl1S05ScHdyMHNDVENnUEVXVlo5ZUtx?=
 =?utf-8?B?d0lmYkRZb2JnL3IyeFRPd2lVNmd5WmptYUJCL0ZLR2xpOWs0c1M1ZnhnTFlB?=
 =?utf-8?B?Y3REbGx0R3o3QmhQeFppdGxVUGljNTA2NE9kWHVzZHVGOTdiUUEwYllFSlpp?=
 =?utf-8?B?TTlZUDVaL3U5aXl3b2tBRjNBVm9INlFITnBja1ViOVEzcGlnK3NLL0pzSEJE?=
 =?utf-8?B?c3hNcTVGTG9HTTZoVUpmQnA0engvV3lsZXdEd1A0dktDWlEvc0t5MGpiOWJp?=
 =?utf-8?B?eFFRODZUc3drMGQvM0RwdXhoZVJMazY4ZkNrUEowTW9XVjVaakhSUEF4ZW9l?=
 =?utf-8?B?MHJsZDZObUp1T0l2L01IUHRpekdGMzRqSUdHQjdEOVV6TEFJOCtNMUo2cm1Z?=
 =?utf-8?B?SVAybXF6Wll5eEZJdkE2SjJDeFB0Sklkd21SdWVYVXlYR0R4amJvRUxnUm5X?=
 =?utf-8?B?TVo3QStJRWtDa0RBR2p1cmhYWUpQa2gxR3lCSXNjcTlNdXZFamhJQUIvWURU?=
 =?utf-8?B?MWxGTEpvTERDVWVZZ3drUzhUN0IraExMVkh0Zkc2QXIvbHY5cHhNNGFkUEg1?=
 =?utf-8?B?a0wvcDBiVDJoVWJybjBJWkZKR0UzcXBMWFNVT2Q2VTc2MXBBVlFrUDQzMkFz?=
 =?utf-8?B?MytQVi9lQ2VyNFVnaDZtN1JjRWZQVXNXK2h6dnQ5WHdFZ3Jwd0didEhnc0VS?=
 =?utf-8?B?UnlzV0tVNFpoMDAzZ2ZuUEQ4aWo2cE5iY2NleTVETzQ2bTRFVm8yWlF6bXY4?=
 =?utf-8?B?dy9NR1JFMHpUWjJ3cXlKam4zbTFXNE4wa09rblNzcC9tM2plaVZ5QmZJd2FT?=
 =?utf-8?B?Vk95YXhiOGtqQ01nb0xQNkRzalhsNDltQmh4VjR6QWZ6ZDVTcUxNME1ZM1Ru?=
 =?utf-8?B?RStzcDExVXc4ZDlqUTdyS2tTV3VzTzFxRXZsUWk4UEhyQ04rTGNkeEJaQkkz?=
 =?utf-8?B?WWhzcExPY0VzRzBXSHQ1SlFMM213UXFPVi9MQ3J0TXZ6NjNNUm5CQ1pWOEdB?=
 =?utf-8?B?UGlaek9ETTJIZTlMQUFvNmVscHcrSWhlaFBESFNEaDZCUFcxd205V0ZPVktC?=
 =?utf-8?B?ejhzZFM3M0JNb0dNdys1SkxrWUh6a2hsY1ZoWDVha2gwUE5BNUhpdWtzK3g5?=
 =?utf-8?B?U0h4a2t1NUp5TUdRYzdoazZnSmFSRGt1VHFIdFQzdDZoTFJaWitQSUE5anhu?=
 =?utf-8?B?ZENrWkc1UlV0NFBmU1lEUHk3K0hod2lDMnBnSVY3WnRnYllnMkpBbk5lanBC?=
 =?utf-8?B?eTA0R0kyTjRJdFpRZ3B2Umt2UlRkMk1YR0lIYncxQjZTZEY4NFJFK1FlV0Ra?=
 =?utf-8?B?d21VbXBNbU90SkI4OXhZNVBCdzlOVVEwOVV6NElSbTYzOXl0TnFUR2kxOFJ2?=
 =?utf-8?B?cG03U2tTdzJuWDBHK2NhaVBHR092Y0RPYTYwdkpWeGpiN0NmdjFLN2MyL1lz?=
 =?utf-8?B?RWg1dEhOR1dFcit5RzdmL3dYdVVBVU5LOFlzbEJZQkdMU3NJZzFrbTZxMU9X?=
 =?utf-8?B?Uk5qWU1JelJSTUt6VVVyWWJtOXFwbW1NMVZKSGpFZFNnTDZqSGsyZ0syV0tF?=
 =?utf-8?B?aEtXRUcrOFlmMWpSRXpkSzZBOGlGRTQvMVFhWklsaTR6NGU1RnBEcnVRUEs0?=
 =?utf-8?B?clY4ZzZlZkJ2Uy9ZNkNDL3pNTFNtaFh4ZURPMk56S3pEbUUwbkdNcFJnVFBE?=
 =?utf-8?B?RFQ5Z2tuSUJpcjJZVGJwSHd1VGt5L3RLWDVxUk5BRy9MNDlNT29uSnBJdGx6?=
 =?utf-8?Q?PwriZjqvaFabkvO3FVD1xXhisdpD7igH5tBfI0E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7336.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddded2d-4535-4671-1145-08d942052e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 11:40:27.1949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXf8SdyxFXW4vuPM9PWhXn+TPD9kfuFMRxRVBKqi8sIaIAIkTMJWSX0hU5XZRCJFdU4i3iioz4hEyku1IoxEAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7734
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgVG9tLA0KDQoJUGxlYXNlIGZpeCBteSByZXNwb25zZSBpbmxpbmUuDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9tIFJpeCA8dHJpeEByZWRoYXQuY29tPg0KPiBT
ZW50OiBXZWRuZXNkYXksIEp1bHkgNywgMjAyMSAyOjM0IEFNDQo+IFRvOiBOYXZhIGtpc2hvcmUg
TWFubmUgPG5hdmFtQHhpbGlueC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7IE1pY2hhbA0KPiBT
aW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgbWRmQGtlcm5lbC5vcmc7IGFybmRAYXJuZGIuZGU7
IFJhamFuIFZhamENCj4gPFJBSkFOVkB4aWxpbnguY29tPjsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc7IEFtaXQgU3VuaWwgRGhhbW5lDQo+IDxhbWl0c3VuaUB4bG54LnhpbGlueC5jb20+OyBU
ZWphcyBQYXRlbCA8dGVqYXNwQHhsbngueGlsaW54LmNvbT47DQo+IHpvdV93ZWlAaHVhd2VpLmNv
bTsgU2FpIEtyaXNobmEgUG90dGh1cmkgPGxha3NobWlzQHhpbGlueC5jb20+OyBSYXZpDQo+IFBh
dGVsIDxyYXZpcGF0ZUB4bG54LnhpbGlueC5jb20+OyBpd2FtYXRzdUBuaWdhdXJpLm9yZzsgSmlh
eWluZyBMaWFuZw0KPiA8amxpYW5nQHhpbGlueC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGZwZ2FAdmdlci5rZXJuZWwub3JnOyBnaXQg
PGdpdEB4aWxpbnguY29tPjsgY2hpbm5pa2lzaG9yZTM2OUBnbWFpbC5jb20NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2OCAxLzVdIGRyaXZlcnM6IGZpcm13YXJlOiBBZGQgUERJIGxvYWQgQVBJIHN1
cHBvcnQNCj4gDQo+IA0KPiBPbiA2LzI2LzIxIDg6NTIgQU0sIE5hdmEga2lzaG9yZSBNYW5uZSB3
cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFkZHMgbG9hZCBQREkgQVBJIHN1cHBvcnQgdG8gZW5hYmxl
IGZ1bGwvcGFydGlhbCBQREkNCj4gPiBsb2FkaW5nIGZyb20gbGludXguIFByb2dyYW1tYWJsZSBE
ZXZpY2UgSW1hZ2UgKFBESSkgaXMgY29tYmluYXRpb24gb2YNCj4gPiBoZWFkZXJzLCBpbWFnZXMg
YW5kIGJpdHN0cmVhbSBmaWxlcyB0byBiZSBsb2FkZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmEubWFubmVAeGlsaW54LmNvbT4NCj4gPiBSZXZpZXdl
ZC1ieTogTW9yaXR6IEZpc2NoZXIgPG1kZkBrZXJuZWwub3JnPg0KPiA+IC0tLQ0KPiA+IENoYW5n
ZXMgZm9yIHYyOg0KPiA+ICAgICAgICAgICAgICAgIC1VcGRhdGVkIEFQSSBEb2MgYW5kIGNvbW1p
dCBtc2cuDQo+ID4gICAgICAgICAgICAgICAgIE5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4gPg0K
PiA+IENoYW5nZXMgZm9yIHYzOg0KPiA+ICAgICAgICAgICAgICAgIC1Ob25lLg0KPiA+DQo+ID4g
Q2hhbmdlcyBmb3IgdjQ6DQo+ID4gICAgICAgICAgICAgICAgLVJlYmFzZWQgdGhlIGNoYW5nZXMg
b24gbGludXgtbmV4dC4NCj4gPiAgICAgICAgICAgICAgICAgTm8gZnVuY3Rpb25hbCBjaGFuZ2Vz
DQo+ID4NCj4gPiBDaGFuZ2VzIGZvciB2NToNCj4gPiAgICAgICAgICAgICAgICAtTm9uZS4NCj4g
Pg0KPiA+IENoYW5nZXMgZm9yIHY2Og0KPiA+ICAgICAgICAgICAgICAgIC1Ob25lLg0KPiA+DQo+
ID4gQ2hhbmdlcyBmb3Igdjc6DQo+ID4gICAgICAgICAgICAgICAgLU5vbmUuDQo+ID4NCj4gPiBD
aGFuZ2VzIGZvciB2ODoNCj4gPiAgICAgICAgICAgICAgICAgLU5vbmUuDQo+ID4NCj4gPiAgIGRy
aXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5jICAgICB8IDE3ICsrKysrKysrKysrKysrKysr
DQo+ID4gICBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL3hsbngtenlucW1wLmggfCAxMCArKysrKysr
KysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAuYw0KPiA+IGIvZHJpdmVy
cy9maXJtd2FyZS94aWxpbngvenlucW1wLmMNCj4gPiBpbmRleCAxNWIxMzgzMjZlY2MuLjJkYjU3
MWRhOWFkOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5jDQo+ID4gQEAgLTEw
MTEsNiArMTAxMSwyMyBAQCBpbnQgenlucW1wX3BtX3NldF9yZXF1aXJlbWVudChjb25zdCB1MzIN
Cj4gbm9kZSwgY29uc3QgdTMyIGNhcGFiaWxpdGllcywNCj4gPiAgIH0NCj4gPiAgIEVYUE9SVF9T
WU1CT0xfR1BMKHp5bnFtcF9wbV9zZXRfcmVxdWlyZW1lbnQpOw0KPiA+DQo+ID4gKy8qKg0KPiA+
ICsgKiB6eW5xbXBfcG1fbG9hZF9wZGkgLSBMb2FkIGFuZCBwcm9jZXNzIFBESQ0KPiA+ICsgKiBA
c3JjOiAgICAgICBTb3VyY2UgZGV2aWNlIHdoZXJlIFBESSBpcyBsb2NhdGVkDQo+ID4gKyAqIEBh
ZGRyZXNzOiAgIFBESSBzcmMgYWRkcmVzcw0KPiA+ICsgKg0KPiA+ICsgKiBUaGlzIGZ1bmN0aW9u
IHByb3ZpZGVzIHN1cHBvcnQgdG8gbG9hZCBQREkgZnJvbSBsaW51eA0KPiA+ICsgKg0KPiA+ICsg
KiBSZXR1cm46IFJldHVybnMgc3RhdHVzLCBlaXRoZXIgc3VjY2VzcyBvciBlcnJvcityZWFzb24g
ICovIGludA0KPiA+ICt6eW5xbXBfcG1fbG9hZF9wZGkoY29uc3QgdTMyIHNyYywgY29uc3QgdTY0
IGFkZHJlc3MpIHsNCj4gPiArCXJldHVybiB6eW5xbXBfcG1faW52b2tlX2ZuKFBNX0xPQURfUERJ
LCBzcmMsDQo+ID4gKwkJCQkgICBsb3dlcl8zMl9iaXRzKGFkZHJlc3MpLA0KPiA+ICsJCQkJICAg
dXBwZXJfMzJfYml0cyhhZGRyZXNzKSwgMCwgTlVMTCk7IH0NCj4gPiArRVhQT1JUX1NZTUJPTF9H
UEwoenlucW1wX3BtX2xvYWRfcGRpKTsNCj4gPiArDQo+ID4gICAvKioNCj4gPiAgICAqIHp5bnFt
cF9wbV9hZXMgLSBBY2Nlc3MgQUVTIGhhcmR3YXJlIHRvIGVuY3J5cHQvZGVjcnlwdCB0aGUgZGF0
YQ0KPiB1c2luZw0KPiA+ICAgICogQUVTLUdDTSBjb3JlLg0KPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L2Zpcm13YXJlL3hsbngtenlucW1wLmgNCj4gPiBiL2luY2x1ZGUvbGludXgvZmly
bXdhcmUveGxueC16eW5xbXAuaA0KPiA+IGluZGV4IDlkMWE1YzE3NTA2NS4uNTZiNDI2ZmUwMjBj
IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvZmlybXdhcmUveGxueC16eW5xbXAuaA0K
PiA+ICsrKyBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUveGxueC16eW5xbXAuaA0KPiA+IEBAIC01
Miw2ICs1MiwxMCBAQA0KPiA+ICAgI2RlZmluZQlaWU5RTVBfUE1fQ0FQQUJJTElUWV9XQUtFVVAJ
MHg0VQ0KPiA+ICAgI2RlZmluZQlaWU5RTVBfUE1fQ0FQQUJJTElUWV9VTlVTQUJMRQkweDhVDQo+
ID4NCj4gPiArLyogTG9hZGVyIGNvbW1hbmRzICovDQo+ID4gKyNkZWZpbmUgUE1fTE9BRF9QREkJ
MHg3MDENCj4gVGhpcyBzaG91bGQgYmUgZGVmaW5lZCBpbiBlbnVtIHBtX2FwaV9pZA0KPiA+ICsj
ZGVmaW5lIFBESV9TUkNfRERSCTB4Rg0KPiANCj4gVGhpcyBpcyBvbmx5IHVzZWQgYnkgdmVyc2Fs
X2ZwZ2Ffb3BzX3dyaXRlKCksIGNvbnNpZGVyIG1vdmluZyB0aGUgI2RlZmluZSB0bw0KPiB2ZXJz
YWwtZnBnYS5jDQo+IA0KDQpZZXMsIGN1cnJlbnRseSBvbmx5IHZlcnNhbF9mcGdhX3dyaXRlKCkg
aXMgdXNpbmcgdGhpcyAjZGVmaW5lIGJ1dCBpdOKAmXMgYSBnZW5lcmljIHRoaW5nIGZvciBWZXJz
YWwgcGxhdGZvcm0NClRoYXTigJlzIHdoeSB3ZSBwbGFjZWQgaXQgaGVyZS4NCg0KUmVnYXJkcywN
Ck5hdmFraXNob3JlLiANCg0K
