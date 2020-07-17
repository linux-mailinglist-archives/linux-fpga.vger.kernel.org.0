Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09D92231C5
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Jul 2020 05:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgGQDs0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Jul 2020 23:48:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:16067 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgGQDsZ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 Jul 2020 23:48:25 -0400
IronPort-SDR: 0mGteuQBK11w5jB/7bF5Ww0yqqzhvUYesDGrEUQ2a3a0PsmerWdfsVJwW8JVWUlX9LERdAhv7j
 tvUXaCWaaRFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="137651416"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="137651416"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:48:25 -0700
IronPort-SDR: NyAb9wrrfK6uhpTyX+qCdqMXauju3AylmZ3ASSkTPKK5QZBeYp2MhnogYfAHlzVR+jAFbocl69
 bbizmYC3RzxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="325327814"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2020 20:48:24 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Jul 2020 20:48:24 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Jul 2020 20:48:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Jul 2020 20:48:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERG+INepxEunj1N4u8dLzRhOq/KM39BkOax5usJmxR/zBRDrr2nSMdAJm0AOmkHBRDajQ/5wuyprk+y2xqN0tWrJsvJU3Terg+YulwX6ideJIg22yE6/byKb7whxVRm5xhIjhbD0KoQiH+8a6Jvk6Nut67hzKuSY2sZB2rQSeeZMelkFMGxdUhMrE0Y6i/oSDKe/QVcN0fw0fxIGaWxPUtciW7R7pwu0QJDq0pb0oP9otHGdPiD2TdzukleatgpWJpKOGECXCeUV1JHPe7382xZ1i4ueYNkHVVDOvoCzhUudfhtibF9slTIr9Pm09PrUzfIwCHuPjuGhBfgBuIFq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVzMD9iaQgFoxdTxbYxBv9KtyZEDG50ZobKOm9Oy4wY=;
 b=YYX4XADtxNhCTmilsGa4E5WSXh50XLHHwnCpMOH8ki5avP8Wq9MB9kuM2BvRm/u34od9EnLF5iZnThgW6p4Bo1AAQVQs4nqIl9tJzmjuliQugEU12NdvZZLPusZ5gsrhpQLz6RnGzQWuiJUbHQX/ngYpHoBt8Ba81lEjRSXEvv4NXLHkKWd2bKo0fAbY47aYf7X9e6Vb0DNvUZiGpx/mWZUXcVfhS+pvZKBYaFZEvwPnE5Z1X/zpU1LZSOLv9KEcQbmenK+pdpFwHamXqqONOX3vqdEn4H9HQF3rTHMQ+Ox7bBWkPdQi/Nce8rYmXHyHPp3dLfqEHf2r2HlFX8Z+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVzMD9iaQgFoxdTxbYxBv9KtyZEDG50ZobKOm9Oy4wY=;
 b=D3XQ476xCyOiK6MvIRnCt4gtOOraWYgq0gYilGQIuLWo7Y+dMFVRQ22iUDSYPUPxEU5obOIlUgyFqZAO3Z4SBNZ7JvqV14KwhcHkkw4Abiwx1E8OTXoTUUy1l0PkDyD+KECeqgMjFEhiyY4rgz2jejT9+8OB6lVoIdlL9vZiF08=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4219.namprd11.prod.outlook.com (2603:10b6:5:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 03:48:22 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 03:48:22 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Tom Rix <trix@redhat.com>, "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH 0/2] Modularization of DFL private feature drivers
Thread-Topic: [PATCH 0/2] Modularization of DFL private feature drivers
Thread-Index: AQHWWmrEJgXA6z6VKkSElM9m2kDwiKkK0kaAgABMTyA=
Date:   Fri, 17 Jul 2020 03:48:22 +0000
Message-ID: <DM6PR11MB38194C448ECCF1E6BF386D3F857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <0c7c63b8-5444-2deb-9fed-18956a5ad938@redhat.com>
In-Reply-To: <0c7c63b8-5444-2deb-9fed-18956a5ad938@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e5c8c22-1247-41c3-3a62-08d82a04408f
x-ms-traffictypediagnostic: DM6PR11MB4219:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4219E43758C79FCF6739AE8D857C0@DM6PR11MB4219.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FECI5F6QTaj+4LNuG9npmZSdlUDmyOXuv6UUw60/SWbXwuu5QVHRaG/pnA3+kvwT/HQ/2dHLhEyZyVNOjgFVl+pE79cuvuzl+pxqv63dvkVs+xEm2zVB9/c4ZTknC4unNs1wOg4W6X+4WVElLp2rUCrL5kQc5qPMaK8tFohkkTNxFt1iKs2HfFsTaDHXyWSIbP3yeS/NrDHo0mFUVkZnc099clyChxV/iHIbbJCZl5Kjpi//FtXKupgUFyzNN+5f8ZzOfXgQBSpuN6iv3A2B8Uleof9sPeyRLDPMniXhOUcl/a373c/ir/+PggYK7+WbmsN2jmEBciyeUpOml9+thg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(55016002)(9686003)(66446008)(478600001)(8676002)(316002)(110136005)(71200400001)(8936002)(2906002)(66476007)(66946007)(76116006)(66556008)(54906003)(4326008)(64756008)(53546011)(26005)(86362001)(7696005)(6506007)(52536014)(33656002)(83380400001)(5660300002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Mzprnqfqa02T77dM0eEtN+URyVjMzF1kdKDkR2FnTz8DBWdXKdcZIjXV0N5KBk6SugTCYZIHIKvTdbXOPhN1U2DTuTfLzpTn/SryXuCgrbgDlybfYZ5gqJ33tHqwW/74NnDBAco9r5Lpd/0jbQ2y0yb5ScsZgwZXI02SeJ0jo8B/1/izuFW6vv+Tdw6ypgvtCtbtqXwU3+9d6tkHV4/GZmXlkCZXzFYY1Gtprz5dpb/j7qFXNvbLlzUdtP6dYzkK3tXcbazpXEGwRJnNxN2wH5Ymf/OktTSXkTUdF6oCqsSVLLbXz/JRAsojbuHFdSL1YD6+OCk3lGQOTqP/D7Pr/QZepxrQ0Q2/QI3O9u4LIZlY4JdRReEZIpQMnZH4+wlLqUi+0hCHfQ5d3GS0Zg6c96MuhxKcNSeI0R4t2W5vOON0QJeElKe117Jvjuc6j+undHFwx9X7Qe4DRxSfw/YTO4Si4+tN0vvRYbA7h/hNvGPUd4JyfBCNFU2hVAR0HCJ+
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5c8c22-1247-41c3-3a62-08d82a04408f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 03:48:22.3249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fhqgu73pqWB5IjUl4HD+nMY7Isq0Rti0Ujy6qDzceVpLhcM2MR+xe5YyGopcUHLHVVSnew73bEroXyUDT7Uc5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4219
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAvMl0gTW9kdWxhcml6YXRpb24gb2YgREZMIHByaXZhdGUg
ZmVhdHVyZSBkcml2ZXJzDQo+IA0KPiBHZW5lcmFsbHkgaSB0aGluayB0aGlzIGlzIGEgZ29vZCBh
cHByb2FjaC4NCj4gDQo+IEhvd2V2ZXIgSSBkbyBoYXZlIGNvbmNlcm4uDQo+IA0KPiBUaGUgZmVh
dHVyZV9pZCBpbiBkZmwgaXMgbWFnaWMgbnVtYmVyLCBzaW1pbGFyIHRvIHBjaSBpZCBidXQgd2l0
aG91dCBhIHZlbmRvcg0KPiBpZC4NCj4gDQo+IElzIGl0IHBvc3NpYmxlIHRvIGFkZCBzb21ldGhp
bmcgbGlrZSBhIHZlbmRvciBpZCBzbyBkaWZmZXJlbnQgdmVuZG9ycyB3b3VsZA0KPiBub3QgaGF2
ZSB0byBiZSBzbyBjYXJlZnVsIHRvIHVzZSBhIHVuaXF1ZSBpZCA/DQoNCkhpIFRvbSwNCg0KVGhh
bmtzIGZvciB0aGUgY29tbWVudHMuDQoNCkhlcmUgaXMgb25seSBvbmUgZmllbGQgZGVmaW5lZCBp
biBzcGVjLCB0aGF0IGlzIGZlYXR1cmUgaWQgdG8gZGlzdGluZ3Vpc2ggb25lDQpmZWF0dXJlIHdp
dGggYW5vdGhlciBvbmUuIFRoZXJlIGlzIG5vIHZlbmRvciBpZCBoZXJlIEkgdGhpbmssIGFuZCBz
ZXZlcmFsDQpjYXJkcyBhcmUgdXNpbmcgdGhpcyBmb3Igbm93IGFuZCBzZWVtcyBub3QgcG9zc2li
bGUgdG8gY2hhbmdlIERGSCBmb3JtYXQNCmZvciB0aGVzZSBwcm9kdWN0cy4gOiAoDQoNCkkgZnVs
bHkgdW5kZXJzdGFuZCB0aGUgY29uY2VybiBpcyB0aGUgZmVhdHVyZSBpZCBtYW5hZ2VtZW50LCBh
bmQgcG90ZW50aWFsDQpjb25mbGljdHMgdGhlcmUgZnJvbSBkaWZmZXJlbnQgdmVuZG9ycy4gT25l
IHBvc3NpYmxlIG1ldGhvZCB0byByZXNvbHZlIHRoaXMNCmlzIG1hbmFnaW5nIHRoZSBpZHMgaW4g
YSBwdWJsaWMgcGxhY2UgKHdlYj8gT3IganVzdCB0aGUgZHJpdmVyIGhlYWRlciBmaWxlIGZvcg0K
ZmVhdHVyZSBpZCBkZWZpbml0aW9uKSwgYWxsIHZlbmRvcnMgY2FuIHJlcXVlc3Qgc29tZSBmZWF0
dXJlIGlkcywgYW5kIG90aGVyDQpwZW9wbGUgY2FuIHNlZSB3aGljaCBmZWF0dXJlIGlkcyBoYXZl
IGJlZW4gdXNlZCBzbyB0aGF0IHRoZXkgY2FuIGF2b2lkDQp1c2luZyBjb25mbGljdCBvbmVzIHdp
dGggb3RoZXIgcGVvcGxlLg0KDQpBbmQgaW4gdGhlIGxhdGVyIHZlcnNpb24gREZILCB0aGlzIGZl
YXR1cmUgaWQgd2lsbCBiZSByZXBsYWNlZCB3aXRoIEdVSUQNCkkgdGhpbmssIHNvIGl0IGNhbiBy
ZXNvbHZlIHRoZSBjb25mbGljdCBwcm9ibGVtcyBmcm9tIGRpZmZlcmVudCB2ZW5kb3JzPw0KQnV0
IG5vdywgd2Ugc3RpbGwgbmVlZCB0byBoYW5kbGUgdGhlIGV4aXN0aW5nIG9uZXMuIDogKQ0KDQpU
aGFua3MNCkhhbw0KDQo+IA0KPiBUaGlzIHRvdWNoZXMgc29tZSBvZiB0aGUgbWF0Y2hpbmcgZnVu
Y3Rpb24gb2YgdGhlIGJ1cyBvcHMuwqAgQ291bGQgdGhlcmUgYmUgYQ0KPiB3YXkgZm9yIGJ1cyBv
cHMgdG8gYmUgdXNlZCBzbyB0aGF0IHRoZXJlIGNvdWxkIGJlIG11bHRpcGxlIG1hdGNoaW5nDQo+
IGZ1bmN0aW9uLsKgIE1heWJlIHRoZSBvbmUgaW4gMDAwMiBhcyBhIGRlZmF1bHQgc28gdXNlcnMg
Y291bGQgb3ZlcnJpZGUgaXQgPw0KPiANCj4gVGhlIHVzZSBjYXNlIEkgYW0gd29ycnlpbmcgYWJv
dXQgaXMgYW4gT0VNLsKgIFRoZSBPRU0gdXNlcyBhbiB1bmNsYWltZWQNCj4gZmVhdHVyZV9pZCBh
bmQgc3VwcGxpZXMgdGhlaXIgb3duIHBsYXRmb3JtIGRldmljZSBkZXZpY2UgZHJpdmVyIHRvIG1h
dGNoIHRoZQ0KPiBmZWF0dXJlX2lkLsKgIEJ1dCBzb21lIGxhdGVyIHZlcnNpb24gb2YgdGhlIGtl
cm5lbCBjbGFpbXMgdGhpcyBmZWF0dXJlX2lkIGFuZA0KPiB0aGUgT0VNJ3MgZHJpdmVyIG5vIGxv
bmdlciB3b3JrcyBhbmQgc2luY2UgdGhlIHZhbHVlIGNvbWVzIGZyb20gcGNpIGNvbmZpZw0KPiBz
cGFjZSBpdCBpcyBkaWZmaWN1bHQgdG8gY2hhbmdlLg0KPiANCj4gU28gbG9va2luZyBmb3Igc29t
ZXRoaW5nIGxpa2UNCj4gDQo+IHJlZ2lzdGVyX2ZlYXR1cmVfbWF0Y2hlcigoKmJ1c19tYXRjaCko
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QNCj4gZGV2aWNlX2RyaXZlciAqZHJ2KSkNCj4gDQo+
IHN0YXRpYyBpbnQgZGZsX2J1c19tYXRjaF9kZWZhdWx0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3Ry
dWN0IGRldmljZV9kcml2ZXIgKmRydikNCj4gew0KPiDCoMKgwqAgc3RydWN0IGRmbF9kZXZpY2Ug
KmRmbF9kZXYgPSB0b19kZmxfZGV2KGRldik7DQo+IMKgwqDCoCBzdHJ1Y3QgZGZsX2RyaXZlciAq
ZGZsX2RydiA9IHRvX2RmbF9kcnYoZHJ2KTsNCj4gwqDCoMKgIGNvbnN0IHN0cnVjdCBkZmxfZGV2
aWNlX2lkICppZF9lbnRyeSA9IGRmbF9kcnYtPmlkX3RhYmxlOw0KPiANCj4gwqDCoMKgIHdoaWxl
IChpZF9lbnRyeS0+ZmVhdHVyZV9pZCkgew0KPiDCoMKgwqAgwqDCoMKgIGlmIChkZmxfbWF0Y2hf
b25lX2RldmljZShpZF9lbnRyeSwgZGZsX2RldikpIHsNCj4gwqDCoMKgIMKgwqDCoCDCoMKgwqAg
ZGZsX2Rldi0+aWRfZW50cnkgPSBpZF9lbnRyeTsNCj4gwqDCoMKgIMKgwqDCoCDCoMKgwqAgcmV0
dXJuIDE7DQo+IMKgwqDCoCDCoMKgwqAgfQ0KPiDCoMKgwqAgwqDCoMKgIGlkX2VudHJ5Kys7DQo+
IMKgwqDCoCB9DQo+IA0KPiDCoMKgwqAgcmV0dXJuIDA7DQo+IH0NCj4gDQo+IHJlZ2lzdGVyX2Zl
YXR1cmVfbWF0Y2hlcigmZGZsX2J1c19tYXRjaF9kZWZhdWx0KQ0KPiANCj4gc3RhdGljIGludCBk
ZmxfYnVzX21hdGNoKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9kcml2ZXIgKmRy
dikNCj4gew0KPiANCj4gwqDCoMKgIHN0cnVjdCBkZmxfZGV2aWNlICpkZmxfZGV2ID0gdG9fZGZs
X2RldihkZXYpOw0KPiDCoMKgwqAgc3RydWN0IGRmbF9kcml2ZXIgKmRmbF9kcnYgPSB0b19kZmxf
ZHJ2KGRydik7DQo+IMKgwqDCoCBjb25zdCBzdHJ1Y3QgZGZsX2RldmljZV9pZCAqaWRfZW50cnkg
PSBkZmxfZHJ2LT5pZF90YWJsZTsNCj4gDQo+IMKgwqDCoCB3aGlsZSAoaWRfZW50cnktPmZlYXR1
cmVfaWQpIHsNCj4gDQo+IMKgwqDCoCDCoMKgwqAgbWF0Y2hlciA9IExvb3Agb3ZlciBtYXRjaGVy
cygpDQo+IA0KPiDCoMKgwqAgwqDCoMKgIGlmIChtYXRjaGVyKGRldiwgZHJ2KSkgew0KPiDCoMKg
wqAgwqDCoMKgwqDCoMKgwqAgZGZsX2Rldi0+aWRfZW50cnkgPSBpZF9lbnRyeTsNCj4gwqDCoMKg
IMKgwqDCoMKgwqDCoMKgIHJldHVybiAxOw0KPiDCoMKgwqDCoMKgwqDCoCB9DQo+IMKgwqDCoCDC
oMKgwqAgaWRfZW50cnkrKzsNCj4gwqDCoMKgIH0NCj4gDQo+IMKgwqDCoCByZXR1cm4gMDsNCj4g
fQ0KPiANCj4gT3IgbWF5YmUgdXNlIHNvbWUgb2YgdGhlIHVudXNlZCBiaXRzIGluIHRoZSBkZmwg
aGVhZGVyIHRvIGFkZCBhIHNlY29uZA0KPiB2ZW5kb3ItbGlrZSBpZCBhbmQgY2hhbmdlIGV4aXN0
aW5nIG1hdGNoZXIgdG8gbG9vayBmZWF0dXJlX2lkIGFuZA0KPiB2ZW5kb3JfbGlrZV9pZC4NCj4g
DQo+IFRvbQ0KPiANCj4gDQo+IA0KPiBPbiA3LzE0LzIwIDEwOjM4IFBNLCBYdSBZaWx1biB3cm90
ZToNCj4gPiBUaGlzIHBhdGNoc2V0IG1ha2VzIGl0IHBvc3NpYmxlIHRvIGRldmVsb3AgaW5kZXBl
bmRlbnQgZHJpdmVyIG1vZHVsZXMNCj4gPiBmb3IgREZMIHByaXZhdGUgZmVhdHVyZXMuIEl0IGFs
c28gaGVscHMgdG8gbGV2ZXJhZ2UgZXhpc3Rpbmcga2VybmVsDQo+ID4gZHJpdmVycyB0byBlbmFi
bGUgc29tZSBJUCBibG9ja3MgaW4gREZMLg0KPiA+DQo+ID4gWHUgWWlsdW4gKDIpOg0KPiA+ICAg
ZnBnYTogZGZsOiBtYXAgZmVhdHVyZSBtbWlvIHJlc291cmNlcyBpbiB0aGVpciBvd24gZmVhdHVy
ZSBkcml2ZXJzDQo+ID4gICBmcGdhOiBkZmw6IGNyZWF0ZSBhIGRmbCBidXMgdHlwZSB0byBzdXBw
b3J0IERGTCBkZXZpY2VzDQo+ID4NCj4gPiAgRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNm
cy1idXMtZGZsIHwgIDE1ICsrDQo+ID4gIGRyaXZlcnMvZnBnYS9kZmwtcGNpLmMgICAgICAgICAg
ICAgICAgICB8ICAyMSArLQ0KPiA+ICBkcml2ZXJzL2ZwZ2EvZGZsLmMgICAgICAgICAgICAgICAg
ICAgICAgfCA0MzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4gPiAgZHJpdmVy
cy9mcGdhL2RmbC5oICAgICAgICAgICAgICAgICAgICAgIHwgIDkxICsrKysrKy0NCj4gPiAgNCBm
aWxlcyBjaGFuZ2VkLCA0OTIgaW5zZXJ0aW9ucygrKSwgNzAgZGVsZXRpb25zKC0pDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1kZmwN
Cj4gPg0KDQo=
