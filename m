Return-Path: <linux-fpga+bounces-728-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ADB97CEDA
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 23:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732F71F2141A
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 21:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF1813C3CD;
	Thu, 19 Sep 2024 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOYf39vD"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4077C1CAA6;
	Thu, 19 Sep 2024 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782589; cv=fail; b=dZQWjT9rfCwbsPPEw3Dj6Q/tflGOxWva8jQsL3EJ2xQy88qShw60dgSRzTP2tupPXtDkmR/+YSAjsGrvvsKDrwRWKSPILbnHDk9Q4RvdPbeXJI4FaVGDOZUQ2+NKuYOgfyS8+UJfgbwZxQL+cjr3S0yn3AS1upcPtOPlldezUA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782589; c=relaxed/simple;
	bh=ovFqjQfEzsNlwlBRxofgMYoIIYwu3I5cxV/JtFb8byE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z7hkxY5d5nXJyCJdKxozXdZdPjjw3uwenniE1XfjNNiyriuJ81Eun/19ZSjVcxS17pc/mKfbvZ9jqwctlRQx2HDiOM6BKwUll+seb7sPXdboaYKWf1VgJzj821jKk4F1XBrDws9S+5tFFDwvKpIMgAWTjmae6xREvhTBWJhaptI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOYf39vD; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726782587; x=1758318587;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ovFqjQfEzsNlwlBRxofgMYoIIYwu3I5cxV/JtFb8byE=;
  b=bOYf39vDnTqLgAxKtyvk+DfjCl6DUBVLCAL8Ax61XBLqUH7BGwfNHRg1
   YGNCLm679XxTTZPV8Hf958BMTNkvzilK+rTIfi5tHKU8txU20OnIk3DIj
   4glOBimudHTfv07zXvOlqTv+WtJUvId4sJMiIJ720xn/sBOzahhfPkCAt
   Yn6jKvF9M7t+uC/hDnMrRnz9tPhlhXEeJEOzAvupOMLIwllEh/F1v1vPP
   BpmpjZSQwTAZcRpiZOV0MW7MC0TlqKZlBXm0FQSQ2HoYISxhbc1kQi1iM
   ZEArUaMCNX41on1lFJFwLdfKvsxrR8JIMTLaql2rdaiYs2uDUq3W1vyFO
   A==;
X-CSE-ConnectionGUID: f0ZHYd7nTWOneQBhjeoqgQ==
X-CSE-MsgGUID: C3VwSWigSpyOoy6EP15btg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="48305564"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="48305564"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:49:46 -0700
X-CSE-ConnectionGUID: XzqH+6kERuStKa8M7GFAtA==
X-CSE-MsgGUID: yd/aSb71QRGsA0U93eQGpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="74866375"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 14:49:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 14:49:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 14:49:46 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 14:49:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ig40N2yjGqMgMJ17TQnOzItbK2IR8yhehriOhhCdnxPhZCLsYJ4sp+USDqbcYuOUM/tI2m+2JvcEJqhHGPuBaXmrO4xRolEDE/wvhKc1l6/cw+kaMQepzeQFn9MpAMT2mnSBT4uHEiv3p0ly5uMOJejO15XciqwF0SZjRAnWm51sFIP3KL43Ek/WPNi8TK6v/g3gY5SbQpAHEmuY1uUxa5coILTO7eZvKJgdIxI+IFBgc5/tkKvM1qIZw7AO6n3wJlYjmCZwDhTlUJJiN1OH1WHOWluNTNPuwt4qlVX+1us4Hu4VGG+G+yC/tOTI5lHJsse1aKUzum6XU09x9LBJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovFqjQfEzsNlwlBRxofgMYoIIYwu3I5cxV/JtFb8byE=;
 b=ULpCQG1hdepRmfj0jvnn+RXvHKHUocSz7mjK7d/sxb39PkL6zW5NdTXqj5fihleclYs/vMvN2pXQRpo3SAlbNJx/eul+/sG5tKuFGFPsQKWUk3uSNb8g+QI9JgoFCpdeAitutmfBTBo9Y+B5oX+wFZJp/ZaHuHvM9dX46iAC17nE3MXWFzXuI8bp4t9ItDtLPYk/wn3/XtXJ93CR+rH6YULBpkLh+fcWZfL7IZaHK/BmgJD11moZZShKqB/rStslS+q2ArF6XCU2XzvUwy7Yv/5a6Szk249CK+ZncDCQ1XFWVIwZHQMHMRMXY9fxEK/RCF3pVA36FliRZdxv+WUuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 21:49:42 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%5]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 21:49:42 +0000
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
Thread-Index: AQHbCt3Vx6V/N2p970+ggb0U71rOWQ==
Date: Thu, 19 Sep 2024 21:49:42 +0000
Message-ID: <21e1306333d397858a906bb17bc3a6908b18be22.camel@intel.com>
References: <20240409233942.828440-1-peter.colberg@intel.com>
	 <20240409233942.828440-10-peter.colberg@intel.com>
	 <ZifVYiMgssOFjM17@yilunxu-OptiPlex-7050>
	 <97093c23ae13a1fdcc52f85e5658a39e8a5ce716.camel@intel.com>
	 <ZmuuqlMJ4nU6m25U@yilunxu-OptiPlex-7050>
In-Reply-To: <ZmuuqlMJ4nU6m25U@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|MW4PR11MB5892:EE_
x-ms-office365-filtering-correlation-id: b65809dd-f1d0-4b36-3cb5-08dcd8f4f836
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eGdvYS8yZ05zY2c1bm9UcHVzMC9kTGhVYUhzZFBwK2p6L201ckFPQTRscktq?=
 =?utf-8?B?RmVoUitvbjlHcktFRmVtU3RCQ3FuOU1RS2h3WHNYWGR3UUlaSXNUK0x6Zlpr?=
 =?utf-8?B?TlNEZkx0RzJyd3I5REZkSWJjTWZ6MkE5NXMzTTI2WFFuUlhEcHhDQnhKSG9C?=
 =?utf-8?B?aEphcm1KYk5EVFJsZkc3V1RFUmRzZ1NOcTVNM0lMYWxKM1czSk9TeHZOUE1O?=
 =?utf-8?B?cHhQSjNGQ2JHOGpNNkdFajFkZVhGcnduT3JYb0V6QUh6NmJTbjE0MUVnbzFm?=
 =?utf-8?B?Smk4NVpKL3RVU085WkpNNjh5N3BWbUtmbC9vT3RSeWhuVUxJN09tejdQeEpw?=
 =?utf-8?B?eEdMMVdZQWlNZjU1Qk9EUWsvekMzTmloNXlDSFlsdXNuWktLNzhBWCtzTGlo?=
 =?utf-8?B?QmtOaFpRT2dpNjdVODZQM1Q0Z3NTMHpBa3Qwc2RrSUZZRmh6eFdRS3kzckZI?=
 =?utf-8?B?M0tBNnNVQkE2UlRHTVNnR0FRTjBwWDliVUxPcGR6RTF4aFYwQVJrRFdTMVE1?=
 =?utf-8?B?Vk03c0FYekJOTlg2RWQvWUxqS0FVUHFaZjV2WU5WV1FNd1lWN2t6eW51ZWR4?=
 =?utf-8?B?SitwNDk5VUExWk4reGtOKzNvYUxPOUU2b0NQZFMvTUxta2FlQ3M3Z3VRVTdV?=
 =?utf-8?B?YmhnbFdqV2dnVGY3ajZ3ZXoxRUNsaVlsUGlWMGV4ZXZ5aXZLRnQxeitWbkdR?=
 =?utf-8?B?d2kyV3AyNEFTeTFDNm5TOUtZTVhBdldxd013SWZyNXcvcHVsSE5iSUFNOFVW?=
 =?utf-8?B?MGQ2QUFDdXIzT0JUUGpNcUNmUitieGhYYzZ6REk4SnBqV0NoMHREUHRjY1NL?=
 =?utf-8?B?OER0K3BVSGhWYmk4L0liYWlKbnhrdzZ6WkxMQlZzdllTQmpEa2FLSFJ0eE5P?=
 =?utf-8?B?NmxFUXZjd0prcWZDTEdHbnZ4bHI0U2JuaGw3R0NMa0FMY1AyMWs2VXdRNUpJ?=
 =?utf-8?B?Q2RWT09GU2cvQW9GODBDMHVYcmFwMkZqTm9kV1BxVkc0bnJyY2lsNVN4WEQ1?=
 =?utf-8?B?VGdHUytqd1kwV2VwaUU2M0kxUUp0U2ZxUlFwZk1aMkZha2pZQ00vVXpVN1dP?=
 =?utf-8?B?QUFzU2JIY2xyU0tuclcvZTNja1didXhONWpYR3I0YkJuOTdYbExhSHMvR2E2?=
 =?utf-8?B?LzVWL2hRWkFQSmFFTDdtcFMyUFdVZFl1UkpZRHhJbG15Z2syaG9iR2ZNRkJv?=
 =?utf-8?B?cjFqMzhwSzBOZDBRT0lhc1llWEdjVTd3bVVld1hpWlYxNUNPem95aFBwMGc2?=
 =?utf-8?B?L1RoSzdaSmZ6VUFWSG1DT2k3MFJuOCtyMEEwSm9zSUVhc0FhUElwaCt0VzFm?=
 =?utf-8?B?ei9FVk40dzhPWmxLeGhXQkdyNTJVdFA1ckxsQkkybXl3UzRXV0J3MW9ENkxW?=
 =?utf-8?B?UlVSV01qVHc3YVR6Y2t2TGpuZ1RiV0N4eWttNC8wS0JSRmp3TTJ4d1BNcjdI?=
 =?utf-8?B?eEpIdEtsRHZCRU5tZE5pNDF6R2dZZHlEVnIxelZOQVZ5Rnd4cnljSnNjZUZG?=
 =?utf-8?B?VjVqclk3Z0tZWElCUGRuWmNrSk05MURYL3JSM01kTU90SkJJdGI0RGdId2lY?=
 =?utf-8?B?dEtoSlFzTUFjd2cxVlZxdTZ6NXphdXpyS096R25pSmhLcUVFY0lYT29oOVVq?=
 =?utf-8?B?RXNTMWdnU3JxRlhXQ1g2RkdGa0Z2N21seVZjdzBsZ2hSQjRhbVR4UmJ3bExF?=
 =?utf-8?B?enFxU1p3T011V3BHTGIxNXlhQ1NJN1g0V3dHbXUvTGhtSEVQL2NqZ0pxRmVl?=
 =?utf-8?B?YzZGVmIrME9YNUhVNmlkVGhZQzdiQ0RqTDNVRGxwYitlQ2piTVpOcXRjcVJq?=
 =?utf-8?B?VERYK2ZSZUQ2RWhzN3VzcXd6Z0s1ZTAzMjg2ckJvdGt2Wk14TDJFV2V0My9R?=
 =?utf-8?B?NVVRaUJzQ3RWL041TlVRME5YOWl5Yk5nbGRWNFM0Z1pMcmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0ZmKzdnVmJQT1BuUHE2Znl3MGJIYVpDNnN6UjN0MzgzNkQrU2FWTGdNTzFW?=
 =?utf-8?B?VEFTdFViRFJKZjFpa1RPK3R3TUR4SVpLQ0pmam5Ha2NRZFdoYkVGNDBla0hL?=
 =?utf-8?B?Y1VwSE5RdWlUalNpRkg3ODBaZklLL1g2ODdqak9OdFUzL0lRZ3YwU2dKTmRT?=
 =?utf-8?B?VXoyZHhnR1A1dk5YYjB0WGFIU28ybEd0TXhZMytSTUl0c1dyZWx0WXZFK082?=
 =?utf-8?B?L1JpV1lzcC82Ui9iSVlEbHo1YmltankrNUx0bVlma09iUXZwd1FXb0dpSmQz?=
 =?utf-8?B?Wmw4a0Irc3piNGlleU1RcnhOZXZoUHVyQWRPL1pWZ3kwQnplOHk0aFBleGhC?=
 =?utf-8?B?MWl3MTZnZVNmN3Z6OTdYM3hvRkptNkk1N0Q0RHQrcFU3dWdpYTBqcUoxZGV5?=
 =?utf-8?B?TXdnQWlaMjVXQ2g3NVo4bWZ1M0dPRHNWQ25LWVFoMVRWQXgvYzcvMHl0M0Z0?=
 =?utf-8?B?M2NYQmhsSGkzd2pUUUQ4TVY0dmNocjdmejRzU3lJWnYzNGZUdkx0cWhvcmZk?=
 =?utf-8?B?ZDkyb1RlemQ5L3JDZzZtWFhOeG90WHBHOVR3TVg0OHhzVHUycWtZV3ErMjYz?=
 =?utf-8?B?YjBpa3FYR09uUmFwZU9ERENPbEdOK1F4RUQ5UnpGZ0xzMXNLcStOUC8weHJE?=
 =?utf-8?B?QlNRaS9uOHFyTUtmSkY5eUJTditHQWozWkZWRkZCMXpyNGhqYVQrQXdBQmNC?=
 =?utf-8?B?SkF0KzdQSjBoM01hS3ZWWGVUQW9vbEJMUUpWK3M3NTFlVVE1RWFuYXgyWXRX?=
 =?utf-8?B?RlNCaktwRXZId1VzYkhyQjVUbTdKc05zUlFQekVlK29HclFMY1RmQ1F2MVVi?=
 =?utf-8?B?RElDOCthNmFKVzRidWgzYXRRZ2JNR0p2RUtVQ2lVVUtCR2M4SFBrZEp1cllC?=
 =?utf-8?B?VERWTTlCUnR6VHJYZzJZWm91TnhSSFROeHpnTlVNLzRTdjlCVVZObHJGbk1F?=
 =?utf-8?B?VVpRb2hBanl0c1B1cE9PUG9jaEJ2TG9XQ3Bic0xBeDZUZVFZS2dpQmhqUXYr?=
 =?utf-8?B?RzRhMGdpaEh1VW5KWHc4WDVKSkt5L1pDTWRBVWJxbVAvOXRhZi9XOXFrZHp6?=
 =?utf-8?B?UWZCZHJjZXhYS1ZvdHJXbG1vck1taWxXVVZRZWh6UlpncFJ2TGVIdVJzZW83?=
 =?utf-8?B?TXo5cnpSdklpdFN6WjFRV21VUWVNcWFIUmtiaUpneW1xc1RaTGxXaUZzdm93?=
 =?utf-8?B?MU9ONXp3OTFxMDA5WEViVU1pcVlEOWVLTDZPVHBublZ4ZmtLR3d1L1dla0Js?=
 =?utf-8?B?Y0JwaE16cU13bW5nUXB3S3M0RDJaaWplcnhvbnhJeGlzVG0yUC9PZGs0bjhK?=
 =?utf-8?B?cjR3dUNCZUlFemJNNG9mUWx0VUtodTlldHZjVkV1OUlpbEZHUVhjaHhmUEdq?=
 =?utf-8?B?d01xZ0VQNnBnU1lzR0QrK0NJem96cUJOQWsrbTQyM25rVzZIR0dIbFNXMmJJ?=
 =?utf-8?B?VWxCRXAwTkY1SnFYR3pnRksxZ2dIZU5FMEY3QW9FWGxSalBnVzFFa2NQenVL?=
 =?utf-8?B?YnBhNDVlSkRYUFVvYWVHUnhLaW9uMm5aVCtwQnk3dHhIaTlWdXUwWGRLVldi?=
 =?utf-8?B?T3d4NldNZXVoRHFZRFROeUE5My9HR0g2d3Q5enpGN3ZUaTFvWC9FNHNNVkZW?=
 =?utf-8?B?QlcyaERuSVpqUEFsdUhJZjJvUU5jVWRnMlV1b2poczZaM1Q1bXlJSnR3TkZs?=
 =?utf-8?B?NGtXcC91S3dKS1Z5b1lNbFFyQzBoQUVzenN1aXcvdmd4ZXJiVWE0MjdzTUMz?=
 =?utf-8?B?MTFEbTE5ZWFtWi9ZbHJnemd5Sk1FZ2tsZjRDNmZvdHBMdDVzbkVTSjkwUFNv?=
 =?utf-8?B?UHliUDJkVGtHbkFZWDZCd2pSK29aN3VxYXI4N0dhK2JvdVR4MWVYS2Z3dUlN?=
 =?utf-8?B?UHExUk02MFRsb08wY3Q2ZFZRcEFMbkRxc1lYdzhmL3hXRXJta1h3Wjh6Qmp5?=
 =?utf-8?B?UENyMDFRTjlET0VVK1ZvUWRldVB3a291YkN6WVJyMFU5anRWWkhiK1pBbnQw?=
 =?utf-8?B?Zzl2VjJjenk0YmxqMUYrQlhHY0x5VjFGTlBac0wybjdSUE93QTUzWW8wRWpu?=
 =?utf-8?B?Y2I5dkxGYSsxc3R5cFg4Z1VJR2ZNcllRTnRvREE1enRXMElNWmNEemViYm1U?=
 =?utf-8?B?NVYwSkRNVkRVQkJPOGIvTnVEYUZpUVE1Z3VUNHlLT0R6Z0xWS1UrOXJuOGdj?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBB6370032FCC54F92E9A14B016A7C4C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65809dd-f1d0-4b36-3cb5-08dcd8f4f836
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 21:49:42.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGKkkQsm5VM2T6BSLtnZXP1oRKoWrOn+csxdai3nT9Cm7Atm3DaR63y9sE+QrIEq5ttkuwJ722yj9iFFk6H7ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA2LTE0IGF0IDEwOjQ0ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
V2VkLCBKdW4gMTIsIDIwMjQgYXQgMTA6MTY6MjlQTSArMDAwMCwgQ29sYmVyZywgUGV0ZXIgd3Jv
dGU6DQo+ID4gT24gVHVlLCAyMDI0LTA0LTIzIGF0IDIzOjM2ICswODAwLCBYdSBZaWx1biB3cm90
ZToNCj4gPiA+IE9uIFR1ZSwgQXByIDA5LCAyMDI0IGF0IDA3OjM5OjQyUE0gLTA0MDAsIFBldGVy
IENvbGJlcmcgd3JvdGU6DQo+ID4gPiA+IEZyb206IFh1IFlpbHVuIDx5aWx1bi54dUBpbnRlbC5j
b20+DQo+ID4gPiA+IA0KPiA+ID4gPiBERkwgcG9ydHMgYXJlIHJlZ2lzdGVyZWQgYXMgcGxhdGZv
cm0gZGV2aWNlcyBpbiBQRiBtb2RlLiBUaGUgcG9ydCBkZXZpY2UNCj4gPiA+ID4gc2hvdWxkIGJl
IHJlbW92ZWQgZnJvbSB0aGUgaG9zdCB3aGVuIHRoZSB1c2VyIHdhbnRzIHRvIGNvbmZpZ3VyZSB0
aGUNCj4gPiA+ID4gcG9ydCBhcyBhIFZGIGFuZCBwYXNzIHRocm91Z2ggdG8gYSB2aXJ0dWFsIG1h
Y2hpbmUuIFRoZSBGTUUgZGV2aWNlDQo+ID4gPiA+IGlvY3RscyBERkxfRlBHQV9GTUVfUE9SVF9S
RUxFQVNFL0FTU0lHTiBhcmUgZGVzaWduZWQgZm9yIHRoaXMgcHVycG9zZS4NCj4gPiA+ID4gDQo+
ID4gPiA+IEluIHRoZSBwcmV2aW91cyBpbXBsZW1lbnRhdGlvbiwgdGhlIHBvcnQgcGxhdGZvcm0g
ZGV2aWNlIGlzIG5vdCBjb21wbGV0ZWx5DQo+ID4gPiA+IGRlc3Ryb3llZCBvbiBwb3J0IHJlbGVh
c2U6IGl0IGlzIHJlbW92ZWQgZnJvbSB0aGUgc3lzdGVtIGJ5DQo+ID4gPiA+IHBsYXRmb3JtX2Rl
dmljZV9kZWwoKSwgYnV0IHRoZSBwbGF0Zm9ybSBkZXZpY2UgaW5zdGFuY2UgaXMgcmV0YWluZWQu
DQo+ID4gPiA+IFdoZW4gdGhlIHBvcnQgYXNzaWduIGlvY3RsIGlzIGNhbGxlZCwgdGhlIHBsYXRm
b3JtIGRldmljZSBpcyBhZGRlZCBiYWNrIGJ5DQo+ID4gPiA+IHBsYXRmb3JtX2RldmljZV9hZGQo
KSwgd2hpY2ggY29uZmxpY3RzIHdpdGggdGhpcyBjb21tZW50IG9mIGRldmljZV9hZGQoKToNCj4g
PiA+ID4gIkRvIG5vdCBjYWxsIHRoaXMgcm91dGluZSBtb3JlIHRoYW4gb25jZSBmb3IgYW55IGRl
dmljZSBzdHJ1Y3R1cmUiLCBhbmQNCj4gPiA+ID4gd2lsbCBjYXVzZSBhIGtlcm5lbCB3YXJuaW5n
IGF0IHJ1bnRpbWUuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIHBhdGNoIHRyaWVzIHRvIGNvbXBs
ZXRlbHkgdW5yZWdpc3RlciB0aGUgcG9ydCBwbGF0Zm9ybSBkZXZpY2Ugb24NCj4gPiA+ID4gcmVs
ZWFzZSBhbmQgcmVnaXN0ZXJzIGEgbmV3IG9uZSBvbiBhc3NpZ24uIEJ1dCB0aGUgbWFpbiB3b3Jr
IGlzIHRvIHJlbW92ZQ0KPiA+ID4gPiB0aGUgZGVwZW5kZW5jeSBvbiBzdHJ1Y3QgZGZsX2ZlYXR1
cmVfcGxhdGZvcm1fZGF0YSBmb3IgbWFueSBpbnRlcm5hbCBERkwNCj4gPiA+ID4gQVBJcy4gVGhp
cyBzdHJ1Y3R1cmUgaG9sZHMgbWFueSBERkwgZW51bWVyYXRpb24gaW5mb3MgZm9yIGZlYXR1cmUg
ZGV2aWNlcy4NCj4gPiA+ID4gTWFueSBERkwgQVBJcyBhcmUgZXhwZWN0ZWQgdG8gd29yayB3aXRo
IHRoZXNlIGluZm8gZXZlbiB3aGVuIHRoZSBwb3J0DQo+ID4gPiA+IHBsYXRmb3JtIGRldmljZSBp
cyB1bnJlZ2lzdGVyZWQuIEJ1dCB3aXRoIHRoZSBjaGFuZ2UgdGhlIHBsYXRmb3JtX2RhdGEgd2ls
bA0KPiA+ID4gPiBiZSBmcmVlZCBpbiB0aGlzIGNhc2UuIFNvIHRoaXMgcGF0Y2ggaW50cm9kdWNl
cyBhIG5ldyBzdHJ1Y3R1cmUNCj4gPiA+ID4gZGZsX2ZlYXR1cmVfZGV2X2RhdGEgZm9yIHRoZXNl
IEFQSXMsIHdoaWNoIGFjdHMgc2ltaWxhcmx5IHRvIHRoZSBwcmV2aW91cw0KPiA+ID4gPiBkZmxf
ZmVhdHVyZV9wbGF0Zm9ybV9kYXRhLiBUaGUgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSB0aGVu
IG9ubHkgbmVlZHMgYQ0KPiA+ID4gPiBwb2ludGVyIHRvIGRmbF9mZWF0dXJlX2Rldl9kYXRhIHRv
IG1ha2UgdGhlIGZlYXR1cmUgZGV2aWNlIGRyaXZlciB3b3JrLg0KPiA+ID4gPiANCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogWHUgWWlsdW4gPHlpbHVuLnh1QGludGVsLmNvbT4NCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogUnVzcyBXZWlnaHQgPHJ1c3NlbGwuaC53ZWlnaHRAaW50ZWwuY29tPg0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBDb2xiZXJnIDxwZXRlci5jb2xiZXJnQGludGVsLmNv
bT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IHYyOg0KPiA+ID4gPiAtIFNwbGl0IG1vbm9saXRoaWMg
cGF0Y2ggaW50byBzZXJpZXMgYXQgcmVxdWVzdCBvZiBtYWludGFpbmVyDQo+ID4gPiA+IC0gU3Vi
c3RpdHV0ZSBiaW5mby0+dHlwZSBmb3IgcmVtb3ZlZCBmdW5jdGlvbiBmZWF0dXJlX2Rldl9pZF90
eXBlKCkgaW4NCj4gPiA+ID4gICBwYXJzZV9mZWF0dXJlX2lycXMoKS4NCj4gPiA+ID4gLSBSZXR1
cm4gRVJSX1BUUigtRU5PTUVNKSBvbiAhZmVhdHVyZS0+cGFyYW1zIGluDQo+ID4gPiA+ICAgYmlu
Zm9fY3JlYXRlX2ZlYXR1cmVfZGV2X2RhdGEoKS4NCj4gPiA+ID4gLSBSZW9yZGVyIGNkZXYgYXMg
Zmlyc3QgbWVtYmVyIG9mIHN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhDQo+ID4gPiA+
ICAgc3VjaCB0aGF0IGNvbnRhaW5lcl9vZigpIHRvIG9idGFpbiBwZGF0YSBldmFsdWF0ZXMgdG8g
YSBuby1vcC4NCj4gPiA+ID4gLSBBbGlnbiBrZXJuZWwtZG9jIGZ1bmN0aW9uIG5hbWUgZm9yIF9f
ZGZsX2ZwZ2FfY2Rldl9maW5kX3BvcnRfZGF0YSgpLg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRy
aXZlcnMvZnBnYS9kZmwtYWZ1LW1haW4uYyB8ICAgOSArLQ0KPiA+ID4gPiAgZHJpdmVycy9mcGdh
L2RmbC1mbWUtYnIuYyAgIHwgIDI0ICstDQo+ID4gPiA+ICBkcml2ZXJzL2ZwZ2EvZGZsLWZtZS1t
YWluLmMgfCAgIDYgKy0NCj4gPiA+ID4gIGRyaXZlcnMvZnBnYS9kZmwuYyAgICAgICAgICB8IDQz
MCArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gIGRyaXZlcnMv
ZnBnYS9kZmwuaCAgICAgICAgICB8ICA4NiArKysrKy0tLQ0KPiA+ID4gPiAgNSBmaWxlcyBjaGFu
Z2VkLCAyODEgaW5zZXJ0aW9ucygrKSwgMjc0IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9kZmwtYWZ1LW1haW4uYyBiL2RyaXZlcnMvZnBn
YS9kZmwtYWZ1LW1haW4uYw0KPiA+ID4gPiBpbmRleCA0MjkyOGNjN2U0MmIuLmVhZDAzYjdhZWE3
MCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9mcGdhL2RmbC1hZnUtbWFpbi5jDQo+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvZnBnYS9kZmwtYWZ1LW1haW4uYw0KPiA+ID4gPiBAQCAtMTQzLDkg
KzE0Myw4IEBAIHN0YXRpYyBpbnQgcG9ydF9yZXNldChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiA+ID4gPiAgCXJldHVybiByZXQ7DQo+ID4gPiA+ICB9DQo+ID4gPiA+ICANCj4gPiA+
ID4gLXN0YXRpYyBpbnQgcG9ydF9nZXRfaWQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gPiA+ID4gK3N0YXRpYyBpbnQgcG9ydF9nZXRfaWQoc3RydWN0IGRmbF9mZWF0dXJlX2Rldl9k
YXRhICpmZGF0YSkNCj4gPiA+ID4gIHsNCj4gPiA+ID4gLQlzdHJ1Y3QgZGZsX2ZlYXR1cmVfZGV2
X2RhdGEgKmZkYXRhID0gdG9fZGZsX2ZlYXR1cmVfZGV2X2RhdGEoJnBkZXYtPmRldik7DQo+ID4g
PiA+ICAJdm9pZCBfX2lvbWVtICpiYXNlOw0KPiA+ID4gPiAgDQo+ID4gPiA+ICAJYmFzZSA9IGRm
bF9nZXRfZmVhdHVyZV9pb2FkZHJfYnlfaWQoZmRhdGEsIFBPUlRfRkVBVFVSRV9JRF9IRUFERVIp
Ow0KPiA+ID4gPiBAQCAtMTU2LDcgKzE1NSw4IEBAIHN0YXRpYyBpbnQgcG9ydF9nZXRfaWQoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+ID4gIHN0YXRpYyBzc2l6ZV90DQo+ID4g
PiA+ICBpZF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUg
KmF0dHIsIGNoYXIgKmJ1ZikNCj4gPiA+ID4gIHsNCj4gPiA+ID4gLQlpbnQgaWQgPSBwb3J0X2dl
dF9pZCh0b19wbGF0Zm9ybV9kZXZpY2UoZGV2KSk7DQo+ID4gPiA+ICsJc3RydWN0IGRmbF9mZWF0
dXJlX2Rldl9kYXRhICpmZGF0YSA9IHRvX2RmbF9mZWF0dXJlX2Rldl9kYXRhKGRldik7DQo+ID4g
PiA+ICsJaW50IGlkID0gcG9ydF9nZXRfaWQoZmRhdGEpOw0KPiA+ID4gDQo+ID4gDQo+ID4gVGhh
bmsgeW91IGZvciB0aGUgY29tcHJlaGVuc2l2ZSByZXZpZXcuDQo+ID4gDQo+ID4gPiBNeSBxdWlj
ayBpZGVhIGlzIHdlIGdvIHdpdGggdGhlc2Ugc3RlcHM6DQo+ID4gPiAxLiByZWZhY3RvciBzdHJ1
Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSB0aGVuIHJlcGxhY2UgYWxsIGRldi9wZGV2DQo+
ID4gPiAgICBhcmd1bWVudHMgd2l0aCBwZGF0YSB3aGVuIG5lY2Vzc2FyeS4NCj4gPiANCj4gPiBD
b3VsZCB5b3Ugb3V0bGluZSBob3cgZmFyIHRoZSByZWZhY3RvcmluZyBzaG91bGQgZ28/IFRoZSBt
YWluIGNoYW5nZXMNCj4gPiBhcmUgaW50cm9kdWNlZCB3aXRoIHRoZSBkZXN0cnVjdGlvbiBvZiB0
aGUgcGxhdGZvcm0gZGV2aWNlIG9uIHBvcnQNCj4gDQo+IFllcywgZXhhY3RseS4gQW5kIHRoZSBn
b2FsIGlzIHRvIG1ha2UgdGhlIGNoYW5nZSBpbiBhIHN0YW5kYWxvbmUgcGF0Y2gNCj4gc28gdGhh
dCBldmVyeW9uZSBjYW4gZmluZCBpdCwgcmF0aGVyIHRoYW4gYnVyeSBpbiBvdGhlciBtYXNzaXZl
DQo+IHJlcGxhY2VtZW50cy4NCj4gDQo+ID4gcmVsZWFzZS4gSWYgdGhlIHJlZmFjdG9yaW5nIHJl
dGFpbnMgdGhlIHBsYXRmb3JtIGRldmljZSBidXQgYWRkcyBhbGwNCj4gPiB0aGUgbmV3IG1lbWJl
cnMgdG8gcGRhdGEsIEkgZmluZCB0aGF0IHRoaXMgcGF0Y2ggd291bGQgaW50cm9kdWNlIG5vbi0N
Cj4gPiB0cml2aWFsIGludGVybWVkaWF0ZSBjb2RlIHRoYXQgaXMgdGhlbiBkZWxldGVkIGluIGEg
c3Vic2VxdWVudCBwYXRjaC4NCj4gDQo+IFRoYXQgd291bGQgbm90IGJlIGEgcHJvYmxlbSwgYXMg
bG9uZyBhcyB0aGV5IGNsZWFybHkgZ2V0IGV4cGxhaW5lZCwgYW5kDQo+IGluIG9uZSBwYXRjaCBz
ZXJpZXMuIFNvbWV0aW1lcyB3ZSBuZWVkIGludGVybWVkaWF0ZSBjb2RlIHRvIGVuc3VyZSBhDQo+
IHBhdGNoIGZvciBvbmUgY2hhbmdlLCB3aGljaCBtYWtlcyBwZW9wbGUgZWFzeSB0byByZWFkLg0K
PiANCj4gPiANCj4gPiA+IDIuIGZhY3RvciBvdXQgZmRhdGEgZnJvbSBwZGF0YSwgYWRkIGZkYXRh
IGhlbHBlcnMuDQo+ID4gPiAzLiBtYXNzaXZlIHBkYXRhLT5mZGF0YSByZXBsYWNlbWVudC4NCj4g
PiA+IDQuIGRlbGV0ZSBhbGwgdW51c2VkIHBkYXRhIGhlbHBlcnMuDQo+ID4gDQo+ID4gVGhlIChy
b3VnaGx5KSByZXZlcnNlIG9yZGVyIHNlZW1zIHRvIHByb2R1Y2UgdGhlIHNtYWxsZXN0IHBhdGNo
IHNldDoNCj4gDQo+IEkgZG9uJ3QgdGhpbmsgJ3NtYWxsZXN0JyBpcyB0aGUgbWFqb3IgY29uY2Vy
biwgYnV0IGl0J3MgZmluZSBpZiB5b3UNCj4gZmlyc3RseSBhZGRyZXNzZWQgb3RoZXIgY29uY2Vy
bnMuIEkgY2Fubm90IGFjdHVhbGx5IHRlbGwgaWYgaXQgaXMNCj4gYmV0dGVyIHVudGlsIHRoZSBj
b2RlIGlzIHNlZW4uIEJ1dCB0byBlbXBoYXNpemUgb24sIHRoZSBjb3JlIGNoYW5nZSBpcw0KPiBz
cGxpdGVkIG91dCwgdGhlIG1hc3NpdmUgcmVwbGFjZW1lbnQgcGF0Y2hlcyBhcmUganVzdCByZXBs
YWNlbWVudHMgc28NCj4gdGhleSBjYW4gYmUgZWFzaWx5IG92ZXJ2aWV3ZWQgYW5kIHNraXBwZWQu
DQoNClRoYW5rIHlvdSBmb3IgdGhlIGd1aWRhbmNlLiBJIGhhdmUgcmVzdHJ1Y3R1cmVkIHRoZSBz
ZXJpZXMgdG8gbW92ZSB0aGUNCm1hc3NpdmUgcmVwbGFjZW1lbnRzIGludG8gdHdvIHBhdGNoZXMs
ICJmcGdhOiBkZmw6IHBhc3MgZmVhdHVyZQ0KcGxhdGZvcm0gZGF0YSBpbnN0ZWFkIG9mIGRldmlj
ZSBhcyBhcmd1bWVudCIgYW5kICJmcGdhOiBkZmw6IHJlZmFjdG9yDQpmdW5jdGlvbnMgdG8gdGFr
ZS9yZXR1cm4gZmVhdHVyZSBkZXZpY2UgZGF0YSIuIFRoZSBvdGhlciBwYXRjaGVzDQphZGRyZXNz
IGF1eGlsaWFyeSwgZnVuY3Rpb25hbCBhbmQgbm9uLWZ1bmN0aW9uYWwgY29uY2VybnMsIHN1Y2gg
dGhhdA0KdGhlIGZpbmFsIHBhdGNoICJmcGdhOiBkZmw6IGZpeCBrZXJuZWwgd2FybmluZyBvbiBw
b3J0IHJlbGVhc2UvYXNzaWduDQpmb3IgU1JJT1YiIGlzIG5vdyBhcyBzbWFsbCBhcyBmZWFzaWJs
ZSBhbmQgZm9jdXNlcyBvbiB0aGUgY29yZSBjaGFuZ2UuDQoNClRoYW5rcywNClBldGVyDQoNCj4g
DQo+IFRoYW5rcywNCj4gWWlsdW4gDQo+IA0KPiA+IA0KPiA+IDEuIFJlcGxhY2UgZnVuY3Rpb24g
YXJndW1lbnQgYHN0cnVjdCBkZXZpY2UgKmRldmAgd2l0aCBgc3RydWN0DQo+ID4gZGZsX2ZlYXR1
cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGFgIGFzIG5lZWRlZC4NCj4gPiAyLiAjZGVmaW5lIGRmbF9m
ZWF0dXJlX2Rldl9kYXRhIGRmbF9mZWF0dXJlX3BsYXRmb3JtX2RhdGEgYW5kIG1hc3NpdmUNCj4g
PiBwZGF0YSAtPiBmZGF0YSByZXBsYWNlbWVudC4NCj4gPiAzLiBSZW1vdmUgI2RlZmluZSBkZmxf
ZmVhdHVyZV9kZXZfZGF0YSwgZmFjdG9yIG91dCBkZmxfZmVhdHVyZV9kZXZfZGF0YQ0KPiA+IGZy
b20gZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSwgYW5kIGRlc3Ryb3kgcGxhdGZvcm0gZGV2aWNl
IG9uIHJlbGVhc2UuDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IFBldGVyDQoNCg==

