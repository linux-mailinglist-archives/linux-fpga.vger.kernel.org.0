Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D7330E984
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Feb 2021 02:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhBDBjL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Feb 2021 20:39:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:27646 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231280AbhBDBjJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 3 Feb 2021 20:39:09 -0500
IronPort-SDR: 2O02TzNQzEO1D5l5utXg7EXbKotuSB4zFNNREvz8pfhW/RffR0p9IE6at9z9AFphq+xkHoh0iB
 ebIfKN1SxLHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="181295085"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="181295085"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 17:38:22 -0800
IronPort-SDR: vYfNxKCFX2KUieeQl0Y3TXbqryhzAKjnno5+i9FWIABjBEDtp2B827yXAm3uAuzmuyQBFHcV1f
 Rn1VdfhxuzYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="356981419"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga003.jf.intel.com with ESMTP; 03 Feb 2021 17:38:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 17:38:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 17:38:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 3 Feb 2021 17:38:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 3 Feb 2021 17:38:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX71PQ/VoDDxYrwC2ZvPE0UeEb7bMuN2vS2bp0otmjWFceNCNiD7HCasZNkY4ifNfbJk0S4cFtotlAJ+PJJQS5kneCLg2Zjsu0p///RIjDc5ikA4BGJWWMc5etWZ1gCLgx3d1roP1h9dp4/QFkVlidGzlbix4IubyzoIGTM0phleP+rLkQzUFIS69/jOFlzoAH/RbTAJjEgi+0DBS/On5WTwDKj0NYybed1J59luMsMIKuDmzCzSr5J0SImlHzGOw2gGdmZtpvOFwFnknV6ksn3ov7npxFvFYYS/ugDD1VzOzmYDuCl494CKKK6tDwuhgC4DwaRsdN0/YKf0i35Baw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrhYmSy4zRj4CHqy0VUSKrZa31vV4UqOJr3mZw32GhE=;
 b=YFjB4JztliaoZbA4MlLrsnna/KejwNe3bmZo41qEGISooACznI7agDS/J9KZplcuIp0H0lu8XRhYaW2uPKIISE2b9B0JeKONsrAd5iYqNACheeAFZ64sDR7vfUiPnMbsAqsAcRMajbpV+uEpWBuQkkQqgq+PU9g541WECdQcCyD6g832UExJuAnoqDM7I0J6lv5KGwJzrjuYimAugPP4O68kAjENHG07hHGBO7DwXiB2RExRrhDGlf9zDNnRuE0l8jqyq3Om2OxT2Qa/behrA7crkakCTTFw9b1aEeYbL99bTcsvkzZX2TWw2siLwNe1rVzAFb1bTE+LlGVKosynIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrhYmSy4zRj4CHqy0VUSKrZa31vV4UqOJr3mZw32GhE=;
 b=tqWDHP3oNyZhkQWdJ8tMmQjB1zRR5vvGUznmPpF5t5g+vNxQ1YKbhcWWUu/pGe6Uri9ZnUASSPDiM6C36q+5OO3JV9mpMYmb0j1nKJEmncmyyfL9t035hF6vKZ65QpNydVPmLcjUMM4fuzpiAFk/4KYc14lGUKSP96+t77xzGQw=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4042.namprd11.prod.outlook.com (2603:10b6:5:197::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 4 Feb
 2021 01:38:18 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597%6]) with mapi id 15.20.3805.029; Thu, 4 Feb 2021
 01:38:18 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
Subject: RE: [PATCH v3 1/1] fpga: dfl: afu: harden port enable logic
Thread-Topic: [PATCH v3 1/1] fpga: dfl: afu: harden port enable logic
Thread-Index: AQHW+bgQqd0GwODdHEqQahZtn2dJJ6pGHiiwgADt4ACAACuRYA==
Date:   Thu, 4 Feb 2021 01:38:18 +0000
Message-ID: <DM6PR11MB38190997A52B3E3C8C618AF885B39@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210202230631.198950-1-russell.h.weight@intel.com>
 <DM6PR11MB3819173E2C84099BA5D6EB4785B49@DM6PR11MB3819.namprd11.prod.outlook.com>
 <7ab15adf-81b5-f1ba-ef02-c31701592e4c@intel.com>
In-Reply-To: <7ab15adf-81b5-f1ba-ef02-c31701592e4c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34a5d98e-c4d7-43eb-e61d-08d8c8ad8c74
x-ms-traffictypediagnostic: DM6PR11MB4042:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB40426ABF41E08E70336227AF85B39@DM6PR11MB4042.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +tppMnXsZJsoL36Zywk3caHmnA/OE+CiDKyWuYqSxQffBf7Be4MSXF/ZGoFono647mO1LtYm4SiW9RLcz+dLRKto4BCPTbCNkqM3hXi9RXogrSj88ffL4Uki5jRpICuyqzhIPyCqfAOT2N27kRs12T417NtlXIS7qU2L1ieaxJ0F7dx0Mx4qeguLzNS9lknnq5fzYqWXzRxWe03vxhQ0Ai92XAv2zpuArUeo/Krdt3jxg9NdcAeoQ7eqIS6vTv1SBdj3iIWD0IfZdNVC1bEZsO6fLjfdYEovtlMDQxrp/HKDEsCskg0X69FwEiDmIxeN2TERSCe+J7tvRkOBuX/vT2U4JTk/VeeSwi4kSQFFTR26/fLGQ3xZLaKwrd4rhVdNEK+otfLEisOdltpYh7C3ifgsvkdvLCLNnsKZQ+5iE1l8kO6BUvV8RptgpVSQVGXUDbcxmXWd6hMfwBV6st0K8KbBAuTb2LXodc0Mfsp+f3/IlC+GKz6CXqA8KLx97HOFjeJRgjDtNoGRD7lz6k1Kvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(346002)(376002)(8676002)(186003)(6506007)(76116006)(66556008)(71200400001)(66476007)(33656002)(316002)(53546011)(9686003)(52536014)(2906002)(4326008)(8936002)(5660300002)(478600001)(107886003)(26005)(110136005)(83380400001)(55016002)(66946007)(64756008)(66446008)(54906003)(86362001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?d3R2S1J6R0hkNFRVSURSUUc0RlR0N1NySThmZFg3VUxWNDVQTG9CSjJaemgx?=
 =?utf-8?B?Z2FGREtmVHhLZjBzVnhGV0RnRUpFb25Remlsb3dEUExGb0tQcU4ra1RHSk1s?=
 =?utf-8?B?d0FLRkJnMFByWTA0YXhCcS9NUTh4QW56RW4vdnVnL3kyTEFXcHhDd1U2bFph?=
 =?utf-8?B?SERGQW5DbjZKVXJIOG90MFFYVmlCTzFWcmFsVmdNa0h4V3JiamNweXVnN2t1?=
 =?utf-8?B?Zk5DVjRoaDFMaGZJVlV1T2NneTRoS2kyaVp3UytUZFFYK3daeVpUQjQ3cHBo?=
 =?utf-8?B?dEd0S0dQeHBlNDVoVEhaUGsweGZMbXhqVUtiTGhHYk03MGpMRittMzRMOW5h?=
 =?utf-8?B?dmVXdTFkcFR4ODBIWjBvSXhDQ09YeGZXSWVLcitHZTdROWdPWnZhUjBESGFt?=
 =?utf-8?B?cVZrZ2w4QUVsWkI5enNVeGNSaUxUOUJVMXZlNzZxVzNMWnBZM2lrRzh1d0RV?=
 =?utf-8?B?bGkvMGwyY0Njb1d1MkdJcXE5bFJIV3QxaktuV2ZVVHIxMkFaRXUwVUhycmFP?=
 =?utf-8?B?bmVhY1dHazlaNHdZVGlRaFlkWXp5WkVUVUQyczJWM1QxT2RhK29oKyt0RHNC?=
 =?utf-8?B?NlU2eWk1TEs3MCtqR2dSNWl2clY5R2RITlE4T2dJTFh3V3VUSGN5djlSY2Zi?=
 =?utf-8?B?K0psYnFKTW13OStRSXFvUk5EREJ4M0gzYk8wMVVDYU5MK2Q2MFAwY0MzZlNy?=
 =?utf-8?B?VmZFOU40Z2dKOGxibmFpOHpyZEVGZ2hkOUw0VUVvanlmYXJvNDNFK2txWGlw?=
 =?utf-8?B?R1ZmRFJ1dHhuUEFzMk56cjZQK2FZa0hmZVdMd0pvNkdXV2tKeFhlaGMxcmQz?=
 =?utf-8?B?MzRMMVlTR3dPbHVXdHhUNXJRQ0VYNDJFRExxM0VrVnVMVjV4SklhYmxwTUE4?=
 =?utf-8?B?QWtIVGVzbkFCckZPdFFPZGUzV1hvTlpGN2ZxYWh1ZWQ0RkE2UlU3dG5keHlp?=
 =?utf-8?B?dVR0WHd3NjNMVzN0WmdpNWpMU05pdVovQnFCL25YN0xtU2FYTzU2WkRQTmU3?=
 =?utf-8?B?T0ZSWGlEQ1AveVVVbXVOSkgralNOMVdCWUlkampENzdCKzY1TFkxVFErNXdD?=
 =?utf-8?B?dTZObUcvY2F6QkIyS3pobG9va0JWc1RST0RWeVhlSzgzbno3OFFhb1Vta3BX?=
 =?utf-8?B?UkU0SDMwR2JDbk5QUU4vWWhOYjNQT2cxQ3M5ZVpBT3UxZEp2eDgybmlvVU9h?=
 =?utf-8?B?YUxRSXo5OExqSWF0VzQwTEFKOXpuTjh3Wm5YNFJjcXFVY3AvYnhJWDBEb3lv?=
 =?utf-8?B?bU0yRFZiVEhZUk5xSHo2YjBCY1lEd1lHMWdmL0hKMVJEVTllWHZBazhkdUNS?=
 =?utf-8?B?dUhGUEFOdzhTL3pMRFJuK1BpbW9yb1NOZHFhR2Z0OCtOMDVXVG9wNmt0ZWcr?=
 =?utf-8?B?Z1dnRzUyK3BlSkFxdTB4cktqelE2RXpGYjFoQlN0MjFsVWlrd01sYTdMemd1?=
 =?utf-8?Q?a/RKp4oE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a5d98e-c4d7-43eb-e61d-08d8c8ad8c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 01:38:18.2684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHTOiIOA5EQZYvBiAk/D9X2djonNdItbwNKgkzcyQ9N7Aq7aDBpB8PLohjqb/tGqr318gM7Am0u7YlQHBnsCew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4042
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBPbiAyLzMvMjEgMTowMSBBTSwgV3UsIEhhbyB3cm90ZToNCj4gPj4gU3ViamVjdDogW1BBVENI
IHYzIDEvMV0gZnBnYTogZGZsOiBhZnU6IGhhcmRlbiBwb3J0IGVuYWJsZSBsb2dpYw0KPiA+Pg0K
PiA+PiBQb3J0IGVuYWJsZSBpcyBub3QgY29tcGxldGUgdW50aWwgQUNLID0gMC4gQ2hhbmdlDQo+
ID4+IF9fYWZ1X3BvcnRfZW5hYmxlKCkgdG8gZ3VhcmFudGVlIHRoYXQgdGhlIGVuYWJsZSBwcm9j
ZXNzDQo+ID4+IGlzIGNvbXBsZXRlIGJ5IHBvbGxpbmcgZm9yIEFDSyA9PSAwLg0KPiA+Pg0KPiA+
PiBTaWduZWQtb2ZmLWJ5OiBSdXNzIFdlaWdodCA8cnVzc2VsbC5oLndlaWdodEBpbnRlbC5jb20+
DQo+ID4+IC0tLQ0KPiA+PiB2MzoNCj4gPj4gICAtIGFmdV9wb3J0X2Vycl9jbGVhcigpIGNoYW5n
ZWQgdG8gcHJpb3JpdGl6ZSBwb3J0X2VuYWJsZSBmYWlsdXJlIG92ZXINCj4gPj4gICAgIG90aGVy
IGEgZGV0ZWN0ZWQgbWlzbWF0Y2ggaW4gcG9ydCBlcnJvcnMuDQo+ID4+ICAgLSByZW9yZ2FuaXpl
ZCBjb2RlIGluIHBvcnRfcmVzZXQoKSB0byBiZSBtb3JlIHJlYWRhYmxlLg0KPiA+PiB2MjoNCj4g
Pj4gICAtIEZpeGVkIHR5cG8gaW4gY29tbWl0IG1lc3NhZ2UNCj4gPj4gLS0tDQo+ID4+ICBkcml2
ZXJzL2ZwZ2EvZGZsLWFmdS1lcnJvci5jIHwgIDggKysrKy0tLS0NCj4gPj4gIGRyaXZlcnMvZnBn
YS9kZmwtYWZ1LW1haW4uYyAgfCAzMSArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+
ID4+ICBkcml2ZXJzL2ZwZ2EvZGZsLWFmdS5oICAgICAgIHwgIDIgKy0NCj4gPj4gIDMgZmlsZXMg
Y2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2ZwZ2EvZGZsLWFmdS1lcnJvci5jIGIvZHJpdmVycy9mcGdhL2Rm
bC1hZnUtZXJyb3IuYw0KPiA+PiBpbmRleCBjNDY5MTE4N2NjYTkuLjJjZWQ2MTAwNTljYyAxMDA2
NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9mcGdhL2RmbC1hZnUtZXJyb3IuYw0KPiA+PiArKysgYi9k
cml2ZXJzL2ZwZ2EvZGZsLWFmdS1lcnJvci5jDQo+ID4+IEBAIC01Miw3ICs1Miw3IEBAIHN0YXRp
YyBpbnQgYWZ1X3BvcnRfZXJyX2NsZWFyKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0IGVycikNCj4g
Pj4gIHN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhICpwZGF0YSA9IGRldl9nZXRfcGxh
dGRhdGEoZGV2KTsNCj4gPj4gIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSB0b19wbGF0
Zm9ybV9kZXZpY2UoZGV2KTsNCj4gPj4gIHZvaWQgX19pb21lbSAqYmFzZV9lcnIsICpiYXNlX2hk
cjsNCj4gPj4gLWludCByZXQgPSAtRUJVU1k7DQo+ID4+ICtpbnQgZW5hYmxlX3JldCA9IDAsIHJl
dCA9IC1FQlVTWTsNCj4gPj4gIHU2NCB2Ow0KPiA+Pg0KPiA+PiAgYmFzZV9lcnIgPSBkZmxfZ2V0
X2ZlYXR1cmVfaW9hZGRyX2J5X2lkKGRldiwNCj4gPj4gUE9SVF9GRUFUVVJFX0lEX0VSUk9SKTsN
Cj4gPj4gQEAgLTEwMiwxMiArMTAyLDEyIEBAIHN0YXRpYyBpbnQgYWZ1X3BvcnRfZXJyX2NsZWFy
KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gdTY0DQo+ID4+IGVycikNCj4gPj4gIC8qIENsZWFyIG1h
c2sgKi8NCj4gPj4gIF9fYWZ1X3BvcnRfZXJyX21hc2soZGV2LCBmYWxzZSk7DQo+ID4+DQo+ID4+
IC0vKiBFbmFibGUgdGhlIFBvcnQgYnkgY2xlYXIgdGhlIHJlc2V0ICovDQo+ID4+IC1fX2FmdV9w
b3J0X2VuYWJsZShwZGV2KTsNCj4gPj4gKy8qIEVuYWJsZSB0aGUgUG9ydCBieSBjbGVhcmluZyB0
aGUgcmVzZXQgKi8NCj4gPj4gK2VuYWJsZV9yZXQgPSBfX2FmdV9wb3J0X2VuYWJsZShwZGV2KTsN
Cj4gPj4NCj4gPj4gIGRvbmU6DQo+ID4+ICBtdXRleF91bmxvY2soJnBkYXRhLT5sb2NrKTsNCj4g
Pj4gLXJldHVybiByZXQ7DQo+ID4+ICtyZXR1cm4gZW5hYmxlX3JldCA/IGVuYWJsZV9yZXQgOiBy
ZXQ7DQo+ID4gTWF5YmUgd2Ugc2hvdWxkIGFkZCBzb21lIGVycm9yIG1lc3NhZ2UgdG8gbm90aWZ5
IHVzZXIsIHRoZXJlIGFyZSBtb3JlDQo+IGVycm9ycyBoYXBwZW5lZCwNCj4gPiBhcyBzb21lIHJl
dCB2YWx1ZSBpcyBub3QgcmV0dXJuZWQuDQo+IEl0IGlzIHRoZSAtRUlOVkFMIGVycm9yIGNhc2Ug
dGhhdCB3b3VsZCBnZXQgbG9zdCBpZiB0aGVyZSB3YXMgYSBkb3VibGUgZXJyb3IuDQo+IFRoaXMg
ZXJyb3IgaW5kaWNhdGVzIHRoYXQgdGhlIHZhbHVlIHdyaXR0ZW4gdG8gc3lzZnMgYnkgdGhlIHVz
ZXIgZG9lcyBub3QNCj4gY29ycmVzcG9uZCB0byB0aGUgY3VycmVudCBwb3J0IGVycm9ycy4gVGhp
cyBpcyBub3QgYSBoYXJkd2FyZSBlcnJvciwgYW5kIGNvdWxkDQo+IGV2ZW4gYmUgYSB1c2VyIGVy
cm9yLiBEbyB5b3UgdGhpbmsgYSB3YXJuaW5nIGluIHRoZSBlcnJvciBsb2cgaXMgbmVlZGVkIGhl
cmU/DQoNCkkgdGhpbmsgc28sIGFzIHRoZXJlIGFyZSBhY3R1YWxseSB0d28gZXJyb3JzIHRoZXJl
LCBJIGZlZWwgaXQncyBiZXR0ZXIgdG8gbGV0IHVzZXIga25vdw0KdGhlaXIgaW5wdXQgaXMgbm90
IGFjY2VwdGVkIHRvbyB0aGFuIGp1c3Qga2VlcGluZyBzaWxlbmNlLCByaWdodD8gYXMgdGhpcyBl
cnJvcg0Kc2hvdWxkIGJlIHRyaWdnZXJlZCBieSB1c2VyIGlucHV0Pw0KDQpIYW8NCg0KPiANCj4g
Pg0KPiA+PiAgfQ0KPiA+Pg0KPiA+PiAgc3RhdGljIHNzaXplX3QgZXJyb3JzX3Nob3coc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4gPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZnBnYS9kZmwtYWZ1LW1haW4uYyBiL2RyaXZlcnMvZnBnYS9kZmwtYWZ1
LW1haW4uYw0KPiA+PiBpbmRleCA3NTNjZGE0YjI1NjguLjcyOWViMzA2MDYyZSAxMDA2NDQNCj4g
Pj4gLS0tIGEvZHJpdmVycy9mcGdhL2RmbC1hZnUtbWFpbi5jDQo+ID4+ICsrKyBiL2RyaXZlcnMv
ZnBnYS9kZmwtYWZ1LW1haW4uYw0KPiA+PiBAQCAtMjEsNiArMjEsOSBAQA0KPiA+Pg0KPiA+PiAg
I2luY2x1ZGUgImRmbC1hZnUuaCINCj4gPj4NCj4gPj4gKyNkZWZpbmUgUlNUX1BPTExfSU5WTCAx
MCAvKiB1cyAqLw0KPiA+PiArI2RlZmluZSBSU1RfUE9MTF9USU1FT1VUIDEwMDAgLyogdXMgKi8N
Cj4gPj4gKw0KPiA+PiAgLyoqDQo+ID4+ICAgKiBfX2FmdV9wb3J0X2VuYWJsZSAtIGVuYWJsZSBh
IHBvcnQgYnkgY2xlYXIgcmVzZXQNCj4gPj4gICAqIEBwZGV2OiBwb3J0IHBsYXRmb3JtIGRldmlj
ZS4NCj4gPj4gQEAgLTMyLDcgKzM1LDcgQEANCj4gPj4gICAqDQo+ID4+ICAgKiBUaGUgY2FsbGVy
IG5lZWRzIHRvIGhvbGQgbG9jayBmb3IgcHJvdGVjdGlvbi4NCj4gPj4gICAqLw0KPiA+PiAtdm9p
ZCBfX2FmdV9wb3J0X2VuYWJsZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+PiAr
aW50IF9fYWZ1X3BvcnRfZW5hYmxlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4+
ICB7DQo+ID4+ICBzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBkZXZf
Z2V0X3BsYXRkYXRhKCZwZGV2LQ0KPiA+Pj4gZGV2KTsNCj4gPj4gIHZvaWQgX19pb21lbSAqYmFz
ZTsNCj4gPj4gQEAgLTQxLDcgKzQ0LDcgQEAgdm9pZCBfX2FmdV9wb3J0X2VuYWJsZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+PiAgV0FSTl9PTighcGRhdGEtPmRpc2FibGVfY291
bnQpOw0KPiA+Pg0KPiA+PiAgaWYgKC0tcGRhdGEtPmRpc2FibGVfY291bnQgIT0gMCkNCj4gPj4g
LXJldHVybjsNCj4gPj4gK3JldHVybiAwOw0KPiA+Pg0KPiA+PiAgYmFzZSA9IGRmbF9nZXRfZmVh
dHVyZV9pb2FkZHJfYnlfaWQoJnBkZXYtPmRldiwNCj4gPj4gUE9SVF9GRUFUVVJFX0lEX0hFQURF
Uik7DQo+ID4+DQo+ID4+IEBAIC00OSwxMCArNTIsMjAgQEAgdm9pZCBfX2FmdV9wb3J0X2VuYWJs
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+PiAgdiA9IHJlYWRxKGJhc2Ug
KyBQT1JUX0hEUl9DVFJMKTsNCj4gPj4gIHYgJj0gflBPUlRfQ1RSTF9TRlRSU1Q7DQo+ID4+ICB3
cml0ZXEodiwgYmFzZSArIFBPUlRfSERSX0NUUkwpOw0KPiA+PiAtfQ0KPiA+Pg0KPiA+PiAtI2Rl
ZmluZSBSU1RfUE9MTF9JTlZMIDEwIC8qIHVzICovDQo+ID4+IC0jZGVmaW5lIFJTVF9QT0xMX1RJ
TUVPVVQgMTAwMCAvKiB1cyAqLw0KPiA+PiArLyoNCj4gPj4gKyAqIEhXIGNsZWFycyB0aGUgYWNr
IGJpdCB0byBpbmRpY2F0ZSB0aGF0IHRoZSBwb3J0IGlzIGZ1bGx5IG91dA0KPiA+PiArICogb2Yg
cmVzZXQuDQo+ID4+ICsgKi8NCj4gPj4gK2lmIChyZWFkcV9wb2xsX3RpbWVvdXQoYmFzZSArIFBP
UlRfSERSX0NUUkwsIHYsDQo+ID4+ICsgICAgICAgISh2ICYgUE9SVF9DVFJMX1NGVFJTVF9BQ0sp
LA0KPiA+PiArICAgICAgIFJTVF9QT0xMX0lOVkwsIFJTVF9QT0xMX1RJTUVPVVQpKSB7DQo+ID4+
ICtkZXZfZXJyKCZwZGV2LT5kZXYsICJ0aW1lb3V0LCBmYWlsdXJlIHRvIGVuYWJsZSBkZXZpY2Vc
biIpOw0KPiA+IE1heWJlIHdlIGNhbiBjaGFuZ2UgZGV2X2VyciBtZXNzYWdlIGluIHBvcnQgZGlz
YWJsZSB0byAiZGlzYWJsZSBkZXZpY2UiIGFzDQo+IHdlbGwuIDogKQ0KPiBUaGFuayB5b3UuIEkn
bGwgc3VibWl0IGEgbmV3IHZlcnNpb24gb2YgdGhlIHBhdGNoIHdpdGggdGhpcyBmaXguDQo+IA0K
PiAtIFJ1c3MNCj4gPg0KPiA+IEhhbw0KPiA+DQo+ID4+ICtyZXR1cm4gLUVUSU1FRE9VVDsNCj4g
Pj4gK30NCj4gPj4gKw0KPiA+PiArcmV0dXJuIDA7DQo+ID4+ICt9DQo+ID4+DQo+ID4+ICAvKioN
Cj4gPj4gICAqIF9fYWZ1X3BvcnRfZGlzYWJsZSAtIGRpc2FibGUgYSBwb3J0IGJ5IGhvbGQgcmVz
ZXQNCj4gPj4gQEAgLTExMSw5ICsxMjQsOSBAQCBzdGF0aWMgaW50IF9fcG9ydF9yZXNldChzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+Pg0KPiA+PiAgcmV0ID0gX19hZnVfcG9ydF9k
aXNhYmxlKHBkZXYpOw0KPiA+PiAgaWYgKCFyZXQpDQo+ID4+IC1fX2FmdV9wb3J0X2VuYWJsZShw
ZGV2KTsNCj4gPj4gK3JldHVybiByZXQ7DQo+ID4+DQo+ID4+IC1yZXR1cm4gcmV0Ow0KPiA+PiAr
cmV0dXJuIF9fYWZ1X3BvcnRfZW5hYmxlKHBkZXYpOw0KPiA+PiAgfQ0KPiA+Pg0KPiA+PiAgc3Rh
dGljIGludCBwb3J0X3Jlc2V0KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4+IEBA
IC04NzIsMTEgKzg4NSwxMSBAQCBzdGF0aWMgaW50IGFmdV9kZXZfZGVzdHJveShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlDQo+ID4+ICpwZGV2KQ0KPiA+PiAgc3RhdGljIGludCBwb3J0X2VuYWJsZV9z
ZXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgYm9vbCBlbmFibGUpDQo+ID4+ICB7DQo+
ID4+ICBzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBkZXZfZ2V0X3Bs
YXRkYXRhKCZwZGV2LQ0KPiA+Pj4gZGV2KTsNCj4gPj4gLWludCByZXQgPSAwOw0KPiA+PiAraW50
IHJldDsNCj4gPj4NCj4gPj4gIG11dGV4X2xvY2soJnBkYXRhLT5sb2NrKTsNCj4gPj4gIGlmIChl
bmFibGUpDQo+ID4+IC1fX2FmdV9wb3J0X2VuYWJsZShwZGV2KTsNCj4gPj4gK3JldCA9IF9fYWZ1
X3BvcnRfZW5hYmxlKHBkZXYpOw0KPiA+PiAgZWxzZQ0KPiA+PiAgcmV0ID0gX19hZnVfcG9ydF9k
aXNhYmxlKHBkZXYpOw0KPiA+PiAgbXV0ZXhfdW5sb2NrKCZwZGF0YS0+bG9jayk7DQo+ID4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2ZwZ2EvZGZsLWFmdS5oIGIvZHJpdmVycy9mcGdhL2RmbC1hZnUu
aA0KPiA+PiBpbmRleCA1NzZlOTQ5NjAwODYuLmU1MDIwZTJiMWYzZCAxMDA2NDQNCj4gPj4gLS0t
IGEvZHJpdmVycy9mcGdhL2RmbC1hZnUuaA0KPiA+PiArKysgYi9kcml2ZXJzL2ZwZ2EvZGZsLWFm
dS5oDQo+ID4+IEBAIC04MCw3ICs4MCw3IEBAIHN0cnVjdCBkZmxfYWZ1IHsNCj4gPj4gIH07DQo+
ID4+DQo+ID4+ICAvKiBob2xkIHBkYXRhLT5sb2NrIHdoZW4gY2FsbCBfX2FmdV9wb3J0X2VuYWJs
ZS9kaXNhYmxlICovDQo+ID4+IC12b2lkIF9fYWZ1X3BvcnRfZW5hYmxlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpOw0KPiA+PiAraW50IF9fYWZ1X3BvcnRfZW5hYmxlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpOw0KPiA+PiAgaW50IF9fYWZ1X3BvcnRfZGlzYWJsZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KTsNCj4gPj4NCj4gPj4gIHZvaWQgYWZ1X21taW9fcmVnaW9u
X2luaXQoc3RydWN0IGRmbF9mZWF0dXJlX3BsYXRmb3JtX2RhdGEgKnBkYXRhKTsNCj4gPj4gLS0N
Cj4gPj4gMi4yNS4xDQoNCg==
