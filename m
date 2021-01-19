Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02512FB14C
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Jan 2021 07:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbhASGXm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Jan 2021 01:23:42 -0500
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com ([40.107.236.74]:8973
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729233AbhASGRs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 19 Jan 2021 01:17:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeE+alDOwV6qI2ZzfbPjVpbxWeN365XeMaVdfav2UqPgvA6PMh8Y49NLse3WDHFRc6mgYg5b9Ki8Tyw1WLd+PG/L4klWDSEvhmVwraFnLRgU14b6E7qfhZqGfdWdZlXPHW86uSZpIsh9Olzxk47vG6AyGQhltc+fgGtzUaCPDdlpRtcvgDJq4lXNoI6Sq0NXwuwKuEQhZUtM/cBili4C0RLPowhaMHPUWP2Af6aMOUV7mqx0u9LBKajUXmCmh0cqV2LRno0JiLsifpf0nNWLnmAG0FjMq7yI4p7a0GrkLGf4/Eq2N+ez96saxlYX8VIAZo05EnL8cYQVKdssUOsV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feqv6BmXlbznPtHQstq/x4DVmiDlNmbIHvYVkp5LYmE=;
 b=CteqxcGLNJQYAgjciJ95EWaDnSRvSZfGjvYIGuXN9ihF9Izx1MAtp0/cova5lXmld24ZEHytQlkiracMil+WwoFqC7PZWiiF+xeeqvQegUpYSQuM+0fh/BD8hjLTAaepfoQ2iLWzkNaiilvNGaCAXlZRZ52lyxQcZ2YW3KsuQJ47QYRm0qsJ2D8B0+0FiCyY/H50+cen8HsiptFm7NQp5xnISN9j9EcxESVgTOtidumEkUX9JuXdog//jyjduCtcMiKZGo+beqNMwvhkXiMAhwdZQVTRlQggkNhZhkEmHbRN9oh/2KTw+S9/32ooMUZHQgos4kfQduJAgM+n5d7lKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feqv6BmXlbznPtHQstq/x4DVmiDlNmbIHvYVkp5LYmE=;
 b=fUEHXtzLU9AZ+52l3dufE4D0yVEksAFjoxH9yLu2jv54jiP8wwhxJitKdS2V77mBIepn1q60ZozgON2OqABCAhvgi3fRFWq6FlZwgCAM2thWpREPPWjoQW7e/SuYqCZj3O8EZwvjEkniWQu9YSb/4wY/ULf4/k4UXTGVfPC8Ayg=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR02MB3357.namprd02.prod.outlook.com (2603:10b6:301:61::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 06:16:50 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942%3]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 06:16:50 +0000
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
Subject: RE: [PATCH 2/2] fpga: Add support for Xilinx DFX AXI Shutdown manager
Thread-Topic: [PATCH 2/2] fpga: Add support for Xilinx DFX AXI Shutdown
 manager
Thread-Index: AQHW6t9xKUyYsQdkFk2NaePj2u7pYKopAheAgAV8NkA=
Date:   Tue, 19 Jan 2021 06:16:50 +0000
Message-ID: <MWHPR02MB26232753E624335632BCE511C2A30@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210115013431.27667-1-nava.manne@xilinx.com>
 <20210115013431.27667-2-nava.manne@xilinx.com>
 <2dc469ae-cdf4-0774-c786-7dd01c4914c9@redhat.com>
In-Reply-To: <2dc469ae-cdf4-0774-c786-7dd01c4914c9@redhat.com>
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
x-ms-office365-filtering-correlation-id: d52d593f-dfec-4708-e45b-08d8bc41cef1
x-ms-traffictypediagnostic: MWHPR02MB3357:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB3357EF986C69B3A1356ABB4BC2A30@MWHPR02MB3357.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p/3b1hirVRH7WcdjSCNicqI11hgsdYAO+ue8m5x8Pr61cOD1mY/7tqWEK+kvYRF4yvuQtXXkJBvRoUsUKde9SIXvbZuqAU7lgs94d1xiLq8tmvpvwJvKstELIXjIWtxpx3KFWfY9KrDYCoAY0n41vuXRZaMpQ4VOlBmHvBEhIrdcL1+xo46VDvHpJs9BPHGPzzOo/+xqYjWl3SMhm1j+tm8P+WkPMp5jFh3G9rE0WcCKzAJ6qe223CAGsg4tLe32LpPwdHZpw9RHnO7LmAql2z5xKR20XlBPGEYc5nGae2gHPzC20aN2bxCxeYusGg40Dr15uS7HU12A+9+KanxLQFXGTp84tJPMMVsjZDFRUdEWLLk8wM7W7+KiWMV6FJ4uq0lFMTkIPl3+sD54klHbXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(71200400001)(66446008)(33656002)(76116006)(64756008)(9686003)(66476007)(66946007)(4326008)(26005)(55016002)(66556008)(52536014)(8676002)(83380400001)(316002)(186003)(7696005)(478600001)(5660300002)(8936002)(54906003)(110136005)(86362001)(2906002)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cWVJb2pKY1dyTy9hSVRJZC83TDRuN05XSlM2NjQvVlBXNVBVVWd3ZUhLTjgz?=
 =?utf-8?B?d0JoL1h2SXdnZi9QTk1IV3lidGNLc0ZRMWJ1aWRhMDc3eHhuY3Riak12alUw?=
 =?utf-8?B?ckxVR2wrcC91aElySUMraEp0bVdHWXcxdnZkS0hPdUhBVGowSXB0M2w2Y3Rr?=
 =?utf-8?B?dS9xR2dBd0lqUHJrcFN2Umt5Y2FOL1h2VjlQTUNpdTRURURxSWlEall3aVVG?=
 =?utf-8?B?SHNLQXR0ZFZJSzEwN3k4QVgzckkza1FYeE9wTlRDbGxyM1ZFMVVXT1pYbm5X?=
 =?utf-8?B?Zzk4QkxoUVFKNmdrVmpndmhiREg0SGJwd1A3ak4zTDF4VUc2eW04S2VPd1hW?=
 =?utf-8?B?eFVxVDd2ZTQvdWszTU1xZTc2QmFDK2J1SjBRdTg1enJTRUszems3R2Z1Z0Za?=
 =?utf-8?B?QnNldU1uZEhXc0luZlJldWxCMEV1Vk9pTC9aUG1FcXNIOFZ4a1VMa2QzTDIv?=
 =?utf-8?B?OHBodDB2d1pGK282WUUvRzArRTNyREtxTW0xTUZHcmpUc1R2ZzhCRU5GWHRh?=
 =?utf-8?B?MFE5eFNSUkFVdHZJWGRHck92eHFaZ0lZWmw2WXlPQmVnczZSVmV4ZUEydUpH?=
 =?utf-8?B?REszYitXQWpjcEFxT3ZvQm5qbWtzcVhabU9tN3ZPMkhHSVpITUxqTkZCR0lV?=
 =?utf-8?B?Ni92WG1vdGRTNFloZXk4VWljbkIzVFhJdW5yaGpLUFo0YlpUN1V1N1EvKy9w?=
 =?utf-8?B?T0d6YXNsNmsrejBNdVdjakoxUGlQMEJ6NUhsQUVwSDkyV2pxODBQc0xKYlpS?=
 =?utf-8?B?OFo3UXREd09iNjlLZmZ4QjhjYU9lKzJZYUlya3pMai9DRkFrdkNtMWhLTXFQ?=
 =?utf-8?B?VW45SHJvVGJRakpyTmxobUdabzl4anBFeGRHNExpVzZ5bEtKZVliclkwQ3cy?=
 =?utf-8?B?Y25hdk5WYVdOK1RjVlh6WkFEdXpZUWhUOHc5Y3B4K3pzYy96MWljOU1Eenp6?=
 =?utf-8?B?VDdZR1dnb1RjUEVRb2pIcGZCQXhvWnlqcnRoTHpsRDFLaTRuenNQQmZmSlZH?=
 =?utf-8?B?VldaUXpjVVU0SGRUUzg0cE94MFpvRXZjYUhwL2kvZXFndTluZUs0blcwWmhy?=
 =?utf-8?B?YVpmL0lITm9ramRwSGdGSThwN0lkbUhqdjhtSFNUVTVoNTZhTXFUSzZ4SWJj?=
 =?utf-8?B?OVZjSHMvbU1QT1hmL2k4QlVnWnltMTV5MU1uZG40ekgwRzNlS1NCVEhMR3M0?=
 =?utf-8?B?NjNnU2plNjZKYlo5NHJnQytsMlpyTzhId1RETlc2bzB6R1d0NVhyOE90SStV?=
 =?utf-8?B?Sy9TZ2tIK0NtV1lLN1Bra0dZdjdxSEk1UllBZkJjc29Ndm5sTElvY3UwVXNp?=
 =?utf-8?B?cmZCVWc1MFFmaEp6enU1U3g3OCtSUGJNNnhSN1RxSk9IK2FFeWlCUlJYMkpa?=
 =?utf-8?B?MGFmbCt3ZXVjczNzVEVlMzNWcjBxczRNSkZxRVpyQjlGVEw2K2w2VkQybUZB?=
 =?utf-8?Q?AsDuXfcP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52d593f-dfec-4708-e45b-08d8bc41cef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 06:16:50.2001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uJTfmPbv5IEGntWak/Iuwbv5xX5xpsRGa6sFPqn3FuT/tteNtzPVr/I2tniWeVoNsDGOPo9S015f18Tff6bQZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3357
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgVG9tLA0KDQoJVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KUGxlYXNlIGZpbmQgbXkgcmVzcG9u
c2UgaW5saW5lLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRvbSBS
aXggPHRyaXhAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDE1LCAyMDIxIDEx
OjU2IFBNDQo+IFRvOiBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmFtQHhpbGlueC5jb20+OyBtZGZA
a2VybmVsLm9yZzsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNA
eGlsaW54LmNvbT47IGxpbnV4LQ0KPiBmcGdhQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGdpdCA8Z2l0QHhpbGlueC5jb20+
OyBjaGlubmlraXNob3JlMzY5QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0g
ZnBnYTogQWRkIHN1cHBvcnQgZm9yIFhpbGlueCBERlggQVhJIFNodXRkb3duDQo+IG1hbmFnZXIN
Cj4gDQo+IA0KPiBPbiAxLzE0LzIxIDU6MzQgUE0sIE5hdmEga2lzaG9yZSBNYW5uZSB3cm90ZToN
Cj4gPiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgWGlsaW54IER5bmFtaWMgRnVuY3Rpb24g
ZVhjaGFuZ2UoREZYKSBBWEkNCj4gPiBzaHV0ZG93biBtYW5hZ2VyIElQLiBJdCBjYW4gYmUgdXNl
ZCB0byBzYWZlbHkgaGFuZGxpbmcgdGhlIEFYSSB0cmFmZmljDQo+ID4gb24gYSBSZWNvbmZpZ3Vy
YWJsZSBQYXJ0aXRpb24gd2hlbiBpdCBpcyB1bmRlcmdvaW5nIGR5bmFtaWMNCj4gPiByZWNvbmZp
Z3VyYXRpb24gYW5kIHRoZXJlIGJ5IHByZXZlbnRpbmcgc3lzdGVtIGRlYWRsb2NrIHRoYXQgbWF5
IG9jY3VyDQo+ID4gaWYgQVhJIHRyYW5zYWN0aW9ucyBhcmUgaW50ZXJydXB0ZWQgZHVyaW5nIHJl
Y29uZmlndXJhdGlvbi4NCj4gPg0KPiA+IFBSLURlY291cGxlciBhbmQgQVhJIHNodXRkb3duIG1h
bmFnZXIgYXJlIGNvbXBsZXRlbHkgZGlmZmVyZW50IElQcy4NCj4gPiBCdXQgYm90aCB0aGUgSVAg
cmVnaXN0ZXJzIGFyZSBjb21wYXRpYmxlIGFuZCBhbHNvIGJvdGggYmVsb25nIHRvIHRoZQ0KPiA+
IHNhbWUgc3ViLXN5c3RlbSAoZnBnYS1icmlkZ2UpLlNvIHVzaW5nIHNhbWUgZHJpdmVyIGZvciBi
b3RoIElQJ3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYXZhIGtpc2hvcmUgTWFubmUgPG5h
dmEubWFubmVAeGlsaW54LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9mcGdhL3hpbGlueC1w
ci1kZWNvdXBsZXIuYyB8IDM1DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+
IA0KPiBJdCBsb29rcyBsaWtlIHRoZSBjb3B5cmlnaHQgaXMgd3JvbmcsIHBsZWFzZSByZXZpZXcg
c3BlbGxpbmcgb2YgWGlsaXgNCj4gDQo+IMKgKiBDb3B5cmlnaHQgKGMpIDIwMTcsIFhpbGl4IElu
Yw0KPiANCldpbGwgZml4IGluIHYyLg0KPiANCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMxIGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9m
cGdhL3hpbGlueC1wci1kZWNvdXBsZXIuYw0KPiA+IGIvZHJpdmVycy9mcGdhL3hpbGlueC1wci1k
ZWNvdXBsZXIuYw0KPiA+IGluZGV4IDdkNjlhZjIzMDU2Ny4uYzk1ZjNkMDY1Y2NiIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZnBnYS94aWxpbngtcHItZGVjb3VwbGVyLmMNCj4gPiArKysgYi9k
cml2ZXJzL2ZwZ2EveGlsaW54LXByLWRlY291cGxlci5jDQo+ID4gQEAgLTE5LDEwICsxOSwxNSBA
QA0KPiA+ICAjZGVmaW5lIENUUkxfT0ZGU0VUCQkwDQo+ID4NCj4gPiAgc3RydWN0IHhsbnhfcHJf
ZGVjb3VwbGVyX2RhdGEgew0KPiA+ICsJY29uc3Qgc3RydWN0IHhsbnhfY29uZmlnX2RhdGEgKmlw
Y29uZmlnOw0KPiA+ICAJdm9pZCBfX2lvbWVtICppb19iYXNlOw0KPiA+ICAJc3RydWN0IGNsayAq
Y2xrOw0KPiA+ICB9Ow0KPiA+DQo+ID4gK3N0cnVjdCB4bG54X2NvbmZpZ19kYXRhIHsNCj4gPiAr
CWNoYXIgKm5hbWU7DQo+ID4gK307DQo+IA0KPiBNb3ZlIHhsbnhfY29uZmlnX2RhdGEgYWJvdmUg
eGxueF9wcl9kZWNvdXBsZV9kYXRhLg0KPiANCldpbGwgZml4IGluIHYyLg0KDQo+IGNvdWxkIHlv
dSAnY29uc3QnIGNoYXIgKm5hbWUgPw0KPiANCldpbGwgZml4IGluIHYyLg0KPiA+ICsNCj4gPiAg
c3RhdGljIGlubGluZSB2b2lkIHhsbnhfcHJfZGVjb3VwbGVyX3dyaXRlKHN0cnVjdCB4bG54X3By
X2RlY291cGxlcl9kYXRhDQo+ICpkLA0KPiA+ICAJCQkJCSAgIHUzMiBvZmZzZXQsIHUzMiB2YWwp
DQo+ID4gIHsNCj4gPiBAQCAtNzYsMTUgKzgxLDI4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZnBn
YV9icmlkZ2Vfb3BzDQo+IHhsbnhfcHJfZGVjb3VwbGVyX2JyX29wcyA9IHsNCj4gPiAgCS5lbmFi
bGVfc2hvdyA9IHhsbnhfcHJfZGVjb3VwbGVyX2VuYWJsZV9zaG93LCAgfTsNCj4gPg0KPiA+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IHhsbnhfY29uZmlnX2RhdGEgZGVjb3VwbGVyX2NvbmZpZyA9IHsN
Cj4gPiArCS5uYW1lID0gIlhpbGlueCBQUiBEZWNvdXBsZXIiLA0KPiA+ICt9Ow0KPiA+ICsNCj4g
PiArc3RhdGljIGNvbnN0IHN0cnVjdCB4bG54X2NvbmZpZ19kYXRhIHNodXRkb3duX2NvbmZpZyA9
IHsNCj4gPiArCS5uYW1lID0gIlhpbGlueCBERlggQVhJIHNodXRkb3duIG1nciIsDQo+IA0KPiBU
byBiZSBjb25zaXN0ZW50IHdpdGggZGVjb3VwbGVyIG5hbWUsDQo+IA0KPiBzaHV0ZG93biBtZ3Ig
LT4gU2h1dGRvd24gTWFuYWdlcg0KPiANCg0KV2lsbCBmaXggaW4gdjIuDQoNCj4gPiArfTsNCj4g
PiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHhsbnhfcHJfZGVjb3Vw
bGVyX29mX21hdGNoW10gPSB7DQo+ID4gLQl7IC5jb21wYXRpYmxlID0gInhsbngscHItZGVjb3Vw
bGVyLTEuMDAiLCB9LA0KPiA+IC0JeyAuY29tcGF0aWJsZSA9ICJ4bG54LHByLWRlY291cGxlciIs
IH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0gInhsbngscHItZGVjb3VwbGVyLTEuMDAiLCAuZGF0
YSA9ICZkZWNvdXBsZXJfY29uZmlnDQo+IH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0gInhsbngs
cHItZGVjb3VwbGVyIiwgLmRhdGEgPSAmZGVjb3VwbGVyX2NvbmZpZyB9LA0KPiA+ICsJeyAuY29t
cGF0aWJsZSA9ICJ4bG54LGRmeC1heGktc2h1dGRvd24tbWFuYWdlci0xLjAwIiwNCj4gPiArCQkJ
CQkuZGF0YSA9ICZzaHV0ZG93bl9jb25maWcgfSwNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAieGxu
eCxkZngtYXhpLXNodXRkb3duLW1hbmFnZXIiLA0KPiA+ICsJCQkJCS5kYXRhID0gJnNodXRkb3du
X2NvbmZpZyB9LA0KPiA+ICAJe30sDQo+ID4gIH07DQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUo
b2YsIHhsbnhfcHJfZGVjb3VwbGVyX29mX21hdGNoKTsNCj4gPg0KPiA+ICBzdGF0aWMgaW50IHhs
bnhfcHJfZGVjb3VwbGVyX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpICB7DQo+
ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+ID4gIAlz
dHJ1Y3QgeGxueF9wcl9kZWNvdXBsZXJfZGF0YSAqcHJpdjsNCj4gPiAgCXN0cnVjdCBmcGdhX2Jy
aWRnZSAqYnI7DQo+ID4gIAlpbnQgZXJyOw0KPiA+IEBAIC05NCw2ICsxMTIsMTQgQEAgc3RhdGlj
IGludCB4bG54X3ByX2RlY291cGxlcl9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiA+ICAJaWYgKCFwcml2KQ0KPiA+ICAJCXJldHVybiAtRU5PTUVNOw0KPiA+DQo+ID4g
KwlpZiAobnApIHsNCj4gPiArCQljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICptYXRjaDsNCj4g
PiArDQo+ID4gKwkJbWF0Y2ggPSBvZl9tYXRjaF9ub2RlKHhsbnhfcHJfZGVjb3VwbGVyX29mX21h
dGNoLCBucCk7DQo+ID4gKwkJaWYgKG1hdGNoICYmIG1hdGNoLT5kYXRhKQ0KPiA+ICsJCQlwcml2
LT5pcGNvbmZpZyA9IG1hdGNoLT5kYXRhOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgCXJlcyA9IHBs
YXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+ID4gIAlwcml2
LT5pb19iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7DQo+ID4g
IAlpZiAoSVNfRVJSKHByaXYtPmlvX2Jhc2UpKQ0KPiA+IEBAIC0xMTQsNyArMTQwLDcgQEAgc3Rh
dGljIGludCB4bG54X3ByX2RlY291cGxlcl9wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+ID4NCj4gPiAgCWNsa19kaXNhYmxlKHByaXYtPmNsayk7DQo+ID4NCj4gPiAt
CWJyID0gZGV2bV9mcGdhX2JyaWRnZV9jcmVhdGUoJnBkZXYtPmRldiwgIlhpbGlueCBQUiBEZWNv
dXBsZXIiLA0KPiA+ICsJYnIgPSBkZXZtX2ZwZ2FfYnJpZGdlX2NyZWF0ZSgmcGRldi0+ZGV2LCBw
cml2LT5pcGNvbmZpZy0+bmFtZSwNCj4gPiAgCQkJCSAgICAgJnhsbnhfcHJfZGVjb3VwbGVyX2Jy
X29wcywgcHJpdik7DQo+ID4gIAlpZiAoIWJyKSB7DQo+ID4gIAkJZXJyID0gLUVOT01FTTsNCj4g
PiBAQCAtMTI1LDcgKzE1MSw4IEBAIHN0YXRpYyBpbnQgeGxueF9wcl9kZWNvdXBsZXJfcHJvYmUo
c3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+DQo+ID4gIAllcnIgPSBmcGdh
X2JyaWRnZV9yZWdpc3Rlcihicik7DQo+ID4gIAlpZiAoZXJyKSB7DQo+ID4gLQkJZGV2X2Vycigm
cGRldi0+ZGV2LCAidW5hYmxlIHRvIHJlZ2lzdGVyIFhpbGlueCBQUg0KPiBEZWNvdXBsZXIiKTsN
Cj4gPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJ1bmFibGUgdG8gcmVnaXN0ZXIgJXMiLA0KPiA+
ICsJCQlwcml2LT5pcGNvbmZpZy0+bmFtZSk7DQo+ID4gIAkJZ290byBlcnJfY2xrOw0KPiA+ICAJ
fQ0KPiANCj4gTG9vayBhdCBYSUxJTlhfUFJfREVDT1VQTEVSIGVudHJ5IGluIEtjb25maWcsIG1h
eWJlIGFkZCBzb21ldGhpbmcgbGlrZQ0KPiANCj4gaGVscA0KPiANCj4gwqAgU2F5IFkgdG8gZW5h
YmxlIGRyaXZlcnMgZm9yIHRoZcKgIC4uLiBEZWNvdXBsZXIgb3IgREZYIEFJWCBTaHV0ZG93biBN
YW5hZ2VyDQo+DQoNCldpbGwgaW4gdjIuDQoNClJlZ2FyZHMsDQpOYXZha2lzaG9yZS4NCg==
