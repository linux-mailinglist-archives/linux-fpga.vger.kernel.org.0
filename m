Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21FD4C1F7C
	for <lists+linux-fpga@lfdr.de>; Mon, 30 Sep 2019 12:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfI3KrP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 Sep 2019 06:47:15 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:42810 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729415AbfI3KrP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 30 Sep 2019 06:47:15 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8UAgq1S007688;
        Mon, 30 Sep 2019 06:46:39 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2052.outbound.protection.outlook.com [104.47.37.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2va45687b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 06:46:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ww6JQuf67JX5XG6H/p102zYAHKciIkViQ3AHVLaamOybUhf8D7ZPqszb4ZewYOVPyqcv/ODccRO3KVPJ+9BFocf3bW+Y6wnrziFN2UXI2adWLDX6PhjLkKzqfY6IyW3DPjXQiYRfnCrlpUZaUjGcE8DzgAZ7oeZtahFaTdz1Ybjm27ERuAY9G0BvOA9I+3pBl8E5lpr2WUZUCPPEtCDYBirzqB9lwNgrnKQg9Nt2Xb1tCncJS7/3bUr7WuVqCMTLET3ruZvHCTdbuyVBV1L7b536BzBFZA8Z/w9M0XyGOAMh2a/Q6F82abDIrUVdkWWtBPQI/xvepaBsidXDjJYohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXk6ntfmIMZBycn70rrl/hUIe+TaIrIoble5++UOWaM=;
 b=hClUKFCNgmffVY9Sim8Jc91gT6wfXsz3RQe6LpFt7ah3gKbsbOITWcdEkiVt/f48rvop88OcBsKkrL+h9Bq1xto0r7Y8atS5zZzXgH81PMq6LnkYhwtDC36rH2Qb7KMgRqczu2Zkh9tWX5+fsMllRsr9KPV+Ch2raAw5MZtPae9pM5fLPebMgfMhphu4TY20zF7spujmvJBpW/ntuoFkk/GNNXpoikQ5kLvMxRG/eQcwzjVT9V8c4rlVUE+yF1agKKwfi/78FZqxF0KFbC9KwmATbDdOX06gz4n2veCD1277f8HdkWWP35cG0qG0sIRM4FoyOKyJcZhH6OP/fwaqDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXk6ntfmIMZBycn70rrl/hUIe+TaIrIoble5++UOWaM=;
 b=GzG/AoNJtFGsSuvc0grubjF5BfGZjhfz3dA5/NLVpXu3zlpc+joEgLi7nsoYCZG27/h1z/i/Mli6gg336SQickCGDqirRcqSXUMn8g5fuwLkKPug2CiyPqEP2S5MKlN4dS6RP8825n1KFDv+p+HAPcy6OUYAse3/Eg7cd5Rzqkw=
Received: from MN2PR03MB5117.namprd03.prod.outlook.com (52.132.171.137) by
 MN2PR03MB4767.namprd03.prod.outlook.com (20.179.82.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Mon, 30 Sep 2019 10:46:38 +0000
Received: from MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::6006:4c13:a8c1:b359]) by MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::6006:4c13:a8c1:b359%4]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 10:46:38 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "mdf@kernel.org" <mdf@kernel.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] include: fpga: adi-axi-common: Define version macros
Thread-Topic: [PATCH 1/3] include: fpga: adi-axi-common: Define version macros
Thread-Index: AQHVdFa0HR2mJl1T3EiTnh5+BsWwSqc/oCIAgARv+oA=
Date:   Mon, 30 Sep 2019 10:46:38 +0000
Message-ID: <a9f4640768627fc17ff220996afd6d4b63de2505.camel@analog.com>
References: <20190926103925.194973-1-nuno.sa@analog.com>
         <20190926103925.194973-2-nuno.sa@analog.com>
         <20190927150114.GA2146@archbox>
In-Reply-To: <20190927150114.GA2146@archbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7032890a-22bf-4b30-791a-08d7459378a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR03MB4767;
x-ms-traffictypediagnostic: MN2PR03MB4767:
x-microsoft-antispam-prvs: <MN2PR03MB47676941D9AEA7E5BE53412E99820@MN2PR03MB4767.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(376002)(346002)(396003)(189003)(199004)(118296001)(66946007)(66066001)(91956017)(2351001)(14454004)(4326008)(446003)(186003)(5660300002)(2501003)(64756008)(66556008)(3846002)(6116002)(66476007)(66446008)(76116006)(305945005)(102836004)(6916009)(26005)(316002)(7736002)(11346002)(229853002)(71200400001)(6486002)(8676002)(5640700003)(36756003)(99286004)(486006)(25786009)(76176011)(6436002)(6506007)(478600001)(256004)(81156014)(81166006)(86362001)(6512007)(2616005)(476003)(54906003)(2906002)(1730700003)(8936002)(6246003)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4767;H:MN2PR03MB5117.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K7xZaq1A8mkjxqCUHUydSZOSVWyhykAla4ys6gaXyQUCXn9jdjVQDK7cX5RjwfCvHjvUSSt07oSmU6GFjUld+fhJ9QKVAucGVx4Y2VOcpMOFIGD6IiURYB5cpPMVhKLHfA2cAP4C2bJNelEyG1Zr44g8Kc3lZllV5UiZsij9KmTSU5IGc+MlFV71DmOW4hBXXLNmjmP5s7lTfgDm13kIFwMOee5PKg124XM74U9y+n9RGFm2yfpPkQLlStIs4zIkKHdJGgmbperNB9LcvP+Go2120zmqI7gGElE9wRKtbI4l5Hueuf5RG44x9A7oC6a7KMCyDSnOuPKclGL4w9sBGWV5drVWdMcgR3Ptb2QObJov9NS6ZY3y1Uq/0aZce5INZgNQTHahrurt+MWhAJ8c3X5odujlHtTj1qpUkDkRQEY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A5239448FFA24429C1EE1EBC1387637@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7032890a-22bf-4b30-791a-08d7459378a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 10:46:38.2083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBpE2E0fX0LeWbbAKllRXFAddkiHWz0wCCBhMhsPbZXUYLbfpMmWq6xQJoTy2ZTq4BlBjhH+VAP0Rg3iaOptew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4767
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_07:2019-09-25,2019-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909300116
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgTW9yaXR6LA0KDQpPbiBGcmksIDIwMTktMDktMjcgYXQgMDg6MDEgLTA3MDAsIE1vcml0eiBG
aXNjaGVyIHdyb3RlOg0KPiANCj4gSGkgTnVubywNCj4gDQo+IE9uIFRodSwgU2VwIDI2LCAyMDE5
IGF0IDEyOjM5OjIzUE0gKzAyMDAsIE51bm8gU8OhIHdyb3RlOg0KPiA+IEFkZCBjb21tb20gbWFj
cm9zIHRvICJwYXJzZSIgQURJIEhETCBjb3JlcyB2ZXJzaW9uLCBpbiB0ZXJtcyBvZg0KPiA+IG1h
am9yLCBtaW5vciBhbmQgcGF0Y2guDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTnVubyBTw6Eg
PG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9saW51eC9mcGdhL2Fk
aS1heGktY29tbW9uLmggfCA0ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ZwZ2EvYWRpLWF4aS1j
b21tb24uaA0KPiA+IGIvaW5jbHVkZS9saW51eC9mcGdhL2FkaS1heGktY29tbW9uLmgNCj4gPiBp
bmRleCA3ZmM5NWQ1Yzk1YmIuLjViYzU2MDNlNmJjOCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L2ZwZ2EvYWRpLWF4aS1jb21tb24uaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvZnBn
YS9hZGktYXhpLWNvbW1vbi5oDQo+ID4gQEAgLTE2LDQgKzE2LDggQEANCj4gPiAgI2RlZmluZSBB
RElfQVhJX1BDT1JFX1ZFUihtYWpvciwgbWlub3IsIHBhdGNoKQlcDQo+ID4gIAkoKChtYWpvcikg
PDwgMTYpIHwgKChtaW5vcikgPDwgOCkgfCAocGF0Y2gpKQ0KPiA+ICANCj4gPiArI2RlZmluZSBB
RElfQVhJX1BDT1JFX1ZFUl9NQUpPUih2ZXJzaW9uKQkoKCh2ZXJzaW9uKSA+PiAxNikgJg0KPiA+
IDB4ZmYpDQo+ID4gKyNkZWZpbmUgQURJX0FYSV9QQ09SRV9WRVJfTUlOT1IodmVyc2lvbikJKCgo
dmVyc2lvbikgPj4gOCkgJg0KPiA+IDB4ZmYpDQo+ID4gKyNkZWZpbmUgQURJX0FYSV9QQ09SRV9W
RVJfUEFUQ0godmVyc2lvbikJKCh2ZXJzaW9uKSAmIDB4ZmYpDQo+ID4gKw0KPiA+ICAjZW5kaWYg
LyogQURJX0FYSV9DT01NT05fSF8gKi8NCj4gPiAtLSANCj4gPiAyLjIzLjANCj4gPiANCj4gDQo+
IFdoaWxlIGltcGxlbWVudGVkIGluIGFuIEZQR0EgSSdtIG5vdCBzdXJlIGlmIHRoaXMgbmVlZHMg
dG8gZ28gaW50bw0KPiBpbmNsdWRlbGludXgvZnBnYS8uDQo+IA0KPiBJJ2Qgc3VnZ2VzdCB0byBh
ZGQgdGhpcyB0byB0aGUgYWN0dWFsIGRyaXZlciBmb3Igbm93LCBhbmQgb25jZSB5b3UNCj4gaGF2
ZQ0KPiBtdWx0aXBsZSB1c2VycyB5b3UgY2FuIGZpbmQgYSBjb21tb24gbG9jYXRpb24uDQoNCldp
bGwgZG8gdGhhdC4NCg0KPiBDaGVlcnMsDQo+IE1vcml0eg0KDQpUaGFua3MhDQpOdW5vIFPDoQ0K
DQo=
