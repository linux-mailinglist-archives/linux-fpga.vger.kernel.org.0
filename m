Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC693AE6E8
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Jun 2021 12:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFUKVe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Jun 2021 06:21:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:18582 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhFUKVe (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Jun 2021 06:21:34 -0400
IronPort-SDR: UjIalGPFL7TlBUAfHbQl6vNq/+O3WuntvdKiwVTePbON6MbdkpL6u6J/wei/6SZla4T4b4JBhC
 ItfFfKFwklTA==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="187190952"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="187190952"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 03:19:19 -0700
IronPort-SDR: nh+jzRS14tKXzZ7ZNNjVMPSqbvZf87v0ZRnf3WX9Inp+PMcgF6Bkx80UZy4aTIs1nQ4rjIhA5T
 OnHIjj/bAH3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="623033212"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 21 Jun 2021 03:19:19 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 21 Jun 2021 03:19:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 21 Jun 2021 03:19:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 21 Jun 2021 03:19:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Mon, 21 Jun 2021 03:19:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfMIGpbhvM7DyZS2Xtu6FrV8S1bmkf+FJx1z4HvMq73AdzAyZzCMxaGx/mWvOk0cGgpvEHL+8wmtp5j3hosIW5l0q3knZR4IND2yJ2qgzefNOP3V7hVacLrsufRI4E0IGp8rYSoYiMRqhRlEm2dblLirKu6wcldo9m0aBk+RlPMsHdePD/LwbqrXW1nJj6eLsgClAzsOGe+jIFTkkT+Bg213h2Pl4QohOqfvIjnYWwrf/7H5ZiLk39JeIthb3zCQ9Onm35RLGxwDA8Ay5qd4gF5Gr9qR5ZACOeobsBjj0UmUCSa/3+6dtjs+Gk3zjOjemsIX3LKsK1tULg40CH/VBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmfnsJ67ZVgI+oowx8Pg/ESwufLfB13IEDXljonkUQ0=;
 b=JEOhuM3yKq+dOq+J8ZpmmxKDis5BJY2clfzWzVFNO0gczSF524RxJsLkgTJx8U7SH6vKBBVotnBks0LGM77SeJzUQFoXrSuzZX8kUQIRBlwCLBrL8GpPFa2K/h5P/CRbkFhORBxHDjnOFTIj8FusLVr+/jBrhwh7tuU95QeCY4o69h95FDRuavZ3jD0wrP3I4lCGWITdZG6yUDPmgLis2UimIgvg3fHceA1IOjqcNux/2iGHbdkos5H/ydrJyexTWzj5Apda8bjf2mq/dIAEj1mnSLF/4ZAoItfOnLblHvvBM7c49QTRW4NxwAR8LNcY5k1EAkLEZMEEPoRCD/A8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmfnsJ67ZVgI+oowx8Pg/ESwufLfB13IEDXljonkUQ0=;
 b=IrulqknyImsPjfYY4ffDXgCjVSK2+g7FV0v5v83Eq+UVs1Gaia6qFlu5nOcmP4PNdYtHgGXlaG25VQXo867YFdchcfXtllxDI2HBG20u/a0YEvh2tieiI3aObSjcAxNA557ibGW7pf2YxA7KOzkpZ+tkUplks/tT2uAnHoYz1dw=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1690.namprd11.prod.outlook.com (2603:10b6:3:15::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Mon, 21 Jun
 2021 10:19:16 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 10:19:16 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        =?utf-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <mhu@silicom.dk>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Lee Jones" <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>
CC:     =?utf-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <mhu@geanix.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Debarati Biswas <debaratix.biswas@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        =?utf-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <mhu@silicom.dk>
Subject: RE: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
 linux/dfl.h
Thread-Topic: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
 linux/dfl.h
Thread-Index: AQHXZmv/x7+K61N2t0+UjQD0SdSPWqsePhcg
Date:   Mon, 21 Jun 2021 10:19:15 +0000
Message-ID: <DM6PR11MB3819FE54D2C399DDBBC38FBA850A9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210621070621.431482-1-mhu@silicom.dk>
 <20210621070621.431482-3-mhu@silicom.dk>
In-Reply-To: <20210621070621.431482-3-mhu@silicom.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd9ecf61-85c6-47f0-cffe-08d9349e0618
x-ms-traffictypediagnostic: DM5PR11MB1690:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1690B1FE880350DA48AE184C850A9@DM5PR11MB1690.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g1qXXor4eJVUHFOd3/vi+q7uw4ofDIoplrHD4/HvSTn9tKGF8AOkjsw2ejN/FPoHfCTY614rfOUwiwWzwAt0gTStlIP1pL7fcu6nYchtiOdLIO9vkV1suExVfHBwLC+jBVpz1XnzZuLd4r+D6kXbMQuNECM6WubJeBeJI81Czsg7Fdw9/KgO4BWHyNcXHho9iJ69l625xyQnH2uELkmq4lwbkSwZ5f8YpQ5P6X6hxLVOy/UKG+8CDFud31ntzPxtDGXHtaa0OpToAsDzyNYZUegaZ68dnSw6/WmXkALsCB75gsSi6007dmTh+g9MduzHOjYuSRx8kvadi7JO9oZ57/Zc0YdEh8m3mG1glwzWUEHamwBisr3qYW5VCOarVr17kIks4ElkNRqptUq0jVAhbWP3CUqSyvJdpmniY2razOEPgKXKhB0rOaP1cmFA9FpdJ8BgnGSlwaS1kxueDcBwYIUcbovZqPKhxaI39Z10cRan6G9osQ+sgIH0v6fE8iG+0uRKwezd4NTqkFgREPfAY0mAPpWrCaVcO+wshkSDUQ8OobZQib3qhblzYWC2tu7q8f9EO0TuSnDDAFZDHKBYlF1KRMQxKuA8AigG+lpFGnk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(346002)(366004)(136003)(55016002)(9686003)(64756008)(66556008)(66946007)(66446008)(38100700002)(4326008)(122000001)(66476007)(66574015)(83380400001)(76116006)(7696005)(478600001)(54906003)(110136005)(186003)(26005)(316002)(86362001)(52536014)(2906002)(6506007)(5660300002)(33656002)(8676002)(7416002)(71200400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmE3VFZWb2RlaFlIdG92RWM0UnF6Tlg5aEUxNHl0Zmt6Y2ZEUDVLZ3R3ZE9R?=
 =?utf-8?B?bTJXYlc3aXdiZEw2am16QXVzblJkN3gyREVmQUllUVNib2pBSEU0MDJva3c5?=
 =?utf-8?B?ZnE2NWRvNFIwL1VkRmliV2NJdWw3NjdkRkJPL1hBYzE1cXdpaG1qalJ2cG9M?=
 =?utf-8?B?OU5vbE56Sm53ckU4RVJVL3dCQ2NLeEhxSGJtMG9QVHFHWTJSNm9XMnVHeE90?=
 =?utf-8?B?bDEyVzV3dUVBM1VGWDd2cEdoMEZwRE9FSTlreDZQUTUzelFMc2RETHNYK0Rm?=
 =?utf-8?B?c3I5dU8wLzBhSnZYU2ZNdkVSdlpYVVNtZ2JlcFNTSTdwS3o4U3gwY1FyWW1w?=
 =?utf-8?B?NytTSWpuVXBuTmxkaUloQ2JuU2QrZGgzRXg4S3hJWU1GYjRPZDRzL3pNNnkr?=
 =?utf-8?B?OXNKMzNuWUYzQkU4L1g5VENQYThjbjhOUmRjR3lhTUVNN0dUY2MyYjhyN2g1?=
 =?utf-8?B?ckV5c1A5TVVzdU9tdWR5LzJxRWhSRzQyYW5lQ1k5Vng1VWNkcXJuS1VtZ2U1?=
 =?utf-8?B?M3dHR3V5YW4rQi9aMngxSEQ2QzZab2Z0RVJBQnR4OWt0dUx5SzBCVktNeGpW?=
 =?utf-8?B?YjlhSndWc2VnRFdoMG5IRk45UXRZaGMyakpxQVhXUkJXRm84cU5sR0FiZURR?=
 =?utf-8?B?RGxwcVdoZHZHbEdzQzRqK3h3K08vR1JPUythK1RleWRJU1Q4THV3Y2txNHQx?=
 =?utf-8?B?TWo3NUJyVm5IVlpFeUxhSUQ2WUNhYzhBbW41RUNVTjAwVUNVeStjaXNiWWVa?=
 =?utf-8?B?cmp6bDZMUExZT0NnUms1MGZMbWcwcVFvNVg2alZOYmhEZ05GemZZaEtHWlUz?=
 =?utf-8?B?WnE4Ykp2d3NrTXRyRE1GdHNzOXc3QVNMaUkwbVFTbkU3QzdWOGI1NzQza2tQ?=
 =?utf-8?B?MTBsN1UvcU1PMXNZeGRiRFExZUJVbjNFam1UV3d5cGlKL0NmQnZ2Y01zMFVt?=
 =?utf-8?B?cXA3WWYzVTNlazR1QkZLcThudHlBWHgzT1JGTVdzamhaQ0pWZERuNVFHQUxs?=
 =?utf-8?B?KzJNRDR3MjhSNGpUckJ1MVZ2RUF5eU9SUFdTOVlITjRONFlKOVR2ME5XT2JS?=
 =?utf-8?B?cjlmMENZNmZkRGhRa01mOUNMZk4vV1dmUUhIdW5nbUc3a1I2cVo4K05TRjVy?=
 =?utf-8?B?bTZEVUx4MUZEamN2cUlTQzdxZEpMVnVHem0renY0T1pZQzh6WlEzN3NWVjJ4?=
 =?utf-8?B?VmYyYnZKOWRQRU51U2ZRUVZpcldRSnpPK0NUUjlZd0pvNHdHT1A3Mkh4UHNZ?=
 =?utf-8?B?L1BrTWZqa292VHF3elJVZU53UXJzbi9pZk4zby9oT1ZFTm5IU1A3MS8xNmRx?=
 =?utf-8?B?ZjBkdTRCRENpeGRpeW1xV1YxVnRqbEdha3p6cXVwaWNuenM4OG1rVWxxekR3?=
 =?utf-8?B?MG0xMUlkS2gvZmljVVBVcG5rV0V1NHl2bTBZVSs0ZUhXYXZVbFcwcVFpb0ZK?=
 =?utf-8?B?RTRRUW5BeDgzdUVXdFhGSENPWWtrQmx6RThCWDJUTWo4amthaGVhVmJCVDFF?=
 =?utf-8?B?L3R2ODVETHl0Y3d2YzNuTm5iZm9aRlBEQnkxNXB2YjA4ZkZKTk1mamJJWXY1?=
 =?utf-8?B?UjNNVS8zYjVVRzJSdmxTMjE3cFdOSldrRHphY1oxTEUxSjlzWjJSWUNrL1RZ?=
 =?utf-8?B?WlFqMWg0L3pkUEhnN01WT0w2clhnK1l5MzRrTm1HVVNYN3FGNnFEcmt3Z3RD?=
 =?utf-8?B?Z28wUm1uNHpEdlVFb1R1L1V3enBVbWU5a2VMTmcwcFNvcmJoemF1Q0tOanFx?=
 =?utf-8?Q?3b843zr2EVQCgw91KE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9ecf61-85c6-47f0-cffe-08d9349e0618
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 10:19:15.9843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1zxa5QcSN6T4dsax58tTVVCwmY1VUAGj8dwieWPE7C/itfRNLJ+0JTW5fsoVgTogN3GPXl0gK7DZtvK8yPXeMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1690
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0ggMi80XSBmcGdhOiBkZmw6IE1vdmUgREZIIGhlYWRlciByZWdpc3Rl
ciBtYWNyb3MgdG8gbGludXgvZGZsLmgNCj4gDQo+IEZyb206IERlYmFyYXRpIEJpc3dhcyA8ZGVi
YXJhdGl4LmJpc3dhc0BpbnRlbC5jb20+DQo+IA0KPiBEZXZpY2UgRmVhdHVyZSBMaXN0IChERkwp
IGRyaXZlcnMgbWF5IGJlIGRlZmluZWQgaW4gc3ViZGlyZWN0b3JpZXMgb3RoZXINCj4gdGhhbiBk
cml2ZXJzL2ZwZ2EsIGFuZCBlYWNoIERGTCBkcml2ZXIgc2hvdWxkIGhhdmUgYWNjZXNzIHRvIHRo
ZSBEZXZpY2UNCj4gRmVhdHVyZSBIZWFkZXIgKERGSCkgcmVnaXN0ZXIsIHdoaWNoIGNvbnRhaW5z
IHJldmlzaW9uIGFuZCB0eXBlDQo+IGluZm9ybWF0aW9uLiBUaGlzIGNoYW5nZSBtb3ZlcyB0aGUg
bWFjcm9zIHNwZWNpZmljIHRvIHRoZSBERkggcmVnaXN0ZXINCj4gZnJvbSBkcml2ZXJzL2ZwZ2Ev
ZGZsLmggdG8gaW5jbHVkZS9saW51eC9kZmwuaC4NCg0KTG9va3MgbGlrZSBpdCByZXF1aXJlcyB0
byBhY2Nlc3MgdGhlIHJldmlzaW9uIGluZm8gaW4gdGhlIG5leHQgcGF0Y2gsIGJlY2F1c2UNCmN1
cnJlbnQgZGZsX2RldmljZSBkb2Vzbid0IGV4cG9zZSByZWxhdGVkIGluZm9ybWF0aW9uLg0KDQpA
WWlsdW4sIGRvIHlvdSBoYXZlIGFueSBjb25jZXJuIHRvIGV4cG9zZSB0aG9zZSBpbmZvIHZpYSBk
ZmxfZGV2aWNlPw0KDQpUaGFua3MNCkhhbw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEZWJhcmF0
aSBCaXN3YXMgPGRlYmFyYXRpeC5iaXN3YXNAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBS
dXNzIFdlaWdodCA8cnVzc2VsbC5oLndlaWdodEBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IE1hcnRpbiBIdW5kZWLDuGxsIDxtaHVAc2lsaWNvbS5kaz4NCj4gLS0tDQo+ICBkcml2ZXJzL2Zw
Z2EvZGZsLmggIHwgNDggKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gIGluY2x1ZGUvbGludXgvZGZsLmggfCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwg
NDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2RmbC5oIGIv
ZHJpdmVycy9mcGdhL2RmbC5oDQo+IGluZGV4IDJiODJjOTZiYTU2Yy4uNmVkMDM1M2U5YTk5IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2ZwZ2EvZGZsLmgNCj4gKysrIGIvZHJpdmVycy9mcGdhL2Rm
bC5oDQo+IEBAIC0xNyw2ICsxNyw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4N
Cj4gICNpbmNsdWRlIDxsaW51eC9jZGV2Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4N
Cj4gKyNpbmNsdWRlIDxsaW51eC9kZmwuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9ldmVudGZkLmg+
DQo+ICAjaW5jbHVkZSA8bGludXgvZnMuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQu
aD4NCj4gQEAgLTUzLDMyICs1NCw2IEBADQo+ICAjZGVmaW5lIFBPUlRfRkVBVFVSRV9JRF9VSU5U
CQkweDEyDQo+ICAjZGVmaW5lIFBPUlRfRkVBVFVSRV9JRF9TVFAJCTB4MTMNCj4gDQo+IC0vKg0K
PiAtICogRGV2aWNlIEZlYXR1cmUgSGVhZGVyIFJlZ2lzdGVyIFNldA0KPiAtICoNCj4gLSAqIEZv
ciBGSVVzLCB0aGV5IGFsbCBoYXZlIERGSCArIEdVSUQgKyBORVhUX0FGVSBhcyBjb21tb24gaGVh
ZGVyIHJlZ2lzdGVycy4NCj4gLSAqIEZvciBBRlVzLCB0aGV5IGhhdmUgREZIICsgR1VJRCBhcyBj
b21tb24gaGVhZGVyIHJlZ2lzdGVycy4NCj4gLSAqIEZvciBwcml2YXRlIGZlYXR1cmVzLCB0aGV5
IG9ubHkgaGF2ZSBERkggcmVnaXN0ZXIgYXMgY29tbW9uIGhlYWRlci4NCj4gLSAqLw0KPiAtI2Rl
ZmluZSBERkgJCQkweDANCj4gLSNkZWZpbmUgR1VJRF9MCQkJMHg4DQo+IC0jZGVmaW5lIEdVSURf
SAkJCTB4MTANCj4gLSNkZWZpbmUgTkVYVF9BRlUJCTB4MTgNCj4gLQ0KPiAtI2RlZmluZSBERkhf
U0laRQkJMHg4DQo+IC0NCj4gLS8qIERldmljZSBGZWF0dXJlIEhlYWRlciBSZWdpc3RlciBCaXRm
aWVsZCAqLw0KPiAtI2RlZmluZSBERkhfSUQJCQlHRU5NQVNLX1VMTCgxMSwgMCkJLyogRmVhdHVy
ZSBJRA0KPiAqLw0KPiAtI2RlZmluZSBERkhfSURfRklVX0ZNRQkJMA0KPiAtI2RlZmluZSBERkhf
SURfRklVX1BPUlQJCTENCj4gLSNkZWZpbmUgREZIX1JFVklTSU9OCQlHRU5NQVNLX1VMTCgxNSwg
MTIpCS8qIEZlYXR1cmUgcmV2aXNpb24gKi8NCj4gLSNkZWZpbmUgREZIX05FWFRfSERSX09GU1QJ
R0VOTUFTS19VTEwoMzksIDE2KQkvKiBPZmZzZXQgdG8gbmV4dCBERkgNCj4gKi8NCj4gLSNkZWZp
bmUgREZIX0VPTAkJCUJJVF9VTEwoNDApCQkvKiBFbmQgb2YgbGlzdA0KPiAqLw0KPiAtI2RlZmlu
ZSBERkhfVFlQRQkJR0VOTUFTS19VTEwoNjMsIDYwKQkvKiBGZWF0dXJlIHR5cGUgKi8NCj4gLSNk
ZWZpbmUgREZIX1RZUEVfQUZVCQkxDQo+IC0jZGVmaW5lIERGSF9UWVBFX1BSSVZBVEUJMw0KPiAt
I2RlZmluZSBERkhfVFlQRV9GSVUJCTQNCj4gLQ0KPiAgLyogTmV4dCBBRlUgUmVnaXN0ZXIgQml0
ZmllbGQgKi8NCj4gICNkZWZpbmUgTkVYVF9BRlVfTkVYVF9ERkhfT0ZTVAlHRU5NQVNLX1VMTCgy
MywgMCkJLyogT2Zmc2V0IHRvDQo+IG5leHQgQUZVICovDQo+IA0KPiBAQCAtNDAzLDI3ICszNzgs
NiBAQCBzdHJ1Y3QgZGV2aWNlICpkZmxfZnBnYV9wZGF0YV90b19wYXJlbnQoc3RydWN0DQo+IGRm
bF9mZWF0dXJlX3BsYXRmb3JtX2RhdGEgKnBkYXRhKQ0KPiAgCXJldHVybiBwZGF0YS0+ZGV2LT5k
ZXYucGFyZW50LT5wYXJlbnQ7DQo+ICB9DQo+IA0KPiAtc3RhdGljIGlubGluZSBib29sIGRmbF9m
ZWF0dXJlX2lzX2ZtZSh2b2lkIF9faW9tZW0gKmJhc2UpDQo+IC17DQo+IC0JdTY0IHYgPSByZWFk
cShiYXNlICsgREZIKTsNCj4gLQ0KPiAtCXJldHVybiAoRklFTERfR0VUKERGSF9UWVBFLCB2KSA9
PSBERkhfVFlQRV9GSVUpICYmDQo+IC0JCShGSUVMRF9HRVQoREZIX0lELCB2KSA9PSBERkhfSURf
RklVX0ZNRSk7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBpbmxpbmUgYm9vbCBkZmxfZmVhdHVyZV9p
c19wb3J0KHZvaWQgX19pb21lbSAqYmFzZSkNCj4gLXsNCj4gLQl1NjQgdiA9IHJlYWRxKGJhc2Ug
KyBERkgpOw0KPiAtDQo+IC0JcmV0dXJuIChGSUVMRF9HRVQoREZIX1RZUEUsIHYpID09IERGSF9U
WVBFX0ZJVSkgJiYNCj4gLQkJKEZJRUxEX0dFVChERkhfSUQsIHYpID09IERGSF9JRF9GSVVfUE9S
VCk7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBpbmxpbmUgdTggZGZsX2ZlYXR1cmVfcmV2aXNpb24o
dm9pZCBfX2lvbWVtICpiYXNlKQ0KPiAtew0KPiAtCXJldHVybiAodTgpRklFTERfR0VUKERGSF9S
RVZJU0lPTiwgcmVhZHEoYmFzZSArIERGSCkpOw0KPiAtfQ0KPiAtDQo+ICAvKioNCj4gICAqIHN0
cnVjdCBkZmxfZnBnYV9lbnVtX2luZm8gLSBERkwgRlBHQSBlbnVtZXJhdGlvbiBpbmZvcm1hdGlv
bg0KPiAgICoNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZGZsLmggYi9pbmNsdWRlL2xp
bnV4L2RmbC5oDQo+IGluZGV4IDZjYzEwOTgyMzUxYS4uMWNkODZiMmU3Y2IxIDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L2RmbC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvZGZsLmgNCj4g
QEAgLTgsNyArOCw5IEBADQo+ICAjaWZuZGVmIF9fTElOVVhfREZMX0gNCj4gICNkZWZpbmUgX19M
SU5VWF9ERkxfSA0KPiANCj4gKyNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L2RldmljZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvbW9kX2RldmljZXRhYmxlLmg+DQo+IA0KPiAgLyoqDQo+IEBAIC04Myw0ICs4NSw1
NCBAQCB2b2lkIGRmbF9kcml2ZXJfdW5yZWdpc3RlcihzdHJ1Y3QgZGZsX2RyaXZlciAqZGZsX2Ry
dik7DQo+ICAJbW9kdWxlX2RyaXZlcihfX2RmbF9kcml2ZXIsIGRmbF9kcml2ZXJfcmVnaXN0ZXIs
IFwNCj4gIAkJICAgICAgZGZsX2RyaXZlcl91bnJlZ2lzdGVyKQ0KPiANCj4gKy8qDQo+ICsgKiBE
ZXZpY2UgRmVhdHVyZSBIZWFkZXIgUmVnaXN0ZXIgU2V0DQo+ICsgKg0KPiArICogRm9yIEZJVXMs
IHRoZXkgYWxsIGhhdmUgREZIICsgR1VJRCArIE5FWFRfQUZVIGFzIGNvbW1vbiBoZWFkZXIgcmVn
aXN0ZXJzLg0KPiArICogRm9yIEFGVXMsIHRoZXkgaGF2ZSBERkggKyBHVUlEIGFzIGNvbW1vbiBo
ZWFkZXIgcmVnaXN0ZXJzLg0KPiArICogRm9yIHByaXZhdGUgZmVhdHVyZXMsIHRoZXkgb25seSBo
YXZlIERGSCByZWdpc3RlciBhcyBjb21tb24gaGVhZGVyLg0KPiArICovDQo+ICsjZGVmaW5lIERG
SCAgICAgICAgICAgICAgICAgICAgIDB4MA0KPiArI2RlZmluZSBHVUlEX0wgICAgICAgICAgICAg
ICAgICAweDgNCj4gKyNkZWZpbmUgR1VJRF9IICAgICAgICAgICAgICAgICAgMHgxMA0KPiArI2Rl
ZmluZSBORVhUX0FGVSAgICAgICAgICAgICAgICAweDE4DQo+ICsNCj4gKyNkZWZpbmUgREZIX1NJ
WkUgICAgICAgICAgICAgICAgMHg4DQo+ICsNCj4gKy8qIERldmljZSBGZWF0dXJlIEhlYWRlciBS
ZWdpc3RlciBCaXRmaWVsZCAqLw0KPiArI2RlZmluZSBERkhfSUQgICAgICAgICAgICAgICAgICBH
RU5NQVNLX1VMTCgxMSwgMCkgICAgICAvKiBGZWF0dXJlIElEICovDQo+ICsjZGVmaW5lIERGSF9J
RF9GSVVfRk1FICAgICAgICAgIDANCj4gKyNkZWZpbmUgREZIX0lEX0ZJVV9QT1JUICAgICAgICAg
MQ0KPiArI2RlZmluZSBERkhfUkVWSVNJT04gICAgICAgICAgICBHRU5NQVNLX1VMTCgxNSwgMTIp
DQo+ICsjZGVmaW5lIERGSF9ORVhUX0hEUl9PRlNUICAgICAgIEdFTk1BU0tfVUxMKDM5LCAxNikg
ICAgIC8qIE9mZnNldCB0byBuZXh0DQo+IERGSCAqLw0KPiArI2RlZmluZSBERkhfRU9MICAgICAg
ICAgICAgICAgICBCSVRfVUxMKDQwKSAgICAgICAgICAgICAvKiBFbmQgb2YgbGlzdCAqLw0KPiAr
I2RlZmluZSBERkhfVFlQRSAgICAgICAgICAgICAgICBHRU5NQVNLX1VMTCg2MywgNjApICAgICAv
KiBGZWF0dXJlIHR5cGUgKi8NCj4gKyNkZWZpbmUgREZIX1RZUEVfQUZVICAgICAgICAgICAgMQ0K
PiArI2RlZmluZSBERkhfVFlQRV9QUklWQVRFICAgICAgICAzDQo+ICsjZGVmaW5lIERGSF9UWVBF
X0ZJVSAgICAgICAgICAgIDQNCj4gKw0KPiArLyogRnVuY3Rpb24gdG8gcmVhZCBmcm9tIERGSCBh
bmQgY2hlY2sgaWYgdGhlIEZlYXR1cmUgdHlwZSBpcyBGTUUgKi8NCj4gK3N0YXRpYyBpbmxpbmUg
Ym9vbCBkZmxfZmVhdHVyZV9pc19mbWUodm9pZCBfX2lvbWVtICpiYXNlKQ0KPiArew0KPiArCXU2
NCB2ID0gcmVhZHEoYmFzZSArIERGSCk7DQo+ICsNCj4gKwlyZXR1cm4gKEZJRUxEX0dFVChERkhf
VFlQRSwgdikgPT0gREZIX1RZUEVfRklVKSAmJg0KPiArCQkoRklFTERfR0VUKERGSF9JRCwgdikg
PT0gREZIX0lEX0ZJVV9GTUUpOw0KPiArfQ0KPiArDQo+ICsvKiBGdW5jdGlvbiB0byByZWFkIGZy
b20gREZIIGFuZCBjaGVjayBpZiB0aGUgRmVhdHVyZSB0eXBlIGlzIHBvcnQqLw0KPiArc3RhdGlj
IGlubGluZSBib29sIGRmbF9mZWF0dXJlX2lzX3BvcnQodm9pZCBfX2lvbWVtICpiYXNlKQ0KPiAr
ew0KPiArCXU2NCB2ID0gcmVhZHEoYmFzZSArIERGSCk7DQo+ICsNCj4gKwlyZXR1cm4gKEZJRUxE
X0dFVChERkhfVFlQRSwgdikgPT0gREZIX1RZUEVfRklVKSAmJg0KPiArCQkgKEZJRUxEX0dFVChE
RkhfSUQsIHYpID09IERGSF9JRF9GSVVfUE9SVCk7DQo+ICt9DQo+ICsNCj4gKy8qIEZ1bmN0aW9u
IHRvIHJlYWQgZmVhdHVyZSByZXZpc2lvbiBmcm9tIERGSCAqLw0KPiArc3RhdGljIGlubGluZSB1
OCBkZmxfZmVhdHVyZV9yZXZpc2lvbih2b2lkIF9faW9tZW0gKmJhc2UpDQo+ICt7DQo+ICsJcmV0
dXJuICh1OClGSUVMRF9HRVQoREZIX1JFVklTSU9OLCByZWFkcShiYXNlICsgREZIKSk7DQo+ICt9
DQo+ICsNCj4gICNlbmRpZiAvKiBfX0xJTlVYX0RGTF9IICovDQo+IC0tDQo+IDIuMzEuMA0KDQo=
