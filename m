Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDAC150D46
	for <lists+linux-fpga@lfdr.de>; Mon, 24 Jun 2019 16:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfFXOIf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 24 Jun 2019 10:08:35 -0400
Received: from mail-eopbgr10126.outbound.protection.outlook.com ([40.107.1.126]:59703
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725562AbfFXOIf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 24 Jun 2019 10:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roLeey6sLYOWB452lKz7QVsZlbn5CO1EhRed5UBnmtk=;
 b=qimuzTLhE5UKkckIFsgxZvvO0Bu/NxMMjxcDKun+VZ+BMOogJwhoNy7gWj7vMJrnCh1veU2OaaeKu6C2iqllRowyLo1pFwNSGhY5zumG7t72ik2dWbhhuG9PtugPi0r+ErPzC04o31oMT6VxIkJqY2tHTV8ZrChY6qgnH2Uugvo=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3401.eurprd02.prod.outlook.com (52.134.73.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 14:07:50 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::29c5:d1ae:8855:3153]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::29c5:d1ae:8855:3153%3]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 14:07:50 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "atull@kernel.org" <atull@kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "jslaby@suse.com" <jslaby@suse.com>
Subject: Re: [PATCH v2 13/28] drivers: Introduce
 class_find_device_by_of_node() helper
Thread-Topic: [PATCH v2 13/28] drivers: Introduce
 class_find_device_by_of_node() helper
Thread-Index: AQHVItpTYJEjQBlMB0GJ7sFY1WhfUKanUbUAgAM37ACAAF0PAA==
Date:   Mon, 24 Jun 2019 14:07:50 +0000
Message-ID: <528dcb2e-3611-00a7-abb2-cc18001f4f8f@axentia.se>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-14-git-send-email-suzuki.poulose@arm.com>
 <325e46fd-a480-78ed-81fd-55e993fbc06f@axentia.se>
 <5cf1a8e2-bb1e-b6bc-32fe-93db0a6b5efd@arm.com>
In-Reply-To: <5cf1a8e2-bb1e-b6bc-32fe-93db0a6b5efd@arm.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:7:67::34) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f90e74f5-d6ca-4396-c533-08d6f8ad57c7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3401;
x-ms-traffictypediagnostic: DB3PR0202MB3401:
x-microsoft-antispam-prvs: <DB3PR0202MB34011A231A599ACFF2460F7CBCE00@DB3PR0202MB3401.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39830400003)(376002)(366004)(346002)(136003)(189003)(199004)(81156014)(7416002)(6246003)(68736007)(229853002)(26005)(81166006)(316002)(54906003)(110136005)(8676002)(25786009)(58126008)(2906002)(99286004)(86362001)(3846002)(31696002)(102836004)(386003)(256004)(53546011)(6506007)(53936002)(486006)(4326008)(446003)(65806001)(65956001)(2616005)(476003)(14454004)(74482002)(11346002)(31686004)(66066001)(6486002)(36756003)(6116002)(6436002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(7736002)(305945005)(76176011)(71190400001)(71200400001)(64126003)(186003)(65826007)(2501003)(52116002)(8936002)(508600001)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3401;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xQAsXOTqbwmbZKVfxVpNEZcHaRw6yV5hwMgr4lj3pGuqU61W9fKi6OgfJA9N5ykHtgtWdzGzAazF4bl1mRhlGO/qmRJDZyb+NI4+9y8orvr8N6vTczR6uLa1dgUh6sZzhxK6E+IidWqTlz80eBd75ZWHIdbj8pUQ5Ymbs5fKEDQlfBvdM8TbQYsE4/CjAjeuW8LHOZsoswbQrwcOnPejWdJQ2Jov6d7lS9EOEhTdP9qp+LD7ETzyz4ESRDkcivTtD4R3U7tAG/ey8CoeHGIhMA5OjFobTdRewKQpocMmsrIn/uLDkXntxdPBKRfm0o9vy2gvNwKtIZwsU7xhZWxQyzut4MVpIu4y/j+WFjy28F1t+u6y190KEzTDZ64zFug9DVJW8l0/GduTl4A972aatEFgNDfBFEGZzflFpn2Wh+c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72F156B1EDA57447A18381C603F9D997@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f90e74f5-d6ca-4396-c533-08d6f8ad57c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 14:07:50.7383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peda@axentia.se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3401
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T24gMjAxOS0wNi0yNCAxMDozNCwgU3V6dWtpIEsgUG91bG9zZSB3cm90ZToNCj4gSGkgUGV0ZXIs
DQo+IA0KPiBPbiAyMi8wNi8yMDE5IDA2OjI1LCBQZXRlciBSb3NpbiB3cm90ZToNCj4+IE9uIDIw
MTktMDYtMTQgMTk6NTQsIFN1enVraSBLIFBvdWxvc2Ugd3JvdGU6DQo+Pj4gQWRkIGEgd3JhcHBl
ciB0byBjbGFzc19maW5kX2RldmljZSgpIHRvIHNlYXJjaCBmb3IgYSBkZXZpY2UNCj4+PiBieSB0
aGUgb2Zfbm9kZSBwb2ludGVyLCByZXVzaW5nIHRoZSBnZW5lcmljIG1hdGNoIGZ1bmN0aW9uLg0K
Pj4+IEFsc28gY29udmVydCB0aGUgZXhpc3RpbmcgdXNlcnMgdG8gbWFrZSB1c2Ugb2YgdGhlIG5l
dyBoZWxwZXIuDQo+Pj4NCj4+PiBDYzogQWxhbiBUdWxsIDxhdHVsbEBrZXJuZWwub3JnPg0KPj4+
IENjOiBNb3JpdHogRmlzY2hlciA8bWRmQGtlcm5lbC5vcmc+DQo+Pj4gQ2M6IGxpbnV4LWZwZ2FA
dmdlci5rZXJuZWwub3JnDQo+Pj4gQ2M6IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+DQo+
Pj4gQ2M6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCj4+PiBDYzogRmxvcmlhbiBG
YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQo+Pj4gQ2M6IEhlaW5lciBLYWxsd2VpdCA8
aGthbGx3ZWl0MUBnbWFpbC5jb20+DQo+Pj4gQ2M6ICJEYXZpZCBTLiBNaWxsZXIiIDxkYXZlbUBk
YXZlbWxvZnQubmV0Pg0KPj4+IENjOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+Pj4g
Q2M6IExpYW0gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+DQo+Pj4gQ2M6IEdyZWcgS3Jv
YWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+Pj4gQ2M6ICJSYWZhZWwg
Si4gV3lzb2NraSIgPHJhZmFlbEBrZXJuZWwub3JnPg0KPj4+IENjOiBKaXJpIFNsYWJ5IDxqc2xh
YnlAc3VzZS5jb20+DQo+Pj4gQWNrZWQtYnk6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9y
Zz4NCj4+PiBSZXZpZXdlZC1ieTogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KPj4+IFJl
dmlld2VkLWJ5OiBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPg0KPj4NCj4+IFdob29vYSEg
SSByZXZpZXdlZCBvbmx5IHRoZSBkcml2ZXJzL211eC9jb3JlLmMgY2hhbmdlcyB3aGVuIHRoaXMg
d2FzIGRvbmUNCj4+IGluIGEgc2VyaWVzIG9mIG11Y2ggc21hbGxlciBwYXRjaGVzLiBUaGlzIHRh
ZyBtYWtlcyBpdCBzZWVtIGFzIGlmIEkgaGF2ZQ0KPj4gcmV2aWV3ZWQgdGhlIHdob2xlIHRoaW5n
LCB3aGljaCBJIGhhZCBub3QgZG9uZSB3aGVuIHlvdSBhZGRlZCB0aGlzIHRhZyBvdXQNCj4+IG9m
IHRoZSBibHVlLg0KPiANCj4gQXBvbG9naWVzIGZvciB0aGUgc3VycHJpc2UuIFRoZSBwYXRjaCB3
YXMgc2ltcGx5IHNxdWFzaGVkIHdpdGggdGhlIGNoYW5nZSB0aGF0DQo+IGludHJvZHVjZWQgdGhl
ICJoZWxwZXIiIHRvIGJldHRlciBhaWQgdGhlIHJldmlld2VycywgYmFzZWQgb24gc3VnZ2VzdGlv
bnMgb24gdGhlDQo+IGxpc3QuIEkga2VwdCB5b3VyIHRhZ3MsIG9ubHkgYmVjYXVzZSB0aGVyZSB3
ZXJlIG5vIGNoYW5nZXMsIGJ1dCBzb21lIGFkZGl0aW9uYWwNCj4gY29udGV4dCBvbiB0aGUgY29y
ZSBkcml2ZXIuDQoNCllvdSBjb3VsZCBlLmcuIGhhdmUgd3JpdHRlbjoNCg0KCS4uLg0KCVtGb3Ig
dGhlIGRyaXZlcnMvbXV4L2NvcmUuYyBwYXJ0XQ0KCVJldmlld2VkLWJ5OiBQZXRlciBSb3NpbiA8
cGVkYUBheGVudGlhLnNlPg0KCS4uLg0KDQo+Pg0KPj4gTm93LCB0aGlzIHN0dWZmIGlzIHRyaXZp
YWwgYW5kIGJ5IG5vdyBJIGhhdmUgbG9va2VkIGF0IHRoZSBvdGhlciBmaWxlcw0KPj4gYW5kIGl0
IGFsbCBzZWVtcyBzaW1wbGUgZW5vdWdoLiBTbywgeW91IGNhbiBrZWVwIHRoZSB0YWcsIGJ1dCBp
dCBpcyBOT1QNCj4+IG9rIHRvIGhhbmRsZSB0YWdzIGxpa2UgeW91IGhhdmUgZG9uZSBoZXJlLg0K
PiANCj4gU3VyZSwgSSB3aWxsIGtlZXAgdGhhdCBpbiBtaW5kLg0KDQpHcmVhdCENCg0KQ2hlZXJz
LA0KUGV0ZXINCg==
