Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439A42FB17A
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Jan 2021 07:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbhASGXj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Jan 2021 01:23:39 -0500
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com ([40.107.93.87]:60257
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbhASGKy (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 19 Jan 2021 01:10:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpHGXztC7RGelVIqmpDrYrlVFLpflemKsVlR34b2Q6rInMmP4zvpsF58bdTAXMABBcRTwB1XcvxuKJrc1/lGM2Th+h6JBiSG9n/LqCEXwz/LAEEHvuMyI4GTlOHqnk65Y/l18IO7gI42hVPS4X0bsjymPhOwsXx1bLktG8T0dlXErfnAOhPEb6m6fMXT9JWuLvj50yUNsfWTskS2sk4AwRPrZlJfkGN/3UG1XM7c06lWessr1ewdMrmkuxsZ1WA1w5DZ2zynMaPrtkT4B5zAFKzgzsdGtlZgEjnc68rocNFitVar1V/NNUN/RPyB8j4BEMmR3olvxPAbK1k9ADkQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu7G/xjs1kk0Pe9M1zpMZlrx69WG3S99/ERGl1LsCV0=;
 b=OdmLrFx1Fv39GM8GO4SXBeAou7GwnsCWO44bke+Z9yqcOprYE+pyU0b+T00eIO9+1g148BzdI1mgWVbP2K2wjYogWUa79vcGi1fvXSwOp8J8b79x/WUwczJb02hkLAr8nQI9Yq6vuMBVkRGJfGyTSuSC3l7ucpQP0COSwKGO0jYlLQrINNH2k1auDKSH1i4fkYa8ht0ougHrMRLytrfzi/zA8BO+Y5PtxTqyN9Rp3JOhU2PWdv5r2mTulhNA/mDhEUoW5/XoSCR+YItt3/6S0Q94Dti2Uh98xrCAFuDN1zP8+xQDsrpfK7RrzYqe6ts0IGVuYa4ORSlDh0RmPUYKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu7G/xjs1kk0Pe9M1zpMZlrx69WG3S99/ERGl1LsCV0=;
 b=dJiKQPH/KlvMunlMqWW7zEbMo/x2/pyqWG1nRNduiMAdI8wrW335TAlJ634uRC0kK0huzdl3fVkqpb1DTyNJ7ibjqn0/HfR2F+WWZJGRFQVitdBU9tBO8itsgPoQsTUlBMfy781Jf8t+WWGReNnuYBZlHmGlzyqfXzhyMhQ5g38=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2784.namprd02.prod.outlook.com (10.175.50.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.13; Tue, 19 Jan 2021 06:09:46 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942%3]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 06:09:45 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [PATCH 1/2] dt-bindings: fpga: Add compatible value for Xilinx
 DFX AXI shutdown manger
Thread-Topic: [PATCH 1/2] dt-bindings: fpga: Add compatible value for Xilinx
 DFX AXI shutdown manger
Thread-Index: AQHW6t9yszH9lixsOUGOAqVWb+KMMqoo/M+AgAV9zRA=
Date:   Tue, 19 Jan 2021 06:09:45 +0000
Message-ID: <MWHPR02MB26230314CDC7179841CDC585C2A30@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210115013431.27667-1-nava.manne@xilinx.com>
 <2dd1a504-9bb7-3bdb-028e-7edd0ed99668@redhat.com>
In-Reply-To: <2dd1a504-9bb7-3bdb-028e-7edd0ed99668@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f987faeb-212d-41d3-5b49-08d8bc40d1e8
x-ms-traffictypediagnostic: MWHPR02MB2784:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB27844AF8C4CCC7496F0D0090C2A30@MWHPR02MB2784.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5IVzzdTx/9o7cXA0WSJ3NzyoIlUwN2Hso6GPLasmIr3y8FOO2n1rFYTfD8yiQD7kYfVSwvE0KIpWwJ53nU5N3cCxRm037v+ImARBq+71hK374NrKwOtHCrQKBmxBA0t981/grK4QfkrD6CAir5l0yER0LAJavQvFyUlKX+gq5K23D3MnsD9FoLdCD7fpFaNhYLC4vkk7dshxbZSVTuPCSxSj5XNKqti/HgOxpDPYK/nDmYWBo63ye6Ikv8OIivJdfn3hcOwO0j9f1M7FGwRROPfwU/VULhgq+Ho8OY1yeL1N3ituOhF2Lg0Tzv01TVv4pr8/hfEz8Oy5m7tk39QkqcfmZOO2+Zt6nJYidT4XvfWPOJkIaN3uAYKZTaTN7sCFlPaVh8g6bM+XZ/tZ6ZLLpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(110136005)(66446008)(52536014)(8936002)(66946007)(55016002)(66476007)(5660300002)(478600001)(53546011)(316002)(8676002)(64756008)(76116006)(26005)(186003)(66556008)(6506007)(2906002)(71200400001)(33656002)(83380400001)(7696005)(9686003)(86362001)(54906003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?K0JGRHNaZGIreWEzcXhKeFRoUGg4bjZHZkc0Q1RxbGMvTzZnNE5mZkpiT0xL?=
 =?utf-8?B?K0RIWXhEMkV0M3g0bmRBcGI2bXFMNngwaTdOeU5oV2FqLzFaU1NuSUFEdVNS?=
 =?utf-8?B?dlVKVUNjWGxHTVF3ZGVHdTJkU3ZwcmdTUjhZY1RDQjdkN0tuNzNiVXFlcVlF?=
 =?utf-8?B?aUJMTThuYk1xVktmSEVVQ2s4amVBcTFxL0p4V1JkbnlKUFJwZ3QwRGNSSUov?=
 =?utf-8?B?U1dhTVV4RmtYbUs4T2lXU21hZEoxN0lhK2RjMXFYVzV3bkoxbWZwRFRNM05H?=
 =?utf-8?B?MGdUZDFEU1hScFZsUHR4NTdOWTBqeXNkYldtVVJRbUYxRDIyZVlyVHlRY2lk?=
 =?utf-8?B?SUEza1pIK0hqODBRaTB0Ylo3RVdtazIwWitzMDFlcWY0QU1Nd2dtZ2x4Wm14?=
 =?utf-8?B?WldzVHhYbU1pVWtVWmx2NlV3NXFpd2JQNys2ZHpzVEN5Q1YveVF1WnFWQklp?=
 =?utf-8?B?dFpJbTd5S1hUYzdrVG9aQTJyMGJHVTJBMVB5M1FTNTBVQkE1ZG1VdXp2Q2dD?=
 =?utf-8?B?Qk1FWGRxYTQ2bnJzN1kremVqZ0x4R2dPdDBvQmRGL1BsYk1zOXltUStqS0Fi?=
 =?utf-8?B?TDRPSHFzbTZYVXpQZWU5RTVKQTZyNFpiRVJRekVMc0N1YlEybWJuWk9nTU5V?=
 =?utf-8?B?U01CakZBTWRRZVpTZDRKVHllc0oxWW16ejJzMXV4WUJxWVUweU9PQzljcGUz?=
 =?utf-8?B?R2xIOEhjVW5JUkwyc216TFRMYUE5S1ZTK1FQdCtYVE5mRFg1cmtxUmhqZjhX?=
 =?utf-8?B?cGVSSDI1c29OZmpZYnRkNEo1UGUzRGlqRG9ycldaNVBjRjdPOWhHOUl1KzEw?=
 =?utf-8?B?S0U2S1Nhc0luSVNXSXJ0dWNxakFHa1l6bG94Nm9NOEQ2d3grMW9oR2NZcGVM?=
 =?utf-8?B?Yi9YbGZMKzJadm1LT29TeTM4TmphNiswZ2NMZmN4NVMzdVBLSUVFNnU0eU4y?=
 =?utf-8?B?dGxHSDY3TGdxS05ndHREdnZFTEh4ekF2M0NMaHpxRWdBR09FeCt4VWhJaHYw?=
 =?utf-8?B?RFB6bWxXWkl5Tjh5c2FpRktJU25neWNTUVQvUDVtRG8xeWJjTjJ3RjZHVXp4?=
 =?utf-8?B?eWRPMGVpUDd5M29pWTQwWk1HOHNXK1BicFNhRElPV2x4YmNySkwrRkFQOFdm?=
 =?utf-8?B?cVNsWVpWbGQ5bm5Rd0VacjMwdmJpSC9RRkFQY1NiRWU4MEpRTUNhUjdqQ3p5?=
 =?utf-8?B?c1RRU2pWVGNxM3k0MjZSV2dTemhuNk93a3RCZkt0L2JHdzVYejZNNVpMWFVu?=
 =?utf-8?B?cWhuYjZvVm9MQm5sNXB5Q1oxTll5T0dtRllQTE5mSUQwV3Nkbzd5R0pacExl?=
 =?utf-8?B?UnJwSHNvdzIydlhQOUZhZzVxL0VYRFhZNEdNbGplaUUxZUNOSUlqckJFdWEv?=
 =?utf-8?B?QWlsVm5GWUdJbTV0ZWZmdHAwM3R1dStadXZlR3Q0M3RpZnlmZEpOMkExWkNB?=
 =?utf-8?Q?qsZOHuZe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f987faeb-212d-41d3-5b49-08d8bc40d1e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 06:09:45.7580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RZLrMN1EYcG0PxtLP3Rtln2+w/LdsDE7J7OmFaZyfNsXSqsqlHqk4X39lV9d+WZ5go4Olk/0sUBSHkcKDPqAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2784
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgVG9tLA0KDQoJVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KUGxlYXNlIGZpbmQgbXkgcmVzcG9u
c2UgaW5saW5lLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRvbSBS
aXggPHRyaXhAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDE1LCAyMDIxIDEx
OjM3IFBNDQo+IFRvOiBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmFtQHhpbGlueC5jb20+OyBtZGZA
a2VybmVsLm9yZzsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNA
eGlsaW54LmNvbT47IGxpbnV4LQ0KPiBmcGdhQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGdpdCA8Z2l0QHhpbGlueC5jb20+
OyBjaGlubmlraXNob3JlMzY5QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0g
ZHQtYmluZGluZ3M6IGZwZ2E6IEFkZCBjb21wYXRpYmxlIHZhbHVlIGZvciBYaWxpbngNCj4gREZY
IEFYSSBzaHV0ZG93biBtYW5nZXINCj4gDQo+IA0KPiBPbiAxLzE0LzIxIDU6MzQgUE0sIE5hdmEg
a2lzaG9yZSBNYW5uZSB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIEFkZHMgY29tcGF0aWJsZSB2YWx1
ZSBmb3IgWGlsaW54IER5bmFtaWMgRnVuY3Rpb24NCj4gPiBlWGNobmFnZShERlgpIEFYSSBTaHV0
ZG93biBtYW5hZ2VyIElQLg0KPiANCj4gQSBtdWx0aSBwYXRjaCBzZXQgc2hvdWxkIGhhdmUgYSBj
b3ZlciBsZXR0ZXIuDQo+IA0KPiBVc2UgZ2l0IGZvcm1hdC1wYXRjaCAtLWNvdmVyLWxldHRlcg0K
PiANCg0KV2lsbCAgZml4IGluIHYyLg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogTmF2YSBraXNob3Jl
IE1hbm5lIDxuYXZhLm1hbm5lQHhpbGlueC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5n
cy9mcGdhL3hpbGlueC1wci1kZWNvdXBsZXIudHh0ICAgICB8IDE5ICsrKysrKysrKysrKysrKyst
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZnBnYS94aWxpbngtcHItZGVjb3VwbGVyLnR4dA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EveGlsaW54LXByLWRlY291cGxlci50eHQNCj4gPiBpbmRl
eCA0Mjg0ZDI5M2ZhNjEuLjQyZmNhMDU4YTVmNCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZnBnYS94aWxpbngtcHItZGVjb3VwbGVyLnR4dA0KPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL3hpbGlueC1wci1k
ZWNvdXBsZXIudHh0DQo+ID4gQEAgLTcsMTMgKzcsMjYgQEAgY2hhbmdlcyBmcm9tIHBhc3Npbmcg
dGhyb3VnaCB0aGUgYnJpZGdlLiAgVGhlDQo+ID4gY29udHJvbGxlciBjYW4gYWxzbyAgY291cGxl
IC8gZW5hYmxlIHRoZSBicmlkZ2VzIHdoaWNoIGFsbG93cyB0cmFmZmljDQo+ID4gdG8gcGFzcyB0
aHJvdWdoIHRoZSAgYnJpZGdlIG5vcm1hbGx5Lg0KPiBCZWxvdyBpcyBzb21lIHdvcmRzbWl0aGlu
ZyB0byBtYWtlIHRoZSBjb21wYXRpYmlsaXR5IGV4cGxpY2l0IGFuZCByZW1vdmUNCj4gdW5uZWVk
ZWQgd29yZHMNCg0KV2lsbCBmaXggaW4gdjINCg0KPiA+DQo+ID4gK1hpbGlueCBMb2dpQ09SRSBE
eW5hbWljIEZ1bmN0aW9uIGVYY2hhbmdlKERGWCkgQVhJIHNodXRkb3duIG1hbmFnZXINCj4gPiAr
U29mdGNvcmUNCj4gaXMgY29tcGF0aWJsZSB3aXRoIHRoZSBYaWxpbnggTG9naUNPUkUgcHItZGVj
b3VwbGVyLg0KDQpZZXMsIEJvdGggSVAncyBhcmUgY29tcGF0aWJsZSB3aXRoIHJlc3BlY3QgdG8g
dGhlIElQIHJlZ2lzdGVycyBzcGVjLg0KDQo+ID4gKw0KPiA+ICtUaGUgWGlsaW54IExvZ2lDT1JF
IER5bmFtaWMgRnVuY3Rpb24gZVhjaGFuZ2UoREZYKSBBWEkgc2h1dGRvd24NCj4gPiArbWFuYWdl
ciBtYW5hZ2VzIG9uZSBvciBtb3JlIHNodXRkb3duIG1hbmFnZXJzIC8gZnBnYSBicmlkZ2VzLg0K
PiA+ICtUaGUgY29udHJvbGxlciBjYW4gc2h1dGRvd24vcGFzc3Rocm91Z2ggdGhlIGJyaWRnZXMg
d2hpY2ggcHJldmVudHMNCj4gDQo+IERlbGV0ZSA0IGxpbmVzIGFib3ZlLg0KPiANCg0KV2lsbCBm
aXggaW4gdjIuDQoNCj4gVGhlIERGWCBBWEkgc2h1dGRvd24gbWFuYWdlciBwcmV2ZW50cw0KPiAN
Cg0KV2lsbCBmaXggaW4gdjIuDQoNCj4gPiArQVhJIHRyYWZmaWMgZnJvbSBwYXNzaW5nIHRocm91
Z2ggdGhlIGJyaWRnZS4gVGhlIGNvbnRyb2xsZXIgc2FmZWx5DQo+ID4gK2hhbmRsZXMgQVhJNE1N
IGFuZCBBWEk0LUxpdGUgaW50ZXJmYWNlcyBvbiBhIFJlY29uZmlndXJhYmxlIFBhcnRpdGlvbg0K
PiA+ICt3aGVuIGl0IGlzIHVuZGVyZ29pbmcgZHluYW1pYyByZWNvbmZpZ3VyYXRpb24gKERGWCks
IHByZXZlbnRpbmcNCj4gPiArc3lzdGVtDQo+IA0KPiBJIGRvbid0IGtub3cgYWJvdXQgdGhlIHVz
ZSBvZiAnKERGWCknIGhlcmUsIGFib3ZlIGl0IGlzIER5bmFtaWMgRnVuY3Rpb24NCj4gZVhjaGFu
Z2UnDQo+IA0KPiBIZXJlIGl0IGlzIGR5bmFtaWMgcmVjb25maWd1cmF0aW9uLCBtYXliZSBqdXN0
IGRlbGV0ZSB0aGUgJyhERlgpJw0KPiANCg0KDQpXaWxsIGZpeCBpbiB2Mi4NCg0KPiA+ICtkZWFk
bG9jayB0aGF0IGNhbiBvY2N1ciBpZiBBWEkgdHJhbnNhY3Rpb25zIGFyZSBpbnRlcnJ1cHRlZCBi
eSBERlgNCj4gPiArDQo+ID4gIFRoZSBEcml2ZXIgc3VwcG9ydHMgb25seSBNTUlPIGhhbmRsaW5n
LiBBIFBSIHJlZ2lvbiBjYW4gaGF2ZSBtdWx0aXBsZQ0KPiA+IC1QUiBEZWNvdXBsZXJzIHdoaWNo
IGNhbiBiZSBoYW5kbGVkIGluZGVwZW5kZW50bHkgb3IgY2hhaW5lZCB2aWENCj4gPiBkZWNvdXBs
ZS8gLWRlY291cGxlX3N0YXR1cyBzaWduYWxzLg0KPiA+ICtQUiBEZWNvdXBsZXJzL0FYSSBzaHV0
ZG93biBtYW5hZ2VyIHdoaWNoIGNhbiBiZSBoYW5kbGVkDQo+IGluZGVwZW5kZW50bHkNCj4gPiAr
b3IgY2hhaW5lZCB2aWEgZGVjb3VwbGUvIGRlY291cGxlX3N0YXR1cyBzaWduYWxzLg0KPiBCZWlu
ZyBjb21wYXRpYmxlLCBpIGRvbid0IHRoaW5rIGl0IGlzIG5lY2Vzc2FyeSB0byBhZGQgdG8gLyBj
aGFuZ2UgdGhpcyBzZWN0aW9uLg0KPiA+DQo+ID4gIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4g
IC0gY29tcGF0aWJsZQkJOiBTaG91bGQgY29udGFpbiAieGxueCxwci1kZWNvdXBsZXItMS4wMCIg
Zm9sbG93ZWQNCj4gYnkNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAieGxueCxwci1k
ZWNvdXBsZXIiDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgInhsbngscHItZGVjb3Vw
bGVyIiBvcg0KPiA+ICsJCQkgICJ4bG54LGRmeC1heGktc2h1dGRvd24tbWFuYWdlci0xLjAwIiBm
b2xsb3dlZCBieQ0KPiA+ICsJCQkgICJ4bG54LGRmeC1heGktc2h1dGRvd24tbWFuYWdlciINCj4g
PiAgLSByZWdzCQkJOiBiYXNlIGFkZHJlc3MgYW5kIHNpemUgZm9yIGRlY291cGxlciBtb2R1bGUN
Cj4gPiAgLSBjbG9ja3MJCTogaW5wdXQgY2xvY2sgdG8gSVANCj4gPiAgLSBjbG9jay1uYW1lcwkJ
OiBzaG91bGQgY29udGFpbiAiYWNsayINCj4gDQo+IEFkZGluZyBhbiBleGFtcGxlIHNpbWlsYXIg
dG8gdGhlIGV4aXN0aW5nIHdvdWxkIGJlIGhlbHBmdWwuDQo+IA0KDQpXaWxsIGZpeCBpbiB2Mi4N
Cg0KUmVnYXJkcywNCk5hdmFraXNob3JlLg0K
