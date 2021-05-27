Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D3D392C27
	for <lists+linux-fpga@lfdr.de>; Thu, 27 May 2021 12:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhE0KwN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 May 2021 06:52:13 -0400
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com ([40.107.237.69]:28769
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236190AbhE0KwM (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 May 2021 06:52:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkWQQlUZ3tZi1RRUL4xhAF8arCcLGFhBD/tJ/8GJ5EEuyz9eP6cXB6v33sxCXKEDk3bfMPO4F6+CCSIq4rREbE7JpRmv0JuI8X2CTgwF2GnpiKxCTOZcyMAZf9DU/YNdbUHnDi1DJC/LLwP/0fanC/gbhHyj7LvJsvO/qyJhAPNIbtcWTwE2oj8Vk9Aq/I37pQ4L6aCaxbKitibP/IeDUNeZJVRei0zuEvnio7MBhIE2nRl7B1eD2uc4C9WB2T+TaCi1caiSIy0O9bdy2JxE5ou4O2IyerJvHdW/Yrb8XgFZ8CNOFS9nx8v1788Bvw2nHZhtARqFvw1nERpiUdqS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ClbstyQpFJ1n/EsDriymi0DDhjVL5Ptk4Qi4bnPPtM=;
 b=gOU06kgL9TeZbmwFKV0T2wKQLGF4ijCNjILXCxCAtcuNQCfxfP+hIo46LNczN+ZEsYX9EAR/ZgiJFk3NTyq7+2PhhrZJIS8OSinoWpZcsrSaeWZ2ErC8c/mImMpNt/LF4YcjVMRXVr7kZQwJMTSy9N3ZCREq9Sqoud0gl+awlamGurNab8bNxMXJ702PVJ65e6EAgHpYU0Y+Jfh/uk9c+WKYlSsekZYn9gUbgWTeBR88RAg9G4DXkM7aOb/ShBcKN9ZjMHdemHtDhNa5JQKO1/8ZkpKSPfmMpYM8lGmSdNku9W1Wdhtj4F3xCDdTQqTUGVTnz+d3bI/CgLYgBYt2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ClbstyQpFJ1n/EsDriymi0DDhjVL5Ptk4Qi4bnPPtM=;
 b=kYpuhQA70Sv9+Kg542aREgCsxGAFTKlZF7mqeqXyeQT8Nc0THo1relBh875omFBnF1uEHKVFF3aowa7tsO7/0OINgTMg3+9Nvp1Zl9yTw2ZIrGiDGechQ2Sk/fgp2TnpL7NHKtbZYn4yYpVkXI5W9hHk3w77cypK/3WOj+q3IJQ=
Received: from MW4PR02MB7332.namprd02.prod.outlook.com (2603:10b6:303:79::18)
 by MW4PR02MB7332.namprd02.prod.outlook.com (2603:10b6:303:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 10:50:36 +0000
Received: from MW4PR02MB7332.namprd02.prod.outlook.com
 ([fe80::a5e1:28aa:7a36:e6c2]) by MW4PR02MB7332.namprd02.prod.outlook.com
 ([fe80::a5e1:28aa:7a36:e6c2%6]) with mapi id 15.20.4173.021; Thu, 27 May 2021
 10:50:36 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Manish Narani <MNARANI@xilinx.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [RFC PATCH 2/4] fpga: Add new properties to support user-key
 encrypted bitstream loading
Thread-Topic: [RFC PATCH 2/4] fpga: Add new properties to support user-key
 encrypted bitstream loading
Thread-Index: AQHXQM90hYIAhSQLOEqomCrE4N/mi6rgvmsAgACDurCAAEZ2gIAVwFYQ
Date:   Thu, 27 May 2021 10:50:36 +0000
Message-ID: <MW4PR02MB7332EAA757E0C032A8E9D379C2239@MW4PR02MB7332.namprd02.prod.outlook.com>
References: <20210504102227.15475-1-nava.manne@xilinx.com>
 <20210504102227.15475-3-nava.manne@xilinx.com>
 <20210513023104.GA909876@robh.at.kernel.org>
 <MWHPR02MB262309A8DC5BD857CBB01446C2519@MWHPR02MB2623.namprd02.prod.outlook.com>
 <CAL_Jsq+mHsrgQOrT48gaoqBOUuMf5mxeVauM74RDxELiA8fXKg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+mHsrgQOrT48gaoqBOUuMf5mxeVauM74RDxELiA8fXKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51718d22-471a-40f1-22fe-08d920fd4291
x-ms-traffictypediagnostic: MW4PR02MB7332:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR02MB7332404DAD4F5C562125674BC2239@MW4PR02MB7332.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kb//yS3nXb/jPSts4nJMi0wnk41REdfQp2Zf1ceRgM2MmjRLnbDePkIoNweMbE35XbtZehHBdHrEBaFpMYkob9nn+OJGghv8HsmLkX9ehvk4JA7+0RTyrOdXwoInVy9ieui8KLuaN4M1HrH1xQxwTvPx2pT4Z0ewmRVDMcBoabDeQY1iGUlDDvIXCenmWN+lGdWuhYkPXTQP0ldB+0lzUUqOtMNBpMTSsdG7/D6wo1axGtxw9DcPIrYSCzLEStDXPGOZ08szRIm5nCCBuCGzjLJcneeKahTf+3uRN+3tU2bE10E2O44tkiJVga1WQ5M2oTWcGJ6Fk7GhwUMHfZPk/jscOMWMcoY2zbSAABdzpUTlXveQu5dKD4t/qvhaXeBeXtyxSDCQe+xMwM2iS3US8n5NfE/jLZZQnWhw8AflvoIT28G620w3uGv1mxt/R/+S1J8ydBhB4HGQjNtPA68jlt42QVSj7cOMwNN87TUAJdtEPrpKSAqaiyMKq5Y9MmaMTqJWdh79zM7zJQCybLfFEefT6ynimioJJ+LO4SMmY6hGg0aVSvS5FedOmB+bTQilUOlRIDwl2EXhrnchmdJrwc+f77RAPMWnOGUir0mzoPQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR02MB7332.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(5660300002)(52536014)(66556008)(33656002)(76116006)(66446008)(71200400001)(64756008)(66946007)(86362001)(2906002)(66476007)(83380400001)(9686003)(55016002)(186003)(6916009)(26005)(7696005)(478600001)(4326008)(53546011)(6506007)(7416002)(8936002)(54906003)(38100700002)(8676002)(316002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzZqdGE1cE5VTzQ4ZkhMS1NpL3JNUENrbGtlU2hDckVSU2J2T1NFUU1FczFI?=
 =?utf-8?B?cnFVYllMQ3VTQ3Z0ZmFsZFdpU0wrUE1WdkFXRTNEM3Q0cnZ1OGRoS2FxZ0dD?=
 =?utf-8?B?NDZSb1A2QzFoSkk2L2kwZVZRSDNmRC9MUEhGcndaNXVacDFIeDlzdzNBdkFG?=
 =?utf-8?B?WFhSNlFJeXlON1ZYa2R4bGo1WW9GV3puOWZIY20ramlZckg3NkhsZUorRlBk?=
 =?utf-8?B?MFI0d2UwemhOL0g2WWVNUU5ja2FFL09URi9kZWgreW51V2lnUDdFcjVMRVlk?=
 =?utf-8?B?U25OSmxJaFF3SFI2MHBVMTY2OHdYUEFOL2U5Y1lha3RwZjZxdDFwZ0liWVhW?=
 =?utf-8?B?UUNpbG9rV2ptdVcvbHZwMHcwcDlRZWU2QWUwUmNWZTV0MGl1YWZRSUx5NWRh?=
 =?utf-8?B?SzdnNTdkTWh4MDV2bTUwbWRlMmpTbHBhemJPb3ptdHN5QWVFMjZsMUNlbS9Q?=
 =?utf-8?B?YTRoaTRIdHdvdktXYWEwbjdRZEpQc2ZrM2JBdnhjYmIvYnBuODhBTE0ybU9J?=
 =?utf-8?B?TERIZWQ5U01wZXJrYVg5d20zREtoVDNXMFloeEtwaXVQZzROaEtENysyS0Vx?=
 =?utf-8?B?YVV4VUNKcUo1NkljY1FhYTJCWGdNbDRGR25yRk1KUTkwbjZGeUpNTXNyM3lG?=
 =?utf-8?B?V3VVVmFNLy9kZHJmTytmSXhreCtZMXRCVGtsZWduYmF1elZZMU5lWnVhcG01?=
 =?utf-8?B?b3dkZmdNMHNsbDZVM2c2S2FqZTREa2ZBczU2Z2VCUko3QUFrbERZb3NDWSth?=
 =?utf-8?B?VVJ0MTdBSnNDQTZpdy9wZ2xVUG50Ujh4cis1RU5LL3NQalIyWFZWbFF0YXEw?=
 =?utf-8?B?UTU2Qnd5U3pvNVRtYXRGeE5pcThUSTRLajh4QmdZOG82ZHhlSzFxemE0NHVr?=
 =?utf-8?B?TFlENUJXakZjbEt4a0hEaUhWWkRGQVJyOUx2ZG41c1NCWDlKRHYydGVxZnpZ?=
 =?utf-8?B?RW5MYjFzSmd5c2JDNTFiaHBGOEg5bkZQVEtudkNkckI4c2sxenFSWTFBeFJo?=
 =?utf-8?B?d0huREE1UFUrTmVlUkJSSXI2MFFKUmV0SVhaR2FJRXhodm9kN0FNUk5uNFd3?=
 =?utf-8?B?UWZnZzRTZDRLdnZRRStKYVNhSFpJK0ZPa0xIZkZyZmthNEZBbVNjL1dMTEFo?=
 =?utf-8?B?RGt2eGxWdWFad3d4bnpWekFOMTZyT3lydml4QkgrMlllM1FrUWpOWnFxL0gw?=
 =?utf-8?B?MFo5TWE1M05XQzRWK2p6ZlJYU2ovdmxjeUx4c1pHeVNMT2EreHZsT01QeWZn?=
 =?utf-8?B?YjZqQ1d2SDFzbHZkQ3hvTTVDalNheVZvUkphVGZTcU9ReTlXRkhyKzYrdUgw?=
 =?utf-8?Q?ggzOMaBlWd?=
x-ms-exchange-antispam-messagedata-1: ThDFh80vjt2GjDniRI1MiJ1Grxlt21UBMeU5TNyfjVeq5Jtn7Qq/wvJO4qHakcIh2xY/5GfWly99/hHxxhzbrmTMvaDD3LzEFwxBQFB5YqIr+gn4+osXvNCRQW6wVPbUXhNgy2o4Mad/Dv97zPNvQfsPwtTcKVomR3qTlL8GYyWEVeDA++Pzougxmr5q2Vo/bbjP/jrdGXw+AX/htnPkRqCk4V5CDnOqfQPdyazMheRGtIQhPVGJNXRKwOiX8WAaourxNDHGmkgMv3onx1GjGohCiap1cd7G1VZCGGduUzRGJqATGr1X5Wujl/U8Y4Tun6y0Wpg0B69QpR3Tz9IvZ9nU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7332.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51718d22-471a-40f1-22fe-08d920fd4291
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 10:50:36.4601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egEwsoY6EaNtUt51xe1Nmp93/c3e65TdSvEvWJ3y/Q0N4+fY4X8uFwnXmPbjlUpsUjBFnrS+5QThWLbmqTKw9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7332
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgUm9iLA0KDQoJUGxlYXNlIGZpbmQgbXkgcmVzcG9uc2UgaW5saW5lLg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTMsIDIwMjEgODowNSBQTQ0KPiBUbzogTmF2YSBraXNo
b3JlIE1hbm5lIDxuYXZhbUB4aWxpbnguY29tPg0KPiBDYzogbWRmQGtlcm5lbC5vcmc7IHRyaXhA
cmVkaGF0LmNvbTsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+Ow0KPiBhcm5kQGFy
bmRiLmRlOyBSYWphbiBWYWphIDxSQUpBTlZAeGlsaW54LmNvbT47DQo+IGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnOyBsaW51cy53YWxsZWlqQGxpbmFyby5vcmc7IEFtaXQgU3VuaWwgRGhhbW5l
DQo+IDxhbWl0c3VuaUB4bG54LnhpbGlueC5jb20+OyBUZWphcyBQYXRlbCA8dGVqYXNwQHhsbngu
eGlsaW54LmNvbT47DQo+IHpvdV93ZWlAaHVhd2VpLmNvbTsgTWFuaXNoIE5hcmFuaSA8TU5BUkFO
SUB4aWxpbnguY29tPjsgU2FpIEtyaXNobmENCj4gUG90dGh1cmkgPGxha3NobWlzQHhpbGlueC5j
b20+OyBKaWF5aW5nIExpYW5nIDxqbGlhbmdAeGlsaW54LmNvbT47IGxpbnV4LQ0KPiBmcGdhQHZn
ZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGdpdA0KPiA8Z2l0QHhpbGlueC5jb20+OyBjaGlubmlraXNob3JlMzY5QGdtYWlsLmNvbQ0KPiBT
dWJqZWN0OiBSZTogW1JGQyBQQVRDSCAyLzRdIGZwZ2E6IEFkZCBuZXcgcHJvcGVydGllcyB0byBz
dXBwb3J0IHVzZXIta2V5DQo+IGVuY3J5cHRlZCBiaXRzdHJlYW0gbG9hZGluZw0KPiANCj4gT24g
VGh1LCBNYXkgMTMsIDIwMjEgYXQgNTo1NSBBTSBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmFtQHhp
bGlueC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSGkgUm9iLA0KPiA+DQo+ID4gICAgICAgICBQ
bGVhc2UgZmluZCBteSByZXNwb25zZSBpbmxpbmUuDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0K
PiA+ID4gU2VudDogVGh1cnNkYXksIE1heSAxMywgMjAyMSA4OjAxIEFNDQo+ID4gPiBUbzogTmF2
YSBraXNob3JlIE1hbm5lIDxuYXZhbUB4aWxpbnguY29tPg0KPiA+ID4gQ2M6IG1kZkBrZXJuZWwu
b3JnOyB0cml4QHJlZGhhdC5jb207IE1pY2hhbCBTaW1law0KPiA+ID4gPG1pY2hhbHNAeGlsaW54
LmNvbT47IGFybmRAYXJuZGIuZGU7IFJhamFuIFZhamENCj4gPFJBSkFOVkB4aWxpbnguY29tPjsN
Cj4gPiA+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBsaW51cy53YWxsZWlqQGxpbmFyby5v
cmc7IEFtaXQgU3VuaWwNCj4gPiA+IERoYW1uZSA8YW1pdHN1bmlAeGxueC54aWxpbnguY29tPjsg
VGVqYXMgUGF0ZWwNCj4gPiA+IDx0ZWphc3BAeGxueC54aWxpbnguY29tPjsgem91X3dlaUBodWF3
ZWkuY29tOyBNYW5pc2ggTmFyYW5pDQo+ID4gPiA8TU5BUkFOSUB4aWxpbnguY29tPjsgU2FpIEty
aXNobmEgUG90dGh1cmkgPGxha3NobWlzQHhpbGlueC5jb20+Ow0KPiA+ID4gSmlheWluZyBMaWFu
ZyA8amxpYW5nQHhpbGlueC5jb20+OyBsaW51eC0gZnBnYUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4g
PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtIGtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+ID4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGdpdCA8Z2l0
QHhpbGlueC5jb20+Ow0KPiA+ID4gY2hpbm5pa2lzaG9yZTM2OUBnbWFpbC5jb20NCj4gPiA+IFN1
YmplY3Q6IFJlOiBbUkZDIFBBVENIIDIvNF0gZnBnYTogQWRkIG5ldyBwcm9wZXJ0aWVzIHRvIHN1
cHBvcnQNCj4gPiA+IHVzZXIta2V5IGVuY3J5cHRlZCBiaXRzdHJlYW0gbG9hZGluZw0KPiA+ID4N
Cj4gPiA+IE9uIFR1ZSwgTWF5IDA0LCAyMDIxIGF0IDAzOjUyOjI1UE0gKzA1MzAsIE5hdmEga2lz
aG9yZSBNYW5uZSB3cm90ZToNCj4gPiA+ID4gVGhpcyBwYXRjaCBBZGRzIOKAmGVuY3J5cHRlZC1r
ZXktbmFtZeKAmSBhbmQNCj4gPiA+ID4g4oCYZW5jcnlwdGVkLXVzZXIta2V5LWZwZ2EtY29uZmln
4oCZIHByb3BlcnRpZXMgdG8gc3VwcG9ydCB1c2VyLWtleQ0KPiA+ID4gPiBlbmNyeXB0ZWQgYml0
c3RyZWFtIGxvYWRpbmcgdXNlIGNhc2UuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YS5tYW5uZUB4aWxpbnguY29tPg0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL2ZwZ2EtcmVn
aW9uLnR4dCB8IDUgKysrKysNCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL2ZwZ2EtcmVnaW9uLnR4dA0KPiA+ID4gPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL2ZwZ2EtcmVnaW9uLnR4dA0KPiA+ID4g
PiBpbmRleCBkNzg3ZDU3NDkxYTEuLjk1N2RjNmNiY2Q5ZSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EvZnBnYS1yZWdpb24udHh0DQo+
ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL2ZwZ2Et
cmVnaW9uLnR4dA0KPiA+ID4gPiBAQCAtMTc3LDYgKzE3Nyw5IEBAIE9wdGlvbmFsIHByb3BlcnRp
ZXM6DQo+ID4gPiA+ICAgICBpdCBpbmRpY2F0ZXMgdGhhdCB0aGUgRlBHQSBoYXMgYWxyZWFkeSBi
ZWVuIHByb2dyYW1tZWQgd2l0aA0KPiA+ID4gPiB0aGlzDQo+ID4gPiBpbWFnZS4NCj4gPiA+ID4g
ICAgIElmIHRoaXMgcHJvcGVydHkgaXMgaW4gYW4gb3ZlcmxheSB0YXJnZXRpbmcgYSBGUEdBIHJl
Z2lvbiwgaXQgaXMgYQ0KPiA+ID4gPiAgICAgcmVxdWVzdCB0byBwcm9ncmFtIHRoZSBGUEdBIHdp
dGggdGhhdCBpbWFnZS4NCj4gPiA+ID4gKy0gZW5jcnlwdGVkLWtleS1uYW1lIDogc2hvdWxkIGNv
bnRhaW4gdGhlIG5hbWUgb2YgYW4gZW5jcnlwdGVkDQo+ID4gPiA+ICtrZXkgZmlsZQ0KPiA+ID4g
bG9jYXRlZA0KPiA+ID4gPiArICAgb24gdGhlIGZpcm13YXJlIHNlYXJjaCBwYXRoLiBJdCB3aWxs
IGJlIHVzZWQgdG8gZGVjcnlwdCB0aGUNCj4gPiA+ID4gKyBGUEdBDQo+ID4gPiBpbWFnZQ0KPiA+
ID4gPiArICAgZmlsZS4NCj4gPiA+ID4gIC0gZnBnYS1icmlkZ2VzIDogc2hvdWxkIGNvbnRhaW4g
YSBsaXN0IG9mIHBoYW5kbGVzIHRvIEZQR0ENCj4gPiA+ID4gQnJpZGdlcyB0aGF0IG11c3QNCj4g
PiA+IGJlDQo+ID4gPiA+ICAgICBjb250cm9sbGVkIGR1cmluZyBGUEdBIHByb2dyYW1taW5nIGFs
b25nIHdpdGggdGhlIHBhcmVudCBGUEdBDQo+ID4gPiBicmlkZ2UuDQo+ID4gPiA+ICAgICBUaGlz
IHByb3BlcnR5IGlzIG9wdGlvbmFsIGlmIHRoZSBGUEdBIE1hbmFnZXIgaGFuZGxlcyB0aGUgYnJp
ZGdlcy4NCj4gPiA+ID4gQEAgLTE4Nyw2ICsxOTAsOCBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzOg0K
PiA+ID4gPiAgLSBleHRlcm5hbC1mcGdhLWNvbmZpZyA6IGJvb2xlYW4sIHNldCBpZiB0aGUgRlBH
QSBoYXMgYWxyZWFkeQ0KPiA+ID4gPiBiZWVuDQo+ID4gPiBjb25maWd1cmVkDQo+ID4gPiA+ICAg
ICBwcmlvciB0byBPUyBib290IHVwLg0KPiA+ID4gPiAgLSBlbmNyeXB0ZWQtZnBnYS1jb25maWcg
OiBib29sZWFuLCBzZXQgaWYgdGhlIGJpdHN0cmVhbSBpcw0KPiA+ID4gPiBlbmNyeXB0ZWQNCj4g
PiA+ID4gKy0gZW5jcnlwdGVkLXVzZXIta2V5LWZwZ2EtY29uZmlnIDogYm9vbGVhbiwgc2V0IGlm
IHRoZSBiaXRzdHJlYW0NCj4gPiA+ID4gK2lzDQo+ID4gPiBlbmNyeXB0ZWQNCj4gPiA+ID4gKyAg
IHdpdGggdXNlciBrZXkuDQo+ID4gPg0KPiA+ID4gV2hhdCdzIHRoZSByZWxhdGlvbnNoaXAgd2l0
aCBlbmNyeXB0ZWQtZnBnYS1jb25maWc/IEJvdGggcHJlc2VudCBvcg0KPiA+ID4gbXV0dWFsbHkg
ZXhjbHVzaXZlPyBDb3VsZG4ndCB0aGlzIGJlIGltcGxpZWQgYnkgZW5jcnlwdGVkLWtleS1uYW1l
DQo+ID4gPiBiZWluZyBwcmVzZW50Pw0KPiA+ID4NCj4gPg0KPiA+IEluIEVuY3J5cHRpb24gd2Ug
aGF2ZSB0d28ga2luZHMgb2YgdXNlIGNhc2Ugb25lIGlzIEVuY3J5cHRlZCBCaXRzdHJlYW0NCj4g
PiBsb2FkaW5nIHdpdGggRGV2aWNlLWtleSBhbmQgT3RoZXIgb25lIGlzIEVuY3J5cHRlZCBCaXRz
dHJlYW0gbG9hZGluZw0KPiA+IHdpdGggVXNlci1rZXkuIGVuY3J5cHRlZC1mcGdhLWNvbmZpZyBh
bmQNCj4gPiBlbmNyeXB0ZWQtdXNlci1rZXktZnBnYS1jb25maWcgYXJlIG11dHVhbGx5IGV4Y2x1
c2l2ZS4gVG8gZGlmZmVyZW50aWF0ZQ0KPiBib3RoIHRoZSB1c2UgY2FzZXMgSSBoYXZlIGFkZGVk
IHRoaXMgbmV3IGZsYWcgYW5kIEFlcyBLZXkgZmlsZShlbmNyeXB0ZWQta2V5LQ0KPiBuYW1lKSBp
cyBuZWVkZWQgb25seSBmb3IgZW5jcnlwdGVkLXVzZXIta2V5LWZwZ2EtY29uZmlnIHVzZSBjYXNl
cy4NCj4gDQo+IElmIGVuY3J5cHRlZC1rZXktbmFtZSBpcyByZXF1aXJlZCBmb3IgYSB1c2VyIGtl
eSwgdGhlbiB3aHkgZG8geW91IG5lZWQNCj4gZW5jcnlwdGVkLXVzZXIta2V5LWZwZ2EtY29uZmln
IGFsc28/DQo+IA0KPiBJT1csIHdoeSBoYXZlIDMgcHJvcGVydGllcyAodGhhdCdzIDkgcG9zc2li
bGUgY29tYmluYXRpb25zKSBmb3IgMiBtb2Rlcz8NCj4gDQoNCkFncmVlLCB3ZSBjYW4gdXNlIGVu
Y3J5cHRlZC1rZXktbmFtZSBmb3IgdXNlci1rZXkgdXNlIGNhc2VzIGluc3RlYWQgb2YgaGF2aW5n
IGJvdGggZW5jcnlwdGVkLWtleS1uYW1lIGFuZCBlbmNyeXB0ZWQtdXNlci1rZXktZnBnYS1jb25m
aWcgZmxhZ3MuDQpXaWxsIGZpeCB0aGlzIGlzc3VlIGluIHYyLg0KDQpSZWdhcmRzLA0KTmF2YWtp
c2hvcmUuDQoNCg==
