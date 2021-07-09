Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084923C2106
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Jul 2021 10:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhGIIvp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Jul 2021 04:51:45 -0400
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com ([40.107.244.44]:63712
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231494AbhGIIvo (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 9 Jul 2021 04:51:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJLMrDaxNIKKrfa1VBF8a4lh1SxKQ/0C2963QfjBmnlFQXuY/eurhxrevGq2WDSxYXWe15UvPPUdx78Q0bUigV/knyy/z1m2B3pxcB6fhaH/VTyN0fkxCaWt3kT12HCCKda2cfmZJWwCc5n3lJhhPM2tDJHgHVQxhIPlJGfOcWAZka1iuW8YsCbMZUoywqUU1RxQIzmJ7MZ2fvT36I/OBQ2SUhQQDqwnttTLdNekPCxGZCEpqS3H5oeG2SvzeV6T+GfpnZdeRVH6qJn2kMVfEgWRcDCdym7Bf/EywGeMpkP/kfLsaQ1oneqFgibxFZTp86V7W+eSAYbFTIzoPW3JNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WS7vRsSsPEb0wYNWX2OxBOX2VlTIS4st0TQR6WVFUo=;
 b=VsA3n0zrgJYvKu0XH/YnAYebTAk6Dez5wAU6PY1E38tkOcdhK0iAo/NJNOqJWsvkVFEHNCceCfcKaHi0VlyX8GigZW/5NsoWn1lxVWQ9DEp8uua8FkByK7AnbpT+KsfGkqq3poWQDCz4HKAn3XyboR/dpOHg2w9+Kz70vLpDoquxhqC3vTlfEhV6M9+vA9IdXT0D5GjSwTa+6DsC9WCWkoUqFJQFlOOn5HcsJmNvx89ERGdT5X+V51/Xxn7JhqlYMbb79d8wHUsS7CbD2mCctQiDgulYoObGvu1X8mskF/HfZS1RUQayDL5zvf677+Ku0eXpcfcJwDh0tnGE3xJ7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WS7vRsSsPEb0wYNWX2OxBOX2VlTIS4st0TQR6WVFUo=;
 b=TMnwmUwzlR24d8T5l5ZslFNpqju2y+on2wFq3ohxS/4WGzhUkSyAtPcJe6U64dIzbf7xuuG9YMb/uNlD1/nkZCVlnBFM9oVbB2sDmOtSD5E6lMcZl+7jn6yQ+hj34+A7KQZqrEl9+VBT8+RjEcnGtKhmUXM+5GXmHOrDhKXtaz0=
Received: from PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) by
 PH0PR02MB7160.namprd02.prod.outlook.com (2603:10b6:510:18::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Fri, 9 Jul 2021 08:48:57 +0000
Received: from PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e]) by PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e%9]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 08:48:57 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
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
Subject: RE: [RFC v2 2/4] fpga: Add new property to support user-key encrypted
 bitstream loading
Thread-Topic: [RFC v2 2/4] fpga: Add new property to support user-key
 encrypted bitstream loading
Thread-Index: AQHXXPOzdQUosgPS8USsZMcumKn6ZKsLcXWAgC8RSBA=
Date:   Fri, 9 Jul 2021 08:48:57 +0000
Message-ID: <PH0PR02MB7336638AB8792043260730FBC2189@PH0PR02MB7336.namprd02.prod.outlook.com>
References: <20210609055232.4501-1-nava.manne@xilinx.com>
 <20210609055232.4501-3-nava.manne@xilinx.com> <YMCQPeGE2gR6QD85@kroah.com>
In-Reply-To: <YMCQPeGE2gR6QD85@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3089f127-7ac7-4cf9-c2c7-08d942b663df
x-ms-traffictypediagnostic: PH0PR02MB7160:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR02MB7160037B38B4D709D14887ACC2189@PH0PR02MB7160.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HVaNjVurxleMIGFPuUyH1oqy7LReG0ppoCmYgsRVUPH4KHxz35J/l5eKKgPbjrBH7zljupV8lj4hHezbvN7tATCawYwOhgIiraTMybUip8t+AUw3VI3SSvUHtocfGWDeBsMeJGMw7evnatRcLqgouRbBmaCrPBC+q7MWmrtPut7h92bxXLRzL0YPC+B5xJ8paNYETaa10xIGulwQjEZPdR+eBvSgUnGs12mkd50L4FCuedspETWuJ1vxZ9J63qtvovlCJLTBiJcMlGhc5X6wqB0CmtrtLg+kWeFW4vho9BA/LcjH7d8fG7/GFJXxAJlhbtXBe465v0iv6X0iPNqGH0RPYiF9iD7Q6U32HuQbYpBcm8C2UPtFxPRn1Fq2lGFp16RI5lJnz0vGqew7A7nHRHDIbTeBxFgfw5AjJNJEGD9djOJiJe93nQ/PuYyD5MeA/K8pJ0RazQboDYRkWwBJcsLazK7IcgtvlU8XFMUwyAM7/1BYBk8eiSvEDIv0B6DXgBnYPOoOQsUXvTZQpKBdyRCenZBlOzek7Qy4bjUpWQeXfQXUCPbXE64Jn6BoeLTu3wNSFSBBe2eZ+ClQSbU/4II33nKesw/aKqJeLxbxpOUDsZgc+1Mr4z1pH0W3nqAl/1HbN+n+woea6gn6SwrZ9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7336.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(8676002)(54906003)(4326008)(478600001)(26005)(76116006)(8936002)(71200400001)(55016002)(86362001)(52536014)(9686003)(5660300002)(6916009)(66446008)(316002)(2906002)(122000001)(38100700002)(55236004)(83380400001)(33656002)(6506007)(186003)(7696005)(66556008)(64756008)(7416002)(53546011)(66946007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGxTYjVZZ3FJTmdhUzF5YU9vY1NWem9selVxWmhtMm5veWFoMmlRdWZXaGVV?=
 =?utf-8?B?eXRuajJ5VEZna2ZMbXNlU1Blb0FkZVlYTmtDSXh5aE5uUWZKOW10eUlHL0F5?=
 =?utf-8?B?RkMrYzJFWXhQZEFwSjVmMG0zWjNVWG9lUjFYZTdhWFpJYlJ2RFRabnVwMDhJ?=
 =?utf-8?B?N3Q2R1R6MUNHN1R4ditQN1dRdUxFRUhkZTdQZitEOFZjYkFNclE2bkpiU0NR?=
 =?utf-8?B?WHkxdG5QYnhGL3pERU1KTEhiMDc3SW5ZdHFzQUM0RkNabi9YdmJtRERadUxm?=
 =?utf-8?B?a3U4MnExdDV0MTVBVlppNmpNV3BBdi9rM1R3RXkwNDU0cTNQNm15dVBEdXgv?=
 =?utf-8?B?Vm10elI1MkxRQzVWbDFLUXdmc3hKd3krMWJId0hNanFsNkVPZFNqbnk4WndQ?=
 =?utf-8?B?bVU4MW5QQTZhMzVUNm9lRjI5YXVRSEM1dHZNU0hDQUpBUnZwVEh2V05TNTBN?=
 =?utf-8?B?L3BobFhMWVJubEx3TElERHMxSjZPRG5hSDRNcFgzSUtBNmRmdGlDWTR0blpH?=
 =?utf-8?B?bGxGZXgydTV5RkNiYklHWUhoZDZKY1g4N0FmWFZrZDFnbzZPYnRhV285cUla?=
 =?utf-8?B?eVVPaGhLdVdzeU0zR1pkb2QwelBhVldKUkpBUXNpOHBxMCtXMUxVUGdpUW1a?=
 =?utf-8?B?YmJkL016T2VMU2c0TUdWT3pGU2Zjb2tWMzBhR216NXN1QTJOM1ZDNUJvV2ll?=
 =?utf-8?B?djFBcFJSWmt2ZUZzR2dRM1VhcGM3MzhJcC9NcXNNOFFvdDNua3FKRjFiV05L?=
 =?utf-8?B?aWlMSFY2aGFkc1JzUVp2UWFpY3NsWFgrOTkxWlptTWtrd1pZUlNEN2I5Mldz?=
 =?utf-8?B?TEgrYzBreW9yaW1MOExScVVNM1BRRXFZdVV6SkZCQVN1aDJwS2tCeHNxRU9Y?=
 =?utf-8?B?SVN5SjJrckdmVnpPMTV2MWQ4NU43eXEwZ0JOeS93ZHpWUUo0Vm9TSTMrR3Bw?=
 =?utf-8?B?WXZka2JIUzNRQ3MxVHMwdi85c0wyK3BqTG5ETHdtNFlpbVhEd1oyTXlGSzA4?=
 =?utf-8?B?cncyRVdNRWtod3lEbEpTMy9hc0o3cUoxcnYxQVpaeWJTbWFrVmZtUGVPb1RF?=
 =?utf-8?B?ZVdYcExwV2w4elNJSEQvSUljcCswb2JHVDZCemtCallObndzWUlIeHltSkFk?=
 =?utf-8?B?eEFRZEgxMGVhWWNwWkRyMEJVbFIrN01OTUc5OVpiS2N5K2UwaFBJb1NRMUNX?=
 =?utf-8?B?TWNNVVY2c3hGNDQwakR0eXhTNEtFV0I5R0RaaEFaUmQ4OE04MFN4UEtJcHBU?=
 =?utf-8?B?V09FMENhYVRmc0JOM2s2ZzYvWVlvTUtqV05yczFtd2xrWHc3dXUwSEM3czI0?=
 =?utf-8?B?U3dQNG4zNkYvaWltQkxQdjBWVVMvbEtrMjRLKy9Rb0hUcStzdm5ENGlJZW40?=
 =?utf-8?B?ajFEUVZyQ1dxMWZ6czR5UGZ1ME5nRnZocWRPOU9vRlFUY01JZFRkT2h2UFI3?=
 =?utf-8?B?N1JtR0hTV1cxK1J2aHlSMmRnZFdGR1k3RFlxZjREaGlhMlFRNURMTHltS2px?=
 =?utf-8?B?cDErc3Q1cittaE5VeWJ3em9XRmhONU5Lb0YyZlNSRDR6M2xjWVE5SlM5KzhN?=
 =?utf-8?B?Yjc1YXozL0pMREdzQTkvVlBZbC94alBNeklIZVo4WDZkOExyUjhqUEJDL3A0?=
 =?utf-8?B?Z2NRS0lhMDZWYW1oRUllRU9HcFJMTG9TdGVwd2d3Zmp2MEVtSE91M1R4Nlov?=
 =?utf-8?B?WFpLY0xhby9HM2pyM0wyODZTUFVKWWRROG8wM01WdFVxd1FWbmtOSVZJTWFq?=
 =?utf-8?Q?pvit8f9ZjDGXIC5KKoAqt/BQ17ptNUPBU9o8foM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7336.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3089f127-7ac7-4cf9-c2c7-08d942b663df
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 08:48:57.1518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yHrG4pblr+2Qd3ornWRtO+9+AQXDe+4Ne531OZNM5kwHv9uq7JkLbckxTCgJZ5cddRV0w0YwGVnrHJNI8Jx+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7160
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgR3JlZywNCg0KCVRoYW5rcyBmb3IgcHJvdmlkaW5nIHRoZSByZXZpZXcgY29tbWVudHMuDQpQ
bGVhc2UgZmluZCBteSByZXNwb25zZSBpbmxpbmUuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgSnVuZSA5LCAyMDIxIDM6MjYgUE0NCj4gVG86IE5hdmEga2lzaG9yZSBN
YW5uZSA8bmF2YW1AeGlsaW54LmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgTWljaGFs
IFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+Ow0KPiBtZGZAa2VybmVsLm9yZzsgdHJpeEByZWRo
YXQuY29tOyBhcm5kQGFybmRiLmRlOyBSYWphbiBWYWphDQo+IDxSQUpBTlZAeGlsaW54LmNvbT47
IEFtaXQgU3VuaWwgRGhhbW5lIDxhbWl0c3VuaUB4bG54LnhpbGlueC5jb20+Ow0KPiBUZWphcyBQ
YXRlbCA8dGVqYXNwQHhsbngueGlsaW54LmNvbT47IHpvdV93ZWlAaHVhd2VpLmNvbTsgU2FpIEty
aXNobmENCj4gUG90dGh1cmkgPGxha3NobWlzQHhpbGlueC5jb20+OyBSYXZpIFBhdGVsIDxSQVZJ
UEFURUB4aWxpbnguY29tPjsNCj4gaXdhbWF0c3VAbmlnYXVyaS5vcmc7IEppYXlpbmcgTGlhbmcg
PGpsaWFuZ0B4aWxpbnguY29tPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWZwZ2FAdmdlci5rZXJuZWwub3JnOyBnaXQgPGdpdEB4aWxpbnguY29t
PjsNCj4gY2hpbm5pa2lzaG9yZTM2OUBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtSRkMgdjIg
Mi80XSBmcGdhOiBBZGQgbmV3IHByb3BlcnR5IHRvIHN1cHBvcnQgdXNlci1rZXkNCj4gZW5jcnlw
dGVkIGJpdHN0cmVhbSBsb2FkaW5nDQo+IA0KPiBPbiBXZWQsIEp1biAwOSwgMjAyMSBhdCAxMToy
MjozMEFNICswNTMwLCBOYXZhIGtpc2hvcmUgTWFubmUgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBB
ZGRzIOKAmGVuY3J5cHRlZC1rZXktbmFtZeKAmSBwcm9wZXJ0eSB0byBzdXBwb3J0IHVzZXIta2V5
DQo+ID4gZW5jcnlwdGVkIGJpdHN0cmVhbSBsb2FkaW5nIHVzZSBjYXNlLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogTmF2YSBraXNob3JlIE1hbm5lIDxuYXZhLm1hbm5lQHhpbGlueC5jb20+DQo+
ID4gLS0tDQo+ID4gQ2hhbmdlcyBmb3IgdjI6DQo+ID4gICAgICAgICAgICAgICAgIC1Cb3RoIERU
IHByb3BlcnRpZXMgaWU7IGVuY3J5cHRlZC1rZXktbmFtZSBhbmQgZW5jcnlwdGVkLXVzZXItDQo+
IGtleS1mcGdhLWNvbmZpZw0KPiA+ICAgICAgICAgICAgICAgICAgYXJlIHRhcmdldGVkIHRvIHVz
ZSBmb3IgdGhlIHNhbWUgdXNlIGNhc2VzIGJ1dCBpZGVhbGx5IGVuY3J5cHRlZC0NCj4ga2V5LW5h
bWUNCj4gPiAgICAgICAgICAgICAgICAgIGlzIGVub3VnaCB0byBzZXJ2ZSB0aGUgcHVycG9zZSBz
byB1cGRhdGVkIHRoZSBmaWxlIHRvIHJlbW92ZSB0aGUNCj4gdW53YW50ZWQNCj4gPiAgICAgICAg
ICAgICAgICAgIGVuY3J5cHRlZC11c2VyLWtleS1mcGdhLWNvbmZpZyBwcm9wZXJ0eSBhcyBzdWdn
ZXN0ZWQgYnkgUm9iLg0KPiA+DQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9mcGdhL2ZwZ2EtcmVnaW9uLnR4dCB8IDMgKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZnBnYS9mcGdhLXJlZ2lvbi50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9mcGdhL2ZwZ2EtcmVnaW9uLnR4dA0KPiA+IGluZGV4IGQ3ODdkNTc0
OTFhMS4uMGRlNGExYzU0NjUwIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9mcGdhL2ZwZ2EtcmVnaW9uLnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL2ZwZ2EtcmVnaW9uLnR4dA0KPiA+IEBAIC0xNzcs
NiArMTc3LDkgQEAgT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPiAgCWl0IGluZGljYXRlcyB0aGF0
IHRoZSBGUEdBIGhhcyBhbHJlYWR5IGJlZW4gcHJvZ3JhbW1lZCB3aXRoIHRoaXMNCj4gaW1hZ2Uu
DQo+ID4gIAlJZiB0aGlzIHByb3BlcnR5IGlzIGluIGFuIG92ZXJsYXkgdGFyZ2V0aW5nIGEgRlBH
QSByZWdpb24sIGl0IGlzIGENCj4gPiAgCXJlcXVlc3QgdG8gcHJvZ3JhbSB0aGUgRlBHQSB3aXRo
IHRoYXQgaW1hZ2UuDQo+ID4gKy0gZW5jcnlwdGVkLWtleS1uYW1lIDogc2hvdWxkIGNvbnRhaW4g
dGhlIG5hbWUgb2YgYW4gZW5jcnlwdGVkIGtleSBmaWxlDQo+IGxvY2F0ZWQNCj4gPiArCW9uIHRo
ZSBmaXJtd2FyZSBzZWFyY2ggcGF0aC4gSXQgd2lsbCBiZSB1c2VkIHRvIGRlY3J5cHQgdGhlIEZQ
R0ENCj4gaW1hZ2UNCj4gPiArCWZpbGUgd2l0aCB1c2VyLWtleS4NCj4gDQo+IFdoYXQgaXMgdGhl
IGZvcm1hdCB0aGlzICJ1c2VyLWtleSIgaXMgaW4/ICBXaGVyZSBpcyB0aGUgZG9jdW1lbnRhdGlv
biBmb3INCj4gaG93IHRvIHVzZSB0aGlzIHR5cGUgb2YgdGhpbmc/DQo+IA0KDQpXaWxsIGZpeCB1
c2VyIGtleSBmb3JtYXQgaXNzdWVzIGluIHYzLg0KDQpXaWxsIHVwZGF0ZSB0aGlzIGJpbmRpbmcg
ZG9jIHdpdGggdXNlciBrZXkgIGVuY3J5cHRlZCBiaXRzdHJlYW0gbG9hZGluZyB1c2UgY2FzZSBp
bmZvLg0KDQpVc2UgY2FzZSBpbmZvOg0KUmVjb25maWd1cmF0aW9uIHdpdGggZW5jcnlwdGVkIGlt
YWdlIHVzaW5nIEFFUyBrZXkNCiAgIEluIHRoaXMgY2FzZSwgdGhlIEZQR0EgTWFuYWdlciB3aWxs
IGRlY3J5cHQgdGhlIGNvbmZpZ3VyYXRpb24gZGF0YSBhbmQNCiAgIHBsYWNlZCBpdCBpbnRvIHRo
ZSBwcm9ncmFtbWFibGUgbG9naWMuIFRvIGRlY3J5cHQgdGhlIGNvbmZpZ3VyYXRpb24gZGF0YQ0K
ICAgaXQgdXNlcyBBRVMga2V5IHByb3ZpZGVkIGJ5IHRoZSB1c2VyLg0KDQpEVCBPdmVybGF5IGNv
bnRhaW5zOg0KL2R0cy12MS87DQovcGx1Z2luLzsNCg0KJmZwZ2FfcmVnaW9uMCB7DQogICAgICAg
ICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KICAgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCg0KICAg
ICAgICBmaXJtd2FyZS1uYW1lID0gInZlcnNhbC1ncGlvLmJpbiI7DQogICAgICAgIGVuY3J5cHRl
ZC1rZXktbmFtZSA9IOKAnEFlcy1rZXkubmt54oCdDQoNCiAgICAgICAgZ3BpbzE6IGdwaW9ANDAw
MDAwMDAgew0KICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAieGxueCx4cHMtZ3Bpby0xLjAw
LmEiOw0KICAgICAgICAgICAgICAgIHJlZyA9IDwweDQwMDAwMDAwIDB4MTAwMDA+Ow0KICAgICAg
ICAgICAgICAgIGdwaW8tY29udHJvbGxlcjsNCiAgICAgICAgICAgICAgICAjZ3Bpby1jZWxscyA9
IDwweDI+Ow0KICAgICAgICAgICAgICAgIHhsbngsZ3Bpby13aWR0aD0gPDB4Nj47DQogICAgICAg
IH07DQp9Ow0KDQpSZWdhcmRzLA0KTmF2YWtpc2hvcmUuDQoNCg0KDQo=
