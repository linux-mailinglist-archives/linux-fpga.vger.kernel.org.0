Return-Path: <linux-fpga+bounces-947-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FE99D3103
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 00:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7E71F2349A
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Nov 2024 23:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1419E1D2F56;
	Tue, 19 Nov 2024 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnfdZoSd"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE601D2794;
	Tue, 19 Nov 2024 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059563; cv=fail; b=gRvTxhiHP/60dLFIPqNI60vvJPL6H0cMRRQCiHs/okDDIcxTrz20xVCOBzeUd+l6bQBPslpsdGCALfPahpLiHmhOtJcq73GgRKPbWmPtZw9kV5/Zd1DDeBV2k9dz8cqzHbQgfgftcYNFYpCXwCZWiTZER6ddXTqVGFxiZ92K+l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059563; c=relaxed/simple;
	bh=V9PRRBo+Fd/tU4snzn10PKswMSIAO4Zd1dENQuVbkWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=azYywBMOLv82mle9Lmn1cNrb+IpJUeHHWPu7H16SxZUCwYLHmIDNuB4MY0SL+goF3MwzAfUnB/sBaUNu1atsM0wVYMobZR8qIuo1lQ+dE+esiDgSgWGkW2R9MKseT27Nw6G9W9/v+qF+lh6l95Rog+4Qj+auhjsMdY4QsskVgPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnfdZoSd; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732059561; x=1763595561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V9PRRBo+Fd/tU4snzn10PKswMSIAO4Zd1dENQuVbkWM=;
  b=CnfdZoSdE+SwoUeHAjXogdgDLiSJxQqtdxZh65RACu0HSOI8GzPbQbVP
   hegIzYEzVpTJcfXLc09vORrShvoy50e1zcNN2z6Rcxzvk+ayKjSjDZtCC
   vU55e9jYasJV8YH0ZGQ09XZEbtA8PccUfx5zKOfMBFO3Ltpuqt9MYYhEq
   2gkcZqhxUdvXeVjnlfUmlf8sFhV38t+jsw8yTvxpZzDAWxu2Pln75h6u0
   cvc8S9PMygez7QG4f3RkTszdwqklLbnFg0gjVfRLEBiLajqUAsmG+cQU7
   4HPwmGuMPc2Jtp7XzFgX7nZnITzKwK8k5j6S+P8jvS9rd5H8bCp9Vt8kW
   A==;
X-CSE-ConnectionGUID: 4npxLvj6T++tzRNVLJxpQA==
X-CSE-MsgGUID: xyne9AiTR8Kh0hnVf9z6/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32199826"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="32199826"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 15:39:15 -0800
X-CSE-ConnectionGUID: hbtBrIENROmpSbhk+gaiHw==
X-CSE-MsgGUID: gXC0DD2jRRyDBRi8xEmKsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="113012152"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 15:39:15 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 15:39:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 15:39:15 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 15:39:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c69oYpTNCwJUDhKf/8aOyq9vsMzJJGquOzKph7CVYg6KB9fNdT+w4sZ6Q1cKJ3FY5ni/A7yixFks17ISDSlgIf7G2hx27fJ4lEzvP12XpDMBwmxK3ajYOHwT7JWUKyQIud6dbl3oYUxAe8QxBRbjA1xpWGg+SPvt4YgFlScLUdYLDyYI+Xgk8pMeGkawjyAvqi+8PwZhcsB8JVh8ypTAnJ5mR0PQTlBTXmLuLG5NDzd+Rv0LwakuXDz3FnSbK9FNaTlQZRzhlnoqAtprH6z2A6r9UrR+BYabBUnR8SFe3P9G0DPJ+FVTzmmh20QSwsWMKPTCwuGiudqOtFI5YjiCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9PRRBo+Fd/tU4snzn10PKswMSIAO4Zd1dENQuVbkWM=;
 b=tNNnjVKYFxaqaqLjadgjSPPpmq0a7U8BmhXNrugWyPDyC8vr+HhPELn87SnhYev3ovVeNBMM/iEgMeV3DZ7aFaO7PoQubVog/+0YTWvn0FdyuuSDriMwyC8UXkJV+fKWJPovDNNBcsf+p7fSWA0I5LEgS6/vjAXVNa0XamtvdUCwpqldtP64stDDp/iGgwtdDCEyF57+6vEIGEvxf6H/hI2yd/928TZZgtX/ecd9IEjZ8Tfo0sWwi7OTDWChjkQKzDu9z+DY9Ga9vO7J0dD1Y5qAkokOhEIH/FshnvFBotIVDN7APKzmY5RA8UToipsnCjLtNjKDr6RU/nmR6z90lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 23:39:11 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 23:39:09 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"hao.wu@intel.com" <hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>,
	"trix@redhat.com" <trix@redhat.com>,
	"basheer.ahmed.muddebihal@linux.intel.com"
	<basheer.ahmed.muddebihal@linux.intel.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v4 16/19] fpga: dfl: allocate platform device after
 feature device data
Thread-Topic: [PATCH v4 16/19] fpga: dfl: allocate platform device after
 feature device data
Thread-Index: AQHbOcnUwiIBOsgtgEK/p85b3czA1rK9qMqAgAGcFgA=
Date: Tue, 19 Nov 2024 23:39:09 +0000
Message-ID: <f173b2c6fbd971a415e93893ce6e8023da49ed00.camel@intel.com>
References: <20241025223714.394533-1-peter.colberg@intel.com>
		 <20241025223714.394533-17-peter.colberg@intel.com>
		 <ZztUfN8ySl0ck3h4@yilunxu-OptiPlex-7050>
	 <4002f681655dce0aa9ec0cceca744f237f392c81.camel@intel.com>
In-Reply-To: <4002f681655dce0aa9ec0cceca744f237f392c81.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|PH7PR11MB7605:EE_
x-ms-office365-filtering-correlation-id: c971b46b-82bd-4372-12d8-08dd08f35d94
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y0VOUEw1cVIwYm91a3dOUmlaSzZmUnlucXhRL1JZVm8wdWF2UW95cXpERTdp?=
 =?utf-8?B?dExuZk9CamhEVlZOd2V0TmNXcUptN1QvcEZFbkltd3RvQnpRUWNRNlZycmJ0?=
 =?utf-8?B?VEM1aGZzckVITlFqSzh2ZDlUZWlTWjhkeFdENDRGQUZ1UGNpZXh0UDNwVUhV?=
 =?utf-8?B?ODRXSXpxREFqVHhlMGVqcnlaZ2NmMFdUWWxHQlVzcTJCQXlmS0gxS3VGWWsr?=
 =?utf-8?B?NGZNeXVwc2x6VnBjTXloRjhVaEhkT3pySjN5bFgzbnptcGw0UTZ4ZVM4N2Uy?=
 =?utf-8?B?SllKTktlMWFLczFFQlBCM294bFVqK3JjZ3pNQ1F0cEtkdGNZa3VNMkFZbHN2?=
 =?utf-8?B?WWxCZm5YQXdVQ3dtN3RWWUtLMTJ6NjYyNTZZeEsyd1pYTUxiSjdmU0N3RFN0?=
 =?utf-8?B?MkdjL3NkajJOQVEwZ1pFRi9yWVJYdXNJczB3SmRyaFFWZ3RIUTJRbW9Yd3N5?=
 =?utf-8?B?NjNsdXdTUGVOdnBGT21sUmlPa3UxbjQ5djVWQ21BL0JpMHh6dFJQLzk3K1pL?=
 =?utf-8?B?c3FGQ2YrcnRZa3NUenFuem95OU5ZWFQvRzV6bk4xd0xVdDBlbzh6QVhtQlRs?=
 =?utf-8?B?dXM0UmlpS2JxUGxVRGhQUldhTUlKaFBGR0llSm56M0ZtT2pNZVA3bHhVMFFR?=
 =?utf-8?B?VlNrdEQ1cG55a0tPRTlvQlRkSFkxdExlSGc2blYzRE5FUitKbUk2OVgyRjY0?=
 =?utf-8?B?Q3ZmZFNxclk4ajFCQ2J5NmVGd1JjcGlsZXJUenBld08xVW9WV3hPNWJiclVz?=
 =?utf-8?B?cnM5T0pRanJEMVA2TVVzRWwzV3pmUGxON1BxYmxuREpHelpFWU9QcnA4RGlF?=
 =?utf-8?B?UG9SSUxUYVA0NTJPUko1VjIzU0U5RnJEeVVyRzNWLy9PUTcyRGt0bWY0bXNk?=
 =?utf-8?B?RnN5R1k5clI4VzYwbXNjNXB6eVJUUHMvU0hIODV6REFFUng2eW0vWnhILzdi?=
 =?utf-8?B?TzRXZDE1Vy96K3Nkb0Y5ak1xM1g0dmZtVFZhNjVaUGh2NTEwZU84UTMvNVE5?=
 =?utf-8?B?RVpCdVVDV3JQNWlWZzBzMWpiSUUwakVFYjhEQXFEWkY5ZFRIeUJ6VFlPYld4?=
 =?utf-8?B?RVZzK3AyTm15NG1IVEduRStBRC9kczFJYWNNdUtTTjZZaExlNVNTWDk0RjlQ?=
 =?utf-8?B?b3RpTzAzdk9LakR1MGhSK3Jibi9uRlNZZ3JFZS94RnhxMHZSZllJR2dQTGIz?=
 =?utf-8?B?TGlrVFFWdnVsdGlrMGY2Tm1Bclo5WnkrSmxlZGhQeUtOOFFpVlB4Y1ZMQitI?=
 =?utf-8?B?N2ExeGtFeXl2NVY0UDc1aVRWem10RE8ycGllem5zWUhFR29ENFFvSklJLzg3?=
 =?utf-8?B?SkRKVXlEVmZ1aC9pc1R3OHpjNjVCblduRy9QdjU0bVZla21rZ1RXNWJjMmFS?=
 =?utf-8?B?RkFjM21GSVNkRFR4RFB0akNoZlI0UStNSWNZZ05uOWU3UXlxdmdSMDdWTmZp?=
 =?utf-8?B?UnI4ZTlQWlRRZE12djllSG1FbUtPSElFL0Qxdnd0S1BrazFBdlpKUVo3eGtW?=
 =?utf-8?B?TmlFOTdlN2RQMUo4c0swOTl1ZXN3aWx0S25scFRaZGxqbk9GVGdpM3Z4Z1NC?=
 =?utf-8?B?TWJlNUNiY3hRUm5xOXZZUDJHV3p1SUNVZWhPZFd4dzBzYmRHQTIrZzNFQ3po?=
 =?utf-8?B?dDM3YVRPSXhnUnY1bU1WMVJHNDQ5MTFwdHpLamx6WGNFdGJidFE2ZllEUy91?=
 =?utf-8?B?M3J6L1l2SmFIMzdOQ0dqZXBOK3RKN0xlc2JEUHBlanRjbHlKMjFVZGMyeGpC?=
 =?utf-8?B?ZUpLT0w3Y0x4a1hxM3J1VGNXejhwWCsvNVViRGx1KzFOaE1jYk9yS2pEaTd4?=
 =?utf-8?Q?nBsydVawrTPvsSNEeMWVPy5LJ3bjindpL1GX0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0F1T3plYVdGVG5VR1lQU3JRQVZSZkJDUVJ6V2hNL3dBdERwVUxPb3YzRStj?=
 =?utf-8?B?WTY5NEJMTTkrWDNOdERMMGZKdWQvSUEwbysraWtHNlBGV29oTVMrQjNkNWVv?=
 =?utf-8?B?Q0o4SW5NbXY5T1p3MmxmUElYbEE1OU9BRGpISnpRTy90U3FvTWE2TFJtbURK?=
 =?utf-8?B?OXVuUUxudE5SYm9iQVNBWHdCYUVGd2FEb2x5Tk90blJFV25kQUg5ZTVjSmQ2?=
 =?utf-8?B?QVdwdTl6RkZ1WDZXWExTNHgydGx3K04yS2w3ems2eVhSaHFjMVpCZzYvRUFj?=
 =?utf-8?B?UFJpcnc0T0JacW9vRXdGejZ2dmVEbEZlR1VPVzFyYkRUbk03cGd1NXlnRTV5?=
 =?utf-8?B?cTVaUzdURUN6TTA1UHUwWElIWnpwVGtlTGV6MFk5ZUxlLzl3UnBZTVVsWVZJ?=
 =?utf-8?B?UXAyQ2hwYUE5N1lJWHdnR2NWUVpXYWJOVmpDUE0rN2pPeVhlbHdNMmh4eHdp?=
 =?utf-8?B?ZG1wbVMzT1BZbjJuV0NLTmtjR3dZcUhXZHF6dUNEdmV1Wmt2QmJ1WkU4VEJ0?=
 =?utf-8?B?bHBDNXE5S0hTbEhRV29vZ0Q4OUU0SDdXSU4vcnI5ekZIT0tucFg1UHduZVJi?=
 =?utf-8?B?T21QclduRm9sRm44YmJTQzhNQ0VSU3hReHE4TmdTcExWbERuUmIvM2pxcm0r?=
 =?utf-8?B?OXo5TVE4UmNwR3NtV2Rva01TMkFoeTVvVlR4Mlp5SXQxamI2NUlNcWo4ZkYr?=
 =?utf-8?B?d3JDUXU4a2V0YkREeEdYSndIN0Y4VmxZNlNvSDYrTWpydHQ0L21CbG5TS2hO?=
 =?utf-8?B?aHN3M2Y3V3EyWUVBUnltaytDb2lSSkFaTS80eUxUbnlLL0NDOW9XR3dyKzc1?=
 =?utf-8?B?K3FrS0JXUWV6U3ZOV2wrcUdJbGZvK01ybG1abFlKKzZGTGYyVEpHZWtXOFp4?=
 =?utf-8?B?M2Z1UHN5RVVmT2FOc2hWVXB3VGlHS0F6d2hhUFhBb2hySmh6b1Qva2kwZlRn?=
 =?utf-8?B?RXhGWFFGaTlSaVhkVzlVNW5Ld3ZKdHQ5TDd1UUV3OGhtcDZndjZZQWl1UkEw?=
 =?utf-8?B?WFl2S043VERCZlUxRHVCYWNnbU1BWHZ5SkVyS0F2NUhzaVVibjVvYllRRDFC?=
 =?utf-8?B?NEhsSDFmSDMwSlg1eDhkNE0vdVpmTk5SK2ZkVHdwT0xQajlIS1FHbHJHMlZJ?=
 =?utf-8?B?Z01adXJqTDlQU3FSa2Fmdk95K1lybm9IRmduMWI4dC85NFV2Sjd0Ni9iQit2?=
 =?utf-8?B?V3MraTBwV3FGV2RkclNaWExYT3RXYjJCcThBRHpKNWpTamFEYjFycG5TcmVV?=
 =?utf-8?B?Q0s0ZVUyNDhPdkZZZE5uZkxvWWdDeXBPY3ROL1B6MlBFdS9KYlNrdE1kMmJx?=
 =?utf-8?B?bG93UGJONkg4VS9MUGY3Zi9kTUwyaXZJVnRrVmZDM3JKcVlCbitidERhcmpO?=
 =?utf-8?B?bGFTelA3U2pFUHU1SkpQZWpyN1JScVVPWGpLcWgyQUFTK0RwbkhvUjNlL0FE?=
 =?utf-8?B?eUUyTXBHME16bEpBMnBtRmVEVzFBL0Q5R0RXNzg3ZmhRQVdYUW41U1lEK0VP?=
 =?utf-8?B?eENYTnI5WjRrNkN4QkVsNktRbVdsNFVZcDU0Vm9QYWRqUnpUL3p0MUNUbUdk?=
 =?utf-8?B?ekdUZVlJM0dPV2xKcDlPN3ErajBuZG9LZk1Nd0NaNHE2NHFJaHBzdUd4L09n?=
 =?utf-8?B?ZStxYlFZaEVqc0IrdDVwaVRlQTE0Tk9JWk52SlhPcVRPMXpkOFJsanJQSlpR?=
 =?utf-8?B?ZExxdDlibXMwc0dDWW16VStKRnBHbkFpblNrOHZ1T1NEV1dYNG94d2RQM0dL?=
 =?utf-8?B?aEJYNXUxK0QzVTZmMzRtT0hBWjB5QmJ4cUtBWlJZWEZMUExxeVJqU3dqZlBr?=
 =?utf-8?B?OE5FRERMRkdlaEJhTngrZ2JmSHczakNIMnU4ZGtHZW83Y2RkV3lrQWk5anl0?=
 =?utf-8?B?ZklTcEFVUTVFTC9vUzErQXowUnVENFlJV0dZNnJRVE9lejA3cGRidC9wM09R?=
 =?utf-8?B?U0JvanRPTmJDUlovRDN5aTdOd0RhaFVIV2l1LzgxNG5BRnZEOUs5UGRoQnoz?=
 =?utf-8?B?ZGpEUGlLb1VhQjF0R2ZRemdiRkxZaDVjSjJYeDFNWXY1ZjljVVhzMEdwaUJz?=
 =?utf-8?B?cm1mTXhzbkZoRHBmMkhRRU90VkR1MEFTZVNYL0JCWmFPcm9ROEFDZnNUSnlh?=
 =?utf-8?B?NUVFeEZVSkZMaVcySlZUK2dUMlNib2tjaHZnaW9md0pOTjJ6SUYyY0QvMXhx?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BCBCCCA40A4324793E28BF5D04462E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c971b46b-82bd-4372-12d8-08dd08f35d94
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 23:39:09.6473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSqEsw0zgA37I6Rx064xA1sddZGqYqrCUZ4bfv2ny+30d1nXbuyuyhp2uG28b3Z/gbPGE4Ob+s+HwNpd+bw8/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7605
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTExLTE4IGF0IDIzOjA0ICswMDAwLCBDb2xiZXJnLCBQZXRlciB3cm90ZToN
Cj4gT24gTW9uLCAyMDI0LTExLTE4IGF0IDIyOjUxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4g
PiBPbiBGcmksIE9jdCAyNSwgMjAyNCBhdCAwNjozNzoxMVBNIC0wNDAwLCBQZXRlciBDb2xiZXJn
IHdyb3RlOg0KPiA+ID4gRGVsYXkgY2FsbGluZyBwbGF0Zm9ybV9kZXZpY2VfYWxsb2MoKSBmcm9t
IGJ1aWxkX2luZm9fY3JlYXRlX2RldigpIHRvDQo+ID4gPiBmZWF0dXJlX2Rldl9yZWdpc3Rlcigp
LCBub3cgdGhhdCB0aGUgZmVhdHVyZSBkZXZpY2UgZGF0YSBjb250YWlucyBhbGwNCj4gPiA+IG5l
Y2Vzc2FyeSBkYXRhIHRvIGNyZWF0ZSB0aGUgZmVhdHVyZSBkZXZpY2UuIFRoaXMgY29tcGxldGVz
IHRoZSBuZXcNCj4gPiA+IGZ1bmN0aW9uIGZlYXR1cmVfZGV2X3JlZ2lzdGVyKCksIHdoaWNoIHdp
bGwgYmUgcmV1c2VkIGluIGEgc3Vic2VxdWVudA0KPiA+ID4gY29tbWl0IHRvIGZ1bGx5IHJlY3Jl
YXRlIHRoZSBmZWF0dXJlIGRldmljZSB3aGVuIGFzc2lnbmluZyBhIHBvcnQuDQo+ID4gPiANCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IFBldGVyIENvbGJlcmcgPHBldGVyLmNvbGJlcmdAaW50ZWwuY29t
Pg0KPiA+ID4gUmV2aWV3ZWQtYnk6IE1hdHRoZXcgR2VybGFjaCA8bWF0dGhldy5nZXJsYWNoQGxp
bnV4LmludGVsLmNvbT4NCj4gPiA+IFJldmlld2VkLWJ5OiBCYXNoZWVyIEFobWVkIE11ZGRlYmlo
YWwgPGJhc2hlZXIuYWhtZWQubXVkZGViaWhhbEBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiAtLS0N
Cj4gPiA+IENoYW5nZXMgc2luY2UgdjM6DQo+ID4gPiAtIE5ldyBwYXRjaCBleHRyYWN0ZWQgZnJv
bSBsYXN0IHBhdGNoIG9mIHYzIHNlcmllcy4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvZnBn
YS9kZmwuYyB8IDU5ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMzcgZGVsZXRpb25z
KC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ZwZ2EvZGZsLmMgYi9kcml2
ZXJzL2ZwZ2EvZGZsLmMNCj4gPiA+IGluZGV4IGE5ZWMzNzI3OGIyZC4uZDljZWYxNTBlZDBkIDEw
MDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9mcGdhL2RmbC5jDQo+ID4gPiArKysgYi9kcml2ZXJz
L2ZwZ2EvZGZsLmMNCj4gPiA+IEBAIC02ODEsNyArNjgxLDYgQEAgRVhQT1JUX1NZTUJPTF9HUEwo
ZGZsX2ZwZ2FfZGV2X29wc191bnJlZ2lzdGVyKTsNCj4gPiA+ICAgKiBAbnJfaXJxczogbnVtYmVy
IG9mIGlycXMgZm9yIGFsbCBmZWF0dXJlIGRldmljZXMuDQo+ID4gPiAgICogQGlycV90YWJsZTog
TGludXggSVJRIG51bWJlcnMgZm9yIGFsbCBpcnFzLCBpbmRleGVkIGJ5IGxvY2FsIGlycSBpbmRl
eCBvZg0KPiA+ID4gICAqCSAgICAgICB0aGlzIGRldmljZS4NCj4gPiA+IC0gKiBAZmVhdHVyZV9k
ZXY6IGN1cnJlbnQgZmVhdHVyZSBkZXZpY2UuDQo+ID4gPiAgICogQHR5cGU6IHRoZSBjdXJyZW50
IEZJVSB0eXBlLg0KPiA+ID4gICAqIEBpb2FkZHI6IGhlYWRlciByZWdpc3RlciByZWdpb24gYWRk
cmVzcyBvZiBjdXJyZW50IEZJVSBpbiBlbnVtZXJhdGlvbi4NCj4gPiA+ICAgKiBAc3RhcnQ6IHJl
Z2lzdGVyIHJlc291cmNlIHN0YXJ0IG9mIGN1cnJlbnQgRklVLg0KPiA+ID4gQEAgLTY5NSw3ICs2
OTQsNiBAQCBzdHJ1Y3QgYnVpbGRfZmVhdHVyZV9kZXZzX2luZm8gew0KPiA+ID4gIAl1bnNpZ25l
ZCBpbnQgbnJfaXJxczsNCj4gPiA+ICAJaW50ICppcnFfdGFibGU7DQo+ID4gPiAgDQo+ID4gPiAt
CXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmZlYXR1cmVfZGV2Ow0KPiA+ID4gIAllbnVtIGRmbF9p
ZF90eXBlIHR5cGU7DQo+ID4gPiAgCXZvaWQgX19pb21lbSAqaW9hZGRyOw0KPiA+ID4gIAlyZXNv
dXJjZV9zaXplX3Qgc3RhcnQ7DQo+ID4gPiBAQCAtNzUwLDcgKzc0OCw2IEBAIHN0YXRpYyB2b2lk
IGRmbF9pZF9mcmVlX2FjdGlvbih2b2lkICphcmcpDQo+ID4gPiAgc3RhdGljIHN0cnVjdCBkZmxf
ZmVhdHVyZV9kZXZfZGF0YSAqDQo+ID4gPiAgYmluZm9fY3JlYXRlX2ZlYXR1cmVfZGV2X2RhdGEo
c3RydWN0IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbykNCj4gPiA+ICB7DQo+ID4gPiAt
CXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmZkZXYgPSBiaW5mby0+ZmVhdHVyZV9kZXY7DQo+ID4g
PiAgCWVudW0gZGZsX2lkX3R5cGUgdHlwZSA9IGJpbmZvLT50eXBlOw0KPiA+ID4gIAlzdHJ1Y3Qg
ZGZsX2ZlYXR1cmVfaW5mbyAqZmluZm8sICpwOw0KPiA+ID4gIAlzdHJ1Y3QgZGZsX2ZlYXR1cmVf
ZGV2X2RhdGEgKmZkYXRhOw0KPiA+ID4gQEAgLTc3Myw3ICs3NzAsNiBAQCBiaW5mb19jcmVhdGVf
ZmVhdHVyZV9kZXZfZGF0YShzdHJ1Y3QgYnVpbGRfZmVhdHVyZV9kZXZzX2luZm8gKmJpbmZvKQ0K
PiA+ID4gIAlpZiAoIWZkYXRhLT5yZXNvdXJjZXMpDQo+ID4gPiAgCQlyZXR1cm4gRVJSX1BUUigt
RU5PTUVNKTsNCj4gPiA+ICANCj4gPiA+IC0JZmRhdGEtPmRldiA9IGZkZXY7DQo+ID4gPiAgCWZk
YXRhLT50eXBlID0gdHlwZTsNCj4gPiA+ICANCj4gPiA+ICAJZmRhdGEtPnBkZXZfaWQgPSBkZmxf
aWRfYWxsb2ModHlwZSwgYmluZm8tPmRldik7DQo+ID4gPiBAQCAtNzg0LDggKzc4MCw2IEBAIGJp
bmZvX2NyZWF0ZV9mZWF0dXJlX2Rldl9kYXRhKHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNfaW5m
byAqYmluZm8pDQo+ID4gPiAgCWlmIChyZXQpDQo+ID4gPiAgCQlyZXR1cm4gRVJSX1BUUihyZXQp
Ow0KPiA+ID4gIA0KPiA+ID4gLQlmZGV2LT5pZCA9IGZkYXRhLT5wZGV2X2lkOw0KPiA+ID4gLQ0K
PiA+ID4gIAlmZGF0YS0+cGRldl9uYW1lID0gZGZsX2RldnNbdHlwZV0ubmFtZTsNCj4gPiA+ICAJ
ZmRhdGEtPm51bSA9IGJpbmZvLT5mZWF0dXJlX251bTsNCj4gPiA+ICAJZmRhdGEtPmRmbF9jZGV2
ID0gYmluZm8tPmNkZXY7DQo+ID4gPiBAQCAtODA5LDcgKzgwMyw2IEBAIGJpbmZvX2NyZWF0ZV9m
ZWF0dXJlX2Rldl9kYXRhKHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNfaW5mbyAqYmluZm8pDQo+
ID4gPiAgCQl1bnNpZ25lZCBpbnQgaTsNCj4gPiA+ICANCj4gPiA+ICAJCS8qIHNhdmUgcmVzb3Vy
Y2UgaW5mb3JtYXRpb24gZm9yIGVhY2ggZmVhdHVyZSAqLw0KPiA+ID4gLQkJZmVhdHVyZS0+ZGV2
ID0gZmRldjsNCj4gPiA+ICAJCWZlYXR1cmUtPmlkID0gZmluZm8tPmZpZDsNCj4gPiA+ICAJCWZl
YXR1cmUtPnJldmlzaW9uID0gZmluZm8tPnJldmlzaW9uOw0KPiA+ID4gIAkJZmVhdHVyZS0+ZGZo
X3ZlcnNpb24gPSBmaW5mby0+ZGZoX3ZlcnNpb247DQo+ID4gPiBAQCAtODY4LDE4ICs4NjEsNiBA
QCBiaW5mb19jcmVhdGVfZmVhdHVyZV9kZXZfZGF0YShzdHJ1Y3QgYnVpbGRfZmVhdHVyZV9kZXZz
X2luZm8gKmJpbmZvKQ0KPiA+ID4gIHN0YXRpYyBpbnQNCj4gPiA+ICBidWlsZF9pbmZvX2NyZWF0
ZV9kZXYoc3RydWN0IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbykNCj4gPiA+ICB7DQo+
ID4gPiAtCWVudW0gZGZsX2lkX3R5cGUgdHlwZSA9IGJpbmZvLT50eXBlOw0KPiA+ID4gLQlzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpmZGV2Ow0KPiA+ID4gLQ0KPiA+ID4gLQkvKg0KPiA+ID4gLQkg
KiB3ZSB1c2UgLUVOT0RFViBhcyB0aGUgaW5pdGlhbGl6YXRpb24gaW5kaWNhdG9yIHdoaWNoIGlu
ZGljYXRlcw0KPiA+ID4gLQkgKiB3aGV0aGVyIHRoZSBpZCBuZWVkIHRvIGJlIHJlY2xhaW1lZA0K
PiA+ID4gLQkgKi8NCj4gPiA+IC0JZmRldiA9IHBsYXRmb3JtX2RldmljZV9hbGxvYyhkZmxfZGV2
c1t0eXBlXS5uYW1lLCAtRU5PREVWKTsNCj4gPiA+IC0JaWYgKCFmZGV2KQ0KPiA+ID4gLQkJcmV0
dXJuIC1FTk9NRU07DQo+ID4gPiAtDQo+ID4gPiAtCWJpbmZvLT5mZWF0dXJlX2RldiA9IGZkZXY7
DQo+ID4gPiAgCWJpbmZvLT5mZWF0dXJlX251bSA9IDA7DQo+ID4gPiAgDQo+ID4gPiAgCUlOSVRf
TElTVF9IRUFEKCZiaW5mby0+c3ViX2ZlYXR1cmVzKTsNCj4gPiA+IEBAIC04OTUsMjcgKzg3Niw0
MyBAQCBidWlsZF9pbmZvX2NyZWF0ZV9kZXYoc3RydWN0IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZv
ICpiaW5mbykNCj4gPiA+ICBzdGF0aWMgaW50IGZlYXR1cmVfZGV2X3JlZ2lzdGVyKHN0cnVjdCBk
ZmxfZmVhdHVyZV9kZXZfZGF0YSAqZmRhdGEpDQo+ID4gPiAgew0KPiA+ID4gIAlzdHJ1Y3QgZGZs
X2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSBwZGF0YSA9IHt9Ow0KPiA+ID4gLQlzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpmZGV2ID0gZmRhdGEtPmRldjsNCj4gPiA+ICsJc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqZmRldjsNCj4gPiA+ICsJc3RydWN0IGRmbF9mZWF0dXJlICpmZWF0dXJlOw0KPiA+ID4g
IAlpbnQgcmV0Ow0KPiA+ID4gIA0KPiA+ID4gKwlmZGV2ID0gcGxhdGZvcm1fZGV2aWNlX2FsbG9j
KGZkYXRhLT5wZGV2X25hbWUsIGZkYXRhLT5wZGV2X2lkKTsNCj4gPiA+ICsJaWYgKCFmZGV2KQ0K
PiA+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gPiArDQo+ID4gPiArCWZkYXRhLT5kZXYgPSBm
ZGV2Ow0KPiA+ID4gKw0KPiA+ID4gIAlmZGV2LT5kZXYucGFyZW50ID0gJmZkYXRhLT5kZmxfY2Rl
di0+cmVnaW9uLT5kZXY7DQo+ID4gPiAgCWZkZXYtPmRldi5kZXZ0ID0gZGZsX2dldF9kZXZ0KGRm
bF9kZXZzW2ZkYXRhLT50eXBlXS5kZXZ0X3R5cGUsIGZkZXYtPmlkKTsNCj4gPiA+ICANCj4gPiA+
ICsJZGZsX2ZwZ2FfZGV2X2Zvcl9lYWNoX2ZlYXR1cmUoZmRhdGEsIGZlYXR1cmUpDQo+ID4gPiAr
CQlmZWF0dXJlLT5kZXYgPSBmZGV2Ow0KPiA+ID4gKw0KPiA+ID4gIAlyZXQgPSBwbGF0Zm9ybV9k
ZXZpY2VfYWRkX3Jlc291cmNlcyhmZGV2LCBmZGF0YS0+cmVzb3VyY2VzLA0KPiA+ID4gIAkJCQkJ
ICAgIGZkYXRhLT5yZXNvdXJjZV9udW0pOw0KPiA+ID4gIAlpZiAocmV0KQ0KPiA+ID4gLQkJcmV0
dXJuIHJldDsNCj4gPiA+ICsJCWdvdG8gZXJyX3B1dF9kZXY7DQo+ID4gPiAgDQo+ID4gPiAgCXBk
YXRhLmZkYXRhID0gZmRhdGE7DQo+ID4gPiAgCXJldCA9IHBsYXRmb3JtX2RldmljZV9hZGRfZGF0
YShmZGV2LCAmcGRhdGEsIHNpemVvZihwZGF0YSkpOw0KPiA+ID4gIAlpZiAocmV0KQ0KPiA+ID4g
LQkJcmV0dXJuIHJldDsNCj4gPiA+ICsJCWdvdG8gZXJyX3B1dF9kZXY7DQo+ID4gPiAgDQo+ID4g
PiAgCXJldCA9IHBsYXRmb3JtX2RldmljZV9hZGQoZmRldik7DQo+ID4gPiAgCWlmIChyZXQpDQo+
ID4gPiAtCQlyZXR1cm4gcmV0Ow0KPiA+ID4gKwkJZ290byBlcnJfcHV0X2RldjsNCj4gPiA+ICAN
Cj4gPiA+ICAJcmV0dXJuIDA7DQo+ID4gPiArDQo+ID4gPiArZXJyX3B1dF9kZXY6DQo+ID4gPiAr
CXBsYXRmb3JtX2RldmljZV9wdXQoZmRldik7DQo+ID4gPiArCWZkYXRhLT5kZXYgPSBOVUxMOw0K
PiA+IA0KPiA+IERvIHdlIGFsc28gbmVlZCB0byBjbGVhbiB1cCBhbGwgdGhlIGZlYXR1cmUtPmRl
dj8NCj4gDQo+IFllcywgdGhhbmsgeW91IGZvciB0aGUgc3VnZ2VzdGlvbi4gSXQgaXMgbm90IG5l
ZWRlZCBmb3IgZnVuY3Rpb25hbA0KPiBjb3JyZWN0bmVzcyBzaW5jZSBmZWF0dXJlLT5kZXYgaXMg
ZXhjbHVzaXZlbHkgdXNlZCB3aGVuIG5vbi1OVUxMLCBidXQNCj4gaXQgc2VlbXMgYSBnb29kIGlk
ZWEgZm9yIGNvbnNpc3RlbmN5Lg0KDQpUaGlzIGhhcyBiZWVuIGltcGxlbWVudGVkIGluIFtQQVRD
SCB2NSAxNS8xOF0uDQoNClRoYW5rcywNClBldGVyDQoNCj4gDQo+IFRoYW5rcywNCj4gUGV0ZXIN
Cj4gDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IFlpbHVuDQo+ID4gDQo+ID4gPiArDQo+ID4gPiAr
CXJldHVybiByZXQ7DQo+ID4gPiAgfQ0KPiA+ID4gIA0KPiA+ID4gIHN0YXRpYyB2b2lkIGZlYXR1
cmVfZGV2X3VucmVnaXN0ZXIoc3RydWN0IGRmbF9mZWF0dXJlX2Rldl9kYXRhICpmZGF0YSkNCj4g
PiA+IEBAIC05NDAsMTYgKzkzNyw3IEBAIHN0YXRpYyBpbnQgYnVpbGRfaW5mb19jb21taXRfZGV2
KHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNfaW5mbyAqYmluZm8pDQo+ID4gPiAgCWlmIChiaW5m
by0+dHlwZSA9PSBQT1JUX0lEKQ0KPiA+ID4gIAkJZGZsX2ZwZ2FfY2Rldl9hZGRfcG9ydF9kYXRh
KGJpbmZvLT5jZGV2LCBmZGF0YSk7DQo+ID4gPiAgCWVsc2UNCj4gPiA+IC0JCWJpbmZvLT5jZGV2
LT5mbWVfZGV2ID0gZ2V0X2RldmljZSgmYmluZm8tPmZlYXR1cmVfZGV2LT5kZXYpOw0KPiA+ID4g
LQ0KPiA+ID4gLQkvKg0KPiA+ID4gLQkgKiByZXNldCBpdCB0byBhdm9pZCBidWlsZF9pbmZvX2Zy
ZWUoKSBmcmVlaW5nIHRoZWlyIHJlc291cmNlLg0KPiA+ID4gLQkgKg0KPiA+ID4gLQkgKiBUaGUg
cmVzb3VyY2Ugb2Ygc3VjY2Vzc2Z1bGx5IHJlZ2lzdGVyZWQgZmVhdHVyZSBkZXZpY2VzDQo+ID4g
PiAtCSAqIHdpbGwgYmUgZnJlZWQgYnkgcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIoKS4gU2Vl
IHRoZQ0KPiA+ID4gLQkgKiBjb21tZW50cyBpbiBidWlsZF9pbmZvX2NyZWF0ZV9kZXYoKS4NCj4g
PiA+IC0JICovDQo+ID4gPiAtCWJpbmZvLT5mZWF0dXJlX2RldiA9IE5VTEw7DQo+ID4gPiArCQli
aW5mby0+Y2Rldi0+Zm1lX2RldiA9IGdldF9kZXZpY2UoJmZkYXRhLT5kZXYtPmRldik7DQo+ID4g
PiAgDQo+ID4gPiAgCS8qIHJlc2V0IHRoZSBiaW5mbyBmb3IgbmV4dCBGSVUgKi8NCj4gPiA+ICAJ
YmluZm8tPnR5cGUgPSBERkxfSURfTUFYOw0KPiA+ID4gQEAgLTk2Niw4ICs5NTQsNiBAQCBzdGF0
aWMgdm9pZCBidWlsZF9pbmZvX2ZyZWUoc3RydWN0IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpi
aW5mbykNCj4gPiA+ICAJCWtmcmVlKGZpbmZvKTsNCj4gPiA+ICAJfQ0KPiA+ID4gIA0KPiA+ID4g
LQlwbGF0Zm9ybV9kZXZpY2VfcHV0KGJpbmZvLT5mZWF0dXJlX2Rldik7DQo+ID4gPiAtDQo+ID4g
PiAgCWRldm1fa2ZyZWUoYmluZm8tPmRldiwgYmluZm8pOw0KPiA+ID4gIH0NCj4gPiA+ICANCj4g
PiA+IEBAIC0xMjYyLDggKzEyNDgsNyBAQCBzdGF0aWMgaW50IHBhcnNlX2ZlYXR1cmVfYWZ1KHN0
cnVjdCBidWlsZF9mZWF0dXJlX2RldnNfaW5mbyAqYmluZm8sDQo+ID4gPiAgCWNhc2UgUE9SVF9J
RDoNCj4gPiA+ICAJCXJldHVybiBwYXJzZV9mZWF0dXJlX3BvcnRfYWZ1KGJpbmZvLCBvZnN0KTsN
Cj4gPiA+ICAJZGVmYXVsdDoNCj4gPiA+IC0JCWRldl9pbmZvKGJpbmZvLT5kZXYsICJBRlUgYmVs
b25naW5nIHRvIEZJVSAlcyBpcyBub3Qgc3VwcG9ydGVkIHlldC5cbiIsDQo+ID4gPiAtCQkJIGJp
bmZvLT5mZWF0dXJlX2Rldi0+bmFtZSk7DQo+ID4gPiArCQlkZXZfaW5mbyhiaW5mby0+ZGV2LCAi
QUZVIGJlbG9uZ2luZyB0byBGSVUgaXMgbm90IHN1cHBvcnRlZCB5ZXQuXG4iKTsNCj4gPiA+ICAJ
fQ0KPiA+ID4gIA0KPiA+ID4gIAlyZXR1cm4gMDsNCj4gPiA+IC0tIA0KPiA+ID4gMi40Ny4wDQo+
ID4gPiANCj4gPiA+IA0KPiANCg0K

