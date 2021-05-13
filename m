Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6998B37F603
	for <lists+linux-fpga@lfdr.de>; Thu, 13 May 2021 12:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhEMK4O (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 13 May 2021 06:56:14 -0400
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:51872
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232698AbhEMK4N (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 13 May 2021 06:56:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFIYGWVQiD5CA19F3MC3ni2zMyRNpHi917bYpobNU1Rr1LAG/EjKi3x48oj7v1oEbtqBa2WR+EYBDKqe6Rk4PRN8i4F0DQ+Z1B7dIlb56YY3YtwNRdHER5x4k8uED6WFNcnXtqWKW9c+ygk0dXSOhxmfz3gVZx0/opnMRRuflS4gcDETvHQ/3tmlJ+0Bxat2fmWefPueoVIm/Jh+FQTn8JIGpt4kqFvKXOY6bB1TCe425oulogGK1iW268BIWDOvpXj3Bkb6vIqAktsg3ruOj2QKhU9sXUMP112i21NNEei4fz4tSq07ozquj5MZbYxEjYvUvxkYEjIT/hooqCu4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCGJ0kyrtIT6H0PF0PWs2O1voiqakML63XTuliT260c=;
 b=KrhQI46++DkLnGS3gFu81X5R6yGGD1lZThLRLOFsd/NdcBG8p2qDkznqaEkXhPzL3tS5TKJn7xZuOpfeYphJsmU/NnXVimhNrMcQ/Y/rzYuverOsiQmKOr1ssV9SMQdsFf4W1moD6kZ++AQHOJDOzqLsG3WbLrqUu77OyW7suXRlkxMjwp+o8LudiJ3bJqrjFEJOxSvOzNHrxPipKwz1tfFT1cRvh0md7AgjktQFEjuL+I0ReQ4BaIV35fWI3fc9kEGcMTraKe3OgukTKdA0wSqSpC/NE82A5lh3hq2EV+Miic+MXKfGbBc8ti/7X37ZEiYM63Y2TqAOglecFvcUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCGJ0kyrtIT6H0PF0PWs2O1voiqakML63XTuliT260c=;
 b=fB/LsH5rGDmLCcmrFTCcwCPv8bkZh2P0yL0/qkf5a4eKjqNGqpUpcWtA1YzCB7sG676Mb/YrNnAoynfm5jd8L9i1cfIvCYQtVgz9JYk4tx1E+3OZ06Ipf7ul76DxjsrnJsbg7ZySrlj/FLXz7SzplKG9aP8VFoDT/qyJF5pUnMU=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by CO6PR02MB7697.namprd02.prod.outlook.com (2603:10b6:303:ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 10:54:59 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8%11]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 10:54:59 +0000
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
Thread-Index: AQHXQM90hYIAhSQLOEqomCrE4N/mi6rgvmsAgACDurA=
Date:   Thu, 13 May 2021 10:54:58 +0000
Message-ID: <MWHPR02MB262309A8DC5BD857CBB01446C2519@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210504102227.15475-1-nava.manne@xilinx.com>
 <20210504102227.15475-3-nava.manne@xilinx.com>
 <20210513023104.GA909876@robh.at.kernel.org>
In-Reply-To: <20210513023104.GA909876@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0958621-50d7-422a-8e28-08d915fd8d55
x-ms-traffictypediagnostic: CO6PR02MB7697:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR02MB76970C427996363C5C19395DC2519@CO6PR02MB7697.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QRd4koPHOZYujGH0+y50EydVfeTj7sjnq9+P3lQFfltsiO/r7NDR67F1gs3SQRultfV/84klZqQsqfIAi+r7+mZIme3tp0ZOGAlbjEMxks1dJQi6JMdfg+WwZ0tFCIUoWTXctXsKQBrQpstJsuYXCnriX0qraQjt71upNunCfm90q2xuTNM1mGAtY1WTZmE0RnhY+3rHRnY5UuwZO+t2I4PWvUjgrZsbq0jBicaXolPZGQHPAzUdVtBHfU+ESypGa9eKIc4gZPfTHV5W8WJQqOXkMloOdCPMnrh2GyW6IyvAL6KSnZOi7AI9EkNcSo3tkafM2Zko6G1UARdxK5cybD0g+1uE6ZMsXHhp8BiF0NHncwGDOay5z21/1agiRxcKWSyO5LSQ47r16DAoO3a3Lq1q06jGbgtjm3LAb3kTx1+nBtTWq+N9u3+S6jaZ0SiviWcdWP1zZTK/EA5yDSkAfvgcMHWJdQs2Aoowmj9V1WXPY590IhO333RIQffbggyDrREjJ0dmFrUrQVqelb6A1hCa+xsniWkSiOTQ/KHumBRppAZCiEWsxvDKHDODYtAJ474/2mErMK2a/EZJsPrH6hBLogGPsgtML5ReyvvK6Do=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(5660300002)(38100700002)(64756008)(8676002)(316002)(54906003)(86362001)(7416002)(55016002)(6506007)(53546011)(7696005)(8936002)(33656002)(26005)(2906002)(66946007)(83380400001)(186003)(71200400001)(76116006)(478600001)(66476007)(66446008)(4326008)(122000001)(66556008)(6916009)(52536014)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnFmcnBETm1XanVuNngwY1RBN1ZVOTkvVWUwak9aYmxsNnB1c3hpT1ZTWkJY?=
 =?utf-8?B?UEhFYUlpeEF5V29QSmV3bDhLbkxNSnpha3FCb1pBUXJDa3RVbElkTmdqWHhu?=
 =?utf-8?B?T3p6R3g4T01pNHM3akZDUTZRclpFbi9LcHc3TGNZRDhTazVpaXlTUUZ0aGdT?=
 =?utf-8?B?RXhtZDlyT1l1bmw5Wm8vbGdpcGpjTlB1amdQdTA4cFg0VmZvQjlqektTclZl?=
 =?utf-8?B?UkRKOVRNbllMOW9iRkJGUnhVSmZBQnRIZ0J5WHJJK2xya2dFN0V1WUtUanh6?=
 =?utf-8?B?UUc4eGphMnhQMmttL3lWWUY4TTRFQ2p0S3Z5Q2N5VEptYi9Oa3h4bGNrdUtw?=
 =?utf-8?B?cWpseGpCV05oeDY1Y0NjU0d3cWlsRThPWWJZNG5MUXpiaWhIUDBNdUdmbDUr?=
 =?utf-8?B?VWRHTjViQVJ5c054OGRKSjV2dFdISVIvRUNuY0hjaGdid1Y2TnEwMlJmUjRW?=
 =?utf-8?B?cVNkTWg5NEpLZTJNaW9jY3pyZ2lOZDhZK0J4Qk9QK05pdUdocTFLYlJtd2tw?=
 =?utf-8?B?TFlrTHhlc2NqTDlzSE9JMUJkWHNsUFJvRlBrekdKTDNYcko1czRhc1hsQy9v?=
 =?utf-8?B?WHdDbEVKU0FaSk9iaUU5a1haQUU0a3Y4T01aMzNuUjA3QmRIcWtKUi96YXVB?=
 =?utf-8?B?WHlIMGZIdXpqZVpOMk8zRm5neWh2aVI2YlVQQ1huQkduYzN3d1lQVlJEb1ov?=
 =?utf-8?B?c0t3bkFSQlUrb3JSb1RmRTRQREFaK2FoQjJuZUhGZ1hyZU55eFU1V0ExbHFY?=
 =?utf-8?B?R3diNWRyd0c4NXJlaXd1aWg1bEhmS21LK2Zta3FJb3NqRU03WVYvOHV2c1F0?=
 =?utf-8?B?a3pFNU9yS25LSFJZRzY1eUJ2eE5sNFFUbjZ2czFPL0FkZUw1ZGFWeHBQOG03?=
 =?utf-8?B?UXRFRVJtazB1Qk93R044RzBYTXlsZ255R2F2NTNNT0x5VGRZaHdoZllydjBW?=
 =?utf-8?B?U2hlQWxvL2ozWThQOGk2U2Ziem10V2RicVdVZDh2SSszOWxjMElUbGVHKzQy?=
 =?utf-8?B?UjdONmttUXJ6K2tIUjNWNURyYUF1UWc3aTc3bjlmRmZHRmtjcTdBamtHWXpm?=
 =?utf-8?B?c3loSzVrQnpjYW4zcFZISVpSS3RLbS96eEhEWmExeFFaT1pORHd2NnJBak5R?=
 =?utf-8?B?ak5xYVpPOUZnZWd6YVZBd2JlUGYvWHpEaDBKdzdka1hHRG9rVk5OZ0V6STJs?=
 =?utf-8?B?b3NKODZXVU1maUJic1p4TEVnRlJpT3JkWEdVZ3FXQ3VVMDFpRXNxZnp5RSt1?=
 =?utf-8?B?Zit4dnFOeFl6alVtckdmRU1SQm1HbkhjY1NUNEZRamlKTVE5TFdiUUg3ZDFr?=
 =?utf-8?B?dWxUb3NZZ05id2dzQmJtdStuVXpKYzhDeFhJSmFNL0p5ckgxb3JhRFlVNVpt?=
 =?utf-8?B?cHFrOUlVenIrZUMzMFJaLzRKemxVR3VFR1lIMytEWlVDS3E0YkpSdmRVdXdF?=
 =?utf-8?B?MjVQM3B3YlRCWktqRW5PckNwRXpPRzk0T20reDJFSVBkY3VBM0d2Z2dqcWdP?=
 =?utf-8?B?SlBvRWYzczVWMFYxc0dKcjhPU2k2THNzamdlNHpabUUwZ0g0U2NWOGowWmFP?=
 =?utf-8?B?dlpIdmxmT01QVkxhWXhzTjJOVVg5bG5vK0FuNnNLSlpKN3ZSVmpMN2lpYmNw?=
 =?utf-8?B?N3hUMmRROFdUNW5wc25uSkt3M2cvcDBGYi9NamZ3K1JwdkN6cEJ3UnQ3OVI0?=
 =?utf-8?B?MlBYNTJOME93V1JER1NzTGpLWFFIb1dORTFZZ0VWMGZPSDkyRDc5Qzl0bXFB?=
 =?utf-8?Q?3BsUaqUSrCPGMIN011k3hf2noJbLE3oXE40qUz2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0958621-50d7-422a-8e28-08d915fd8d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 10:54:58.6901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oseNuOXzsve/9JPfW1L+1aNkeHQ9TGXHbCubrpbkOJUI2zOzweAL/fHtENgYr8t0qGEv8f+ePuZhA3ly7zFQiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7697
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgUm9iLA0KDQoJUGxlYXNlIGZpbmQgbXkgcmVzcG9uc2UgaW5saW5lLg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTMsIDIwMjEgODowMSBBTQ0KPiBUbzogTmF2YSBraXNo
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
VHVlLCBNYXkgMDQsIDIwMjEgYXQgMDM6NTI6MjVQTSArMDUzMCwgTmF2YSBraXNob3JlIE1hbm5l
IHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggQWRkcyDigJhlbmNyeXB0ZWQta2V5LW5hbWXigJkgYW5k
DQo+ID4g4oCYZW5jcnlwdGVkLXVzZXIta2V5LWZwZ2EtY29uZmln4oCZIHByb3BlcnRpZXMgdG8g
c3VwcG9ydCB1c2VyLWtleQ0KPiA+IGVuY3J5cHRlZCBiaXRzdHJlYW0gbG9hZGluZyB1c2UgY2Fz
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YS5tYW5u
ZUB4aWxpbnguY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZnBnYS9mcGdhLXJlZ2lvbi50eHQgfCA1ICsrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZnBnYS9mcGdhLXJlZ2lvbi50eHQNCj4gPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL2ZwZ2EtcmVnaW9uLnR4dA0KPiA+IGluZGV4IGQ3
ODdkNTc0OTFhMS4uOTU3ZGM2Y2JjZDllIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL2ZwZ2EtcmVnaW9uLnR4dA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL2ZwZ2EtcmVnaW9uLnR4dA0KPiA+IEBA
IC0xNzcsNiArMTc3LDkgQEAgT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPiAgCWl0IGluZGljYXRl
cyB0aGF0IHRoZSBGUEdBIGhhcyBhbHJlYWR5IGJlZW4gcHJvZ3JhbW1lZCB3aXRoIHRoaXMNCj4g
aW1hZ2UuDQo+ID4gIAlJZiB0aGlzIHByb3BlcnR5IGlzIGluIGFuIG92ZXJsYXkgdGFyZ2V0aW5n
IGEgRlBHQSByZWdpb24sIGl0IGlzIGENCj4gPiAgCXJlcXVlc3QgdG8gcHJvZ3JhbSB0aGUgRlBH
QSB3aXRoIHRoYXQgaW1hZ2UuDQo+ID4gKy0gZW5jcnlwdGVkLWtleS1uYW1lIDogc2hvdWxkIGNv
bnRhaW4gdGhlIG5hbWUgb2YgYW4gZW5jcnlwdGVkIGtleSBmaWxlDQo+IGxvY2F0ZWQNCj4gPiAr
CW9uIHRoZSBmaXJtd2FyZSBzZWFyY2ggcGF0aC4gSXQgd2lsbCBiZSB1c2VkIHRvIGRlY3J5cHQg
dGhlIEZQR0ENCj4gaW1hZ2UNCj4gPiArCWZpbGUuDQo+ID4gIC0gZnBnYS1icmlkZ2VzIDogc2hv
dWxkIGNvbnRhaW4gYSBsaXN0IG9mIHBoYW5kbGVzIHRvIEZQR0EgQnJpZGdlcyB0aGF0IG11c3QN
Cj4gYmUNCj4gPiAgCWNvbnRyb2xsZWQgZHVyaW5nIEZQR0EgcHJvZ3JhbW1pbmcgYWxvbmcgd2l0
aCB0aGUgcGFyZW50IEZQR0ENCj4gYnJpZGdlLg0KPiA+ICAJVGhpcyBwcm9wZXJ0eSBpcyBvcHRp
b25hbCBpZiB0aGUgRlBHQSBNYW5hZ2VyIGhhbmRsZXMgdGhlIGJyaWRnZXMuDQo+ID4gQEAgLTE4
Nyw2ICsxOTAsOCBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ICAtIGV4dGVybmFsLWZwZ2Et
Y29uZmlnIDogYm9vbGVhbiwgc2V0IGlmIHRoZSBGUEdBIGhhcyBhbHJlYWR5IGJlZW4NCj4gY29u
ZmlndXJlZA0KPiA+ICAJcHJpb3IgdG8gT1MgYm9vdCB1cC4NCj4gPiAgLSBlbmNyeXB0ZWQtZnBn
YS1jb25maWcgOiBib29sZWFuLCBzZXQgaWYgdGhlIGJpdHN0cmVhbSBpcyBlbmNyeXB0ZWQNCj4g
PiArLSBlbmNyeXB0ZWQtdXNlci1rZXktZnBnYS1jb25maWcgOiBib29sZWFuLCBzZXQgaWYgdGhl
IGJpdHN0cmVhbSBpcw0KPiBlbmNyeXB0ZWQNCj4gPiArCXdpdGggdXNlciBrZXkuDQo+IA0KPiBX
aGF0J3MgdGhlIHJlbGF0aW9uc2hpcCB3aXRoIGVuY3J5cHRlZC1mcGdhLWNvbmZpZz8gQm90aCBw
cmVzZW50IG9yDQo+IG11dHVhbGx5IGV4Y2x1c2l2ZT8gQ291bGRuJ3QgdGhpcyBiZSBpbXBsaWVk
IGJ5IGVuY3J5cHRlZC1rZXktbmFtZSBiZWluZw0KPiBwcmVzZW50Pw0KPiANCg0KSW4gRW5jcnlw
dGlvbiB3ZSBoYXZlIHR3byBraW5kcyBvZiB1c2UgY2FzZSBvbmUgaXMgRW5jcnlwdGVkIEJpdHN0
cmVhbSBsb2FkaW5nIHdpdGggRGV2aWNlLWtleSBhbmQNCk90aGVyIG9uZSBpcyBFbmNyeXB0ZWQg
Qml0c3RyZWFtIGxvYWRpbmcgd2l0aCBVc2VyLWtleS4gZW5jcnlwdGVkLWZwZ2EtY29uZmlnIGFu
ZCBlbmNyeXB0ZWQtdXNlci1rZXktZnBnYS1jb25maWcgDQphcmUgbXV0dWFsbHkgZXhjbHVzaXZl
LiBUbyBkaWZmZXJlbnRpYXRlIGJvdGggdGhlIHVzZSBjYXNlcyBJIGhhdmUgYWRkZWQgdGhpcyBu
ZXcgZmxhZyBhbmQgQWVzIEtleSBmaWxlKGVuY3J5cHRlZC1rZXktbmFtZSkNCmlzIG5lZWRlZCBv
bmx5IGZvciBlbmNyeXB0ZWQtdXNlci1rZXktZnBnYS1jb25maWcgdXNlIGNhc2VzLg0KDQpSZWdh
cmRzLA0KTmF2YWtpc2hvcmUuDQo=
