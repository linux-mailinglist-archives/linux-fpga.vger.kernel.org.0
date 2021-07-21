Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6179E3D07E5
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Jul 2021 06:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhGUEHz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Jul 2021 00:07:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:3241 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhGUEHu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 21 Jul 2021 00:07:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="272486034"
X-IronPort-AV: E=Sophos;i="5.84,257,1620716400"; 
   d="scan'208";a="272486034"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 21:48:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,257,1620716400"; 
   d="scan'208";a="432480248"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jul 2021 21:48:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 20 Jul 2021 21:48:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 20 Jul 2021 21:48:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 20 Jul 2021 21:48:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrZ6XilVkxw4S7UPGoe9tzj39+0Wx9xBAz4Lj4lB1W8ClAM9+UsSTD0FQXOb7aqxjJujGv0ey85OjHXqp0Ct222mBc6Q7NXugWPjfnbl5z7bi5l4Y1ehzVe6bdZt24TXgpnw/GVNVfaoTheB350FS4EMaHMmha+BTETs4ET6KzKE3r0u/DaQPqvtIBpEAgkBB93NrFXBMubd3im2GU9SjNM/PuYAR8VDIGMww22U9bwUX70zBW2hrM/k1K5tQiUmnZTiS/w9x5cMGcz3VmShpw2jgA+gpp8/cQ14hNLcC6EaJPHnHjrsZrr8+EvGu6Ksa0bvazElyx1DBSZBOhml5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv1FSxrbfO7reOxhl0L2OjqR1HabfliILGqKWyGhMww=;
 b=h/NOoH63tm6Sjq64Qpd7DmmNtqcnsamcuiVwhR6GI5ENR4DASy0t/s4buX9Tb7RgidVRMWfq8lUSTC+8YJr+oON+ANq4td0+QeZiPlAIgbm8Trp0OT/a4/PRW96bZsqJZ3JXKxiwQTD7/dDxP34G0YrA5mzHFhKvU2OFnC/Y/tMuW7MnJ1+YgxiDmO392ez7o4fHIFGvwuvU5ytJBmJ/lHqlXWrG0QXDXYG3VkKMnJ0x2g74eFor8wSyQXzZWD53hK3c11DEIlY+hVsH5sKt0iwHShQhUaqgOT7eIZuWUf6q21cQQswWDv+EVGj2GxWmaGHw75iWXFWbEIHTMP++3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv1FSxrbfO7reOxhl0L2OjqR1HabfliILGqKWyGhMww=;
 b=FFBeFzrAdjEfG9bFORSAUDjiIVGNzqNrb9FlmEX/alaQRSXijbAs4E9cvCJNTh+UoyJg4hPPvfYTQr/UlaDK7s1XIVE0FasAmusnisfd/CCcikQ1KS9uJzRH3L37KjpBsynAhED4L5FP8RW5sqmU0E/DdN7lFtmMvg1+THkWNhk=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3914.namprd11.prod.outlook.com (2603:10b6:5:197::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 04:48:17 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4308.027; Wed, 21 Jul 2021
 04:48:17 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Weight, Russell H" <russell.h.weight@intel.com>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] fpga: remove compat_id from fpga_manager and
 fpga_region
Thread-Topic: [PATCH v2 4/4] fpga: remove compat_id from fpga_manager and
 fpga_region
Thread-Index: AQHXdMhnnZ/opknHKEOx9KM5yJtYvas+kL3QgADx7QCADVWi4A==
Date:   Wed, 21 Jul 2021 04:48:16 +0000
Message-ID: <DM6PR11MB38193C3FE87830E9627E112C85E39@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210709134229.2510349-1-trix@redhat.com>
 <20210709134229.2510349-6-trix@redhat.com>
 <DM6PR11MB3819098B673C54530B227D4385159@DM6PR11MB3819.namprd11.prod.outlook.com>
 <2a3b3131-96a3-9761-f2e7-63a32fd277f6@redhat.com>
In-Reply-To: <2a3b3131-96a3-9761-f2e7-63a32fd277f6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfc21917-cfe1-406e-9eb7-08d94c02c1ac
x-ms-traffictypediagnostic: DM6PR11MB3914:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3914D5B0120946DBA0242F3585E39@DM6PR11MB3914.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Swzdt7EoMExww7KRFWSQfs3aoZBezJEXEXMY2RF3zFIRogMf8L4UyPV4U+bmaCmGKwoLIb3xk43sjkCiyJmh59gMQhzi28G5DKfA+UhxAsTUw5m5T8Jb8sWp+5Wb2DOW+jyE5vaus3LpJyzSa/Fm8nvj5tkeMjzWey4C674MG1DHUYqoDjOmwqPuocRMMgpQAwhluNvgYyZieG2YOL4kol1R1bZQ/hT81ukFKKTaZs9kitvFo5+yThB+JkOGq323b+YMYAH3yTDRPw/itRPiKcRgwQuzB65mGmbdmqvKvwF5p62rAsMwRw78xwU0erm7b6ji1pAfabVUu7mKI59yYSnQ8g7wUYiUlqZWYPTbib/gWbqFiQKbEgR0LCXVq1+WcqDI0h3lyLYvO/i62aYWlGyvJWebqQt7Poc8Qx8ywrSXVk5dRiuDmS2ebnDlV2A1x3KxaJ7dcR+gRGbFVsNaQDj5OPQ5pSeloAX06tJlr9sv5eXqBFyZKYAQVHvB5fabDjNJ40ek6V/RV4GmYhmkmUszxDvF/kaDMjSc5PQLQxm4ih/GU6An1UcVSCTC+SAjkDqSyuS9OPmXDQ/SZfJLrdajzqpxbWR3MTomJ1PJd2St4LPV3gIVUPmZ9QCLNNZO2ZPyt3hsUCb/w/0H8NQFMkmoLiDKxWYrvoBVHHU/GSTXx3otV+TXHQcVTbGATVdTIGjqAYDf8vY/uiLHAd1c/F+vNYfreEXqgd78IiOBAhg63cMmY9ir1Q3qV7axveQUL0GYvQK3ifUOCiTv5ONxin+FaEHzngkvcjbFwYVipY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(8676002)(66446008)(55016002)(9686003)(64756008)(186003)(966005)(71200400001)(8936002)(66476007)(110136005)(2906002)(316002)(6636002)(66946007)(83380400001)(53546011)(6506007)(54906003)(7696005)(86362001)(52536014)(122000001)(76116006)(38100700002)(33656002)(508600001)(5660300002)(4326008)(26005)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVhPeE5NN0JUNWVOaUZJSGhjQm44M3VlbkJKK1lNNnlOM2JlcFlBdUgvRHZi?=
 =?utf-8?B?aHdsNzUvd2ZJWUZhWHVGOGJuOFZPbTV0akgrOTV4c2dlaW1iKy9KUjh1QnVv?=
 =?utf-8?B?QVFvLzRpbkU4a2E1ajA1RFJXb3ZUY1hvS2pHckxnQnhXOWs2RFBKTFR3M1Jm?=
 =?utf-8?B?c3Q0NkZtY1cyQlUyQ0ZvZUpza1Z4d3NkNzN6cCtoVWl1N1VIeTFQNmpPTk8w?=
 =?utf-8?B?bzc1VTlndVZRNU9sSnNmQStaR05JaHlVOUl0bFIrVTJ5QlZ3VW05OEpISjJO?=
 =?utf-8?B?aFBkMDR0T1NlV3lnNHl1TFZRWS85bENYY0NlWFc3ZktjTnd2Rnh1MjZpUlJa?=
 =?utf-8?B?aXdYclA0YXM2NlpGWlc5c29oSjYrNEJac1VuQWEvQzZSWTZQV1pDd3BUV21U?=
 =?utf-8?B?bHVlZjVLQ2paMFd6NkRQUzZoN3lEdnZQQi9JZDNyU041TWVJK2ZnTU9NMzNW?=
 =?utf-8?B?YXNEOEdScWtjeU9ocEV2c0hHMzBNR09kOUZMTlNyQ2dYUGxLK0pmVHM4SlQ4?=
 =?utf-8?B?dnVHbUc1Vm5EWTZleU50MVhoY3drS3Uwc0l4WVEvQ1IxdnFHK0htVFBKV1ZB?=
 =?utf-8?B?cmVsNkRJQnBmYkNNR3RUalJ1UnNMbVg4eWNIRHNXcUlESzRVY20xbzR4NVNW?=
 =?utf-8?B?aFgxT3V0V0VkVnUrNU5MRVBxNUpqTlhhbzdxMitsMEhaWUlLRnBOcDBGbjZL?=
 =?utf-8?B?QW9xcU8ySTJEWnJDTU4wME5tSEFjY0hWWUQvUlpyMStWcWxDc1diekNkL09q?=
 =?utf-8?B?dktCeER1WXNXckhmR1V3dmRVMFlRNEEyNTZqTmZKSDAxRTBkT0pjUVpZOXZC?=
 =?utf-8?B?eEpqRUVudkxabjRyVnNWYTEzTWZDa1FYM2U3L2hyK2NPZk0vRGZtTHE5eUV3?=
 =?utf-8?B?SDRCYkxScFZsVFM1WVRRbGdjRE9HTVZTd0xNNjZ4bmpKb0RsdFllcjNXTmNr?=
 =?utf-8?B?ejRSVThldFA3WUs2SlZjQ2owcHVlaHFNa2czOXRIMEFlY2tMVGxjczFuK0oy?=
 =?utf-8?B?VDZQZFJscjVGcGZSTkpVREQrVmI5VVV1TjlQaUFVY0g2VEx0UFJ1bUF1TjZE?=
 =?utf-8?B?U3RYeWlMSU8rYlFIeXZDZWVVdzF3Y1RhUWRWK1U1SjNnL3JoaVYxS09MNEdt?=
 =?utf-8?B?MGZmVWY5NjJsdjV0SlZsZFlZbHdwejJrY3NyOU8vMWF2QVJMUmhUaC9aYkJE?=
 =?utf-8?B?VGkxbVpoK05qUlFjMDJxaS9hSzFkSUE1YTVDNHUvVk1zLzd2czl6ckRmQWlt?=
 =?utf-8?B?SGVqVWtraWRsN2t5NldwY2U3b242Z0c4U09kL1ZpL0d4amdIbW9vNjhoMU4v?=
 =?utf-8?B?b3dpNnZHVUJ2ajM4OUhrMUVWQUlxRnVJbHpJYkRDMFN0dlpkV2EydWNwMTZt?=
 =?utf-8?B?T1pLc2pHV2x3bjVxSVJmZTlGY05WSDZtK0padDlMclZtZVpSUW5OTjhwTm5M?=
 =?utf-8?B?NFRFT3hlbnBNNDk2VWxqajlwODNJMEV4NnVLTS8zSGhwVm5aZmNyamNBNUJj?=
 =?utf-8?B?Y1NUNUhoQ3FGdHRYci9uUm1nZWw2b2l2RUxuNCs3RjhOYnNLazdWdm5JdWtt?=
 =?utf-8?B?K3kwWEVYQUFUMkZySHV1bDVXcEw1bCtCZkY3SHl6dTc1OFl1QU9OaEprUzlU?=
 =?utf-8?B?djlPZmlVaDA0eTNmL3ZTM1ovOXZJZ3pvRTUzdFArY1VNRkd0eEhONWNicjAr?=
 =?utf-8?B?MWllUnpPV3M4cGhBa2pjY3ViMzFGNEQzaDk1cnlBUlc1UFpKUWFBVFI2L2E5?=
 =?utf-8?Q?t4T17YNUwX356cHBpm1iJHDiN5rQYh5I42hStQ4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc21917-cfe1-406e-9eb7-08d94c02c1ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 04:48:17.1577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0KobXQpFKqYEqAY4TU27r15i2DkoPb1QQtECSPmTcu6M06ikdOmxKMKCFs0EGka+NLHsNm1Yo91nPmeWxWQjhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3914
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBPbiA3LzExLzIxIDY6NDAgUE0sIFd1LCBIYW8gd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IHRyaXhAcmVkaGF0LmNvbSA8dHJpeEByZWRoYXQuY29t
Pg0KPiA+PiBTZW50OiBGcmlkYXksIEp1bHkgOSwgMjAyMSA5OjQyIFBNDQo+ID4+IFRvOiBtZGZA
a2VybmVsLm9yZzsgY29yYmV0QGx3bi5uZXQ7IFd1LCBIYW8gPGhhby53dUBpbnRlbC5jb20+DQo+
ID4+IENjOiBsaW51eC1mcGdhQHZnZXIua2VybmVsLm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtDQo+ID4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFRvbSBSaXggPHRyaXhA
cmVkaGF0LmNvbT4NCj4gPj4gU3ViamVjdDogW1BBVENIIHYyIDQvNF0gZnBnYTogcmVtb3ZlIGNv
bXBhdF9pZCBmcm9tIGZwZ2FfbWFuYWdlciBhbmQNCj4gPj4gZnBnYV9yZWdpb24NCj4gPj4NCj4g
Pj4gRnJvbTogVG9tIFJpeCA8dHJpeEByZWRoYXQuY29tPg0KPiA+Pg0KPiA+PiBjb21wYXRfaWQg
aXMgaW1wbGVtZW50YXRpb24gc3BlY2lmaWMuICBTbyB0aGUgZGF0YSBzaG91bGQgYmUNCj4gPj4g
c3RvcmVkIGF0IHRoZSBpbXBsZW1lYXRpb24gbGF5ZXIsIG5vdCB0aGUgaW5mcmFzdHJ1Y3R1cmUg
bGF5ZXIuDQo+ID4+IFJlbW92ZSB0aGUgY29tcGF0X2lkIGVsZW1lbnRzIGFuZCBzdXBwb3J0aW5n
IGNvZGUuDQo+ID4gSSB0aGluayBjdXJyZW50IGNvbXBhdF9pZCBmb3JtYXQgY2FuIG1lZXQgdGhl
IGNoZWNraW5nIHJlcXVpcmVtZW50Lg0KPiA+IEFjdHVhbGx5IEkgaG9wZSBvdGhlciBoYXJkd2Fy
ZSB3aGljaCBuZWVkcyBjb21wYXRpYmxlIGNoZWNraW5nDQo+ID4gdG8gZXhwb3NlIHRoZSBzYW1l
IGZvcm1hdCBjb21wYXRfaWQuIFRoZW4gd2UgY2FuIGhhdmUgbW9yZQ0KPiA+IHVuaWZpZWQvY29t
bW9uIGNvZGUsIGUuZy4gdXNlcnNwYWNlIGFwcGxpY2F0aW9uL2xpYiBoYW5kbGluZy4NCj4gDQo+
IHYyIGRvZXMgbm90IGNoYW5nZSB0aGUgY3VycmVudCBBQkkuIFRoZSBkZmwgb3V0cHV0IGlzIHRo
ZSBzYW1lIGFzDQo+IGJlZm9yZSwgdGhlIG90aGVyIG5vbnVzZXJzIGdldCAtRU5PRU5ULg0KDQpJ
IHRoaW5rIHRoZSBjb21tb24gQUJJIGlzIGNoYW5nZWQgc29tZWhvdywgYXMgb3V0cHV0IGZvcm1h
dCBjYW4NCmJlIGFueXRoaW5nIHdpdGggeW91ciBjaGFuZ2UsIHRoaXMgY29uZnVzZXMgdXNlcnNw
YWNlIHRvby4NCg0KPiANCj4gRm9yIGRmbCBjb21wYXRfaWQgaXMgMiA2NCBiaXQgcmVnaXN0ZXJz
Lg0KPiANCj4gRm9yIGNvbXBhdF9pZCB0byBiZSB1c2VmdWwgdG8gdGhlIG90aGVycywgdGhleSBu
ZWVkIHRoZSBmbGV4aWJpbGl0eSB0bw0KPiBwcmludCB0byB0aGUgc3lzZnMgaW4gdGhlIG1hbm5l
ciB0aGF0IGFsaWducyB3aXRoIHdoYXRldmVyIHRoZWlyIHVzZXINCj4gbGlicmFyeSBpbnRlcmZh
Y2UgaXMsIDIgNjQgdmFsdWVzIGlzbid0IGdvaW5nIHRvIHdvcmsgZm9yIGV2ZXJ5b25lLsKgIGV4
Lw0KPiB4cnQgbGlrZWx5IHdvdWxkIGJlIGEgdXVpZF90IHByaW50ZWQgb3V0IGEgc3BlY2lhbCB3
YXkuIHNvbWVvbmUgZWxzZQ0KPiBtYXliZSBqdXN0IHN0cmluZyBpbiB0aGUgYm9hcmQgZncsIG1h
eWJlIHNvbWUgaGFzIGEgOCBvciAyNTYgYml0cyBvZg0KPiBjb21wYXRfaWTCoCBldGMuDQo+IA0K
PiBhcyBhIGRyaXZlciByZWdpb24gc3BlY2lmaWMgb3AsIG90aGVycyBhcmUgZnJlZSB0byBkbyB3
aGF0ZXZlciBpcyByZXF1aXJlZC4NCj4gDQo+ID4gQ3VycmVudGx5IEkgZGlkbid0IHNlZSBhbnkg
b3RoZXIgdXNhZ2Ugb3IgcmVxdWlyZW1lbnQgb24gdGhpcyBwYXJ0DQo+ID4gbm93LCBvbmx5IERG
TCB1c2VzIGl0LiAgU28gc2hvdWxkIHdlIGxlYXZlIGl0IGhlcmUgYXQgdGhpcyBtb21lbnQ/DQo+
ID4gSSBmZWVsIHdlIGRvbid0IGhhdmUgdG8gY2hhbmdlIGl0IGZvciBub3cgdG8gbW92ZSBpdCB0
byBhDQo+ID4gUGVyLWZwZ2EtbWdyIGZvcm1hdC4gOiApDQo+IA0KPiBUaGUgbW90aXZhdGlvbiBm
b3IgZG9pbmcgdGhpcyBub3cgaXMgdGhlICd1c2Ugc3RhbmRhcmQgY2xhc3MgZGV2IHJlbGVhc2UN
Cj4gLi4gJyBwYXRjaHNldA0KPiANCj4gSSByZWFsbHkgZG8gbm90IGxpa2UgMiByZWdpc3RlciBm
dW5jdGlvbnMuDQo+IA0KPiBCeSBtb3ZpbmcgY29tcGF0X2lkLCB0aGUgMiByZWdpc3RlciBmdW5j
dGlvbnMgcmVkdWNlcyBkb3duIHRvIDEuDQo+IA0KDQpZb3UgZG9uJ3QgaGF2ZSB0byBtb3Zpbmcg
Y29tcGFjdF9pZCwgeW91IGNhbiBoYXZlIDEgcGFyYW1ldGVyDQp3aXRoIGEgZGF0YSBzdHJ1Y3R1
cmUgaW5jbHVkaW5nIGV2ZXJ5dGhpbmcuDQoNClRoYW5rcw0KSGFvDQoNCj4gSSBkaWQgYSBwb2Mg
aGVyZQ0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZnBnYS8yMDIxMDcwOTE4
NDUxMS4yNTIxNTA4LTEtDQo+IHRyaXhAcmVkaGF0LmNvbS8NCj4gDQo+IFRvbQ0KPiANCj4gPg0K
PiA+IFRoYW5rcw0KPiA+IEhhbw0KPiA+DQo+ID4+IFByaW50aW5nIG91dCB0aGUgY29tcGF0X2lk
IGlzIGRvbmUgd2l0aCB0aGUgZnBnYV9yZWdpb24NCj4gPj4gY29tcGF0X2lkX3Nob3coKSBvcC4N
Cj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogVG9tIFJpeCA8dHJpeEByZWRoYXQuY29tPg0KPiA+
PiAtLS0NCj4gPj4gICBkcml2ZXJzL2ZwZ2EvZGZsLWZtZS1tZ3IuYyAgICAgICB8ICA3IC0tLS0t
LS0NCj4gPj4gICBkcml2ZXJzL2ZwZ2EvZGZsLWZtZS1yZWdpb24uYyAgICB8ICAxIC0NCj4gPj4g
ICBkcml2ZXJzL2ZwZ2EvZnBnYS1yZWdpb24uYyAgICAgICB8ICA3ICstLS0tLS0NCj4gPj4gICBp
bmNsdWRlL2xpbnV4L2ZwZ2EvZnBnYS1tZ3IuaCAgICB8IDEzIC0tLS0tLS0tLS0tLS0NCj4gPj4g
ICBpbmNsdWRlL2xpbnV4L2ZwZ2EvZnBnYS1yZWdpb24uaCB8ICAyIC0tDQo+ID4+ICAgNSBmaWxl
cyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMjkgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2ZwZ2EvZGZsLWZtZS1tZ3IuYyBiL2RyaXZlcnMvZnBnYS9kZmwt
Zm1lLW1nci5jDQo+ID4+IGluZGV4IGNkMGI5MTU3ZWE2ZTUuLjhjNTQyM2VlZmZlNzUgMTAwNjQ0
DQo+ID4+IC0tLSBhL2RyaXZlcnMvZnBnYS9kZmwtZm1lLW1nci5jDQo+ID4+ICsrKyBiL2RyaXZl
cnMvZnBnYS9kZmwtZm1lLW1nci5jDQo+ID4+IEBAIC0yOTIsNyArMjkyLDYgQEAgRVhQT1JUX1NZ
TUJPTF9HUEwoZm1lX21ncl9nZXRfY29tcGF0X2lkKTsNCj4gPj4gICBzdGF0aWMgaW50IGZtZV9t
Z3JfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPj4gICB7DQo+ID4+ICAg
CXN0cnVjdCBkZmxfZm1lX21ncl9wZGF0YSAqcGRhdGEgPSBkZXZfZ2V0X3BsYXRkYXRhKCZwZGV2
LT5kZXYpOw0KPiA+PiAtCXN0cnVjdCBmcGdhX2NvbXBhdF9pZCAqY29tcGF0X2lkOw0KPiA+PiAg
IAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+PiAgIAlzdHJ1Y3QgZm1lX21n
cl9wcml2ICpwcml2Ow0KPiA+PiAgIAlzdHJ1Y3QgZnBnYV9tYW5hZ2VyICptZ3I7DQo+ID4+IEBA
IC0zMTIsMTAgKzMxMSw2IEBAIHN0YXRpYyBpbnQgZm1lX21ncl9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlDQo+ID4+ICpwZGV2KQ0KPiA+PiAgIAkJCXJldHVybiBQVFJfRVJSKHByaXYtPmlv
YWRkcik7DQo+ID4+ICAgCX0NCj4gPj4NCj4gPj4gLQljb21wYXRfaWQgPSBkZXZtX2t6YWxsb2Mo
ZGV2LCBzaXplb2YoKmNvbXBhdF9pZCksIEdGUF9LRVJORUwpOw0KPiA+PiAtCWlmICghY29tcGF0
X2lkKQ0KPiA+PiAtCQlyZXR1cm4gLUVOT01FTTsNCj4gPj4gLQ0KPiA+PiAgIAlfZm1lX21ncl9n
ZXRfY29tcGF0X2lkKHByaXYtPmlvYWRkciwgJnByaXYtPmNvbXBhdF9pZCk7DQo+ID4+DQo+ID4+
ICAgCW1nciA9IGRldm1fZnBnYV9tZ3JfY3JlYXRlKGRldiwgIkRGTCBGTUUgRlBHQSBNYW5hZ2Vy
IiwNCj4gPj4gQEAgLTMyMyw4ICszMTgsNiBAQCBzdGF0aWMgaW50IGZtZV9tZ3JfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPj4gICAJaWYgKCFtZ3IpDQo+ID4+ICAg
CQlyZXR1cm4gLUVOT01FTTsNCj4gPj4NCj4gPj4gLQltZ3ItPmNvbXBhdF9pZCA9IGNvbXBhdF9p
ZDsNCj4gPj4gLQ0KPiA+PiAgIAlyZXR1cm4gZGV2bV9mcGdhX21ncl9yZWdpc3RlcihkZXYsIG1n
cik7DQo+ID4+ICAgfQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2RmbC1m
bWUtcmVnaW9uLmMgYi9kcml2ZXJzL2ZwZ2EvZGZsLWZtZS1yZWdpb24uYw0KPiA+PiBpbmRleCBk
MjFlYWNiZjI0NjlmLi5iZTFkNTdlZTM3NjY2IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2Zw
Z2EvZGZsLWZtZS1yZWdpb24uYw0KPiA+PiArKysgYi9kcml2ZXJzL2ZwZ2EvZGZsLWZtZS1yZWdp
b24uYw0KPiA+PiBAQCAtNjQsNyArNjQsNiBAQCBzdGF0aWMgaW50IGZtZV9yZWdpb25fcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPj4gICAJfQ0KPiA+Pg0KPiA+PiAg
IAlyZWdpb24tPnByaXYgPSBwZGF0YTsNCj4gPj4gLQlyZWdpb24tPmNvbXBhdF9pZCA9IG1nci0+
Y29tcGF0X2lkOw0KPiA+PiAgIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCByZWdpb24pOw0K
PiA+Pg0KPiA+PiAgIAlyZXQgPSBmcGdhX3JlZ2lvbl9yZWdpc3RlcihyZWdpb24pOw0KPiA+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2ZwZ2EtcmVnaW9uLmMgYi9kcml2ZXJzL2ZwZ2EvZnBn
YS1yZWdpb24uYw0KPiA+PiBpbmRleCA4NjRkZDRmMjkwZTNiLi5iMDhkMzkxNDcxNmYwIDEwMDY0
NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2ZwZ2EvZnBnYS1yZWdpb24uYw0KPiA+PiArKysgYi9kcml2
ZXJzL2ZwZ2EvZnBnYS1yZWdpb24uYw0KPiA+PiBAQCAtMTcyLDEyICsxNzIsNyBAQCBzdGF0aWMg
c3NpemVfdCBjb21wYXRfaWRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4+ICAgCWlmIChy
ZWdpb24tPnJvcHMgJiYgcmVnaW9uLT5yb3BzLT5jb21wYXRfaWRfc2hvdykNCj4gPj4gICAJCXJl
dHVybiByZWdpb24tPnJvcHMtPmNvbXBhdF9pZF9zaG93KHJlZ2lvbiwgYnVmKTsNCj4gPj4NCj4g
Pj4gLQlpZiAoIXJlZ2lvbi0+Y29tcGF0X2lkKQ0KPiA+PiAtCQlyZXR1cm4gLUVOT0VOVDsNCj4g
Pj4gLQ0KPiA+PiAtCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiUwMTZsbHglMDE2bGx4XG4iLA0KPiA+
PiAtCQkgICAgICAgKHVuc2lnbmVkIGxvbmcgbG9uZylyZWdpb24tPmNvbXBhdF9pZC0+aWRfaCwN
Cj4gPj4gLQkJICAgICAgICh1bnNpZ25lZCBsb25nIGxvbmcpcmVnaW9uLT5jb21wYXRfaWQtPmlk
X2wpOw0KPiA+PiArCXJldHVybiAtRU5PRU5UOw0KPiA+PiAgIH0NCj4gPj4NCj4gPj4gICBzdGF0
aWMgREVWSUNFX0FUVFJfUk8oY29tcGF0X2lkKTsNCj4gPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvZnBnYS9mcGdhLW1nci5oIGIvaW5jbHVkZS9saW51eC9mcGdhL2ZwZ2EtbWdyLmgNCj4g
Pj4gaW5kZXggZWMyY2Q4YmZjZWIwMC4uZWJkZWEyMTVhODY0MyAxMDA2NDQNCj4gPj4gLS0tIGEv
aW5jbHVkZS9saW51eC9mcGdhL2ZwZ2EtbWdyLmgNCj4gPj4gKysrIGIvaW5jbHVkZS9saW51eC9m
cGdhL2ZwZ2EtbWdyLmgNCj4gPj4gQEAgLTE0MywyNCArMTQzLDEyIEBAIHN0cnVjdCBmcGdhX21h
bmFnZXJfb3BzIHsNCj4gPj4gICAjZGVmaW5lIEZQR0FfTUdSX1NUQVRVU19JUF9QUk9UT0NPTF9F
UlIJCUJJVCgzKQ0KPiA+PiAgICNkZWZpbmUgRlBHQV9NR1JfU1RBVFVTX0ZJRk9fT1ZFUkZMT1df
RVJSCUJJVCg0KQ0KPiA+Pg0KPiA+PiAtLyoqDQo+ID4+IC0gKiBzdHJ1Y3QgZnBnYV9jb21wYXRf
aWQgLSBpZCBmb3IgY29tcGF0aWJpbGl0eSBjaGVjaw0KPiA+PiAtICoNCj4gPj4gLSAqIEBpZF9o
OiBoaWdoIDY0Yml0IG9mIHRoZSBjb21wYXRfaWQNCj4gPj4gLSAqIEBpZF9sOiBsb3cgNjRiaXQg
b2YgdGhlIGNvbXBhdF9pZA0KPiA+PiAtICovDQo+ID4+IC1zdHJ1Y3QgZnBnYV9jb21wYXRfaWQg
ew0KPiA+PiAtCXU2NCBpZF9oOw0KPiA+PiAtCXU2NCBpZF9sOw0KPiA+PiAtfTsNCj4gPj4gLQ0K
PiA+PiAgIC8qKg0KPiA+PiAgICAqIHN0cnVjdCBmcGdhX21hbmFnZXIgLSBmcGdhIG1hbmFnZXIg
c3RydWN0dXJlDQo+ID4+ICAgICogQG5hbWU6IG5hbWUgb2YgbG93IGxldmVsIGZwZ2EgbWFuYWdl
cg0KPiA+PiAgICAqIEBkZXY6IGZwZ2EgbWFuYWdlciBkZXZpY2UNCj4gPj4gICAgKiBAcmVmX211
dGV4OiBvbmx5IGFsbG93cyBvbmUgcmVmZXJlbmNlIHRvIGZwZ2EgbWFuYWdlcg0KPiA+PiAgICAq
IEBzdGF0ZTogc3RhdGUgb2YgZnBnYSBtYW5hZ2VyDQo+ID4+IC0gKiBAY29tcGF0X2lkOiBGUEdB
IG1hbmFnZXIgaWQgZm9yIGNvbXBhdGliaWxpdHkgY2hlY2suDQo+ID4+ICAgICogQG1vcHM6IHBv
aW50ZXIgdG8gc3RydWN0IG9mIGZwZ2EgbWFuYWdlciBvcHMNCj4gPj4gICAgKiBAcHJpdjogbG93
IGxldmVsIGRyaXZlciBwcml2YXRlIGRhdGUNCj4gPj4gICAgKi8NCj4gPj4gQEAgLTE2OSw3ICsx
NTcsNiBAQCBzdHJ1Y3QgZnBnYV9tYW5hZ2VyIHsNCj4gPj4gICAJc3RydWN0IGRldmljZSBkZXY7
DQo+ID4+ICAgCXN0cnVjdCBtdXRleCByZWZfbXV0ZXg7DQo+ID4+ICAgCWVudW0gZnBnYV9tZ3Jf
c3RhdGVzIHN0YXRlOw0KPiA+PiAtCXN0cnVjdCBmcGdhX2NvbXBhdF9pZCAqY29tcGF0X2lkOw0K
PiA+PiAgIAljb25zdCBzdHJ1Y3QgZnBnYV9tYW5hZ2VyX29wcyAqbW9wczsNCj4gPj4gICAJdm9p
ZCAqcHJpdjsNCj4gPj4gICB9Ow0KPiA+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mcGdh
L2ZwZ2EtcmVnaW9uLmggYi9pbmNsdWRlL2xpbnV4L2ZwZ2EvZnBnYS0NCj4gcmVnaW9uLmgNCj4g
Pj4gaW5kZXggMjM2ZDM4MTlmMWMxMy4uYWZjNzk3ODRiMjgyMyAxMDA2NDQNCj4gPj4gLS0tIGEv
aW5jbHVkZS9saW51eC9mcGdhL2ZwZ2EtcmVnaW9uLmgNCj4gPj4gKysrIGIvaW5jbHVkZS9saW51
eC9mcGdhL2ZwZ2EtcmVnaW9uLmgNCj4gPj4gQEAgLTMwLDcgKzMwLDYgQEAgc3RydWN0IGZwZ2Ff
cmVnaW9uX29wcyB7DQo+ID4+ICAgICogQGJyaWRnZV9saXN0OiBsaXN0IG9mIEZQR0EgYnJpZGdl
cyBzcGVjaWZpZWQgaW4gcmVnaW9uDQo+ID4+ICAgICogQG1ncjogRlBHQSBtYW5hZ2VyDQo+ID4+
ICAgICogQGluZm86IEZQR0EgaW1hZ2UgaW5mbw0KPiA+PiAtICogQGNvbXBhdF9pZDogRlBHQSBy
ZWdpb24gaWQgZm9yIGNvbXBhdGliaWxpdHkgY2hlY2suDQo+ID4+ICAgICogQHByaXY6IHByaXZh
dGUgZGF0YQ0KPiA+PiAgICAqIEByb3BzOiBvcHRpb25hbCBwb2ludGVyIHRvIHN0cnVjdCBmb3Ig
ZnBnYSByZWdpb24gb3BzDQo+ID4+ICAgICovDQo+ID4+IEBAIC00MCw3ICszOSw2IEBAIHN0cnVj
dCBmcGdhX3JlZ2lvbiB7DQo+ID4+ICAgCXN0cnVjdCBsaXN0X2hlYWQgYnJpZGdlX2xpc3Q7DQo+
ID4+ICAgCXN0cnVjdCBmcGdhX21hbmFnZXIgKm1ncjsNCj4gPj4gICAJc3RydWN0IGZwZ2FfaW1h
Z2VfaW5mbyAqaW5mbzsNCj4gPj4gLQlzdHJ1Y3QgZnBnYV9jb21wYXRfaWQgKmNvbXBhdF9pZDsN
Cj4gPj4gICAJdm9pZCAqcHJpdjsNCj4gPj4gICAJY29uc3Qgc3RydWN0IGZwZ2FfcmVnaW9uX29w
cyAqcm9wczsNCj4gPj4gICB9Ow0KPiA+PiAtLQ0KPiA+PiAyLjI2LjMNCg0K
