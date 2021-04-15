Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8063360228
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Apr 2021 08:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhDOGIK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 15 Apr 2021 02:08:10 -0400
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com ([40.107.237.85]:37344
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229793AbhDOGIJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 15 Apr 2021 02:08:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3Z1xA8TazkPfp6Jk/XOVnEFekJqGJeWHBssedKMeOjZ4L6XJsmQ0JQFR2p8kyZhFbo6vdKhjljTOHESfZK++dybp7sD/hyho1uRph6oJK64feCGUUlxQbs6hiDN/PS+pWhI4Dfls29RSWG36tyPdfyQJb2V2h5InL9nfvs0PBK1B8IYK9Vz3HujFeKAyv370UilmN1cKrO3aAOem22nL4vsZWWa8HuctyZs3LfClHbu7SfvbtHDYUhYMC2r6dRZHlyEITY/y8Km4OwuCjsgGcA0HsPejr50k046pNiJr2q/kmxUcZwW35Q0Ap2FkDgUxf1IIogsa1uuODdGmjHgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LohbEM8myyLADkhU94819r/xn9uJ1w4RIRIVxZy694U=;
 b=lZjMG0NlNgK29oJpQYi46zywPrrSJX3TIqXR6MJW1SfUFwjD2xBNcqvUmXfjSL49NJ9Sqvuaipodt0s8I4H8iln2O58/xt+oUbzI7bEa+I/J7R1c8UAkPJE34e6k0JGnwEQkS+pGB/UuxTux2lWMdLVL8ZdwCd44S5SI9rKyI/lMyHELxROBIHHq9dsowIYmOz39QTBvfvsUt9URH2vIG8bTN09IKiLPyXyD0ao3oi5BhhiChd+wWs+ljicTv6phASq9ubcASeuymiNh+tcKXus/ejRngGfkSEquXnLvSKvE+vTIwzRK3ZUItD5Shq1vIxwLHaKNcmVcXHzUSUMulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LohbEM8myyLADkhU94819r/xn9uJ1w4RIRIVxZy694U=;
 b=ONpASh+xIYLgkgy42gARZaA8zijTtaJPfyJsItd+PAQZbDCdyqXaIiyXFlj+xDl9QJ+ZYXpyqJ6Nh4CYCeDa0WVr/qn2bsXsb4sdQXpnchMzktFRhii9M/1yfuKZ9aQ1DzFQPIafSh1hOvUiDrPNVVvWmdQq24dH6ktKerJPzDQ=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by CO6PR02MB7601.namprd02.prod.outlook.com (2603:10b6:303:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 06:07:44 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26%9]) with mapi id 15.20.4020.023; Thu, 15 Apr 2021
 06:07:44 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Manish Narani <MNARANI@xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>
Subject: RE: [PATCH v3 2/3] dt-bindings: fpga: Add binding doc for versal fpga
 manager
Thread-Topic: [PATCH v3 2/3] dt-bindings: fpga: Add binding doc for versal
 fpga manager
Thread-Index: AQHXEMVdMsyP8+vbRE2oyddQhLKezap6jzYAgAKDMvCAAG03gIAAAfYAgDfXKDA=
Date:   Thu, 15 Apr 2021 06:07:43 +0000
Message-ID: <MWHPR02MB26239FBFB985D5AE1A052C24C24D9@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210304070224.22346-1-nava.manne@xilinx.com>
 <20210304070224.22346-3-nava.manne@xilinx.com>
 <20210308201944.GA2886704@robh.at.kernel.org>
 <MWHPR02MB26231DD759D8C9D1CB26EC1EC2919@MWHPR02MB2623.namprd02.prod.outlook.com>
 <CAL_JsqLDK5pNprA5RJq8VfTbQX=hP-8NUyY6Xsesz3TE6=YYeg@mail.gmail.com>
 <CAL_JsqKAP5Up7=qJEM6E0HuV2-faaVqTg+S=pdD8RpWyJ3KVcQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKAP5Up7=qJEM6E0HuV2-faaVqTg+S=pdD8RpWyJ3KVcQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87cad69c-417a-4c1d-88de-08d8ffd4c8eb
x-ms-traffictypediagnostic: CO6PR02MB7601:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR02MB7601E932BEC7B94C0169F5EAC24D9@CO6PR02MB7601.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t2s/OqnTUasnIvCeXswKxZ441JIH6tMkXiAUtKFZ9vS0ZKY60MlCheAAqImcvwzNt039inPMEbm6ECHcRzjYTYcaJw13EtEM57Xqk+9cQCTuKPl8GvO67D1BjIjNEWlQCwemLlOzjTqwFLpDNOYl2nUWynInHyV/mnil0afjcUWH+JVlpLb3kjKYkkPq9UGTqO/L0ACegLt1+ngQgxzQpT7i8ZbO3qvyuQwi43A1/zheRpQB2qtQA+u4IDZVtIlzopWH1rAQEE4g7U/AzbTTj6IbPRQvkiRIPFuz9gnfg8E2APWYHOr9j3J/IS80pb/DBVCb/a5HNStKhdquzrYXmWsh4BaCQPiX2sqIgAYv34mtDqRfnLxh1aoi+tCwzPAKWH7DVBEb5CGd0fqaei0BMSxfdNog6YLTuCJNtVg86Dskrs5PPj4CObRX5Nm8ZCJkh1Sc5EwhnCjzCtQWL+LXuvpRWr8yRvljnb7y8iddLpvLjSlRFP4iFlauop7hS+oCYrTE48CpLsaob7WPVJo8pNpU4Y7CCbNtPOertiFsY+ExOcxDRjGKagPqgB2GS8E8MiTS71ZoNipFCn0nN7rbH0m+VBrnz+mC8+jX1T5fNxc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(8936002)(53546011)(6506007)(4326008)(66946007)(86362001)(83380400001)(7696005)(7416002)(186003)(55016002)(8676002)(54906003)(76116006)(66476007)(71200400001)(5660300002)(107886003)(26005)(9686003)(2906002)(6916009)(33656002)(316002)(122000001)(38100700002)(66556008)(64756008)(478600001)(52536014)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c2VDL2RNNDRySTFNc1ZiZEluaUxjL3NsU3FPMXlZM2lUT1V3akZ2dXZxYi95?=
 =?utf-8?B?K0tyK1RHb3Yzb2ZxekVWK3FONnAvOWUxcXJQOGp0N2N4dWlpS3hXMXcwZGl2?=
 =?utf-8?B?WjVaTmIwakRkMGNWeVF3enI1OWVyU0diazZUaVZzY20yQkMvVlJqQm9JRVNp?=
 =?utf-8?B?K2Zsclh3dlhCRFJhclFFOTRaSGZNdFZNM1dRdWluNlYrRUprVVZYbC9xMHJt?=
 =?utf-8?B?Nk5iVFNESVZRWDc0NWtjVGFmRDA3OXJPRjJONjZvYWprek1rZ1FnY3hKaW1i?=
 =?utf-8?B?QkdkUU50blRHblBvZm1aeTNieU9FUC9INVo0NE9MMms3c21HdklKbDlmMU4x?=
 =?utf-8?B?WXBhTnFabnZRVElDUE9vYVIxWTVSeDFiakd5eEI5RFhMakg5L2s5ckp0dCtY?=
 =?utf-8?B?dTN2SWJKSFNUR1F5c1gyeG1mR3Y2TU1ocUFyOTZuWk1lWlRtSU9qdS9GUnJT?=
 =?utf-8?B?dXZUcmY1T1pkWkp0YmJXUENCL2JaZHBHamhyY1BOMWh1UXV2NVNtZU1OMFpE?=
 =?utf-8?B?QXFPTCt3cjFLUWlrMytuWkM2L3p3dGd4eXp6NFpUajRsaHVVZmFxSmZpMVNv?=
 =?utf-8?B?ZktOYk5HKzRMbFVjMGNzSzFPSm9JcEE3UHJHOGFvREw4cy9rby94ZTVOM2d3?=
 =?utf-8?B?MDFOYjdzM2Yzckt0ZDlJYU1RYlpZSWxsZ0YvQkpRcVVjZHhqRXpXTEE4SWtN?=
 =?utf-8?B?WFZxZGVDWWV6VVl2T3Y0U2E2QU5NdGdJNVo1TVpxOGVZenY4NzVJVTYxT2JF?=
 =?utf-8?B?RFdsaXI4WjNaRTVDLzIzRDVXaG1uejFLRkxsYjdmVkFLT1F2RldURktXWXJU?=
 =?utf-8?B?WUtnNUM5MWNNVnhnUEcxTUxmYjR6RWwzWk9idTNTSjc2d1dXaVp4aWpHMDM4?=
 =?utf-8?B?YlpsVVJhZ2E5SlJTbEpyY2daNVlaVEFFMDQyT3laTU5Payt4M0M4ZFVPMHhi?=
 =?utf-8?B?N09OWWw2R0JjWU1KYmtJS2ZCZk9GUWNQc2k0bzYzODBiM2hub2FyclNKdUtj?=
 =?utf-8?B?Z0dnSFd2dzltWkViTE1ObmtlSVJHc3Nwc2hwVDJsRE5ZMTB3MFJGS3U2Z1FI?=
 =?utf-8?B?eDBZTUVJOEpJendBNHNWMWd0VVRucnJONWtEMTJQN085TE1ZMU5UWFltdHV5?=
 =?utf-8?B?dVpqODA3cGtFNFdQVEZBSzBEZkN4YlZEc051WGhWdTFXUWNGS0pjbnpKYXFy?=
 =?utf-8?B?S2xjL3l0dGw0Zit6WmdGdURhMzFRL0ZIZGU2NnRhRXFVdnYrRHcxSjI4Zy9U?=
 =?utf-8?B?UVUyWjBGZDNNL0M0NWhsOTRGTzRpM205ejhTRnBybENyZkZUYjI4UW50dTdU?=
 =?utf-8?B?VW8rbTIrMkUvVFE3cDcwbUVpdVN0NStRNHpnYTh0N1lBQUpDYk9ZSERTUXpD?=
 =?utf-8?B?TlVhczlkZk1tMHpUWHZ1aWZDNkI0ajBzV1RhNTZKVDhCV2cvT1BYRmRUakdO?=
 =?utf-8?B?YXI1OGhPcG9CYnh5bW9PWW44d21RVTdvZDMxclBnUXc4c2xSRUZDUmF0MjhW?=
 =?utf-8?B?eFBxY1R4dlhZYm0zUUhyRGVWcUdUZXZKd1RGL1UzQUhCUCszaXdSZU4zdUd1?=
 =?utf-8?B?QTdxcDgvL3JKbEIxdXR4UDd1c3B4SHY2SER3QzRNb3UvRVFkZDVhT3RIeVFj?=
 =?utf-8?B?d3NQZzlDcGFONzBWcEowekQxQ2h6SHJYTjNobDlNMUlMSitBMjZyRkxtMDdh?=
 =?utf-8?B?ZDhOaHVyaEw2WWY5YTcrSGdDOE0rZmd4dnVmcllFVDNORkFTb2dudGZ2VzFS?=
 =?utf-8?Q?u4ZVRcHiefcxsYNUfM84wm09CNfeiQkcGN7F9as?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cad69c-417a-4c1d-88de-08d8ffd4c8eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 06:07:43.8835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AN3/6ttEbmbDwPyRIAZ3dfvmzqpLzP8sGfE8oB7igh6f1q6v167mA+0HBPzvjiRqkbuUQ5CZFKtDy6EiVzbnHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7601
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgUm9iLA0KDQoJUGxlYXNlIGZpbmQgbXkgcmVzcG9uc2UgaW5saW5lLg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTAsIDIwMjEgMTA6NTAgUE0NCj4gVG86IE5hdmEg
a2lzaG9yZSBNYW5uZSA8bmF2YW1AeGlsaW54LmNvbT4NCj4gQ2M6IG1kZkBrZXJuZWwub3JnOyB0
cml4QHJlZGhhdC5jb207IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsNCj4gZ3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IEpvbGx5IFNoYWggPEpPTExZU0B4aWxpbnguY29tPjsg
UmFqYW4gVmFqYQ0KPiA8UkFKQU5WQHhpbGlueC5jb20+OyBhcm5kQGFybmRiLmRlOyBNYW5pc2gg
TmFyYW5pDQo+IDxNTkFSQU5JQHhpbGlueC5jb20+OyBBbWl0IFN1bmlsIERoYW1uZSA8YW1pdHN1
bmlAeGlsaW54LmNvbT47IFRlamFzDQo+IFBhdGVsIDx0ZWphc3BAeGxueC54aWxpbnguY29tPjsg
bGludXgtZnBnYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBjaGlubmlraXNob3JlMzY5QGdtYWlsLmNvbTsgQXBwYW5hIER1cmdh
DQo+IEtlZGFyZXN3YXJhIFJhbyA8YXBwYW5hZEB4aWxpbnguY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzIDIvM10gZHQtYmluZGluZ3M6IGZwZ2E6IEFkZCBiaW5kaW5nIGRvYyBmb3IgdmVy
c2FsIGZwZ2ENCj4gbWFuYWdlcg0KPiANCj4gT24gV2VkLCBNYXIgMTAsIDIwMjEgYXQgMTA6MTIg
QU0gUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBXZWQs
IE1hciAxMCwgMjAyMSBhdCAzOjUwIEFNIE5hdmEga2lzaG9yZSBNYW5uZQ0KPiA8bmF2YW1AeGls
aW54LmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gSGkgUm9iLA0KPiA+ID4NCj4gPiA+ICAgICAg
ICAgVGhhbmtzIGZvciBwcm92aWRpbmcgdGhlIHJldmlldyBjb21tZW50cy4NCj4gPiA+IFBsZWFz
ZSBmaW5kIG15IHJlc3BvbnNlIGlubGluZS4NCj4gPiA+DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
DQo+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDksIDIwMjEgMTo1MCBBTQ0KPiA+ID4gPiBU
bzogTmF2YSBraXNob3JlIE1hbm5lIDxuYXZhbUB4aWxpbnguY29tPg0KPiA+ID4gPiBDYzogbWRm
QGtlcm5lbC5vcmc7IHRyaXhAcmVkaGF0LmNvbTsgTWljaGFsIFNpbWVrDQo+ID4gPiA+IDxtaWNo
YWxzQHhpbGlueC5jb20+OyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgSm9sbHkgU2hhaA0K
PiA+ID4gPiA8Sk9MTFlTQHhpbGlueC5jb20+OyBSYWphbiBWYWphIDxSQUpBTlZAeGlsaW54LmNv
bT47DQo+ID4gPiA+IGFybmRAYXJuZGIuZGU7IE1hbmlzaCBOYXJhbmkgPE1OQVJBTklAeGlsaW54
LmNvbT47IEFtaXQgU3VuaWwNCj4gPiA+ID4gRGhhbW5lIDxhbWl0c3VuaUB4aWxpbnguY29tPjsg
VGVqYXMgUGF0ZWwNCj4gPiA+ID4gPHRlamFzcEB4bG54LnhpbGlueC5jb20+OyBsaW51eC1mcGdh
QHZnZXIua2VybmVsLm9yZzsNCj4gPiA+ID4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiA+IGxpbnV4LWFybS0ga2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGNoaW5uaWtpc2hvcmUzNjlAZ21haWwuY29tOw0KPiA+ID4gPiBB
cHBhbmEgRHVyZ2EgS2VkYXJlc3dhcmEgUmFvIDxhcHBhbmFkQHhpbGlueC5jb20+DQo+ID4gPiA+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8zXSBkdC1iaW5kaW5nczogZnBnYTogQWRkIGJpbmRp
bmcgZG9jIGZvcg0KPiA+ID4gPiB2ZXJzYWwgZnBnYSBtYW5hZ2VyDQo+ID4gPiA+DQo+ID4gPiA+
IE9uIFRodSwgTWFyIDA0LCAyMDIxIGF0IDEyOjMyOjIzUE0gKzA1MzAsIE5hdmEga2lzaG9yZSBN
YW5uZQ0KPiB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBBcHBhbmEgRHVyZ2EgS2VkYXJlc3dhcmEg
cmFvDQo+IDxhcHBhbmEuZHVyZ2EucmFvQHhpbGlueC5jb20+DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBUaGlzIHBhdGNoIGFkZHMgYmluZGluZyBkb2MgZm9yIHZlcnNhbCBmcGdhIG1hbmFnZXIgZHJp
dmVyLg0KPiA+ID4gPg0KPiA+ID4gPiBXaHkgZG8geW91IG5lZWQgYSBEVCBlbnRyeSBmb3IgdGhp
cz8gQ2FuJ3QgdGhlIFZlcnNhbCBmaXJtd2FyZQ0KPiA+ID4gPiBkcml2ZXIgaW5zdGFudGlhdGUg
dGhlIGZwZ2EtbWdyIGRldmljZT8NCj4gPiA+ID4NCj4gPiA+IFRoaXMgZHQgZW50cnkgaXMgbmVl
ZCB0byBoYW5kbGUgdGhlIGZwZ2EgcmVnaW9ucyBwcm9wZXJseSBmb3IgYm90aCBmdWxsIGFuZA0K
PiBQYXJ0aWFsIGJpdHN0cmVhbSBsb2FkaW5nIHVzZSBjYXNlcyBhbmQgaXQgY2Fubm90IGJlIGRv
bmUgYnkgVmVyc2FsIGZpcm13YXJlDQo+IGRyaXZlciBpbnN0YW50aWF0ZS4NCj4gPg0KPiA+IEFo
IHllcywgSSBmb3Jnb3QgYWJvdXQgdGhhdC4NCj4gDQo+IExvb2tpbmcgYXQgdGhpcyBzb21lIG1v
cmUsIHBsZWFzZSBjb252ZXJ0IHhsbngsenlucW1wLWZpcm13YXJlLnR4dCB0bw0KPiBzY2hlbWEg
YW5kIGFkZCB0aGUgbm9kZSBmb3IgdGhpcyB0aGVyZS4gV2UgZG9uJ3QgbmVlZCBhIHdob2xlIG90
aGVyDQo+IHNjaGVtYSBmaWxlIGp1c3QgZm9yIGEgbm9kZSBhbmQgY29tcGF0aWJsZS4gQWxzbywg
bG9va3MgbGlrZSB4bG54LHp5bnFtcC0NCj4gcGNhcC1mcGdhLnR4dCBpcyB0aGUgcHJpb3IgdmVy
c2lvbiBvZiB0aGUgc2FtZSB0aGluZywgc28gaXQgc2hvdWxkIGJlIGhhbmRsZWQNCj4gaW4gdGhl
IHNjaGVtYSB0b28uDQo+IA0KDQpXaWxsIGZpeCB0aGlzIGluIHRoZSBuZXh0IHZlcnNpb24NCg0K
UmVnYXJkcywNCk5hdmFraXNob3JlLg0K
