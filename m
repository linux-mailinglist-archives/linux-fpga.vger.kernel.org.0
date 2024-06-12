Return-Path: <linux-fpga+bounces-543-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F17B905E51
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Jun 2024 00:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE731F22777
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Jun 2024 22:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42714F60D;
	Wed, 12 Jun 2024 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JX4ZKq7m"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F521DFF0;
	Wed, 12 Jun 2024 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718230598; cv=fail; b=fMBhuYSnQjdX030xAE+4XaCKzM60GQ41Ja07cTcVLUi96TXgVvdZYVItePVziKpuIXblZo2uEzRbOuVcP4eRLu2h5zWr+YdoERBYFXYZOUxt+QBawgMr10SV9VFp9sQXz2CaEQp2P6lDS6pcL4KfUNJ9Yo0kXLBNUeLpNUftXjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718230598; c=relaxed/simple;
	bh=6HXfkfbdMaBxCq6ZfPmKccDRoI5+hci+aBn4XdVx0Ew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qpaXbf7nAfD0dc7wlveHozSRWLVCuL6I/zSmzkhuhK0SBpMR5o9vTlxpfI+g1N7memWYq3n4k1CwZa8p4jooAJGhpbPL47P/TjkkqG8HqrB/ypA6hgPknP2MZT4u/tUvdjU3nCqNfZ49yqtcvzNhwsIj1eMhq+rpJQ9jv3i27IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JX4ZKq7m; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718230597; x=1749766597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6HXfkfbdMaBxCq6ZfPmKccDRoI5+hci+aBn4XdVx0Ew=;
  b=JX4ZKq7mxjFuKyH0c6fZcw3vN1PR6BMOYt2HJEwyzqCxtup5WFxc37tV
   m3YpK+Kx2P0LVEN/Ud1LKvdQzYhRAEq4I4DgJj7uRci46XQoIxmaiU7eR
   +Sg7EhbE9wmwyStpHeETN/iiaqbAKhDNy2usUiUhw0rMkeFd54QUvvrtX
   EjyHtOxlC1o1IvAg7YOKhJTT61gkF7aikwiTLUW+Dod8/HWMLelDTyq9W
   nCftzIVf6f96kl1Flf/TwxtAOJm5Un0XeO0Ww41Tyo571DMWEUaOdlFhD
   z5F80v+FvsOYWH3WeeVo6yRkwXq7O9c+72l1a67CAaDN8fbzAqrcnEmpv
   w==;
X-CSE-ConnectionGUID: IzY2AyYcTF2YpByjBmCLzQ==
X-CSE-MsgGUID: Zvilwl2wQxqIaVuwT0O5mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25602449"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="25602449"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 15:16:36 -0700
X-CSE-ConnectionGUID: AbVyAmpgREqVQpl81gJ9WQ==
X-CSE-MsgGUID: JeBv1JcoTk25v4dlSw13KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39818140"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 15:16:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 15:16:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 15:16:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 15:16:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeiI12CQkI+SjOdekRaQD42iu6Xy0xsxR61XNktmqxdPUGLsLoEU8NqB9Kx0MR4mkkoFeqL20LBnpIX8ML6moXk+bF5Zzgdbf9FAaViuQftAZu1S79WvJv3bNrR5YKsqdP2sk8T9eoVajogqXoIxUp4Uix4UsFQa7wCndefafXnxt2Vz0zg7Tu3sT1ga5qy7a/LjqHoKkfBuoYQE5Mz1v4V3SvND/zVJBfHKH+NMb+B1n9ysR6VyY9uvfxJxjdhNWBCM1SUZYDvbuVFzeEbuv2w8Nw76Ej0uREIDeynTGv9TEc1tH+XSHhUUg1CR4ZocBwMNdD15PrFV6k84E6hxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HXfkfbdMaBxCq6ZfPmKccDRoI5+hci+aBn4XdVx0Ew=;
 b=PM0YG+Oi/Y6auWkC2KlGqX3ztakaMMXjR1U5N9/8QGxApxxeYR/RBOApNbabdAgQ2lvmvNLUma/msoKGSPRJ4g970c0C/kt8wd6psd/+IHkXLBGBMclDoxJyKIXm/7CWxzXG1i6xsrAKL3lyPIRVqzzK4LmN1gXMD1iQgioJKGUIYTs6e+LhAbx7srbzHmYA/Bum4APqU0zIM+ve6fm3YrmbooZQfGj9F3YGRtgDCOqu6qqNmYlQXMLPsmB3ncnhOSDRYKIEcMbqD2aLplG0q3FirMfJLFCMlXSRtlz1r3tDBzNTVw/NXnWQdcusSPHXSRgrnVp13DASWbPUSYCjvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by SJ0PR11MB5814.namprd11.prod.outlook.com (2603:10b6:a03:423::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 22:16:29 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%7]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 22:16:29 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao"
	<hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>,
	"trix@redhat.com" <trix@redhat.com>, "russell.h.weight@intel.com"
	<russell.h.weight@intel.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [RFC PATCH v2 9/9] fpga: dfl: fix kernel warning on port
 release/assign for SRIOV
Thread-Topic: [RFC PATCH v2 9/9] fpga: dfl: fix kernel warning on port
 release/assign for SRIOV
Thread-Index: AQHavRYsoxMM4QL8q0uV7cagtdvJnA==
Date: Wed, 12 Jun 2024 22:16:29 +0000
Message-ID: <97093c23ae13a1fdcc52f85e5658a39e8a5ce716.camel@intel.com>
References: <20240409233942.828440-1-peter.colberg@intel.com>
	 <20240409233942.828440-10-peter.colberg@intel.com>
	 <ZifVYiMgssOFjM17@yilunxu-OptiPlex-7050>
In-Reply-To: <ZifVYiMgssOFjM17@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|SJ0PR11MB5814:EE_
x-ms-office365-filtering-correlation-id: c96b898f-2189-4af6-74e6-08dc8b2d4f17
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|366010|376008|1800799018|38070700012;
x-microsoft-antispam-message-info: =?utf-8?B?QWZGbUpZaFlyckJvVHZpM0VsWEl0UDU4M2lKN1AySDREWjNncWlMdEF1ellG?=
 =?utf-8?B?S0xTSnNBa3F4TERuMVRKdVpuYmpzNnhUaG1oblhuSzZyU1pGeGI5VVdhS3hn?=
 =?utf-8?B?bXk1MHZLOWkveFprOWVuaVhNNzc1ZnJsZ0xsZENLUUcraVczUFBlVk5DVnV5?=
 =?utf-8?B?UkhsaGlNQzE3YzdJZlFmTHRzemtRVTkwU0o3L0lhZmIrbldNTnZUdjNQTEJX?=
 =?utf-8?B?Zi9Jd0FOZ0RiMmFpRlhLQUVOL3NqZEtPd3NZbUdydGV1clBpZG9GZUJzMnFV?=
 =?utf-8?B?aWxJeUFmc0l4cXROb1Z5cEJlOFE4VmVwSjVJcGJWd21jQUxUZDV3bS9MRklH?=
 =?utf-8?B?eFlUM2pVUm9aNUFpZ1Nmd21ieVJtOU1xcnJyandHOGR2eWJuKzlFQnRPQVRp?=
 =?utf-8?B?ZVcvRDc4QTdxR3dwaGJzWko0R2NBNzlFK3RhKy94MVRZZjV6amsrMUV4R3hE?=
 =?utf-8?B?cVVRT0dwZWgxbHNQZm9jNkpqdTY0bjJWeWphYldXWGhmUXpNR3ltRXBRME9w?=
 =?utf-8?B?OHBqb3pyM09kRzg5OVZNU09pdU5ORnZHZnFPZmw2MHhWa1lRV1JLdFRBL0Fa?=
 =?utf-8?B?Zlo2bnYyT01UTVBtL1BFN1dyYjZGNEY4ai81SHRaQkUzM2hxMU12em5CZjNm?=
 =?utf-8?B?VFhoU2htcVN6SXRIangrb21jZTNXbDlCQ2xvSkptOGNTT0JFcWJlV2RqZGdr?=
 =?utf-8?B?MXJKRklTQU5UQW1seXU1VGJueGluaXpDSTlKL0ViSFhwQnJpUTFyYTRYRGE5?=
 =?utf-8?B?TkxjR3FXenZZdDlpU3JYdW1sQ1U1c0x0NlUxUi9xYUFiZFNUMmNndm15Y3kx?=
 =?utf-8?B?bnZIMGxiL2NjM1M0UEl0NVE1aTE3TTlXSVpxRDVwZXdIK3ZLdmdjNXNuN2tx?=
 =?utf-8?B?QmE3M0Q3Z29JaWxGdkpUYU92RHBvaEZ2RFR5eGVKN0FZTTJhSy83cnFuRnQv?=
 =?utf-8?B?Y3NyMGkxT3E3Q0Z0QjFxNG13YkpSVEtSU0ZrRERSZGxYRk04MXd2YWxPdnVH?=
 =?utf-8?B?RE52UWRKOVVseVBjUnZQTHJhNjBteU44WDIvR1dWazQzSVF5ZnJncHNxN0Fa?=
 =?utf-8?B?aGR4UTlYd2kvYWFsRWdFSmc2SlYrajkxTFdzdGc3aDVYcnNuL3FHOWNPZ2Zv?=
 =?utf-8?B?Ym5DWE5IN3ZyQTZiSThzRUVOOEUxUlRQQ3MrdUZaR0lPdElsWS80emFieUhV?=
 =?utf-8?B?OUsxSlllSHVFcWdpY3ZNSUYvR0NUeDhCNUNJZ3ZodDhCakNHZUJIbG9nMFY5?=
 =?utf-8?B?dGgxSGJSQXJjUngzemg5WTN5aU13SEVLNXRodGREZmJXcE5nSUdmb2FZNWFO?=
 =?utf-8?B?aEZmcjE1eHZNcHYwd3YrQjFBMnV4Rzd3TWN5RXVrR2xBNlI5ZEZTekFTRVU5?=
 =?utf-8?B?NTNYdUpiMEJIcGthVGZZODE4cWgyc0x5aVpOak9FRkdIT2pvR05DMU5sUjlP?=
 =?utf-8?B?MUV1TDNINFVSWGR5TzlOY0I2M3lHVEMrOEh5YmVZekFJMkVVclNBVmJuSHZa?=
 =?utf-8?B?ZGNEQWZWUHhnVERGdmJiUUVUbVMvZGFsL0Y5cDBMclVucWhxT3RUYnNnazJa?=
 =?utf-8?B?RXRxUWh3WS84blRKNXRQZU5jcFV0KzUzNTZFcXhDMzBOeFhoL0ExdVBoaTNL?=
 =?utf-8?B?ODArNEswNEwxZU1yT2Nsc0x6OWNic2xQVGd6Q2NkbXNyTE50bmRkSVp4VGxV?=
 =?utf-8?B?NTRkRUFLby9sam1xN3VsSHllR0p1SHVwMGgvK1lSYkRlalVuWmZvdk5QRm1r?=
 =?utf-8?B?WGVYZGdGdW9EeXNtQ0hJaHN5ZVZiT204KyszYzlBWHBsKy9UTXFBZVV2SWsr?=
 =?utf-8?Q?6YFVfJ12p5F6CTnn3m0wYSLLXknHVs0JJqDr0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(366010)(376008)(1800799018)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjJDMnBCc2I4bWNkR05SK2htZHhibURmMXY4V3d2YW5TeWZQUVBvckxPV3dR?=
 =?utf-8?B?L2FndTJiR3Vya2xybitJejhKMTJZVWY0cUJZOWJ1RlBud1JISlJickt1WHRL?=
 =?utf-8?B?RzdMcFh0SzRaSmx2ZjNwaVBJME9YV3BQMTZ1c3BlR01uQWF3bFJHcStOejdK?=
 =?utf-8?B?R214Sy84UjFObFRkZ0doK0UwQk8ydmY0Y1luV3JsWm5IbFhib0NoVHhmUU1o?=
 =?utf-8?B?RW1iUnZPc00vWDdvaEhET3o3K1RBL2NZWmREdjlmamVxY0tVV2lHVms2VzBz?=
 =?utf-8?B?MHl6S0xVSjRPYm1SeklCUGF5SzBHOHh3T1hMakJwMFZVNWFsOE1iZFBoZU5X?=
 =?utf-8?B?MWhpd2FuVnIwbE9yVTlQUUNOa3BvbjRYVWk5RkpmUXovdVhkUkwwaUUvSm1V?=
 =?utf-8?B?UkdQNHdzY0hCL2tZTEJ2Ymp4dmhKNkJtT1A3UnBKRHZFVzNyUC9yY25WeVV6?=
 =?utf-8?B?Q0F5U2l1SDVxeWJ5WDBhelNjOUxBQ0s0MEFTWWxBNmRZa1Y0ak5weFlxTXFI?=
 =?utf-8?B?ZzdoNGh3anJ1TFBEbC9lbEJKTmhqb3RSRnJYbWJxT0pZNy90ZmpKc2Jvejl6?=
 =?utf-8?B?NkZJaFRzYk0rbnhEVWhLRUR5eGlSY0d6K0drQ1BSK0VjbUlIdUpQUEV5bjhw?=
 =?utf-8?B?MWx4eS94ei9oV3dTWGhnTDErY1g2S3JKZXhoNFpyeDFGZGI2MGs5V0tZS0lU?=
 =?utf-8?B?WHN4c3FRUTR0L2lJSk9SbnNTN2xwSmxuVHk2Znl6aW5GcVZocE8wSVBFZ29I?=
 =?utf-8?B?RXJ4Z3hhUmxJTklPL1czRkNBenNSS2hUdFRydkM0WWp6bFdLTUF4UWpaZUMw?=
 =?utf-8?B?aEt4VDVFSDhpT2JTRktkc3JJTGYxQVRvVldYL2JvUEd3dUhrSHNoMmFmKzZp?=
 =?utf-8?B?TkMwL1hqaGlITFBPRkVxQW4vcWYralRDdW9HVC92dnRSSFR5aVhOSHdKNWRG?=
 =?utf-8?B?bWkxTTdkN0trUjNwaU01STJaNTBVUmU3dXozYldXS25ENXpmbExMRVQ4bGpI?=
 =?utf-8?B?a0hMNnZseUVWNFVMdk9YU1lTek56a042VVd2bEtTdUpJMHZBcUd0RkdYRWRo?=
 =?utf-8?B?MUFjVXY0YWlJMTU1ZFFqREZXZFJEck04ZzdZM1VYRTg2aWNNUU9OWkFSdXVj?=
 =?utf-8?B?aGN5UUZSWFltNkpJVksrUU43TFB2cUh1YitsK0JqTVZCYnVKakpIekp0US9m?=
 =?utf-8?B?aWlqUENINTdWUG5xSThCc3FOeUQ4NG5EUUpYSStwWndwbVlDd0ppMUp5V2Fi?=
 =?utf-8?B?dkdhelMyem13MFdBUnVEQ3hLVUY2aUR1YmQ4MjkxZWxlcllQcGlmTzFzS2ZX?=
 =?utf-8?B?UTYrTVBZbjg3SFlZU00vNGdwcnRsTlF2eHZEQUsxN2JpTy9mNGhkQVdyejAy?=
 =?utf-8?B?ajZTV3p4THU2VHVlNEpEMjBqSW5GMTRmaFhqLzFqWHVnaHh5TVE5RmZmUXNN?=
 =?utf-8?B?YW9KS1lSWUtLaCtESHB4THo5MVBhNDZzUndMK3pxTDljcUJJSUlIQ1I4N0Ra?=
 =?utf-8?B?bVFTT0xLaWlka1JyTHF0VUxySDRHSkxnY0ZreEJLYzZGbUxJRVpVajNzRXha?=
 =?utf-8?B?NE4wU0taWVJUUy9rTWxFMG9MdjYrVnlqLzhsQ0tqRU5MWmh4SjdGWnZtUmtC?=
 =?utf-8?B?MDB3dmR1bngycjBKcC94NlBTVkpQblRLVkJKR1pJeEg0RVJKMG0rYk01OVhm?=
 =?utf-8?B?R0VTQ2Ziak55aVJpbmlJcDRhTitpUGJnRFB0SnlteEMyenZPRWFkM2srR1R2?=
 =?utf-8?B?MVFIdk00dTVqU0V5UExjZHBVMGlTREZHcFo2Tm1GK2crdFpyVkZyN2N2R0Iy?=
 =?utf-8?B?VDh6VlZLRjNyZ2h0a1QrNU9nWFhBenA4TGZTZEdxcDYrdmFuOTJxQ2dlQjRo?=
 =?utf-8?B?QTZUdy8zcHJhZGZhVC8rTGNDYkROSnN3UGtCZGxlZW5TYXdKQVFVVzJtZWpW?=
 =?utf-8?B?QTF4cGVNWFBmS0hpMEV4R3BlVWR3OHpNZURucm4wUG0yNVp6SHQ0WU5hQlpw?=
 =?utf-8?B?QWFQVklsZWc0aGFDUlRYaHRidnB0WU9SdE5zaEQzbnhub0JldEtvaHdmaFAr?=
 =?utf-8?B?UGVvZE44T2c5V0NpY3dzL3EvTFdoYU1yYm5NdXgxOHRTRGhkOG5HT0o0TUlz?=
 =?utf-8?B?ZEVhWkQyMXVreURuc2JHYXlpaGpUdXk4U2NDTjVGbndjbnpHbGxhSUxrdmRx?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E98B296FEA0F46418D8DA4810DEE62D3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96b898f-2189-4af6-74e6-08dc8b2d4f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 22:16:29.5949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSYsJUdxZeS+chX/03Stb/ggwfcZrWqahduxyp0/Qog+RW1ahJD+VxcYebUfG7aChE7ZyeTWaXH5Qz3M/4BiYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5814
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTIzIGF0IDIzOjM2ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VHVlLCBBcHIgMDksIDIwMjQgYXQgMDc6Mzk6NDJQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBGcm9tOiBYdSBZaWx1biA8eWlsdW4ueHVAaW50ZWwuY29tPg0KPiA+IA0KPiA+IERG
TCBwb3J0cyBhcmUgcmVnaXN0ZXJlZCBhcyBwbGF0Zm9ybSBkZXZpY2VzIGluIFBGIG1vZGUuIFRo
ZSBwb3J0IGRldmljZQ0KPiA+IHNob3VsZCBiZSByZW1vdmVkIGZyb20gdGhlIGhvc3Qgd2hlbiB0
aGUgdXNlciB3YW50cyB0byBjb25maWd1cmUgdGhlDQo+ID4gcG9ydCBhcyBhIFZGIGFuZCBwYXNz
IHRocm91Z2ggdG8gYSB2aXJ0dWFsIG1hY2hpbmUuIFRoZSBGTUUgZGV2aWNlDQo+ID4gaW9jdGxz
IERGTF9GUEdBX0ZNRV9QT1JUX1JFTEVBU0UvQVNTSUdOIGFyZSBkZXNpZ25lZCBmb3IgdGhpcyBw
dXJwb3NlLg0KPiA+IA0KPiA+IEluIHRoZSBwcmV2aW91cyBpbXBsZW1lbnRhdGlvbiwgdGhlIHBv
cnQgcGxhdGZvcm0gZGV2aWNlIGlzIG5vdCBjb21wbGV0ZWx5DQo+ID4gZGVzdHJveWVkIG9uIHBv
cnQgcmVsZWFzZTogaXQgaXMgcmVtb3ZlZCBmcm9tIHRoZSBzeXN0ZW0gYnkNCj4gPiBwbGF0Zm9y
bV9kZXZpY2VfZGVsKCksIGJ1dCB0aGUgcGxhdGZvcm0gZGV2aWNlIGluc3RhbmNlIGlzIHJldGFp
bmVkLg0KPiA+IFdoZW4gdGhlIHBvcnQgYXNzaWduIGlvY3RsIGlzIGNhbGxlZCwgdGhlIHBsYXRm
b3JtIGRldmljZSBpcyBhZGRlZCBiYWNrIGJ5DQo+ID4gcGxhdGZvcm1fZGV2aWNlX2FkZCgpLCB3
aGljaCBjb25mbGljdHMgd2l0aCB0aGlzIGNvbW1lbnQgb2YgZGV2aWNlX2FkZCgpOg0KPiA+ICJE
byBub3QgY2FsbCB0aGlzIHJvdXRpbmUgbW9yZSB0aGFuIG9uY2UgZm9yIGFueSBkZXZpY2Ugc3Ry
dWN0dXJlIiwgYW5kDQo+ID4gd2lsbCBjYXVzZSBhIGtlcm5lbCB3YXJuaW5nIGF0IHJ1bnRpbWUu
DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCB0cmllcyB0byBjb21wbGV0ZWx5IHVucmVnaXN0ZXIgdGhl
IHBvcnQgcGxhdGZvcm0gZGV2aWNlIG9uDQo+ID4gcmVsZWFzZSBhbmQgcmVnaXN0ZXJzIGEgbmV3
IG9uZSBvbiBhc3NpZ24uIEJ1dCB0aGUgbWFpbiB3b3JrIGlzIHRvIHJlbW92ZQ0KPiA+IHRoZSBk
ZXBlbmRlbmN5IG9uIHN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhIGZvciBtYW55IGlu
dGVybmFsIERGTA0KPiA+IEFQSXMuIFRoaXMgc3RydWN0dXJlIGhvbGRzIG1hbnkgREZMIGVudW1l
cmF0aW9uIGluZm9zIGZvciBmZWF0dXJlIGRldmljZXMuDQo+ID4gTWFueSBERkwgQVBJcyBhcmUg
ZXhwZWN0ZWQgdG8gd29yayB3aXRoIHRoZXNlIGluZm8gZXZlbiB3aGVuIHRoZSBwb3J0DQo+ID4g
cGxhdGZvcm0gZGV2aWNlIGlzIHVucmVnaXN0ZXJlZC4gQnV0IHdpdGggdGhlIGNoYW5nZSB0aGUg
cGxhdGZvcm1fZGF0YSB3aWxsDQo+ID4gYmUgZnJlZWQgaW4gdGhpcyBjYXNlLiBTbyB0aGlzIHBh
dGNoIGludHJvZHVjZXMgYSBuZXcgc3RydWN0dXJlDQo+ID4gZGZsX2ZlYXR1cmVfZGV2X2RhdGEg
Zm9yIHRoZXNlIEFQSXMsIHdoaWNoIGFjdHMgc2ltaWxhcmx5IHRvIHRoZSBwcmV2aW91cw0KPiA+
IGRmbF9mZWF0dXJlX3BsYXRmb3JtX2RhdGEuIFRoZSBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRh
IHRoZW4gb25seSBuZWVkcyBhDQo+ID4gcG9pbnRlciB0byBkZmxfZmVhdHVyZV9kZXZfZGF0YSB0
byBtYWtlIHRoZSBmZWF0dXJlIGRldmljZSBkcml2ZXIgd29yay4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBYdSBZaWx1biA8eWlsdW4ueHVAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFJ1c3MgV2VpZ2h0IDxydXNzZWxsLmgud2VpZ2h0QGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBQZXRlciBDb2xiZXJnIDxwZXRlci5jb2xiZXJnQGludGVsLmNvbT4NCj4gPiAtLS0NCj4g
PiB2MjoNCj4gPiAtIFNwbGl0IG1vbm9saXRoaWMgcGF0Y2ggaW50byBzZXJpZXMgYXQgcmVxdWVz
dCBvZiBtYWludGFpbmVyDQo+ID4gLSBTdWJzdGl0dXRlIGJpbmZvLT50eXBlIGZvciByZW1vdmVk
IGZ1bmN0aW9uIGZlYXR1cmVfZGV2X2lkX3R5cGUoKSBpbg0KPiA+ICAgcGFyc2VfZmVhdHVyZV9p
cnFzKCkuDQo+ID4gLSBSZXR1cm4gRVJSX1BUUigtRU5PTUVNKSBvbiAhZmVhdHVyZS0+cGFyYW1z
IGluDQo+ID4gICBiaW5mb19jcmVhdGVfZmVhdHVyZV9kZXZfZGF0YSgpLg0KPiA+IC0gUmVvcmRl
ciBjZGV2IGFzIGZpcnN0IG1lbWJlciBvZiBzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0
YQ0KPiA+ICAgc3VjaCB0aGF0IGNvbnRhaW5lcl9vZigpIHRvIG9idGFpbiBwZGF0YSBldmFsdWF0
ZXMgdG8gYSBuby1vcC4NCj4gPiAtIEFsaWduIGtlcm5lbC1kb2MgZnVuY3Rpb24gbmFtZSBmb3Ig
X19kZmxfZnBnYV9jZGV2X2ZpbmRfcG9ydF9kYXRhKCkuDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
ZnBnYS9kZmwtYWZ1LW1haW4uYyB8ICAgOSArLQ0KPiA+ICBkcml2ZXJzL2ZwZ2EvZGZsLWZtZS1i
ci5jICAgfCAgMjQgKy0NCj4gPiAgZHJpdmVycy9mcGdhL2RmbC1mbWUtbWFpbi5jIHwgICA2ICst
DQo+ID4gIGRyaXZlcnMvZnBnYS9kZmwuYyAgICAgICAgICB8IDQzMCArKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgZHJpdmVycy9mcGdhL2RmbC5oICAgICAgICAgIHwg
IDg2ICsrKysrLS0tDQo+ID4gIDUgZmlsZXMgY2hhbmdlZCwgMjgxIGluc2VydGlvbnMoKyksIDI3
NCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2RmbC1h
ZnUtbWFpbi5jIGIvZHJpdmVycy9mcGdhL2RmbC1hZnUtbWFpbi5jDQo+ID4gaW5kZXggNDI5Mjhj
YzdlNDJiLi5lYWQwM2I3YWVhNzAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9mcGdhL2RmbC1h
ZnUtbWFpbi5jDQo+ID4gKysrIGIvZHJpdmVycy9mcGdhL2RmbC1hZnUtbWFpbi5jDQo+ID4gQEAg
LTE0Myw5ICsxNDMsOCBAQCBzdGF0aWMgaW50IHBvcnRfcmVzZXQoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gPiAgCXJldHVybiByZXQ7DQo+ID4gIH0NCj4gPiAgDQo+ID4gLXN0YXRp
YyBpbnQgcG9ydF9nZXRfaWQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiArc3Rh
dGljIGludCBwb3J0X2dldF9pZChzdHJ1Y3QgZGZsX2ZlYXR1cmVfZGV2X2RhdGEgKmZkYXRhKQ0K
PiA+ICB7DQo+ID4gLQlzdHJ1Y3QgZGZsX2ZlYXR1cmVfZGV2X2RhdGEgKmZkYXRhID0gdG9fZGZs
X2ZlYXR1cmVfZGV2X2RhdGEoJnBkZXYtPmRldik7DQo+ID4gIAl2b2lkIF9faW9tZW0gKmJhc2U7
DQo+ID4gIA0KPiA+ICAJYmFzZSA9IGRmbF9nZXRfZmVhdHVyZV9pb2FkZHJfYnlfaWQoZmRhdGEs
IFBPUlRfRkVBVFVSRV9JRF9IRUFERVIpOw0KPiA+IEBAIC0xNTYsNyArMTU1LDggQEAgc3RhdGlj
IGludCBwb3J0X2dldF9pZChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICBzdGF0
aWMgc3NpemVfdA0KPiA+ICBpZF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmlj
ZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikNCj4gPiAgew0KPiA+IC0JaW50IGlkID0gcG9y
dF9nZXRfaWQodG9fcGxhdGZvcm1fZGV2aWNlKGRldikpOw0KPiA+ICsJc3RydWN0IGRmbF9mZWF0
dXJlX2Rldl9kYXRhICpmZGF0YSA9IHRvX2RmbF9mZWF0dXJlX2Rldl9kYXRhKGRldik7DQo+ID4g
KwlpbnQgaWQgPSBwb3J0X2dldF9pZChmZGF0YSk7DQo+IA0KDQpUaGFuayB5b3UgZm9yIHRoZSBj
b21wcmVoZW5zaXZlIHJldmlldy4NCg0KPiBNeSBxdWljayBpZGVhIGlzIHdlIGdvIHdpdGggdGhl
c2Ugc3RlcHM6DQo+IDEuIHJlZmFjdG9yIHN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRh
IHRoZW4gcmVwbGFjZSBhbGwgZGV2L3BkZXYNCj4gICAgYXJndW1lbnRzIHdpdGggcGRhdGEgd2hl
biBuZWNlc3NhcnkuDQoNCkNvdWxkIHlvdSBvdXRsaW5lIGhvdyBmYXIgdGhlIHJlZmFjdG9yaW5n
IHNob3VsZCBnbz8gVGhlIG1haW4gY2hhbmdlcw0KYXJlIGludHJvZHVjZWQgd2l0aCB0aGUgZGVz
dHJ1Y3Rpb24gb2YgdGhlIHBsYXRmb3JtIGRldmljZSBvbiBwb3J0DQpyZWxlYXNlLiBJZiB0aGUg
cmVmYWN0b3JpbmcgcmV0YWlucyB0aGUgcGxhdGZvcm0gZGV2aWNlIGJ1dCBhZGRzIGFsbA0KdGhl
IG5ldyBtZW1iZXJzIHRvIHBkYXRhLCBJIGZpbmQgdGhhdCB0aGlzIHBhdGNoIHdvdWxkIGludHJv
ZHVjZSBub24tDQp0cml2aWFsIGludGVybWVkaWF0ZSBjb2RlIHRoYXQgaXMgdGhlbiBkZWxldGVk
IGluIGEgc3Vic2VxdWVudCBwYXRjaC4NCg0KPiAyLiBmYWN0b3Igb3V0IGZkYXRhIGZyb20gcGRh
dGEsIGFkZCBmZGF0YSBoZWxwZXJzLg0KPiAzLiBtYXNzaXZlIHBkYXRhLT5mZGF0YSByZXBsYWNl
bWVudC4NCj4gNC4gZGVsZXRlIGFsbCB1bnVzZWQgcGRhdGEgaGVscGVycy4NCg0KVGhlIChyb3Vn
aGx5KSByZXZlcnNlIG9yZGVyIHNlZW1zIHRvIHByb2R1Y2UgdGhlIHNtYWxsZXN0IHBhdGNoIHNl
dDoNCg0KMS4gUmVwbGFjZSBmdW5jdGlvbiBhcmd1bWVudCBgc3RydWN0IGRldmljZSAqZGV2YCB3
aXRoIGBzdHJ1Y3QNCmRmbF9mZWF0dXJlX3BsYXRmb3JtX2RhdGEgKnBkYXRhYCBhcyBuZWVkZWQu
DQoyLiAjZGVmaW5lIGRmbF9mZWF0dXJlX2Rldl9kYXRhIGRmbF9mZWF0dXJlX3BsYXRmb3JtX2Rh
dGEgYW5kIG1hc3NpdmUNCnBkYXRhIC0+IGZkYXRhIHJlcGxhY2VtZW50Lg0KMy4gUmVtb3ZlICNk
ZWZpbmUgZGZsX2ZlYXR1cmVfZGV2X2RhdGEsIGZhY3RvciBvdXQgZGZsX2ZlYXR1cmVfZGV2X2Rh
dGENCmZyb20gZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSwgYW5kIGRlc3Ryb3kgcGxhdGZvcm0g
ZGV2aWNlIG9uIHJlbGVhc2UuDQoNClRoYW5rcywNClBldGVyDQo=

