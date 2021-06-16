Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89FB3A8E09
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Jun 2021 03:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhFPBHp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Jun 2021 21:07:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:15653 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhFPBHp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Jun 2021 21:07:45 -0400
IronPort-SDR: xjO+kYb5ZzjW88qLJEJDn3KXbTxG/W7XZ/2/akJ/KMfZ3Ax4UeBtX/Luv2SoZpb3qrTLX4bzvr
 i+x+NkhovsPA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="186470842"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="186470842"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 18:05:40 -0700
IronPort-SDR: M9uovYHSeuNI2ywvV4+4J6U79DSdqofTjjVkv71NssqjEy3MBWC4mrhIzMyBtmn5Z6BDgfzOxR
 hbKCrUbGEiLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="471833120"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2021 18:05:39 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 15 Jun 2021 18:05:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 15 Jun 2021 18:05:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 15 Jun 2021 18:05:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 15 Jun 2021 18:05:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4wfEbuJ3gtUqxT9/Jm0Ny+TyshTFSdE2UHGNm0xxl8QNgM5NooDYvSBkud4/JJ+VdqcL9iwooH+FGQfLdgyz346KY9uWaJXEXE8j7K+p1Y75Rte2RCDH2gFH92Me5fKdF/zq0x9QqH/teXhjUuy48OsJXCSIsuUzpRea+wmmJyFDvbwSTso5aLghl1mDxsU73GEjPGkHeKWlcUckO2YCY0UN0McHbnosMviwIlMydOzznaOioQyt4kFiF6qagAMbKp0DebmKp7cx2USkjh4Y81ipS3JnbErwYq7heqk29lUUbIXpHfOWVPWHr8Sl8w8fx9Po+YJ2fK85qpxzXCo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diYCnjpowDqNfa5EtmsxdkDsTn5bsgqYjXSY0SG1cW4=;
 b=HpXpAlNn0Za8Qfu+XVQOElkMNdPjuQZtZ1y7zatOdYOPiWbP2ofKS0K5MG+FYCopVkKbs2QeIx4AaWG5lHkjvdrIHR6mEw7HC68oARUti4Mw82n0jBE8dyfnLLMB87f+c7ZJ6+RzL2qzs7I9c47in82sweMbCfvnaDu9jic7TjqAOlfJsE/IgQ4nnCxEb0Xg6aUuiOpUkd9K2LfUfoKar+tW2aOiGZGTATyLhYZq5J7aBsr10O7INputM6fZp/FiFN5dMxtP/ljxlOSfsDUZV7y4G0cvYRYRIVpVp/W+eTjrJx4r2IQUhQfl7lR4pQgNvBZOvQVolXRizNc+K6YJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diYCnjpowDqNfa5EtmsxdkDsTn5bsgqYjXSY0SG1cW4=;
 b=K3VNXdf5RkCCSEMAW86tG6vyVL3Q0TioiMbYEIELnTdbb1eqBZfteWL/kzZz8yybm7Kz3YXakqjSTyD1pffvBsl+rQknEqFdPYWP0nncwuBROXm05FN3rvnkt4BduDa3Naeoq94D445D0hUO0AhuRjwuerIcoXPsO5SvcZPOFlw=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR1101MB2153.namprd11.prod.outlook.com (2603:10b6:4:56::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 01:05:36 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4219.025; Wed, 16 Jun 2021
 01:05:36 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "fpacheco@redhat.com" <fpacheco@redhat.com>,
        "Gong, Richard" <richard.gong@intel.com>,
        "luca@lucaceresoli.net" <luca@lucaceresoli.net>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 1/4] fpga: dfl: reorganize to subdir layout
Thread-Topic: [PATCH v4 1/4] fpga: dfl: reorganize to subdir layout
Thread-Index: AQHXYVpMuuq4CCKpI0OAe3HAOe9lxqsUps2ggADmEgCAAEctkA==
Date:   Wed, 16 Jun 2021 01:05:36 +0000
Message-ID: <DM6PR11MB3819259241791EB04A2CB9C8850F9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210614201648.3358206-1-trix@redhat.com>
 <20210614201648.3358206-3-trix@redhat.com>
 <DM6PR11MB381964374223D0D2958AFA6985309@DM6PR11MB3819.namprd11.prod.outlook.com>
 <d64b0fb8-5f83-2995-7ee9-b4ed2932ef60@redhat.com>
In-Reply-To: <d64b0fb8-5f83-2995-7ee9-b4ed2932ef60@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.142.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5aff3d3-25f4-4dc6-4ac0-08d93062d9c1
x-ms-traffictypediagnostic: DM5PR1101MB2153:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB21531D97457662F8A8921284850F9@DM5PR1101MB2153.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lxfyPNKWckVc124MWFk90TVDQ7JMqYG4aS9NRnfrinzIvEonGZGRBoHSmqC0i5TWLfzdilxh2qCWtsearTWsQTggcRD1Yvu88jO/x9EVpsavV/zS+D+81iH5evHE9OlRAajlsabE8K37ISb0XEj8587l7JublztucE6ANlcYjA/IY8gkIZ0zE8XEQgHxwFBwirp55iJlG+2BljeDJzlaB7Yd+m0OqbaeOCSzUqynaMnrc6TWEjVXNhyJaMs0+HDFnfjD0ujJFPSPggaRN7In/c6Ed4dVuCmit7SEJHOiUzp5Gx/PDekXopZEypwNSJHODusAoAwA02epes4SOuAtzM1EGUgu82RHS1rFFv3LHrBGr22XXVDq0HVZwcA0SAGlmRr5iHMMKr/lvj0dyfeYCoHP064TcrmGRvPUgaQYHMhSy4qrGFhaJvkLbuXxotlZgDhYvxjXhzJzTBXCUenJm5dafiSqMaNkslLG5jCzFJhxRVnRi/FLzG9Njm29NqhmT928iYVtCJ4v0LYhjsaB7oKZncWpwTYVqUcbREcgNl4KqSeNAKIsmF90sYOxyHnEpVmNRurOGLCA3mU27OM/BMlgKCeNVpTG2KBHCnX+dszjwRs3p6/4wO5Wom0UV2XHuqxXlTKjP3WDqZlBur4PrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(39860400002)(396003)(7696005)(66446008)(52536014)(66556008)(478600001)(66476007)(53546011)(64756008)(6506007)(71200400001)(86362001)(33656002)(186003)(38100700002)(54906003)(921005)(2906002)(110136005)(122000001)(5660300002)(66946007)(76116006)(8936002)(55016002)(7416002)(4326008)(316002)(8676002)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0JoY0tBcEFUamtERkRLVDdjMVJOVzY4bFBSdE9OeW0yQUFQdVlIQ1YzcUtY?=
 =?utf-8?B?bUlkMHRBTXVaOFBZcHViLzBPWG55NGIwVmZ2QmgyOHJoRHovcWNSbTNvRHFW?=
 =?utf-8?B?SGt3RFJXUVNHOGhDYSs4Z29WOTh1OUYrdDA1dzdNU1dBdmFQWHNnaEY0a3Ro?=
 =?utf-8?B?NTlZRWk1Y21jc0ZpdEllY3JROVF4bGRxN2VBd1dKRGY3eE9jMmdNc0FtNWNY?=
 =?utf-8?B?b09zclBCYldWdXNXMUhZS25sTGlmeFM2dEJlbEI2YmpKOHR5a3pVTzF4UWN2?=
 =?utf-8?B?T0M1bkZ1U25hdTRLRDRDQklvMmp3cXlPdDYxdGYvZzdrS0dPbG1mL0RUb0Nx?=
 =?utf-8?B?OWpRRDlrUkwxSlVvWDJDVmlhVkRsM2MzS1pRdHRrZVA4SEFXUGxhTXl2N3Ir?=
 =?utf-8?B?QjRvRXlTc1RCdnY1TU0vK003bU41bTIvREpzN1M3d3JBQmRjSlNGM0cvczdM?=
 =?utf-8?B?T0ppQjU5Q1F2cWdURVdUTUZTemRRaHgzZkFIVkY3QXpqMHp6T2lrRWxRZyt1?=
 =?utf-8?B?RUZSNkFuVmcxb0tIL2FzV29QTkNYR3Zzd29YbisrR0lJVlhnOXdsWlFqZFNw?=
 =?utf-8?B?c0hXVXlRTEhWSENSQ20yY2c3aWZvOHVPcGR5OXZxZmxtVWhOVWFjTUlBcmdv?=
 =?utf-8?B?dUN6Rk03dUVFQ0pJVGtKSytQYllyZUZoMTZkY3hseFM3dWtYWitxR2V4bnRs?=
 =?utf-8?B?N1BFaTlzNnAyU21YVU9seVNkd0hOckVOaHNlemhpN28yKzVYZ2U3bkxjVzhO?=
 =?utf-8?B?U0tsVExuLzRBMkRQeGhhdG05YW9LYlowWWU0V0lGU3RCMFlIdERXajRqY2o1?=
 =?utf-8?B?dDhYVms0amttc2RyOVB0ZldJUGJPdzRzMkt2Ym5aRXpUenBTbEwvbEJ3c2NE?=
 =?utf-8?B?SDEyNG9VU1JSdERyc1F2eDRhTWw2SVgrRGZpbEl5ODZJMllDRkFuZm9xdk4w?=
 =?utf-8?B?YUhLOU5JN2E2VkoycWhhU0czbExKWWFoNXRpUnFJeHl0YjhENytaSzhydkFS?=
 =?utf-8?B?R2wwNzJZaUlvV3NKdlpBV1p1MzNTOFlDZERNeFd0SjVKeTEyZXJLbHViSTFw?=
 =?utf-8?B?TVdBSHhmZ2c4WTkvR0d3SThNMEt3RmhDODhBMXlNd3VQdk54cVlCUFFoUTBI?=
 =?utf-8?B?ODhMRy9odDlGY0kyQUVQWk4xTW5kL0lJMllyUjNpTWFqd1g1ZjI5cEExd2Q5?=
 =?utf-8?B?WmJOZVdMMkhiVVdONGU0U1Zid0JoN2R0UlA5eWpNbXY4SGVMb2xIS3dCZkVF?=
 =?utf-8?B?TkQ3TW81cWJONHduYTlZdTNmUWRyRmFnVWVpZXM0REZqZkVoMlpJWGoxY1do?=
 =?utf-8?B?dmZmMkpPVk4rTUp6ZXovdHUyNmd2dDRrTDR4VHFxTjFqa1hqZzVzcWZCNEE1?=
 =?utf-8?B?OUc3cUpTUEhpcHdRZDlEeEtUZmJXVWlnMDVXU0FVa05vWHNwaG1ES2Jld3h4?=
 =?utf-8?B?eEFyMWdNYkQwQkJvVjNGNU1UTTVrT01TMkxIOE84ZWJyMnB2bkxTeFc1M3JN?=
 =?utf-8?B?SlB1TWFKZFhFUG5rQ0VTbFhyU1Y1WFlSZUtZT1pxZUtaUTZHZWM1QVVnYXNV?=
 =?utf-8?B?dlF1dEo1WGoyclNqYnJzVzRubERqeG9ITER4L0VIQVJsUm1EOE4xemVQQ0Za?=
 =?utf-8?B?bXQ5Uks5dDhTQ2ViOU1NeVBQSkxCL0JpMnZSMllWcFJ3TEtBM2VZdlUrK3pu?=
 =?utf-8?B?eVNld2x1MG5pUzB3ZXNEVnlCR3BvZk4wbDU0RmpOYnpoVUJsZW0yNmVrWHhj?=
 =?utf-8?Q?kBF/BWyYUJh7QAB94vuXCzKT4XERln1uWSK/3L7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5aff3d3-25f4-4dc6-4ac0-08d93062d9c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 01:05:36.7028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KOACLRVKlL/myxcO0QbCjqDHYdY2r/G+g3eD+RjXAHrlXmQ0RH2RIe+08zurosazUQPEJsntvRbHVZD8+r4Dzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2153
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBPbiA2LzE1LzIxIDE6MDggQU0sIFd1LCBIYW8gd3JvdGU6DQo+ID4+IFN1YmplY3Q6IFtQQVRD
SCB2NCAxLzRdIGZwZ2E6IGRmbDogcmVvcmdhbml6ZSB0byBzdWJkaXIgbGF5b3V0DQo+ID4+DQo+
ID4+IEZyb206IFRvbSBSaXggPHRyaXhAcmVkaGF0LmNvbT4NCj4gPj4NCj4gPj4gRm9sbG93IGRy
aXZlcnMvbmV0L2V0aGVybmV0LyB3aGljaCBoYXMgY29udHJvbCBjb25maWdzDQo+ID4+IE5FVF9W
RU5ET1JfQkxBIHRoYXQgbWFwIHRvIGRyaXZlcnMvbmV0L2V0aGVybmV0L2JsYQ0KPiA+PiBTaW5j
ZSBmcGdhcyBkbyBub3QgaGF2ZSBtYW55IHZlbmRvcnMsIGRyb3AgdGhlICdWRU5ET1InIGFuZCB1
c2UNCj4gPj4gRlBHQV9CTEEuDQo+ID4gSGkgVG9tLA0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGlz
IHBhdGNoLiA6ICkNCj4gPg0KPiA+IERGTCBpcyBub3QgYSB2ZW5kb3IsIGJ1dCBzb21ldGhpbmcg
Y2FuIGJlIHNoYXJlZC9yZXVzZWQuIEl0J3MgcG9zc2libGUgdGhhdA0KPiA+IG90aGVyIHZlbmRv
cnMgcmV1c2UgdGhlIHNhbWUgY29uY2VwdHMgYW5kIHRoZSBkcml2ZXJzIG9mIERGTC4gSWYgdmVu
ZG9yDQo+ID4gZHJpdmVycyBuZWVkIHRvIGJlIG1vdmVkIGluc2lkZSBzdWIgZm9sZGVycywgdGhl
biBtYXliZSBpdCdzIGJldHRlciB0bw0KPiA+IGxlYXZlIERGTCBpbiB0aGUgcGFyZW50IGZvbGRl
cj8NCj4gDQo+IHhydCBpcyBhbHNvIG5vdCBhIHZlbmRvciwgbW9yZSBhIHN1YmRldmljZSBmcmFt
ZXdvcmsgbGlrZSBkZmwuDQo+IA0KPiBJIGFtIG5vdCBzdXJlIHdoYXQgeW91IG1lYW4gYnkgb3Ro
ZXIgZGZsIHZlbmRvcnMgY2FuIHlvdSBnaXZlIGFuIGV4YW1wbGUgPw0KDQpJdCdzIGZpbmUsIGJ1
dCB0aGUgZGVzY3JpcHRpb24gaGVyZSBpcyBhIGxpdHRsZSBjb25mdXNpbmcgb24gdmVuZG9yL2Zy
YW1ld29yaw0KaGFuZGxpbmcuIE5vIG90aGVyIHZlbmRvciBzbyBmYXIsIGJ1dCBpdCdzIHBvc3Np
YmxlLCBERkwgY2FuIGJlIHVzZWQgaW4gDQpub24taW50ZWwgZGV2aWNlLCBhbmQgcmVsYXRlZCBk
cml2ZXJzIGNhbiBiZSByZXVzZWQgYXMgd2VsbC4gVGhlbiBhIGZwZ2EgDQptZ3IgZHJpdmVyIGRl
cGVuZHMgb24gREZMLCBzaG91bGQgYmUgcHV0IGluc2lkZSBkZmwgZm9sZGVyIG9yIG5ldw0KdmVu
ZG9yJ3Mgc3ViZm9sZGVyPw0KDQpIYW8NCg0K
