Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1701A4BB423
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Feb 2022 09:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiBRIZQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Feb 2022 03:25:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiBRIZP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 18 Feb 2022 03:25:15 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D514D211D40;
        Fri, 18 Feb 2022 00:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645172699; x=1676708699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=52RczYCp+zxOACHMN5t/JZrRwbUuRzLaCebWR9/EIkk=;
  b=AdH3HmFEOOdmqjuBPlMpGnhkRSkOIAd7UUOrAAW2wmIA5i7qf+uYeDSi
   LANFdr/+Q9LXoMfG4NhJatHXWY6MhWzIz8tUoJk4M/DJDgCrjN4wRXpub
   4VGvh8evpp2Z3D1YnpUSktbj8jASzDF/X+nljv5Y0WQgiVoWcY2O0ZiGO
   RR+riOidFybmG0/ef3J1X7qcihndtirUBXVoKMp4SseBjTvUJ2OJST6OS
   iCvu9HTYWMIU7LNSIncfVUBYapFVaBrzLwee6sq2ufm+CsjYSUUfC/xnn
   ISCUqy5JX6f2/26kGDA4z1jlBEogreg42WSxDfcLO+Wl/csbdUpRGaQ60
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231716875"
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="231716875"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 00:24:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="635623577"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 18 Feb 2022 00:24:59 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 00:24:59 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 00:24:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 18 Feb 2022 00:24:58 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 18 Feb 2022 00:24:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYm1GYg95OPwnIcAbBLM8raKGuOrrd+Omxm6zRX5aUDcRfNUiC9++mjxqfGNr0gHVGNm26hdeVcvHKfRheSwMahxQL/owYz+OrR/mU/ks6Q+2rjAOIwG4+BXtzvocGf+ur++umucnKleL/B6zeQel06+DZLmFpgUotbntAQ6Fw8djWtGDsAx4lMJEf2zxbVmqEGpkBn3ygTyG6B3gd0IPBBITDDT+qrn06xdbJEWgq8O/IDbEczBXsxp4JuRo3/aXMNmEEKY3n0pK8jXegnB7f1IQMds5eWYfKneu4SLiFHTTU17anAdm8B3lzXzlxFgViDHJS7R5ExhoSXAbMHs8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52RczYCp+zxOACHMN5t/JZrRwbUuRzLaCebWR9/EIkk=;
 b=D2Joo4+517lepHxpfOZK0FqIXXIntXV0GNsCYzML2Wo9DA9JTozugQFMrEku2lS6qMxsBl8T3f8JyutcR7gVfK9hK+Zp0xmaSdHKBZ9pa69zVTOM9yTh3SmbBx/FX94VzDmdjhvKej9RkO0QvJ2gtXNJLvln8/55pGAJL/bVfpvdISUuM/v9t1RHwpjyOp1mOv4as3swI3HB5dYj2GyeJfkzZBP91XzrywfrSY5Ug926RliGe3cVAzEPGAdMla0SSXfH0v5F+r5a3Xzh3OdBNHPC5IBV9Q2RAIv2uialBVqVUcuvORaLhXppTwK/XTWFBIvAHknWGOb9o1EQpBX59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BYAPR11MB3573.namprd11.prod.outlook.com (2603:10b6:a03:fe::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Fri, 18 Feb
 2022 08:24:50 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.4995.017; Fri, 18 Feb 2022
 08:24:50 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     Tom Rix <trix@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1 5/7] drivers: fpga: dfl: handle empty port list
Thread-Topic: [PATCH v1 5/7] drivers: fpga: dfl: handle empty port list
Thread-Index: AQHYIZYuPtjFpaLABUu1Aozsump7nKyUxdiAgAQ3A6A=
Date:   Fri, 18 Feb 2022 08:24:50 +0000
Message-ID: <BN9PR11MB5483DE5B3268E74B0C439CD8E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-6-tianfei.zhang@intel.com>
 <6fae1b06-f275-fc11-8a3f-92fd7c666396@redhat.com>
In-Reply-To: <6fae1b06-f275-fc11-8a3f-92fd7c666396@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9de9b92-6889-408e-6628-08d9f2b821f7
x-ms-traffictypediagnostic: BYAPR11MB3573:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB3573C029F637353E3FB793CAE3379@BYAPR11MB3573.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MsbpumolVf/ugXSQLY4TSNMsBS/qj0DFbqMCuFbH1NkFFc3FJ62FKNbRGMYaHxC5e1g606jVpxQjuhBKlVtoARIuNSNZuEqr1gqhBsgu9hUnn61sd0mqF6A2fOpcY4NIUfxRA9IGi2zOASdCcqFxIEfMFsvMlT211ZoUGFUlHa9ariH1HPTsdCHlT+aXztSajvHghpD9BEzDLEVTDkMQD78S63yRKbRp0ZIGPevCYzGVqBefvlFI3iDqnKhsbPWuGoSiUT1s8Kl8ujaxxybaWDFg0laWMJDU+KMqeB1OgQImhRXCLUSXGvyjVVOcjEyX8eAfBBPmRbXAqCxnNdk7uIkg6lMm8sNW/ZD5OnOo+yLoHE3pi1Vjdp1gtkoJJosJuHc/OtoT1KC9mkPBXA4c79CqlaIl/1szEnfINE8VvFpDTq3hbyRQiVn0Plr+sOPBAoepM4Husb/RDzFBbOrgZGpy6M06vuF1FnmXFecOYjPbWNqKEZSfBfbP3qPfBiMj2NGKZez9no7EZvmAiTbOWBqsQbYzmmF7GxQ/nbjlIsp1jdd/3DZKlSlnaGAK0LQGpX6wTQyWgk3r2gacV4cOfCz1HlzmQrXwsT8yBV4zNAsuhxJp5JwJOGYqfQ2CBPDwqvPY+4R7W4fpJHC1Jl/kI4jlYRnXo716JmFJazJ3NMWWbNbRxcEJ2/kQoq1/kwviLtyZGikW2Ipo9PvCS4Plig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(33656002)(82960400001)(26005)(110136005)(186003)(83380400001)(66556008)(508600001)(66446008)(66476007)(71200400001)(38070700005)(64756008)(76116006)(38100700002)(122000001)(66946007)(55016003)(7696005)(9686003)(6506007)(8676002)(53546011)(4326008)(52536014)(316002)(8936002)(5660300002)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2E0NFFFdE9tZU5LZ1hWazYxK0x3YU43V3FrREFLc0szejNKOXU4WlVLNTVj?=
 =?utf-8?B?WWpDNWo4UU11aUhCV3huWlgyTFlpQjUzRGFpVzdEVXFxVlNNcFVyTWYxZDl4?=
 =?utf-8?B?cytVSmJESGRjRWUzazZNTW9JYnJYZzRydVRVaW1OVGlKV1R2R2lpQ2l1dDB3?=
 =?utf-8?B?bUFyUm5kci80cUZVU2kxUmIzYXdNMUVIN3hUTkJlMzkybGVKYzZiMm9rZTkw?=
 =?utf-8?B?QjJVVDJIQjRFczZnbWFUampHUE1CWmR2S211cjhhNXlLTHFjckVDN3Y1d3g1?=
 =?utf-8?B?N2JjN3ArTm4zaFVrTE9uWVNsRFRzdHY1cTQ1YWp3NkdEU29RcTU3QU8yREo4?=
 =?utf-8?B?akVONW1aVTRFajdXbXdnaC82OEhpalVHYnhUZ09HN0FSRkNVMHM3Z284YmFN?=
 =?utf-8?B?QjdCaWkrZlBmMmhkTE1nd3RqKys4anVZRW5RWlh4cHdHOGlTTXpEVE5US0lR?=
 =?utf-8?B?RUlzS0RsY1RFQnVHaHVVdndxRjlSMmlVdlVsSVVRYjdlVVE4VDJqZmt3OGxZ?=
 =?utf-8?B?UDNiS3hoaEhHTElUMjRvTHNPTVpQa3Z4TXBtOXVSb2w0RVBJL3EvNEkzRnAw?=
 =?utf-8?B?d3F4YUFybVJab2hNYS9FRzZzSTdaaXU5cG5aOFIwQWlYUDhaVERHSWR2VWFY?=
 =?utf-8?B?WEl5UEs0VXVkd3NyMm9JVUZCVURZZFRORjlYVGpJeDlOWmVLczBHSStTVzVs?=
 =?utf-8?B?QlNwa3pXR2pPb0ZDU0NRNnp6a05zV212YXNZRkdYRyswQWNKY0lzdGdEYnVE?=
 =?utf-8?B?cXgvZzNGS2Q1bUlOZFg2RytoYmVqbDdHaHQ1bmlUeTVYeWlVWXUzTDJia0VD?=
 =?utf-8?B?NEl2clVsUTgrczJ2Y2Z5RkNXdVZUUWU1eGFmTkZvRmZ4Sm1jRFMyclBmK1R6?=
 =?utf-8?B?dEJ4UW9LK1NaMWlqSGdRZE5CR1ZKbCtIeFZsc0FWVFpaVzQ4OW42WEtzdDlB?=
 =?utf-8?B?TktNZnNDVzhpSW9VazhHcnZiRWNycDFmeTUzTDBGOTRCaS9oczRZTUI5bDZj?=
 =?utf-8?B?NXppcFlxYjU4NmpKVVhYUmZhWXVlQWs3T2lWSVI3OGh2dmkrQnJmZXFSbGRT?=
 =?utf-8?B?WkJENVJDeHNHTk9na29ra1Q0MGx5TVI3V3hIWFdxbkJKR09UR09ZUkl3QmxG?=
 =?utf-8?B?eVJNYmxVMytqc3c3RUNrS2NTY1pzS2F1RTFIY28wRlNIZEVLSEFTU0w5Z0xO?=
 =?utf-8?B?RldzMWJ2cWRQTHdvQzB2cGRwZER5dDA4YnhpVFRVdnFUOVFpSmRiaFpHLy9E?=
 =?utf-8?B?QXZVWGgxVHBTRlVHMXZRdzFSNmFUQXdaY2lseFlnR20vRE1rQ2Q4eUxBaG8x?=
 =?utf-8?B?bnVlYWI3M1dORjdnWi9nUFVVelRZTDl4Ujl1WHpHajNybmJjNDJJblNWYWJu?=
 =?utf-8?B?V0tGZ0R3VjBVbXE0aGFrd1Z1WmxwRllwcm9KQUhMbTFKdVdlMGF6d2d3ek1r?=
 =?utf-8?B?ZVVobml4SkltTERuSXUwUjNEdnNzdXNYeWRXdWNGWDhNM1R0TmM4cDFhR3ow?=
 =?utf-8?B?eGx4dUVjOVdPYVpLNGVKajlpNjk5THh5ZUNXVzQvUEFrTUwvb3pBNXEzRmVK?=
 =?utf-8?B?VGRobFduTkxpNEwyeklseE9xZEprMTFTYVpINmszcWJuMXVVeDdQWkV4MEJZ?=
 =?utf-8?B?NFFiM0EwcHR1M21LZzhyMWdnNHYwcUdkQ3JUZjgyTGNJQ3RnNXVKMFFmdktC?=
 =?utf-8?B?S1pSaUVKWGFGL2dhbmhFdlE4MlQ5TXMreXhJL0l1OWZPS2E1KzBzeFc0eXdo?=
 =?utf-8?B?U243S2J4NUw0S3ZRU0FvNkNza0VZSDljM3dYdVRCWGVqWDg5RkkrT2t6OUpp?=
 =?utf-8?B?WGY4T09JaEd5OWpQYzFOS2hmM05WNS9nemtrWE1zUHZKOXZxK1h6a0xEYTl6?=
 =?utf-8?B?ZGEyWTMyZGFhV1IxMzBCT3ZBemRjUDdxUUxJdGUyVzdCOUJqWkd2RFBWYkNL?=
 =?utf-8?B?d0FKUmVtdTdxajhjQno1K3U0Uk5Ec2hpM3VhYURGS2xCbm1Ubkc2QUhZYjZr?=
 =?utf-8?B?ai9EOGw3SkN1VDNBV0NuVDFIdWRZS3dyOU1GQlNFUFoyRVZ5WURJMGxCdkI5?=
 =?utf-8?B?ZkdwVDI2ekd4dXlXRmdmamtVTzlWdUpMSE8xTHBoandranFLWEQrb0RTNlo3?=
 =?utf-8?B?MEc1SGRMTnV0djBCSDAzcFFEV1Y5Q0IvUmJ3b29WM21vMmZwSUVJUUJlbW55?=
 =?utf-8?Q?QQQEdXkuU54Hil7LWOGh2gg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9de9b92-6889-408e-6628-08d9f2b821f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 08:24:50.6308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5p0V4Fj+/gGJo+u67XEPIj2hcWIFL5S1KGrClQc2BPLliprBT+Qo21Wh2JyWZAoiQzOLi3XO9jDUtuvayb+Bzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9tIFJpeCA8dHJpeEBy
ZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxNSwgMjAyMiAxMTo1NiBQTQ0K
PiBUbzogWmhhbmcsIFRpYW5mZWkgPHRpYW5mZWkuemhhbmdAaW50ZWwuY29tPjsgV3UsIEhhbyA8
aGFvLnd1QGludGVsLmNvbT47DQo+IG1kZkBrZXJuZWwub3JnOyBYdSwgWWlsdW4gPHlpbHVuLnh1
QGludGVsLmNvbT47IGxpbnV4LWZwZ2FAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1kb2NAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBjb3JiZXRA
bHduLm5ldDsgTWF0dGhldyBHZXJsYWNoIDxtYXR0aGV3LmdlcmxhY2hAbGludXguaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDUvN10gZHJpdmVyczogZnBnYTogZGZsOiBoYW5k
bGUgZW1wdHkgcG9ydCBsaXN0DQo+IA0KPiANCj4gT24gMi8xNC8yMiAzOjI2IEFNLCBUaWFuZmVp
IHpoYW5nIHdyb3RlOg0KPiA+IEZyb206IE1hdHRoZXcgR2VybGFjaCA8bWF0dGhldy5nZXJsYWNo
QGxpbnV4LmludGVsLmNvbT4NCj4gPg0KPiA+IE5vdCBhbGwgRlBHQSBkZXNpZ25zIG1hbmFnZWQg
YnkgdGhlIERGTCBkcml2ZXIgaGF2ZSBhIHBvcnQuDQo+ID4gSW4gdGhlc2UgY2FzZXMsIGRvbid0
IHdyaXRlIHRoZSBQb3J0IEFjY2VzcyBDb250cm9sIHJlZ2lzdGVyIHdoZW4NCj4gPiBlbmFibGlu
ZyBTUklPVi4NCj4gDQo+IERyb3AgdGhlICdkcml2ZXJzOicgaW4gdGhlIHN1YmplY3QgbGluZS4N
Cg0KWWVzLCBJIGFncmVlLg0KDQo+IA0KPiBUaGlzIHBhdGNoIGxpa2VseSBuZWVkcyB0byBtb3Zl
ZCB0byA0Lzcgc2luY2UgdGhlIGxhc3QgcGF0Y2ggYWxzbyBpdGVyYXRlZCBvdmVyDQo+IHRoZSBs
aXN0Lg0KDQpZZXMsICBJIGFncmVlLCBJIHdpbGwgbW92ZSBpdCBvbiBuZXh0IHZlcnNpb24gcGF0
Y2guDQoNCj4gDQo+IFRvbQ0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hdHRoZXcgR2Vy
bGFjaCA8bWF0dGhldy5nZXJsYWNoQGxpbnV4LmludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBUaWFuZmVpIFpoYW5nIDx0aWFuZmVpLnpoYW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IGRyaXZlcnMvZnBnYS9kZmwuYyB8IDIgKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ZwZ2EvZGZsLmMgYi9kcml2
ZXJzL2ZwZ2EvZGZsLmMgaW5kZXgNCj4gPiBjZmM1MzlhNjU2ZjAuLmE1MjYzYWMyNThjNSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2ZwZ2EvZGZsLmMNCj4gPiArKysgYi9kcml2ZXJzL2ZwZ2Ev
ZGZsLmMNCj4gPiBAQCAtMTcwOCw2ICsxNzA4LDggQEAgaW50IGRmbF9mcGdhX2NkZXZfY29uZmln
X3BvcnRzX3ZmKHN0cnVjdA0KPiBkZmxfZnBnYV9jZGV2ICpjZGV2LCBpbnQgbnVtX3ZmcykNCj4g
PiAgIAlpbnQgcmV0ID0gMCwgcG9ydF9jb3VudCA9IDA7DQo+ID4NCj4gPiAgIAltdXRleF9sb2Nr
KCZjZGV2LT5sb2NrKTsNCj4gPiArCWlmIChsaXN0X2VtcHR5KCZjZGV2LT5wb3J0X2Rldl9saXN0
KSkNCj4gPiArCQlnb3RvIGRvbmU7DQo+ID4NCj4gPiAgIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KHBk
YXRhLCAmY2Rldi0+cG9ydF9kZXZfbGlzdCwgbm9kZSkgew0KPiA+ICAgCQlpZiAocGRhdGEtPmRl
dikNCg0K
