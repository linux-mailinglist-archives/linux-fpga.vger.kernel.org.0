Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839AE3B7421
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Jun 2021 16:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhF2OTx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Jun 2021 10:19:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:22937 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234244AbhF2OTv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Jun 2021 10:19:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="195306255"
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="195306255"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 07:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="643727305"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2021 07:17:23 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 29 Jun 2021 07:17:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 29 Jun 2021 07:17:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 29 Jun 2021 07:17:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neHVX1DH5BavyqcQUyiye7tqP6x0EmTbcgzuOl0kltMa90vk4Uic5pwnLYqqz9PepmmnreIdR//su73vNvfByVqXayi82mZDx90h7rUpAygeMkAHo7ouI7n2yBqfK8rO6m1Lts3f0rc8EN+4exq42V9H0pfMe9ALDH1u2QSV1B6zsLLdYR/x7OL7BvL/F2xGjenhtie6qb7C2UclkacP0TkpX7oS4zUuZC4vv3Fk0CA1U4VhqUHL+fYWcM2UnN4pXA9eUJSFt0XzS+secHPMOVKiqT1vHAIPzI3JbEOzA6i2TEjBcRsqP4j9U5NySGiOYtpHUf8jbgW3yFWSxNhX0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qONOdbdHCfJqTKOc0jq4ZQCF888yxLhwwbIYflbY74Y=;
 b=Q4Vu/e/4gjKhlvhl2e46Dp27/5Mlu72KAHPlz9uyxVaqfWY8bIwvhX1KYlV16gcfKIirHmruY4RjIwYN5ex5IoaC5xG3Rw1AzOTi3/XZHrVC/vnFm9jfj/VvkRcwRx53zWw1yhFbwbXDXplqLY38F0/P3CE+YEiUW1jEYzvcQaBqnPy6Xm6Tvs07IPwGhoE5BkplSk6Ijst6rU6PS0iZ/r0kMjLv2QfQF6eRV1M9TXPlUgUyy/a46wW0DRJOK9V0RGPxukN0iy9bdUjh70C4+B3AH/GLgrV+iw/L39sQeGhwRUWynEkrD9q9wstGD9C8LjmLup7V8wJ7w5SsKZDE+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qONOdbdHCfJqTKOc0jq4ZQCF888yxLhwwbIYflbY74Y=;
 b=oXJkplbCAuZLCtMe0JKdJPSx8tb5r5DBzJwMcNW+BxXZaXdDxioweHImOBY7LD8XbiCY5oWhHcuRD+daJBunjGTHRAl5PKQobvADyoN1B9DFcvnC1wR6sYWoIJyLJ+2f12nDuHBUFg5ySawzxFInDE+w+8OiAQywK4ACVdRaxrY=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1915.namprd11.prod.outlook.com (2603:10b6:3:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Tue, 29 Jun
 2021 14:17:14 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 14:17:14 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     =?utf-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@geanix.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
CC:     =?utf-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <mhu@silicom.dk>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH v3 1/4] fpga: dfl: expose feature revision from struct
 dfl_device
Thread-Topic: [PATCH v3 1/4] fpga: dfl: expose feature revision from struct
 dfl_device
Thread-Index: AQHXbOASPfAqvcx7E0OGOIQ1tDM82asrCHCg
Date:   Tue, 29 Jun 2021 14:17:14 +0000
Message-ID: <DM6PR11MB3819322771BAD3F7556012DB85029@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210629121214.988036-1-martin@geanix.com>
 <20210629121214.988036-2-martin@geanix.com>
In-Reply-To: <20210629121214.988036-2-martin@geanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: geanix.com; dkim=none (message not signed)
 header.d=none;geanix.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [124.64.84.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 497af9e1-e21a-41c4-c83a-08d93b0897f9
x-ms-traffictypediagnostic: DM5PR11MB1915:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB191596F8C24C811C9A5E366885029@DM5PR11MB1915.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dg6TDGD9xqmrd3x4kSvezC4EFtAAGxeUfohGlfI/g2g3qz8oUGjlbDpmHfYVm8aaSN+B/rJEfYfNesVXahPRfpMUO5Nlr9tKftn3X/WiLnQoyfiIREQnQcMdCwAjCX5QpYo/6QFhsfv43Puxf8riaBU4agCUrzoB1QGSBS6aWd28NpTOsr9h6e7PGZ+gQ3gbRU97ijnz0al8cpSY7Sr5oyfLPRPkKpEFd3zGi0Y6DI5FB6zQHwFPgMZoEQTN550yt/uE7oCU6h17aQOi1FkVB2PVah/1UakDBB/Ct6Duz1Mvzlnql5kIZGXXPFPJIoxxEBvV/Ide+3QBESmKZ5gZd19pSVoNFnnN4fYK5dXjJIOHRqFFaMABnvAAbBDrGfCHudvRmx25IWvoRVeUu5imvcAN04Zp7pTJvFYF/EQRhFn/J4poUbk19yX3cFyG5x4TDfqJ0J10Z4dB9vWbpOolyAtYXMij3kzErkPhBLaU98UsWEgSZDPa9FbfEgkL+XJM4sd1k91dExRR6ptwCpwBs5SGa2Qx5xfdFA1w6LSLYsz/EoslXlXMAbIz4ZOhjtMA9PohuglSawWXMyPFFT0fKjIrh8JlMM+PktGvnd5jRP+6Nh1TW/aIg+/qB1UEpSqQkDY/wsH/NE+hXAppuOwWYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(376002)(396003)(346002)(6506007)(26005)(186003)(7696005)(86362001)(83380400001)(7416002)(4326008)(71200400001)(66556008)(38100700002)(122000001)(76116006)(66476007)(66946007)(64756008)(66446008)(54906003)(110136005)(5660300002)(52536014)(316002)(55016002)(9686003)(478600001)(8676002)(8936002)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFcvdmpsMnZZVDFSZEdaOXdwM3VOMCttanNqRkxxQWFucXl4TU52M1JzWC9C?=
 =?utf-8?B?SGxXL1VIRCtUWE9rMkRFREQ5bm45SWIyVGxNTDIyMGhpT09ZY1lmejNOV1Mz?=
 =?utf-8?B?S2F4dG1yNXl4SHV2M1NiRDJ0akw0eFVtWXhFSlJUYlkyWkpZSnA4d01uanFt?=
 =?utf-8?B?RW5ORGE3eE0ySitCK05GeCt4aTNQcHFpUEJ3MWM2Q2xiUW05RExwVGxBaFda?=
 =?utf-8?B?T25TK2dpQlROb2tvRGdFczVtYjQ0c2ErVDI2VEFabGtnT1EyeVA3Um9FS1Z4?=
 =?utf-8?B?WXcvMzEzWWNGYUs0ejM4TjRrTktLTXVSTklJaTUwQkQ3TGtJWEh1c29tMGJT?=
 =?utf-8?B?UVE1QlRSMXE1ckhDK0RxK1o4Nnh1SUFYSFVIL0ZOSkpuV25vN1YwMWxKTFFK?=
 =?utf-8?B?WWFIZVEyNTdhd01iN2FtRkxUSTVaT0wxYmpNN0FYbzlVUklyQ0daczlSUEhQ?=
 =?utf-8?B?RTgrN3g0MHFIRWE4SzdZbkFXNmk4TWErbmxrWHU1dk1kVnVLV2NjeFpLSko0?=
 =?utf-8?B?QWc2MEQ1OXR4bSt2VTFEOTdLYnM4d1BjTC9sa2ZIVERVOFNjZzVLQnFJc3d1?=
 =?utf-8?B?OG56WnJzMnlFanZwbk9yVnVsS1gvdllRVHk0M1QwT3F5ZkljVE9wYTVNRElR?=
 =?utf-8?B?OWFnb1hrSFBOTUdxVmlHdUJwd2hxT1k0NVhjL2dOa0x3bDd1SGhlL1E2NEs4?=
 =?utf-8?B?TVdtSXBOT3lVbWoxSW1jQnhoOWhMRmZacVVjOVdVVXFjK1VoUThsdnpxNnYw?=
 =?utf-8?B?Y2c4VDRveDJjSjZRdkFJdzlWTTg2R2pkWEg5blZ2V0U1RDJBQXFUclJBNFRD?=
 =?utf-8?B?dWs3R1RnTUJmMkMxRUs2MWhGZWlCcFhqZkdpU3VqYjRlL3FrUkhPcmpiSmhw?=
 =?utf-8?B?V2hKZFBHNG9rYlJkSEZaYVM4SzBieFF4NEZrTk5WV01qUHhUZmVLOE9tT1U1?=
 =?utf-8?B?amUwcjNhekE0UU05aWRpL0QrMTIxSXFQL05Yb0JGSDFWRmcxejdQZ1ZLTWpy?=
 =?utf-8?B?dUhBZmhYd3haNW1DZEdHSDdUZVFXU0lPVkcvV0tValNnMElhKzZmQ0R5NWg3?=
 =?utf-8?B?dHkvd1lKVzRHYnBteGE2QVo4UzEvczdpOCtwRXpHM3htZ2RQb1ZTbG9nNTM1?=
 =?utf-8?B?Mnh1M0VtTHBxaWhkcGtiSjhYY2VIRmRNSW1IZHlzdFQrR0YvbFVFeEZpS0Rn?=
 =?utf-8?B?K0NpTFZrTDVWVCsyalpEVjFtZjI1cjQ4STROSnlaNDRjeElYMDJ6aUF0TmFG?=
 =?utf-8?B?bkdjdzJ3RUp0WEIvVURUUjlJZmRoSGlCNUsrMnJjN0N3bzcrTVZNRG1BSFRx?=
 =?utf-8?B?Qks2NW9TOThnQXdUUXhXN3BHM1pDd0hGWWt5dXAvUXBxd1hjdW9kOSs0dW02?=
 =?utf-8?B?eTJyUFByVlViZTM0ZXhOMzVxakpYUVFwWmhsRXk0M1k3K1FwdURSR3hGN0Q1?=
 =?utf-8?B?TmZrdC95OUp6UGpJbmxXOVhLMmdNOUJKVStkSlpTbGhvTWtScytrTzZDdUVt?=
 =?utf-8?B?SWZSaSt5ZVliNGplMmdSVWF2Q0pIMElhZHdMdnJNRTRSa0k3c05QeEpQOHRP?=
 =?utf-8?B?Y2JlU0ZHYkhUQXdCQW5KbTlKaUVMR2Q3ZzZiVTBaY202TlNkMmJiMlNQNkRM?=
 =?utf-8?B?MUIybTN5QUt3Q0c0bVJVZTdWdFZObDVGVE54cG5ScTlOeUZTVk5sbUFlTmpo?=
 =?utf-8?B?N1d1K2pqWUpQa0UyR0x0ckl5ZS9kWnBROGNDOVBibDRLSGFraFVLU3dKSzN4?=
 =?utf-8?Q?tns2L59OjtWux2P5DRw5KvZEjVcLOmeJLkXGXoo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497af9e1-e21a-41c4-c83a-08d93b0897f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 14:17:14.3193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMpVEb8ZC5opHjfYLUFIk3bybQAKNGjRojInMHkiXSnlqrrUdxBtut7t+bdcQuzRa5ucxfoGrMZEpaW4tIjogQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1915
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0ggdjMgMS80XSBmcGdhOiBkZmw6IGV4cG9zZSBmZWF0dXJlIHJldmlz
aW9uIGZyb20gc3RydWN0IGRmbF9kZXZpY2UNCj4gDQo+IEZyb206IE1hcnRpbiBIdW5kZWLDuGxs
IDxtaHVAc2lsaWNvbS5kaz4NCj4gDQo+IERGTCBkZXZpY2UgZHJpdmVycyBoYXZlIGEgY29tbW9u
IG5lZWQgZm9yIGNoZWNraW5nIGZlYXR1cmUgcmV2aXNpb24NCj4gaW5mb3JtYXRpb24gZnJvbSB0
aGUgREZMIGhlYWRlciwgYXMgd2VsbCBhcyBvdGhlciBjb21tb24gREZMIGluZm9ybWF0aW9uDQo+
IGxpa2UgdGhlIGFscmVhZHkgZXhwb3NlZCBmZWF0dXJlIGlkIGFuZCB0eXBlLg0KPiANCj4gVGhp
cyBwYXRjaCBleHBvc2VzIHRoZSBmZWF0dXJlIHJldmlzaW9uIGluZm9ybWF0aW9uIGRpcmVjdGx5
IHZpYSB0aGUgREZMDQo+IGRldmljZSBkYXRhIHN0cnVjdHVyZS4NCj4gDQo+IFNpbmNlIHRoZSBE
RkwgY29yZSBjb2RlIGhhcyBhbHJlYWR5IHJlYWQgdGhlIERGTCBoZWFkZXIsIHRoaXMgdGhpcyBw
YXRjaA0KPiBzYXZlcyBhZGRpdGlvbmFsIG1taW8gcmVhZHMgZnJvbSBERkwgZGV2aWNlIGRyaXZl
cnMgdG9vLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFydGluIEh1bmRlYsO4bGwgPG1odUBzaWxp
Y29tLmRrPg0KQWNrZWQtYnk6IFd1IEhhbyA8aGFvLnd1QGludGVsLmNvbT4NCg0KVGhhbmtzIQ0K
SGFvDQoNCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYyOg0KPiAgKiBSZXdvcmRlZCBjb21t
aXQgbWVzc2FnZSBhcyBwZXIgSGFvJ3Mgc3VnZ2VzdGlvbg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2
MToNCj4gICogVGhpcyBwYXRjaCByZXBsYWNlcyB0aGUgcHJldmlvdXMgcGF0Y2ggMiBhbmQgZXhw
b3NlcyB0aGUgZmVhdHVyZQ0KPiAgICByZXZpc2lvbiB0aHJvdWdoIHN0cnVjdCBkZmxfZGV2aWNl
IGluc3RlYWQgb2YgYSBoZWxwZXIgcmVhZGluZyBmcm9tDQo+ICAgIGlvLW1lbQ0KPiANCj4gIGRy
aXZlcnMvZnBnYS9kZmwuYyAgfCAyNyArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gIGRy
aXZlcnMvZnBnYS9kZmwuaCAgfCAgMSArDQo+ICBpbmNsdWRlL2xpbnV4L2RmbC5oIHwgIDEgKw0K
PiAgMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ZwZ2EvZGZsLmMgYi9kcml2ZXJzL2ZwZ2EvZGZsLmMN
Cj4gaW5kZXggNTExYjIwZmYzNWEzLi45MzgxYzU3OWQxY2QgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZnBnYS9kZmwuYw0KPiArKysgYi9kcml2ZXJzL2ZwZ2EvZGZsLmMNCj4gQEAgLTM4MSw2ICsz
ODEsNyBAQCBkZmxfZGV2X2FkZChzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRh
dGEsDQo+IA0KPiAgCWRkZXYtPnR5cGUgPSBmZWF0dXJlX2Rldl9pZF90eXBlKHBkZXYpOw0KPiAg
CWRkZXYtPmZlYXR1cmVfaWQgPSBmZWF0dXJlLT5pZDsNCj4gKwlkZGV2LT5yZXZpc2lvbiA9IGZl
YXR1cmUtPnJldmlzaW9uOw0KPiAgCWRkZXYtPmNkZXYgPSBwZGF0YS0+ZGZsX2NkZXY7DQo+IA0K
PiAgCS8qIGFkZCBtbWlvIHJlc291cmNlICovDQo+IEBAIC03MTcsNiArNzE4LDcgQEAgc3RydWN0
IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvIHsNCj4gICAqLw0KPiAgc3RydWN0IGRmbF9mZWF0dXJl
X2luZm8gew0KPiAgCXUxNiBmaWQ7DQo+ICsJdTggcmV2Ow0KPiAgCXN0cnVjdCByZXNvdXJjZSBt
bWlvX3JlczsNCj4gIAl2b2lkIF9faW9tZW0gKmlvYWRkcjsNCj4gIAlzdHJ1Y3QgbGlzdF9oZWFk
IG5vZGU7DQo+IEBAIC03OTYsNiArNzk4LDcgQEAgc3RhdGljIGludCBidWlsZF9pbmZvX2NvbW1p
dF9kZXYoc3RydWN0DQo+IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbykNCj4gIAkJLyog
c2F2ZSByZXNvdXJjZSBpbmZvcm1hdGlvbiBmb3IgZWFjaCBmZWF0dXJlICovDQo+ICAJCWZlYXR1
cmUtPmRldiA9IGZkZXY7DQo+ICAJCWZlYXR1cmUtPmlkID0gZmluZm8tPmZpZDsNCj4gKwkJZmVh
dHVyZS0+cmV2aXNpb24gPSBmaW5mby0+cmV2Ow0KPiANCj4gIAkJLyoNCj4gIAkJICogdGhlIEZJ
VSBoZWFkZXIgZmVhdHVyZSBoYXMgc29tZSBmdW5kYW1lbnRhbCBmdW5jdGlvbnMNCj4gKHNyaW92
DQo+IEBAIC05MTAsMTkgKzkxMywxNyBAQCBzdGF0aWMgdm9pZCBidWlsZF9pbmZvX2ZyZWUoc3Ry
dWN0DQo+IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbykNCj4gIAlkZXZtX2tmcmVlKGJp
bmZvLT5kZXYsIGJpbmZvKTsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgaW5saW5lIHUzMiBmZWF0dXJl
X3NpemUodm9pZCBfX2lvbWVtICpzdGFydCkNCj4gK3N0YXRpYyBpbmxpbmUgdTMyIGZlYXR1cmVf
c2l6ZSh1NjQgdmFsdWUpDQo+ICB7DQo+IC0JdTY0IHYgPSByZWFkcShzdGFydCArIERGSCk7DQo+
IC0JdTMyIG9mc3QgPSBGSUVMRF9HRVQoREZIX05FWFRfSERSX09GU1QsIHYpOw0KPiArCXUzMiBv
ZnN0ID0gRklFTERfR0VUKERGSF9ORVhUX0hEUl9PRlNULCB2YWx1ZSk7DQo+ICAJLyogd29ya2Fy
b3VuZCBmb3IgcHJpdmF0ZSBmZWF0dXJlcyB3aXRoIGludmFsaWQgc2l6ZSwgdXNlIDRLIGluc3Rl
YWQgKi8NCj4gIAlyZXR1cm4gb2ZzdCA/IG9mc3QgOiA0MDk2Ow0KPiAgfQ0KPiANCj4gLXN0YXRp
YyB1MTYgZmVhdHVyZV9pZCh2b2lkIF9faW9tZW0gKnN0YXJ0KQ0KPiArc3RhdGljIHUxNiBmZWF0
dXJlX2lkKHU2NCB2YWx1ZSkNCj4gIHsNCj4gLQl1NjQgdiA9IHJlYWRxKHN0YXJ0ICsgREZIKTsN
Cj4gLQl1MTYgaWQgPSBGSUVMRF9HRVQoREZIX0lELCB2KTsNCj4gLQl1OCB0eXBlID0gRklFTERf
R0VUKERGSF9UWVBFLCB2KTsNCj4gKwl1MTYgaWQgPSBGSUVMRF9HRVQoREZIX0lELCB2YWx1ZSk7
DQo+ICsJdTggdHlwZSA9IEZJRUxEX0dFVChERkhfVFlQRSwgdmFsdWUpOw0KPiANCj4gIAlpZiAo
dHlwZSA9PSBERkhfVFlQRV9GSVUpDQo+ICAJCXJldHVybiBGRUFUVVJFX0lEX0ZJVV9IRUFERVI7
DQo+IEBAIC0xMDIxLDEwICsxMDIyLDE1IEBAIGNyZWF0ZV9mZWF0dXJlX2luc3RhbmNlKHN0cnVj
dA0KPiBidWlsZF9mZWF0dXJlX2RldnNfaW5mbyAqYmluZm8sDQo+ICAJdW5zaWduZWQgaW50IGly
cV9iYXNlLCBucl9pcnFzOw0KPiAgCXN0cnVjdCBkZmxfZmVhdHVyZV9pbmZvICpmaW5mbzsNCj4g
IAlpbnQgcmV0Ow0KPiArCXU4IHJldjsNCj4gKwl1NjQgdjsNCj4gKw0KPiArCXYgPSByZWFkcShi
aW5mby0+aW9hZGRyICsgb2ZzdCk7DQo+ICsJcmV2ID0gRklFTERfR0VUKERGSF9SRVZJU0lPTiwg
dik7DQo+IA0KPiAgCS8qIHJlYWQgZmVhdHVyZSBzaXplIGFuZCBpZCBpZiBpbnB1dHMgYXJlIGlu
dmFsaWQgKi8NCj4gLQlzaXplID0gc2l6ZSA/IHNpemUgOiBmZWF0dXJlX3NpemUoYmluZm8tPmlv
YWRkciArIG9mc3QpOw0KPiAtCWZpZCA9IGZpZCA/IGZpZCA6IGZlYXR1cmVfaWQoYmluZm8tPmlv
YWRkciArIG9mc3QpOw0KPiArCXNpemUgPSBzaXplID8gc2l6ZSA6IGZlYXR1cmVfc2l6ZSh2KTsN
Cj4gKwlmaWQgPSBmaWQgPyBmaWQgOiBmZWF0dXJlX2lkKHYpOw0KPiANCj4gIAlpZiAoYmluZm8t
PmxlbiAtIG9mc3QgPCBzaXplKQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gQEAgLTEwMzgsNiAr
MTA0NCw3IEBAIGNyZWF0ZV9mZWF0dXJlX2luc3RhbmNlKHN0cnVjdA0KPiBidWlsZF9mZWF0dXJl
X2RldnNfaW5mbyAqYmluZm8sDQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiANCj4gIAlmaW5mby0+
ZmlkID0gZmlkOw0KPiArCWZpbmZvLT5yZXYgPSByZXY7DQo+ICAJZmluZm8tPm1taW9fcmVzLnN0
YXJ0ID0gYmluZm8tPnN0YXJ0ICsgb2ZzdDsNCj4gIAlmaW5mby0+bW1pb19yZXMuZW5kID0gZmlu
Zm8tPm1taW9fcmVzLnN0YXJ0ICsgc2l6ZSAtIDE7DQo+ICAJZmluZm8tPm1taW9fcmVzLmZsYWdz
ID0gSU9SRVNPVVJDRV9NRU07DQo+IEBAIC0xMTY2LDcgKzExNzMsNyBAQCBzdGF0aWMgaW50IHBh
cnNlX2ZlYXR1cmVfcHJpdmF0ZShzdHJ1Y3QNCj4gYnVpbGRfZmVhdHVyZV9kZXZzX2luZm8gKmJp
bmZvLA0KPiAgew0KPiAgCWlmICghaXNfZmVhdHVyZV9kZXZfZGV0ZWN0ZWQoYmluZm8pKSB7DQo+
ICAJCWRldl9lcnIoYmluZm8tPmRldiwgInRoZSBwcml2YXRlIGZlYXR1cmUgMHgleCBkb2VzIG5v
dCBiZWxvbmcNCj4gdG8gYW55IEFGVS5cbiIsDQo+IC0JCQlmZWF0dXJlX2lkKGJpbmZvLT5pb2Fk
ZHIgKyBvZnN0KSk7DQo+ICsJCQlmZWF0dXJlX2lkKHJlYWRxKGJpbmZvLT5pb2FkZHIgKyBvZnN0
KSkpOw0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIAl9DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9mcGdhL2RmbC5oIGIvZHJpdmVycy9mcGdhL2RmbC5oDQo+IGluZGV4IDJiODJjOTZiYTU2
Yy4uNDIyMTU3Y2ZkNzQyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2ZwZ2EvZGZsLmgNCj4gKysr
IGIvZHJpdmVycy9mcGdhL2RmbC5oDQo+IEBAIC0yNDMsNiArMjQzLDcgQEAgc3RydWN0IGRmbF9m
ZWF0dXJlX2lycV9jdHggew0KPiAgc3RydWN0IGRmbF9mZWF0dXJlIHsNCj4gIAlzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpkZXY7DQo+ICAJdTE2IGlkOw0KPiArCXU4IHJldmlzaW9uOw0KPiAgCWlu
dCByZXNvdXJjZV9pbmRleDsNCj4gIAl2b2lkIF9faW9tZW0gKmlvYWRkcjsNCj4gIAlzdHJ1Y3Qg
ZGZsX2ZlYXR1cmVfaXJxX2N0eCAqaXJxX2N0eDsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvZGZsLmggYi9pbmNsdWRlL2xpbnV4L2RmbC5oDQo+IGluZGV4IDZjYzEwOTgyMzUxYS4uNDMx
NjM2YTBkYzc4IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RmbC5oDQo+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvZGZsLmgNCj4gQEAgLTM4LDYgKzM4LDcgQEAgc3RydWN0IGRmbF9kZXZpY2Ug
ew0KPiAgCWludCBpZDsNCj4gIAl1MTYgdHlwZTsNCj4gIAl1MTYgZmVhdHVyZV9pZDsNCj4gKwl1
OCByZXZpc2lvbjsNCj4gIAlzdHJ1Y3QgcmVzb3VyY2UgbW1pb19yZXM7DQo+ICAJaW50ICppcnFz
Ow0KPiAgCXVuc2lnbmVkIGludCBudW1faXJxczsNCj4gLS0NCj4gMi4zMS4wDQoNCg==
