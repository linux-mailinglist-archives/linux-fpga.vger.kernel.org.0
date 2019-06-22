Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F9E4F3D7
	for <lists+linux-fpga@lfdr.de>; Sat, 22 Jun 2019 07:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfFVF0A (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 22 Jun 2019 01:26:00 -0400
Received: from mail-eopbgr30125.outbound.protection.outlook.com ([40.107.3.125]:41647
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbfFVFZ7 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 22 Jun 2019 01:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32wnNkw7gbxeyA/7yXc8NQjKn5VCXdVIE4VgPB1NjOQ=;
 b=qO3usaG5AjyNUxcaRBjIjT60X0DIepVfA8L6GgJJC7t9OsGKd6zYO7kS7VYSGZ1s2+eds/oWZnWYJVuWQx6h4059/jkQd/gMpO8lzzYVJygJYpvukaU/rlrt55e14MhI6SYqqZznAEgcca/ljvxxxfRgAKRCrtxgYfFI1D7Sdvg=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3435.eurprd02.prod.outlook.com (52.134.65.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Sat, 22 Jun 2019 05:25:54 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf%5]) with mapi id 15.20.1987.014; Sat, 22 Jun 2019
 05:25:54 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v2 13/28] drivers: Introduce
 class_find_device_by_of_node() helper
Thread-Topic: [PATCH v2 13/28] drivers: Introduce
 class_find_device_by_of_node() helper
Thread-Index: AQHVItpTYJEjQBlMB0GJ7sFY1WhfUKanMC4A
Date:   Sat, 22 Jun 2019 05:25:54 +0000
Message-ID: <325e46fd-a480-78ed-81fd-55e993fbc06f@axentia.se>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-14-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1560534863-15115-14-git-send-email-suzuki.poulose@arm.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0902CA0002.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::12) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8575a67-eb67-4308-802a-08d6f6d218e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3435;
x-ms-traffictypediagnostic: DB3PR0202MB3435:
x-microsoft-antispam-prvs: <DB3PR0202MB343555CF2184E7784AD47CA4BCE60@DB3PR0202MB3435.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0076F48C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39830400003)(199004)(189003)(26005)(186003)(64756008)(66476007)(66446008)(66556008)(65956001)(66066001)(508600001)(7736002)(65806001)(66946007)(476003)(81166006)(256004)(71190400001)(74482002)(305945005)(71200400001)(81156014)(446003)(5660300002)(73956011)(14454004)(31686004)(8936002)(68736007)(486006)(11346002)(8676002)(2616005)(2906002)(110136005)(65826007)(86362001)(229853002)(316002)(6246003)(54906003)(58126008)(64126003)(6486002)(31696002)(52116002)(53936002)(2501003)(99286004)(36756003)(25786009)(4326008)(6116002)(102836004)(7416002)(76176011)(6512007)(386003)(6506007)(53546011)(3846002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3435;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zl9nFeLPNU5i+NEdHUYXGicvNuEwdrVCoV2STaMiNxE5dAeInW+s6GIHTkMduBk+BG/13uPW+LkkMz+f3S3S9PvWUQRTEUH4YhVJ3ZKDuqAkEB8S2xFS16JS8+PYy8yV4R80OVTMxctT9iHBfDQ8nZYUPt92/7MOdxDA95yC1ONAz8JenkFlfNMhee1iFTZYVwVhDCiZZE+yAqMMZ0N80VyJqGgWzyGUrqt5n7yJyrDynKzk1sRhRqsFjRkzvp+a0ps7Xk2sDYZDeAHFJrjSJY9moDlZUi85WFLZxd3CftludPd15eU1zapVjyPUMEEPIzu5qH44bixmWkRTJ1xQnPXk+NGF4sV1NyssaxANRHEHF5P7gXCPCBtRAT0sUTY9FjOUswuYFJmvfwyWuJ84FD6qQGMWTn+NOHetk+ClVWQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DFDE098696CA146A51B62B2EAEDE154@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b8575a67-eb67-4308-802a-08d6f6d218e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2019 05:25:54.3268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peda@axentia.se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3435
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T24gMjAxOS0wNi0xNCAxOTo1NCwgU3V6dWtpIEsgUG91bG9zZSB3cm90ZToNCj4gQWRkIGEgd3Jh
cHBlciB0byBjbGFzc19maW5kX2RldmljZSgpIHRvIHNlYXJjaCBmb3IgYSBkZXZpY2UNCj4gYnkg
dGhlIG9mX25vZGUgcG9pbnRlciwgcmV1c2luZyB0aGUgZ2VuZXJpYyBtYXRjaCBmdW5jdGlvbi4N
Cj4gQWxzbyBjb252ZXJ0IHRoZSBleGlzdGluZyB1c2VycyB0byBtYWtlIHVzZSBvZiB0aGUgbmV3
IGhlbHBlci4NCj4gDQo+IENjOiBBbGFuIFR1bGwgPGF0dWxsQGtlcm5lbC5vcmc+DQo+IENjOiBN
b3JpdHogRmlzY2hlciA8bWRmQGtlcm5lbC5vcmc+DQo+IENjOiBsaW51eC1mcGdhQHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRpYS5zZT4NCj4gQ2M6IE1hcmsg
QnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCj4gQ2M6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFp
bmVsbGlAZ21haWwuY29tPg0KPiBDYzogSGVpbmVyIEthbGx3ZWl0IDxoa2FsbHdlaXQxQGdtYWls
LmNvbT4NCj4gQ2M6ICJEYXZpZCBTLiBNaWxsZXIiIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KPiBD
YzogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KPiBDYzogTGlhbSBHaXJkd29vZCA8bGdp
cmR3b29kQGdtYWlsLmNvbT4NCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+DQo+IENjOiAiUmFmYWVsIEouIFd5c29ja2kiIDxyYWZhZWxAa2VybmVs
Lm9yZz4NCj4gQ2M6IEppcmkgU2xhYnkgPGpzbGFieUBzdXNlLmNvbT4NCj4gQWNrZWQtYnk6IE1h
cmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IEFuZHJldyBMdW5u
IDxhbmRyZXdAbHVubi5jaD4NCj4gUmV2aWV3ZWQtYnk6IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50
aWEuc2U+DQoNCldob29vYSEgSSByZXZpZXdlZCBvbmx5IHRoZSBkcml2ZXJzL211eC9jb3JlLmMg
Y2hhbmdlcyB3aGVuIHRoaXMgd2FzIGRvbmUNCmluIGEgc2VyaWVzIG9mIG11Y2ggc21hbGxlciBw
YXRjaGVzLiBUaGlzIHRhZyBtYWtlcyBpdCBzZWVtIGFzIGlmIEkgaGF2ZQ0KcmV2aWV3ZWQgdGhl
IHdob2xlIHRoaW5nLCB3aGljaCBJIGhhZCBub3QgZG9uZSB3aGVuIHlvdSBhZGRlZCB0aGlzIHRh
ZyBvdXQNCm9mIHRoZSBibHVlLg0KDQpOb3csIHRoaXMgc3R1ZmYgaXMgdHJpdmlhbCBhbmQgYnkg
bm93IEkgaGF2ZSBsb29rZWQgYXQgdGhlIG90aGVyIGZpbGVzDQphbmQgaXQgYWxsIHNlZW1zIHNp
bXBsZSBlbm91Z2guIFNvLCB5b3UgY2FuIGtlZXAgdGhlIHRhZywgYnV0IGl0IGlzIE5PVA0Kb2sg
dG8gaGFuZGxlIHRhZ3MgbGlrZSB5b3UgaGF2ZSBkb25lIGhlcmUuDQoNCkNoZWVycywNClBldGVy
DQoNCj4gU2lnbmVkLW9mZi1ieTogU3V6dWtpIEsgUG91bG9zZSA8c3V6dWtpLnBvdWxvc2VAYXJt
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2ZwZ2EvZnBnYS1icmlkZ2UuYyAgICAgICB8ICA4ICst
LS0tLS0tDQo+ICBkcml2ZXJzL2ZwZ2EvZnBnYS1tZ3IuYyAgICAgICAgICB8ICA4ICstLS0tLS0t
DQo+ICBkcml2ZXJzL211eC9jb3JlLmMgICAgICAgICAgICAgICB8ICA3ICstLS0tLS0NCj4gIGRy
aXZlcnMvbmV0L3BoeS9tZGlvX2J1cy5jICAgICAgIHwgIDkgKy0tLS0tLS0tDQo+ICBkcml2ZXJz
L3JlZ3VsYXRvci9vZl9yZWd1bGF0b3IuYyB8ICA3ICstLS0tLS0NCj4gIGRyaXZlcnMvc3BpL3Nw
aS5jICAgICAgICAgICAgICAgIHwgMTEgKystLS0tLS0tLS0NCj4gIGluY2x1ZGUvbGludXgvZGV2
aWNlLmggICAgICAgICAgIHwgMTIgKysrKysrKysrKysrDQo+ICA3IGZpbGVzIGNoYW5nZWQsIDE5
IGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQ0K
