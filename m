Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546644DBBE1
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Mar 2022 01:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiCQAnB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Mar 2022 20:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354876AbiCQAm5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Mar 2022 20:42:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B8D12AEB
        for <linux-fpga@vger.kernel.org>; Wed, 16 Mar 2022 17:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647477702; x=1679013702;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=byvhzzcrI5/doMvlvpYxl7mN58wzQ6DrHPx/7FxokFI=;
  b=bbC7Yns5OJFdIWpbQCk0wAKpXm5PAehdxfRTrkrzJAysxiyFQzGmaJwJ
   TGIOCWLbyn6DX2rIJCRt+PDKcZ+rPQ+txDcIFlbmZ5oehNwF7tjLedbxw
   kqk8kmWlItvbVbsuNRdGYx1kSQvwOBU2Ra7OyYU66mqO4a1oP245ya1rl
   mGAFj8mQMb8x7DGh0s6d8H95hKK56EHygLPosXQWePmMivU2tgh6wXew+
   kWJb3CNKACKiOlquyvjFGuMuEjkV/txcHg5+ZDpJukiPvR2OL1rCIUTpL
   dbpE1WAIVyDCbhm1uwcmrZcIZupxKx5hU5JDfRKPdS+f+qzBgcFT32Fiw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="255579147"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="255579147"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:41:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="635187646"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2022 17:41:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 17:41:41 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 17:41:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 17:41:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 17:41:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEaIsYuOpSrQ2AwW8eP541UBwrZ30k/k25HWipqs0+kb0s6bY7uFCVIOmUZCnddM8aNtl5mKR79Qsz44ipoRcYMunY2/v+lF8C/cmqPjAPr7AAWpasxf83BApxjs1niTFJUbFZZmRZhzw/d47O3Pb4uTCZaRf2LSVsSvo1q9owC0Vh7KkpGqGWqLaKmXDGOpHDt/gJyqyOpvVQcRTK0EeEqRYGsYfl27qqWtIsppBj3UL5JkqzghSQcGz+vg9s+OJye6G1gPn2iK1UMEMmXEgG/x14QtiTGmWHMZR/Xbdyhyquc8J63XZGQ+8IZzYuo4h5gSmR2jEwzXL2X00htBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byvhzzcrI5/doMvlvpYxl7mN58wzQ6DrHPx/7FxokFI=;
 b=GuOxJdbYjA80PWJy8sdX5THibm/dr8asl94QUTSrAdjNS8T+LGjUCOyRKd4j9MP+cIdI1Op4zAIAoYqzVluCbQ3tLNLrgmZgrWn9/aeRsQ2DUzn3oKopn+8715TWv7THYkbvKs1Tv5gR0NXj2VSHY7Y8B2Pq34Nt0CfaNn9LLIUQbaHlJGNzq2kgZpWPuIA3LhlLSzkSe5CtthgiHc3plVbFFxijKIq1RjsueM5TOX8OxrutERVhEsapRY6Fy3jNOknGledJ/m3cuvdkvAPCAZ4oXU2QNg7c0RYOAv0doilMKPzcB37Isn0YUuKC0uSgdPcA+2AyxEBujEHhPTV5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3816.namprd11.prod.outlook.com (2603:10b6:a03:f8::32)
 by MN2PR11MB4015.namprd11.prod.outlook.com (2603:10b6:208:154::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 00:41:35 +0000
Received: from BYAPR11MB3816.namprd11.prod.outlook.com
 ([fe80::b03a:2ea1:4a3d:1e55]) by BYAPR11MB3816.namprd11.prod.outlook.com
 ([fe80::b03a:2ea1:4a3d:1e55%4]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 00:41:34 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Xu, Yilun" <yilun.xu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1] uio: dfl: add HSSI feature id
Thread-Topic: [PATCH v1] uio: dfl: add HSSI feature id
Thread-Index: AQHYNLWszaqWHWDC/E+0/e+KE1p1U6y5ZyLggABOFgCABIET0IAAcMGAgAGJxtCAABGsAIACgu1A
Date:   Thu, 17 Mar 2022 00:41:34 +0000
Message-ID: <BYAPR11MB38167BB8881D050DE53DDE6685129@BYAPR11MB3816.namprd11.prod.outlook.com>
References: <20220308064315.1452217-1-tianfei.zhang@intel.com>
 <03814133-4bb5-f8df-ed2a-fa94720c3075@intel.com>
 <DM6PR11MB3819A43505B9986593143C21850C9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BN9PR11MB5483722F9156F6EBA53126B4E30C9@BN9PR11MB5483.namprd11.prod.outlook.com>
 <DM6PR11MB3819715B8A7DF03DDD19F7E9850F9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BN9PR11MB5483A25DF3AEF87F83AA4A9DE30F9@BN9PR11MB5483.namprd11.prod.outlook.com>
 <DM6PR11MB3819F9A80C12E0253ED1594B85109@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BL1PR11MB54772E1517EEE39B1091836EE3109@BL1PR11MB5477.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB54772E1517EEE39B1091836EE3109@BL1PR11MB5477.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 003b1304-99b3-4507-ff10-08da07aee38a
x-ms-traffictypediagnostic: MN2PR11MB4015:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB4015CF11312EF83D116D8ADC85129@MN2PR11MB4015.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7WX5W6+9LcN5gCoOGs4Ziu6y6A6sFYcd9ghQPqa30u787JIZ7gnYoq3gpIKLAGH6sfJhBH8WR+JQT9E9Whoypag1HYgDRQxf4fqhASMlYf/fT0xRTx27A+zPNPzGRStLl6E7eB9DPWVTRsDp0zBbzgUYIYo5FHNYRyTD/BSLcxJda4jVUM1AnVpi8bgvGDy7JYvgUOWMOCuAKSPmoJFjgHJkn2Weiii58AqCn9IeM0cGgzrAYewjNSBrhaU/YCeTn+z12I9d66GC5Nc7yXfoTmtIBkllSvBnVvBBsDnVCPerOLvQLbsER8bKXjtX7dQw7yVFDcPU39e3TdwyBMExZNuiD1xsVkGXLjcmEflkXaT6NEtcDz4E+Eqt+4JOceP04LiZMiDRjwquxvhu0Olmz4o9FDheivmpdFWv1kXnH1SLpnpsoSdEnV46M/Lg8brEDIVIVuhRpeiomaPCCs61iVcun2+1IY3hI2oBn2xaefP5xikD/JawIkx185DDjTkPyewHf4JXMc7HY5TG+ojIDm8yAdLtrV2UVgf5LlSqZtBeJNa2piaone8uHrsO1h4hInnCC24fQpIoQJJ3iql3NM/AWuhWoprfZsM0LWra+cztJFdF4gY9EnO0UBCOfvM+RAWZJKRtQAmAcKTgvmgtH8JiGQl5lN+pX4fPKsDK21cfkyCF/dGk2qZeimDIkOnWrs68LzysmvxI8Xn+EiOfvAj9bz0RVXm/KjoB+ghdTCIyuAXn+I4lDkD15dvrkSItFQtFmfZugyVwUm8iDrTRn2pW/KnygpovNz+nYfiMzo5DQDoFhrUfczmfGtfdulwuFZvr3lI9DN0pu+QQ4UvGFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3816.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(83380400001)(6506007)(53546011)(7696005)(33656002)(9686003)(508600001)(5660300002)(71200400001)(122000001)(55016003)(2906002)(86362001)(82960400001)(966005)(110136005)(54906003)(38100700002)(8936002)(316002)(38070700005)(66556008)(76116006)(66946007)(64756008)(4326008)(66446008)(66476007)(52536014)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDUvNEtCMkRVaUxmUnJwRVNkVlhPSjBQYWh0RUQyNGxlRjdlRGJnK1NqYURE?=
 =?utf-8?B?WUgvUFBOMVRmd0lGdUpxT0tKTUFONW1iM1dkS1dNdTBHdVIyM0diaHhNeFA1?=
 =?utf-8?B?MEdTM21lZSszd21uM25XN3pCVVpuV2NyNHJNTU9vc05OalVTbHo5eUowTi9v?=
 =?utf-8?B?WDl1VmFES2cwY294WDc1ejR6RVBqNXp1MFliSml0d012ejR6MitjNTU2UnFK?=
 =?utf-8?B?WVpXeG5QSkJXeDN1NU02ZUxlZkpUeGtWTmljSW0xVlNzQ0kycWY4d3lINExn?=
 =?utf-8?B?UUJ4SHN1b2ZHcSsvcFJXK3ViQ2ZlUVQ5dHRXN1RYWDlCbVpmajVUUldvditV?=
 =?utf-8?B?K2NCNktkM0xTR1Q4Njg5RzhFWXlKMXBNYTYxN3FJdmR5WGwwZGxDd2pCUCsr?=
 =?utf-8?B?QjBPZElpTFpiWENFZDBMaVFKdThZbEhHdHFST29QemphU3NsRXlRbVJKbmlr?=
 =?utf-8?B?VndCSHZXNmxLQ0ZmWmorREN4K1FVM1doRnQ4SVI3bUttQ2NMWlNSN3RReUVB?=
 =?utf-8?B?SVdvZUN2NDc0RXZxQkx0S1BLSzhGWUh0OFIybXpqUXhma3RuVW9xZEpOSmYw?=
 =?utf-8?B?bWNyT2l0Z0d0d1F0OVAvaUdaMTFHNmRlZjBCQWNUYnRYS2x3WUpQWWxTWE1V?=
 =?utf-8?B?OHpZNWNtUTlKTDdVQW1uWnRCY294azVnV3dudnlraU92QUNVS0RBV3BFcG42?=
 =?utf-8?B?Z0F0djgvNW9MOXRDS1FmOEZUaVZ5bVBFUlNHVGNvTVBwWlk3VzB5ekV5dmpU?=
 =?utf-8?B?OTNNYWdyYktRMk1MWjZRbHlBYUtKa09uRWptcHhkWGRKNW50WmtpSWtrcnZL?=
 =?utf-8?B?dVVMWXpSZ0NrQ1RsODFxYUlRbjdjME9NMW9vamJTN0VjK1A1QlExU0ltU2Rk?=
 =?utf-8?B?eENKU0NaVDhsSEdHcWdCQlNxa0JNMHJVR0s2UTVaaG5KRnc3Nis0dXNNTlVx?=
 =?utf-8?B?Y0lvQm92ZU1jaFlVems3UTRSaE9wdFAvU3F0aHBITGduQllFU01vV2h0Vktl?=
 =?utf-8?B?VDVvSkZEbkkwaU9mQkkyeTBvUUdkemVnNkxwV3BhOHV0MVh1djlWcXB5L2tq?=
 =?utf-8?B?NWZ1dTRmZUU4ZmplcFlFSmdZSktIUkhFOVRWM1J4N2Jhc3lldEFMcVY2bkRX?=
 =?utf-8?B?NW1zM0tzZXhnbnUyS0twMjNUUXNWakhuTG9kQWJIbHJBVk5DUVlIRWxIbW83?=
 =?utf-8?B?RzJHOHVSeW1jRGRlLzYwK0ZBSHZ2OUJQeUNzYW14S0hERGQxOEE1bTRPQ1dm?=
 =?utf-8?B?cytHMllodm5zZzhMMTM1eDE1QXVsaVQ5aTBKVHFyM3cweWduWEtjRmtzYTZR?=
 =?utf-8?B?M0hKZXF0dU1BcWsvWmp1K25Lbm95RWkvenZWU2VnOWY2OE5JcHJob0NYMjV3?=
 =?utf-8?B?ODE2eTBpR3Y2TGdhT3RBalI1Nit1Mnhacy9uS1E2NWxCVU1IQ0hWWk5XRUZO?=
 =?utf-8?B?RXR4MHZWaldWdTJ2SE54d0h3akhZV295ZFl0NUZET3RQSzFRNGhCRkVqdVIx?=
 =?utf-8?B?K0wvTW5KU1FMbktiVllUT3lzcWpsSFNITVdTSldCQ0tXMjFtOWRuY29IL2xz?=
 =?utf-8?B?bmtvbkhyRi9qZGY5UEY0UlNXckRBYjM4QnA2V1Z3bTdhc0gwbVlhdHlUaGpU?=
 =?utf-8?B?QWl4c0tzSFlSK2Y0bG4xWW9RWWhiajM0OWxXREV3dFM3WmNDTlM1WkNkZVQy?=
 =?utf-8?B?bmozelFzd0t4SXdhZklYUUJZRkxpdTZYSnZYT2ZKRkhxN3ptaHh3TW1teHYr?=
 =?utf-8?B?VnJrdXZNZFlKWEFUVG1BUHVEZTVTWVdaQ0tWQ255cUQ4b3hnYUNQT1NNWE9I?=
 =?utf-8?B?azhKNXlCVUVWY2Uzd1I4N21heW9KMFFEUHhPTlc5aFZZNWVjaVZOL0E0YWdX?=
 =?utf-8?B?MlVUdmp5T09HaVN6b2MrTmpmU056TWUzUmxkRmNOSmVYbUozMjRMNUcxMkJk?=
 =?utf-8?Q?kt9WewL2YOM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3816.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003b1304-99b3-4507-ff10-08da07aee38a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 00:41:34.8025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+kgoTS33I2fK39bieZXiwNJnpQHm3AqFYc1HVwgtR1UaQSMK/F3qwFc1ROSuLwq37HRATdtTXcoxMTM69bvcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogV3UsIEhhbyA8aGFvLnd1
QGludGVsLmNvbT4NCj4gPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAxNSwgMjAyMiA1OjMyIFBNDQo+
ID4gVG86IFpoYW5nLCBUaWFuZmVpIDx0aWFuZmVpLnpoYW5nQGludGVsLmNvbT47IFdlaWdodCwg
UnVzc2VsbCBIDQo+ID4gPHJ1c3NlbGwuaC53ZWlnaHRAaW50ZWwuY29tPjsgdHJpeEByZWRoYXQu
Y29tOyBtZGZAa2VybmVsLm9yZzsgbGludXgtDQo+ID4gZnBnYUB2Z2VyLmtlcm5lbC5vcmc7IGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnDQo+ID4gQ2M6IFh1LCBZaWx1biA8eWlsdW4ueHVAaW50
ZWwuY29tPjsgTWF0dGhldyBHZXJsYWNoDQo+ID4gPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRl
bC5jb20+DQo+ID4gU3ViamVjdDogUkU6IFtQQVRDSCB2MV0gdWlvOiBkZmw6IGFkZCBIU1NJIGZl
YXR1cmUgaWQNCj4gPg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
PiBGcm9tOiBXdSwgSGFvIDxoYW8ud3VAaW50ZWwuY29tPg0KPiA+ID4gPiBTZW50OiBNb25kYXks
IE1hcmNoIDE0LCAyMDIyIDExOjA5IEFNDQo+ID4gPiA+IFRvOiBaaGFuZywgVGlhbmZlaSA8dGlh
bmZlaS56aGFuZ0BpbnRlbC5jb20+OyBXZWlnaHQsIFJ1c3NlbGwgSA0KPiA+ID4gPiA8cnVzc2Vs
bC5oLndlaWdodEBpbnRlbC5jb20+OyB0cml4QHJlZGhhdC5jb207IG1kZkBrZXJuZWwub3JnOw0K
PiA+ID4gPiBsaW51eC0gZnBnYUB2Z2VyLmtlcm5lbC5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnDQo+ID4gPiA+IENjOiBYdSwgWWlsdW4gPHlpbHVuLnh1QGludGVsLmNvbT47IE1hdHRo
ZXcgR2VybGFjaA0KPiA+ID4gPiA8bWF0dGhldy5nZXJsYWNoQGxpbnV4LmludGVsLmNvbT4NCj4g
PiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSCB2MV0gdWlvOiBkZmw6IGFkZCBIU1NJIGZlYXR1cmUg
aWQNCj4gPiA+ID4NCj4gPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiA+ID4gPiBGcm9tOiBXdSwgSGFvIDxoYW8ud3VAaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4gU2Vu
dDogRnJpZGF5LCBNYXJjaCAxMSwgMjAyMiAxMDo0NyBBTQ0KPiA+ID4gPiA+ID4gVG86IFdlaWdo
dCwgUnVzc2VsbCBIIDxydXNzZWxsLmgud2VpZ2h0QGludGVsLmNvbT47IFpoYW5nLA0KPiA+ID4g
PiA+ID4gVGlhbmZlaSA8dGlhbmZlaS56aGFuZ0BpbnRlbC5jb20+OyB0cml4QHJlZGhhdC5jb207
DQo+ID4gPiA+ID4gPiBtZGZAa2VybmVsLm9yZzsgbGludXgtIGZwZ2FAdmdlci5rZXJuZWwub3Jn
Ow0KPiA+ID4gPiA+ID4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcNCj4gPiA+ID4gPiA+IENj
OiBYdSwgWWlsdW4gPHlpbHVuLnh1QGludGVsLmNvbT47IE1hdHRoZXcgR2VybGFjaA0KPiA+ID4g
PiA+ID4gPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+ID4gPiBTdWJq
ZWN0OiBSRTogW1BBVENIIHYxXSB1aW86IGRmbDogYWRkIEhTU0kgZmVhdHVyZSBpZA0KPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+ID4gT24gMy83LzIyIDIyOjQzLCBUaWFuZmVpIFpoYW5nIHdyb3Rl
Og0KPiA+ID4gPiA+ID4gPiA+IEZyb206IE1hdHRoZXcgR2VybGFjaCA8bWF0dGhldy5nZXJsYWNo
QGxpbnV4LmludGVsLmNvbT4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEFkZCB0
aGUgZmVhdHVyZSBpZCBvZiB0aGUgT0ZTIEhpZ2ggU3BlZWQgU2VyaWFsIEludGVyZmFjZQ0KPiA+
ID4gPiA+ID4gPiA+IHN1YnN5c3RlbSB0byB0YWJsZSBvZiBpZHMgc3VwcG9ydGVkIGJ5IHRoZSB1
aW9fZGZsIGRyaXZlci4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IE1hdHRoZXcgR2VybGFjaA0KPiA+ID4gPiA+ID4gPiA+IDxtYXR0aGV3LmdlcmxhY2hA
bGludXguaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFRpYW5mZWkg
WmhhbmcgPHRpYW5mZWkuemhhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiBSZXZpZXdlZC1ieTogUnVzcyBXZWlnaHQgPHJ1c3NlbGwuaC53ZWlnaHRAaW50ZWwuY29t
Pg0KPiA+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiA+ICBkcml2ZXJzL3Vpby91aW9f
ZGZsLmMgfCAyICsrDQo+ID4gPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Vpby91aW9fZGZsLmMgYi9kcml2ZXJzL3Vpby91aW9fZGZsLmMNCj4gPiA+ID4gPiA+ID4g
PiBpbmRleA0KPiA+ID4gPiA+ID4gPiA+IDg5YzBmYzdiMGNiYy4uNjYwZTFkMGJmNmI5IDEwMDY0
NA0KPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdWlvL3Vpb19kZmwuYw0KPiA+ID4gPiA+
ID4gPiA+ICsrKyBiL2RyaXZlcnMvdWlvL3Vpb19kZmwuYw0KPiA+ID4gPiA+ID4gPiA+IEBAIC00
NSw5ICs0NSwxMSBAQCBzdGF0aWMgaW50IHVpb19kZmxfcHJvYmUoc3RydWN0DQo+ID4gPiA+ID4g
PiA+ID4gZGZsX2RldmljZQ0KPiA+ID4gPiA+ID4gPiA+ICpkZGV2KSB9DQo+ID4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gPiAgI2RlZmluZSBGTUVfRkVBVFVSRV9JRF9FVEhfR1JPVVAJMHgx
MA0KPiA+ID4gPiA+ID4gPiA+ICsjZGVmaW5lIEZNRV9GRUFUVVJFX0lEX09GU19IU1NJCQkweDE1
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gV2hlcmUgaXMgdGhlICJPRlMiIGNvbWluZyBmcm9t
PyBpcyBpdCBmb3IgYWxsIE9GUyBkZXZpY2Ugb3IgYSBzcGVjaWZpYw0KPiA+IGNhcmQ/DQo+ID4g
PiA+ID4gPiBBbnl3YXksIGNvdWxkIHdlIGhhdmUgYSBtYXRjaGVkIG5hbWUgcGVyIHB1YmxpYyB0
YWJsZT8NCj4gPiA+ID4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9PUEFFL2xpbnV4LWRmbC1mZWF0
dXJlLWlkL2Jsb2IvbWFzdGVyL2RmbC1mZWENCj4gPiA+ID4gPiA+IHR1cmUNCj4gPiA+ID4gPiA+
IC1pZHMucnN0DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBZZXMsIEkgdGhpbmsgYSBtYXRjaGVkIG5h
bWUgb2YgcHVibGljIHRhYmxlIHdpbGwgYmUgYmV0dGVyLiBIb3cgYWJvdXQgdGhlDQo+ICINCj4g
PiA+ID4gPiBGTUVfRkVBVFVSRV9JRF9IU1NJIj8NCj4gPiA+ID4NCj4gPiA+ID4gTm8uIFdlIGFs
cmVhZHkgaGF2ZSB0aGUgc2FtZSBuYW1lIGZvciBpZCAweDYgZGVmaW5lZCBpbg0KPiBkcml2ZXJz
L2ZwZ2EvZGZsLmgNCj4gPiA+ID4gI2RlZmluZSBGTUVfRkVBVFVSRV9JRF9IU1NJCQkweDYNCj4g
PiA+DQo+ID4gPiBJcyBpdCBwb3NzaWJsZSBjaGFuZ2UgdGhlICJGTUVfRkVBVFVSRV9JRF9IU1NJ
IiB0byAiDQo+ID4gPiBGTUVfRkVBVFVSRV9JRF9MRUdBQ1lfSFNTSSIsIGFuZCB0aGUgbmV3IG9u
ZSBpcyAiDQo+ID4gPiBGTUVfRkVBVFVSRV9JRF9IU1NJIj8NCj4gPg0KPiA+IEkgYW0gbm90IHN1
cmUgd2hvIG93bnMgdGhlIElEIGFsbG9jYXRpb24gdGFibGUsIGFuZCB3aHkNCj4gPiAweDYgaXMg
Y2hhbmdlZCB0byAiTGVnYWN5IiBIU1NJIGJ1dCBJIGZlZWwgaXQncyBiZXR0ZXIgdG8gaGF2ZSBh
IHNwZWNpZmljIHByZWZpeA0KPiBmb3INCj4gPiB0aGlzIEhTU0kgaW5zdGVhZCwgSSBob3BlIHdl
IGRvbid0IGhhdmUgdG8gY2hhbmdlIHRoaXMgMHgxNSBIU1NJIHRvIGFub3RoZXINCj4gPiBsZWdh
Y3kgb25lIHdoZW4gc29tZW9uZSBhZGRzIGEgbmV3IEhTU0kuIFRoaXMgaXMgZm9yIEZQR0EsIGV2
ZXJ5Ym9keSBjb3VsZA0KPiA+IGltcGxlbWVudCBoaXMgb3duIEhTU0ksIGdlbmVyaWMgbmFtZSBz
aG91bGQgYmUgYXZvaWQgd2hlbiBwb3NzaWJsZSwgYW5kIGENCj4gPiBiZXR0ZXIgcnVsZSB3aGVu
IG1hbmFnaW5nIHRoZSBmZWF0dXJlIElEcy4NCj4gDQo+IFllcywgSSB0aGluayB0aGlzIEhTU0kg
d2FzIGRlc2lnbmVkIGZvciBPRlMsIHVzaW5nICJPRlMiIGFzIHByZWZpeCBpcyBiZXR0ZXIuDQoN
ClRoZW4gY2hhbmdlIHRoZSBuYW1lIGluIA0KaHR0cHM6Ly9naXRodWIuY29tL09QQUUvbGludXgt
ZGZsLWZlYXR1cmUtaWQvYmxvYi9tYXN0ZXIvZGZsLWZlYXR1cmUtaWRzLnJzdA0KYXMgd2VsbC4N
Cg0KSGFvDQoNCj4gDQo+ID4NCj4gPiA+DQoNCg==
