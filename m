Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC0A2D357D
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Dec 2020 22:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgLHVll (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Dec 2020 16:41:41 -0500
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com ([40.107.243.53]:17289
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727793AbgLHVlk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 8 Dec 2020 16:41:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+0IPhtM02CJvCB4qru9hYHhlWVDEyGUPQYKj5ZCa3mkJ8QvDDpkEufyyYQR6Ok9FxipTkJpfHw1SMX75UTj7xrf0ctkbzqDM5Z65Yww8tMXNPa81ROXaR/b8jbk64aOc0gLr/Op8WQvi77BwBFLcv7ZeIWEZ55Id292cgS+X8fvc5YoRXUqBD7NSTDdmTcxIHReigKDHSon9mIxi5VM8rsjKfNQxeQxFVyE9+oh6N4wITTvYdMPEtfpRMfmSrEMUQ1hrDhig+FKG/xuJG4RV4D3I13w+F2xC7EV/rHC7QcOTi0AvZ8gT6HpDkuRH+wPfKWXecuGy2dx92S3jVtwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlrQSRuzIv6+3Jgh7KRsmll7TbWhDeBW66A5Wh+DIjQ=;
 b=TcVRbHnrlojWSz28goFAHT03fa31jYHOx0hNTrB1YXSt57OP2SEgcpUBOBpNOJ00+rOUlCX/1rziol7HFKq8AkfX+edJxSJBFEbaZ5ncxPQ9Kr2Nu1JF5+I2sSjv8N3V6ipGnY5XzrvFnANuvfM/JEB5E8AQ+rmP2eEvpeiw2kqgTwyQeQCByf2Uc0PerkJSOuQ0QpQmukhpLVubD/V6y9Te3hqZDdI1eQ1nnT49uWtqMG6oKuvMkNx1PBTO0a6r9hTKsyk2K9hwj2ryr5b92YQZv+pTZNB0a18hldygtK9yktaRG2wVlPf9i2IfWXXzMZV7zW7RO9yEcrE8Ida/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlrQSRuzIv6+3Jgh7KRsmll7TbWhDeBW66A5Wh+DIjQ=;
 b=CF9qR4qT7Xc85FNTtLuvvW3dbwsSE4Td0RmYde/d38wV271+VjRguHbyY4PgJmBK/RuujAO8+XsGAnnDgwNwhxns6R166AykBLAQ8+uU1gha9Xh9xn1fLmoF7drqk96gdnNacm1Q16OvWdN62qE6wvTVfFCLLmnz1wXh/fQJ7wI=
Received: from BY5PR02MB6260.namprd02.prod.outlook.com (2603:10b6:a03:1b0::29)
 by BY5PR02MB6050.namprd02.prod.outlook.com (2603:10b6:a03:1f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 21:40:44 +0000
Received: from BY5PR02MB6260.namprd02.prod.outlook.com
 ([fe80::7183:fa14:bfcf:8ff5]) by BY5PR02MB6260.namprd02.prod.outlook.com
 ([fe80::7183:fa14:bfcf:8ff5%7]) with mapi id 15.20.3654.012; Tue, 8 Dec 2020
 21:40:44 +0000
From:   Sonal Santan <sonals@xilinx.com>
To:     Tom Rix <trix@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Max Zhen <maxz@xilinx.com>, Lizhi Hou <lizhih@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH Xilinx Alveo 0/8] Xilinx Alveo/XRT patch overview
Thread-Topic: [PATCH Xilinx Alveo 0/8] Xilinx Alveo/XRT patch overview
Thread-Index: AQHWxeLU/QqdfVxGqkCi67mkKmZopKnqTq2AgAN0ecA=
Date:   Tue, 8 Dec 2020 21:40:44 +0000
Message-ID: <BY5PR02MB6260399E717A00FFEE32F290BBCD0@BY5PR02MB6260.namprd02.prod.outlook.com>
References: <20201129000040.24777-1-sonals@xilinx.com>
 <457f9fad-f108-26de-3cdb-b367a4782ef2@redhat.com>
In-Reply-To: <457f9fad-f108-26de-3cdb-b367a4782ef2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8da4d13-7acb-4016-5264-08d89bc1ead1
x-ms-traffictypediagnostic: BY5PR02MB6050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB6050D1D723E7999AE8217D68BBCD0@BY5PR02MB6050.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: InbdK58B2HLffu0zttjSeEDPXL568+4wei2Rc2sGoJ0HDN46rb3AMS0BoD6/ga2Ratxh0FSbKvq8AojZfvpUInCS0qCVrGzxUfSK4kmnpEVm0X+aRvSBmGO5C4SOHEGpMgNlJzsqigd3wxayrv08LqVYL64BkJ0WG/ExT768LPckJybCq9SSBN+gfPnOIJoIdqMr2c3oag5W8gf7WVW6MWddL0Jes9p7AgxwDK1oYT7ZGuNxp7Z2kWuu2L9lsu7FNwB3KQ7VVNbdXbIrSrswWT6UNrx01K6Qd4fAe7I4o/7/lPSR6+RGMVuNZD0Js3r1p+l67ZxTTcmFDwhQzBlLtx45cViPrC3IYS9wuvPLWn1mSpCaRXI6qW5bENLbfrIP3kyKEjzIdCfRu6GLiwMqoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6260.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(54906003)(64756008)(76116006)(2906002)(33656002)(966005)(508600001)(6506007)(66556008)(71200400001)(7696005)(9686003)(52536014)(4326008)(83380400001)(8676002)(110136005)(86362001)(8936002)(66446008)(55016002)(66476007)(26005)(186003)(66946007)(5660300002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eHgyUDdxbFFJQ1ZMemI5enlGNXlubURDMjRUc3lqVDBoYXQwU0JXK1hqUjBS?=
 =?utf-8?B?SkJ1NVoxL2RyNjZpK1pXL2RraGJMRGZVU2Q1cDduYmVTTDJ3MWtjK3d1cGM4?=
 =?utf-8?B?cFE1RjBOeE9Ua3RHMkxreGlxWmZiemFQZnZNTHp1eFEzbXcwbEJJQVVqOGNI?=
 =?utf-8?B?a0gyc2l1N0hrRzV5TmVDWXJDS25obitHMVVjSkN2Y2IxZEVXTm4wU1U0M25U?=
 =?utf-8?B?WXZDdTdYTCs1MVlGRmZ4SmFOa21pSkRqT04vM3dSU1dOczdSUFZnM2kzOVAv?=
 =?utf-8?B?enVCQllwZTFOZkVjcmNPWmRSQzR2elhWYWZiQ1VwMDNMRHBzOGQ0UlU4ZFNC?=
 =?utf-8?B?RHJWRjFpbkhTOU0ydTVMUUt1eDBMRURUVUFrcDY5OTA3dFJKOW56VkQwL0VN?=
 =?utf-8?B?VjdHM2QyNjhJUkEvQ3lFQjBBSzVRZmoyRmMwekEwWlVjNi9aM1JZeFhDQ2dH?=
 =?utf-8?B?QWgyYzlJSmhkazUwekR4cTJjSW9leE0rNWRWMnhha2FBa1ZBZ0F0RTRBU2JL?=
 =?utf-8?B?dU5uNEZxQzFRTmVxTmlVTG1jMWR4NFByN1ZyS0czM1RMV20xVTZtOUFnbmRu?=
 =?utf-8?B?eVE4ZXI4Kzh2V0tGdjBSSzVXMTFLOGNzUTUvSml2blZVKzlwU00welkxemhZ?=
 =?utf-8?B?aWd2cVEvTllENEJ5MmJ5LzIrMHVLSmRGa0ZFdE5lZXFZSEJxM0pETXlRN0Zh?=
 =?utf-8?B?T2NSci90Snk5dXhpSmNmUklHalM4a2R1TTVhN0VYM0dYd3E2cHN0Y0xaL29T?=
 =?utf-8?B?Ri80WERoa2RobWdUUS8rMEt0VnBlVS8rdkl3NjdFZnVBZ3pzc0pUQ2xabGtT?=
 =?utf-8?B?R0d3NXo2L1JCbVNtRm00anhWa2FjSi9hZHNLTFZ5WHI2Z1NZWjBmM2VsVWVu?=
 =?utf-8?B?dDI3Qmp0TkVHT0FNVFJQWloxdWgrWDBIbmRmOS9RNVRDQWxPaGh6czducmNK?=
 =?utf-8?B?SmhiNlA4bUx0TzBtZzdBcE5mb1UrQW5QY3RLTHl3TWNtTHlwakM0N1VWN0V6?=
 =?utf-8?B?OENSQTRqZjVBbmhEMmEzSytPSjJjdGNaVG5zdFlFb1c3bC9aUHJrSUJSd0dl?=
 =?utf-8?B?Y2Z1eU9IWWtNazZ6eUE0bjdERXA4clpId2ZYR3NvL2tYN2Q5ZURSaWU5bVNu?=
 =?utf-8?B?SXRHeERCTFo1U1VZT1h3OVltbXVXUHAvRFppcWlRbHVWdFhNS0EzY25rdmwy?=
 =?utf-8?B?RG85WDFmVHhISWNIaS9UbWxlem9GS20zUXRWbVdmNFJzdWFVZkVNK0R4NS94?=
 =?utf-8?B?RUZoeU5Nb2d2T2taeldkU2FxVFNTVGxXZHdISUJmWmVETDVTRDBDVVp4cVVM?=
 =?utf-8?Q?fk0ONAy18xqJY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6260.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8da4d13-7acb-4016-5264-08d89bc1ead1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 21:40:44.2375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yequGRiCy+boq238B7yCw56euF+nWqjoLbl5s9cTsmzgHt538DbfiY6WtUFHenGbEyf05kJyuN3ltXEPvn1swQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6050
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGVsbG8gVG9tLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRvbSBS
aXggPHRyaXhAcmVkaGF0LmNvbT4NCj4gU2VudDogU3VuZGF5LCBEZWNlbWJlciA2LCAyMDIwIDg6
MzEgQU0NCj4gVG86IFNvbmFsIFNhbnRhbiA8c29uYWxzQHhpbGlueC5jb20+OyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBTb25hbCBTYW50YW4gPHNvbmFsc0B4aWxpbnguY29t
PjsgbGludXgtZnBnYUB2Z2VyLmtlcm5lbC5vcmc7IE1heCBaaGVuDQo+IDxtYXh6QHhpbGlueC5j
b20+OyBMaXpoaSBIb3UgPGxpemhpaEB4aWxpbnguY29tPjsgTWljaGFsIFNpbWVrDQo+IDxtaWNo
YWxzQHhpbGlueC5jb20+OyBTdGVmYW5vIFN0YWJlbGxpbmkgPHN0ZWZhbm9zQHhpbGlueC5jb20+
Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFhp
bGlueCBBbHZlbyAwLzhdIFhpbGlueCBBbHZlby9YUlQgcGF0Y2ggb3ZlcnZpZXcNCj4gDQo+IE9u
IDExLzI4LzIwIDQ6MDAgUE0sIFNvbmFsIFNhbnRhbiB3cm90ZToNCj4gPiBIZWxsbywNCj4gPg0K
PiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgbWFuYWdlbWVudCBwaHlzaWNhbCBmdW5jdGlvbiBk
cml2ZXIgZm9yIFhpbGlueA0KPiA+IEFsdmVvIFBDSWUgYWNjZWxlcmF0b3IgY2FyZHMsDQo+ID4g
aHR0cHM6Ly93d3cueGlsaW54LmNvbS9wcm9kdWN0cy9ib2FyZHMtYW5kLWtpdHMvYWx2ZW8uaHRt
bA0KPiA+IFRoaXMgZHJpdmVyIGlzIHBhcnQgb2YgWGlsaW54IFJ1bnRpbWUgKFhSVCkgb3BlbiBz
b3VyY2Ugc3RhY2suDQo+IA0KPiBBIGZldyBnZW5lcmFsIHRoaW5ncy4NCj4gDQo+IFVzZSBzY3Jp
cHRzL2dldF9tYWludGFpbmVyLnBsIHRvIGZpbmQgd2hvIGEgcGF0Y2ggc2hvdWxkIGdvIHRvLCBp
IHNob3VsZCBoYXZlDQo+IGJlZW4gb24gdGhlIGNjIGxpbmUuDQo+IA0KV2lsbCBkby4NCj4gRWFj
aCBwYXRjaCBzaG91bGQgYXQgYSBtaW5pbXVtIHBhc3Mgc2NyaXB0cy9jaGVja3BhdGNoLnBsLCBu
b25lIGRvLg0KPiANCkxvb2tzIGxpa2UgYSBmZXcgZmlsZXMgbWlzc2VkIG91ciBjaGVja3BhdGNo
IHByb2Nlc3MuIFdpbGwgYWRkcmVzcyBpbiB0aGUNCnVwY29taW5nIHBhdGNoIHNlcmllcy4NCg0K
PiBMb29raW5nIGJyb2FkbHkgYXQgdGhlIGZpbGVzLCB0aGVyZSBhcmUgY29tcGV0aW5nIG5hbWVz
IHhydCBvciBhbHZlby4NCj4gDQo+IEl0IHNlZW1zIGxpa2UgeHJ0IGlzIHRoZSBkZmwgZXF1aXZh
bGVudCwgc28gbWF5YmUNCj4gDQo+IGRyaXZlcnMvZnBnYS9hbHZlbyBzaG91bGQgYmUgZHJpdmVy
cy9mcGdhL3hydA0KPiANCkFncmVlZC4gV2lsbCBhZGRyZXNzIGluIHRoZSBuZXh0IHBhdGNoIHNl
cmllcy4NCj4gVGhlcmUgYXJlIGEgbG90IG9mIGZpbGVzIHdpdGggdW5uZWNlc3NhcnkgcHJlZml4
ZXMNCj4gDQo+IGV4Lw0KPiANCj4gZnBnYS9hbHZlby9pbmNsdWRlL3hydC11Y3MuaCBjb3VsZCBq
dXN0IGJlIGZwZ2EvYWx2ZW8vaW5jbHVkZS91Y3MuaA0KPiANCldvdWxkIHdvcmsgb24gc2VwYXJh
dGluZyB4cnQgaW5mcmFzdHJ1Y3R1cmUgYW5kIHN1YmRldnMgaGVhZGVyIGZpbGVzDQppbnRvIHNl
cGFyYXRlIGRpcmVjdG9yaWVzIGFuZCBkcm9wIHRoZSB4cnQgcHJlZml4LiANCj4gaW5kaXZpZHVh
bCBzdWJkZXYncyBtYXkgbm90IGJlbG9uZyBpbiB0aGUgZnBnYSBzdWJzeXN0ZW0uDQo+IA0KPiBJ
IHRoaW5rIGl0IHdvdWxkIGJlIGJldHRlciB0byBzdWJtaXQgdGhlc2Ugb25lIGF0IGEgdGltZSBh
cyBpcyBkb25lIGZvciBkZmwuDQo+IA0KSW4gdGhlIHVwY29taW5nIHBhdGNoIHJldmlzaW9uLCB3
aWxsIGRyb3AgdGhlIHN1YmRldnMgZXhjZXB0IGJhcmUgbWluaW11bSANCm5lY2Vzc2FyeSB0byBw
ZXJmb3JtIGJpdHN0cmVhbSBkb3dubG9hZC4NCj4gU28gdGhpcyB3aWxsIG5vdCBibG9jayBnZXR0
aW5nIHRoZSBiYXNpY3MgZG9uZSwgaW4gdGhlIG5leHQgcmV2aXNpb24sIGNhbiB5b3UgbGVhdmUN
Cj4gdGhlIHN1YmRldidzIG91dCA/DQo+IA0KPiANClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0K
LVNvbmFsDQo+IA0KPiBCZWNhdXNlIG9mIHRoZSBjaGVja3BhdGNoLnBsIGZhaWx1cmVzLCBJIHdp
bGwgd2FpdCBmb3IgdGhlIG5leHQgcmV2aXNpb24uDQo+IA0KPiBUb20NCj4gDQoNCg==
