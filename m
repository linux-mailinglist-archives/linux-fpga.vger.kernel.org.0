Return-Path: <linux-fpga+bounces-915-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABC19B12F3
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18701F2347B
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F82E1D2B03;
	Fri, 25 Oct 2024 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVuMvzYM"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C11217F22;
	Fri, 25 Oct 2024 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729896215; cv=fail; b=gtC0UloeUS3+W9cHF05sa05vagfdrPRQpsN9+5+opvFwvuvhTA9SNWGTqAxs5FpeeizVHSl0MceKFO6Jf1d1mQRM27wz1R0lWziPyjDsyAarsROgINiVz7Et4VNGwZO6y/Ilmi6AG9W+xrSgO135dbkr6VudBFZYpWWMqe+i9b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729896215; c=relaxed/simple;
	bh=WmMSUMFACIItpxJBi4bGREjgcoCLhgWtQ4fJ44Npui0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oIqGrAW5r4aOj1o8uK8OWn28fOJM+zeewhcejdQMtr4ZYsb4Q3a8uhD0c/joQzXmMbg7sd6Dmsa3fTgBRXfVk3JDbYX6LT6LOLRlJ07BkjRn29rV8A5HHaxvgAS/sC4w7IeSVnEymbtExAO0m5+2piataFWkIXmZ+aWnUJ2DwLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVuMvzYM; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729896213; x=1761432213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WmMSUMFACIItpxJBi4bGREjgcoCLhgWtQ4fJ44Npui0=;
  b=gVuMvzYMKhWoy/fpky65YPuRD2hXtuK1jWwC1tK6DA2ffkX3uE/iG4sd
   r4jFQKiJ2d40UjEIC+DRhq2aIPFYFN943lxE12I2RTGLxYFX8z5gQeaCs
   qN45cJHwBP2PsrQo9JBvsDEQ+q99JJ4sFtMkVrWp/c8E5YYgo1yTh2yPV
   FEDDI+NyEHZNEEYDUYpcM8GUNs+vLjzm1tPhlofXaktSSp+brM6gJln8t
   wuYnXnz7Eb0kwWuoUe3XSR8B3NeijaLQi8rub42DUwJ5/g5JScqPbkoaV
   bshpj+r4tPFGbLJInt5Ih3z/mCTbsf0s1yj5AKXVjI0BDF16ZxDuZcxnq
   g==;
X-CSE-ConnectionGUID: iXtfk/y+TtiigWD7EfpndA==
X-CSE-MsgGUID: W7l80W1bRl+RZk6EFDyoNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40955673"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40955673"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:43:32 -0700
X-CSE-ConnectionGUID: b3ZqfVjISJq9EjV0yoihYg==
X-CSE-MsgGUID: kBCun5ltT/+pHxVYFmADqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="81348284"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 15:43:32 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 15:43:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 15:43:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 15:43:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4PwMlnCuAnjLQUdO+6fn1xFxB2KLzp8iNXuL2Mp6xJ4FoKYpeaXk5OJ+F8U2LnexoBy/P87Yu1A2cj4U+ZXGzSCIx1t75G/7FavYxcqy23qQjb98v/S0WHy8jFupslTtOOUSWAdpJLDDozrJBMhHXeCX+DMcBfk+zJ86hJdyAPz5AJsFp6yuiZtGQNSJiZdC+295mIbWqMN0NKV8KNeLwohYPUR5K5ybRURMBLCEpmLJcmU4mZHKnen7C24kc5APMZMqQ08xgTBbpMlQhlgu985LWn6eX+IGq/jqeK4WNMVRmNhhPXj45K/qVamStZsAJGQv/Xojli8vOy9pcQPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmMSUMFACIItpxJBi4bGREjgcoCLhgWtQ4fJ44Npui0=;
 b=SsDKYuU/rUYS9zNhrcKFqzSZN6vybG0Objhf20QmC+VzWYBc6Vg6DgDpiAyqTI53XZoYwB3BXcgn8BLfiDcxlm4sZIN+rRyH/O22O7r0HhEZJWg5lgmn6ccvlnZf/k8+ZroVWfsC1USR0Iq89WJBXIYRbMOYSl1rtz5ZkvRSpkahlyKTY97WwmfrmErZDAfv4rC1oE+OvZRnzbWNx0h+sDuB7MPKYV5wSvxDcrCz0JkEAyv0Oy5QgE1/QGINvC6QTzidmaArX1HdFaDiOL4a6D9AB9Opnobk3g12guQiNHw1oZnX/cfF6d0koh3y8hr3cDRob1phGifbFnsns1N5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by SA3PR11MB7463.namprd11.prod.outlook.com (2603:10b6:806:304::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 22:43:28 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%6]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 22:43:28 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao"
	<hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>,
	"trix@redhat.com" <trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v3 6/9] fpga: dfl: factor out feature data creation from
 build_info_commit_dev()
Thread-Topic: [PATCH v3 6/9] fpga: dfl: factor out feature data creation from
 build_info_commit_dev()
Thread-Index: AQHbJy9PP+x7Uge9p0K5Ah1JnRwEyw==
Date: Fri, 25 Oct 2024 22:43:28 +0000
Message-ID: <2cb783bc7d3a85226d8dfbcded551ef5b93582a6.camel@intel.com>
References: <20240919203430.1278067-1-peter.colberg@intel.com>
	 <20240919203430.1278067-7-peter.colberg@intel.com>
	 <ZvJnC7hHISkbOo2n@yilunxu-OptiPlex-7050>
In-Reply-To: <ZvJnC7hHISkbOo2n@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|SA3PR11MB7463:EE_
x-ms-office365-filtering-correlation-id: 72cf7be4-06ce-4b3e-7c26-08dcf54671a3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c2lRSXptMlgvN3hGMDl5SkdqUWEwaHVUcnhQbFd2c1kvWWlYcmdTWUVTdkJ6?=
 =?utf-8?B?eFJzNlhSUytuamxMT0Z6clNqdVE5NTlxSEpzSXlzUm5tRmNhbnlNeURTM1FO?=
 =?utf-8?B?NDc4Tk5RVkdnSzRVWGh2cjV0WGZSQWQ2N1ZENmNjdVFpRHFTb2pKb0FkUXpS?=
 =?utf-8?B?Z0NqaXNZWmQ2bjJMcUx5aXRVb1VmWmhYSThoUzZxQ3A0M0lSSW5rWnl4aXNo?=
 =?utf-8?B?ZnR6bDZINXMyY2JLS3d2T0lWZnRMQUQwQ1huNDg4amtPbkxEWmVkSHFCZ05j?=
 =?utf-8?B?elJOK3VJeXpla0d3Z0dzdzV6T2Z3TzFHWGFZaVBuSGNIcjI3YTlDcVRxUTd3?=
 =?utf-8?B?MjVOK3Vzd1NuSzlOR0hZZ2pZNTNETUpVelA0YUhRM2V6bEhUZDJmcm9QS2JK?=
 =?utf-8?B?Z2d0dk8xTmk4MG84cTRCTk9kcmJkTWRsb2NJVmFHK1duL3p4NWdpNWlydlgw?=
 =?utf-8?B?QjlXU2FaQTlzQlFlVEwvL0lrZ0JoSzRHUzRLSWpiWEpzN2EzVEVjKytjSGh3?=
 =?utf-8?B?OXhWQ202b3MzZGg0VXU0MEt1dkpNNUhGTWRuSGpzbjBPS3liNEhMd3N1cFZh?=
 =?utf-8?B?R3V1aGlKYVVRWGNhendtbUZiN3RPc3F3VEkzMTU1dVpZRkRVbFBWMXBNTUM4?=
 =?utf-8?B?UERhalVyb2hqWTNtYnpiRk53OTcvN0FtTlBrTTJHdk1rYld5Wldlam05UUYz?=
 =?utf-8?B?UGE2Ry9tYWJoMjdmLzhXanZHM3VHK2FRUEl6MUhMdktnaGIyS1NiRnNwYmlQ?=
 =?utf-8?B?NlR2bkdINnhwWTc4OU1iSThZdVArMVQ0TzE4YThyYlFuRHZKQ05WTHBObmFC?=
 =?utf-8?B?UmZUSzczWCtHQnZLZERheFFmSW96aGV2b2ViTHcyNEp0b0hZRlFLc1Y0UFcy?=
 =?utf-8?B?MktMSy9UeURtdXplUThPa1RSYVNaUnBEck1oU1JJU09lOTRydTRYcldUUEx5?=
 =?utf-8?B?SHBUMnFJZGhLb2JQZzlJTTJJVTZuUjM4dlZ2dnZoc0JySUpIa2ZGS05MUGFL?=
 =?utf-8?B?TWZGUDlwZFpFRXRnZjRRcFFJaWF1T205MEpHN2h2Y2VOZkE3UGMydGE4Y1VD?=
 =?utf-8?B?OVNabFlicmU4NS9jMngyU1VwdWhsYk5HM0dNRm5pT0d6UGxtMWRUZGFacWdu?=
 =?utf-8?B?WDdXZHRXdjZCd1ZhYmhNODRXNUdnbHNlZHlGbkVUUUtmM0xYZ3NJUWlJYlNL?=
 =?utf-8?B?QVludmcvdU10THloVWhqa29qWDdSM24ySGdHNTQ5THBRcFFETGpPVDlxUXNp?=
 =?utf-8?B?ZTdGNXhteG1lWEtuc3pmeC80K2Y4NUxhNDFsMlhoaE9ia2lmTjlIQi9PRVB4?=
 =?utf-8?B?djF5RlBBY0NyeHYzczRSVWE4RkVrREVZUHVwTGVNTThXTDczZTBQTUZtcG9j?=
 =?utf-8?B?czVZdE1tOHZocU10WlZ0K1lndHB4RVQ2VlJWbUFXRVdydzh1RE4xLy9ETzY3?=
 =?utf-8?B?NkFkQ0hVWkJNVTVBR0x6a08xek9ZSTFYNHVQMFM4dkt6L0Y5SWpUdjFXdGUy?=
 =?utf-8?B?Z2VMbnZtM3JyMkhKQmdtZjYzSnBCQ1pYZXVrTjRnUXJyUEFtOXA4VThzKzY4?=
 =?utf-8?B?VGx2Q1RLcVo3cVBjK1hnSWtNdndiTXBuajFsMGJhS3pPbEt5VW1ObHZncklw?=
 =?utf-8?B?OVhxUisrR1J4RWdhcU5WOGk4TWpCSDg1bkc0Q2lGSW03TUlvb05lSFF5RXpi?=
 =?utf-8?B?a3E2Vng2R1BFL0VzUmVBZkVKTGRSY2p1VFNPOXQvcVdGYmpXbjZlemNtc1VV?=
 =?utf-8?B?RmJRaU5GeVdDbmJEb3dFTysrSmttdEJrQUR2eDB1a1BxWGY1aUJldkU0aHFS?=
 =?utf-8?Q?T4qJ36GPkY7AnODHce7I9G+xV06o4PNn1Hfr0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWR5ajYvd2N4d3JHOXZINGhSazlObXpMVkR3bGVWT0JsOFBuUUErSndteWxJ?=
 =?utf-8?B?M0RWc1c4WXNXTG9rS3lSTVMyaFRjL2M1VjlCbVRvZzAzZkpKK1BQS1BiRGNn?=
 =?utf-8?B?ODJya3RoaEMzYzczY2kwTnZFckF1RXN3TGhlWUxoVG1QcGZwVmNTdklYL1BH?=
 =?utf-8?B?dGdkUkMxRXhmNW52L1NwUzY3d3RNK3pNMHZOTm82SjBpMjhWWE40ZzhTVW5Z?=
 =?utf-8?B?UUNXYnBURGhWdXNOUko5U1JGYmVwbGMzNExsdklwS0c4YVFHK2xwZlB1UDdI?=
 =?utf-8?B?cG5mV3NwaDZkODVobFJFVTdmRGhpWlUvNERPd1N2RjFha2tuTnlnZTlzRVBD?=
 =?utf-8?B?WU9ISzFaVFA2T0o2dzJROEUyditJV00rNWJ6U29uOXI5YUVRK0o2VDVJa1I3?=
 =?utf-8?B?S0RpYzVSVEJNeDA5b1VaV1VkaHNuMG1LVEVvbUlRRUlrZ2k5ckZvTXFEbHRZ?=
 =?utf-8?B?bUt3cTVEU2xGdTUxT1NrQjNGTmYzNkhzQ2V2N3hmNzVSb2JEbFl2UnBHK0pZ?=
 =?utf-8?B?RnNETzZuKytiV1JGZjJRNHppVmJkUHdrWnJNQnhMWjFnbkE2VEpEbUVaSGJu?=
 =?utf-8?B?dlRCa01vc0E4c2ZCVGE5dlh4NVh1ZjN3cVBwSzM2d3k5YmQ2TWZXUTBDT1ov?=
 =?utf-8?B?T1hwY2xrSkQ5ZmdEclZROTMyU2IzeDZaKzRRR0kycVZaWE9VT3FSRVV5RzFr?=
 =?utf-8?B?NTc3MXJZMUhPZEZ0RjdNakVhZXR2TE03RHgxNVFKM1Y5YVhEUDdUa0ZFWTJr?=
 =?utf-8?B?cUhLMEk0bFZKMFVPeGszRXhiRXJnYU02RTE1QjdzQ0FTdXBEMS9DdkpCalpI?=
 =?utf-8?B?dVl4TCtVaHA1K09TVlpaR0FuenJrYmk4RklUV2orZ0lKYnc1Z0E3MHVPTUpI?=
 =?utf-8?B?bk5BUFYzOXYveXdlZ25wMzBDdXYvRFA1OElsUGJEL2o4eGsxUDhwYWJWM0Zh?=
 =?utf-8?B?czhqWDlPa3hGbkRtb1RXQ1huL2x6b0dVVU9zOW5ybmF0OXU3WWJUMGc3VHZt?=
 =?utf-8?B?MS9PczB3bllTcjl6cUpWMkxRWXJ5WkFTWkNmTkt2NkRDUlJZTEcxRk8rcTlT?=
 =?utf-8?B?YjU5MmhMbWdzWDIzRWFwSCtIWkE2dGUvME52ZWptYVpTVksvNFZ2MEhOWm5E?=
 =?utf-8?B?d3dUUXp4T24xU0tkc0Vodngyb3piMFpudkZkZG41a29KaU1wMTBWZGJCdnYz?=
 =?utf-8?B?NE0yL3RoWlpOSFF1b2RuYlpDWVk4bW9SK1VaWmVWSXBlZkR0ei8vSXNMU0Fu?=
 =?utf-8?B?RVV2d2ZIemRQTEVlcWUvbXhrM3pnTnhxTWZaNlZZeHNJWE9tQ3FjaEwycFhm?=
 =?utf-8?B?cWhFeHhrNUZDQ3hzbnJaQUdYU0tCUWRLK3UvMUdGTGhZd2lneFpCQU9pRkw1?=
 =?utf-8?B?L1YzZllzOGFyQkVrNWtzKzNkOFppanB4ZjhGdHEydDM2SVNMNUJiQmNqRFVM?=
 =?utf-8?B?OVYwWTVMcVl2MjJ4aVF2QndOd0p3K0ZhZGJLN2NwRmN3c1ZUN1Izbm14dUUv?=
 =?utf-8?B?amtYUk9HYkdPNUdmU1NNdk9hcmVXeUROQlpScGlSL1QyM25GZGpRRmtBajJT?=
 =?utf-8?B?UjlZV3ZjTVdyd1lqVnJnSHp2NWpoR0FXOUEzaU1Va3RteUVSdDFWR2xsSjV5?=
 =?utf-8?B?YTlPN3Zjd0NIY3V6RlBBU0ZJdFJ4blhZMFFyTWpteWwvK01NaVI2VGtUbmhu?=
 =?utf-8?B?cmsrNzQ5dmZDbnRzMEJydEdlSEV3NzlZSzczSnBTSmxVcktvSFA0eGlUK2JS?=
 =?utf-8?B?ZzV1cndZNTI2cEtMdkY1UWRtM0ZKamJhQXl5UUljUEJoc253SGxpTUpHQXZM?=
 =?utf-8?B?SGhWdExXajVScTQxdUdGWmNqWjRLOCtiRGhvQ0xFWTBrcHBtclRCRDROR3RN?=
 =?utf-8?B?SklhK0hNUi9lZVpiOG00Ymd5Zmp2Mmk2WHZ6NDk4T3BEeDNvb0ZtamxyYU92?=
 =?utf-8?B?SkVQdHFyeXgrZ0J2clNNT0RsQmdLdDE2aTBOOHVWcXhQajgzYnlyOU9Pd1lj?=
 =?utf-8?B?QVl6VTg2V1VSczBlVEVHSUdpNkFUa2I2UEF4TEJaMTllRWdLbzlHek1XZTlh?=
 =?utf-8?B?NTNyM1NCc1RtYVZ4NFFXdDFsbUsydU8zcGtCSFZHUnBQYU44dVlmUWY2OTdn?=
 =?utf-8?B?QjdpbEliREZhTytmN2lPRzM2N1hIQ3kyNnN3QXdudlp6VHVFQmdOcFJ3STVN?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <494F0B55C0FB9249823C8ECAAAA32293@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cf7be4-06ce-4b3e-7c26-08dcf54671a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 22:43:28.2518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: szhO5wsFfxnQd5gIcfwohTtlKOJaC4Pxu9QfehxikUUgLf/ELzEmuZjQA2AztazhsuIHPzjqnBuApmbGvaYxDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7463
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA5LTI0IGF0IDE1OjE1ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VGh1LCBTZXAgMTksIDIwMjQgYXQgMDQ6MzQ6MjdQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBBZGQgYSBzZXBhcmF0ZSBmdW5jdGlvbiBiaW5mb19jcmVhdGVfZmVhdHVyZV9kZXZf
ZGF0YSgpIHdoaWNoIGFsbG9jYXRlcw0KPiA+IGFuZCBwb3B1bGF0ZXMgdGhlIGZlYXR1cmUgcGxh
dGZvcm0gZGF0YSwgYW5kIGNhbGwgdGhlIGZ1bmN0aW9uIGZyb20NCj4gPiBidWlsZF9pbmZvX2Nv
bW1pdF9kZXYoKSB3aGljaCByZWdpc3RlcnMgdGhlIGZlYXR1cmUgcGxhdGZvcm0gZGV2aWNlLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFBldGVyIENvbGJlcmcgPHBldGVyLmNvbGJlcmdAaW50
ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBNYXR0aGV3IEdlcmxhY2ggPG1hdHRoZXcuZ2VybGFj
aEBsaW51eC5pbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZnBnYS9kZmwuYyB8IDc0
ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDMyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ZwZ2EvZGZsLmMgYi9kcml2ZXJzL2ZwZ2EvZGZsLmMNCj4g
PiBpbmRleCA0Yzc5ZDQzM2QyMTYuLmU2NDRlYjlmZGUzOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2ZwZ2EvZGZsLmMNCj4gPiArKysgYi9kcml2ZXJzL2ZwZ2EvZGZsLmMNCj4gPiBAQCAtNzQ5
LDEyICs3NDksOCBAQCBzdGF0aWMgdm9pZCBkZmxfZnBnYV9jZGV2X2FkZF9wb3J0X2RhdGEoc3Ry
dWN0IGRmbF9mcGdhX2NkZXYgKmNkZXYsDQo+ID4gIAltdXRleF91bmxvY2soJmNkZXYtPmxvY2sp
Ow0KPiA+ICB9DQo+ID4gIA0KPiA+IC0vKg0KPiA+IC0gKiByZWdpc3RlciBjdXJyZW50IGZlYXR1
cmUgZGV2aWNlLCBpdCBpcyBjYWxsZWQgd2hlbiB3ZSBuZWVkIHRvIHN3aXRjaCB0bw0KPiA+IC0g
KiBhbm90aGVyIGZlYXR1cmUgcGFyc2luZyBvciB3ZSBoYXZlIHBhcnNlZCBhbGwgZmVhdHVyZXMg
b24gZ2l2ZW4gZGV2aWNlDQo+ID4gLSAqIGZlYXR1cmUgbGlzdC4NCj4gPiAtICovDQo+ID4gLXN0
YXRpYyBpbnQgYnVpbGRfaW5mb19jb21taXRfZGV2KHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNf
aW5mbyAqYmluZm8pDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0
YSAqDQo+ID4gK2JpbmZvX2NyZWF0ZV9mZWF0dXJlX2Rldl9kYXRhKHN0cnVjdCBidWlsZF9mZWF0
dXJlX2RldnNfaW5mbyAqYmluZm8pDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKmZkZXYgPSBiaW5mby0+ZmVhdHVyZV9kZXY7DQo+ID4gIAlzdHJ1Y3QgZGZsX2ZlYXR1cmVf
cGxhdGZvcm1fZGF0YSAqcGRhdGE7DQo+ID4gQEAgLTc2NCw3ICs3NjAsNyBAQCBzdGF0aWMgaW50
IGJ1aWxkX2luZm9fY29tbWl0X2RldihzdHJ1Y3QgYnVpbGRfZmVhdHVyZV9kZXZzX2luZm8gKmJp
bmZvKQ0KPiA+ICANCj4gPiAgCXR5cGUgPSBmZWF0dXJlX2Rldl9pZF90eXBlKGZkZXYpOw0KPiA+
ICAJaWYgKFdBUk5fT05fT05DRSh0eXBlID49IERGTF9JRF9NQVgpKQ0KPiA+IC0JCXJldHVybiAt
RUlOVkFMOw0KPiA+ICsJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiA+ICANCj4gPiAgCS8q
DQo+ID4gIAkgKiB3ZSBkbyBub3QgbmVlZCB0byBjYXJlIGZvciB0aGUgbWVtb3J5IHdoaWNoIGlz
IGFzc29jaWF0ZWQgd2l0aA0KPiA+IEBAIC03NzQsNyArNzcwLDcgQEAgc3RhdGljIGludCBidWls
ZF9pbmZvX2NvbW1pdF9kZXYoc3RydWN0IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbykN
Cj4gPiAgCSAqLw0KPiA+ICAJcGRhdGEgPSBremFsbG9jKHN0cnVjdF9zaXplKHBkYXRhLCBmZWF0
dXJlcywgYmluZm8tPmZlYXR1cmVfbnVtKSwgR0ZQX0tFUk5FTCk7DQo+ID4gIAlpZiAoIXBkYXRh
KQ0KPiA+IC0JCXJldHVybiAtRU5PTUVNOw0KPiA+ICsJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0p
Ow0KPiA+ICANCj4gPiAgCXBkYXRhLT5kZXYgPSBmZGV2Ow0KPiA+ICAJcGRhdGEtPm51bSA9IGJp
bmZvLT5mZWF0dXJlX251bTsNCj4gPiBAQCAtNzk5LDcgKzc5NSw3IEBAIHN0YXRpYyBpbnQgYnVp
bGRfaW5mb19jb21taXRfZGV2KHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNfaW5mbyAqYmluZm8p
DQo+ID4gIAlmZGV2LT5yZXNvdXJjZSA9IGtjYWxsb2MoYmluZm8tPmZlYXR1cmVfbnVtLCBzaXpl
b2YoKmZkZXYtPnJlc291cmNlKSwNCj4gPiAgCQkJCSBHRlBfS0VSTkVMKTsNCj4gPiAgCWlmICgh
ZmRldi0+cmVzb3VyY2UpDQo+ID4gLQkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKwkJcmV0dXJuIEVS
Ul9QVFIoLUVOT01FTSk7DQo+ID4gIA0KPiA+ICAJLyogZmlsbCBmZWF0dXJlcyBhbmQgcmVzb3Vy
Y2UgaW5mb3JtYXRpb24gZm9yIGZlYXR1cmUgZGV2ICovDQo+ID4gIAlsaXN0X2Zvcl9lYWNoX2Vu
dHJ5X3NhZmUoZmluZm8sIHAsICZiaW5mby0+c3ViX2ZlYXR1cmVzLCBub2RlKSB7DQo+ID4gQEAg
LTgxOCw3ICs4MTQsNyBAQCBzdGF0aWMgaW50IGJ1aWxkX2luZm9fY29tbWl0X2RldihzdHJ1Y3Qg
YnVpbGRfZmVhdHVyZV9kZXZzX2luZm8gKmJpbmZvKQ0KPiA+ICAJCQkJCQkgICAgICAgZmluZm8t
PnBhcmFtcywgZmluZm8tPnBhcmFtX3NpemUsDQo+ID4gIAkJCQkJCSAgICAgICBHRlBfS0VSTkVM
KTsNCj4gPiAgCQkJaWYgKCFmZWF0dXJlLT5wYXJhbXMpDQo+ID4gLQkJCQlyZXR1cm4gLUVOT01F
TTsNCj4gPiArCQkJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KPiA+ICANCj4gPiAgCQkJZmVh
dHVyZS0+cGFyYW1fc2l6ZSA9IGZpbmZvLT5wYXJhbV9zaXplOw0KPiA+ICAJCX0NCj4gPiBAQCAt
ODM0LDggKzgzMCwxMCBAQCBzdGF0aWMgaW50IGJ1aWxkX2luZm9fY29tbWl0X2RldihzdHJ1Y3Qg
YnVpbGRfZmVhdHVyZV9kZXZzX2luZm8gKmJpbmZvKQ0KPiA+ICAJCQlmZWF0dXJlLT5pb2FkZHIg
PQ0KPiA+ICAJCQkJZGV2bV9pb3JlbWFwX3Jlc291cmNlKGJpbmZvLT5kZXYsDQo+ID4gIAkJCQkJ
CSAgICAgICZmaW5mby0+bW1pb19yZXMpOw0KPiA+IC0JCQlpZiAoSVNfRVJSKGZlYXR1cmUtPmlv
YWRkcikpDQo+ID4gLQkJCQlyZXR1cm4gUFRSX0VSUihmZWF0dXJlLT5pb2FkZHIpOw0KPiA+ICsJ
CQlpZiAoSVNfRVJSKGZlYXR1cmUtPmlvYWRkcikpIHsNCj4gPiArCQkJCXJldCA9IFBUUl9FUlIo
ZmVhdHVyZS0+aW9hZGRyKTsNCj4gPiArCQkJCXJldHVybiBFUlJfUFRSKHJldCk7DQo+IA0KPiBX
aHkgY2hhbmdlIHRoZSB0eXBlIGJhY2sgYW5kIGZvcnRoPw0KPiANCj4gICByZXR1cm4gZmVhdHVy
ZS0+aW9hZGRyOw0KPiANCj4gaXMgaXQgT0s/DQo+IA0KPiBUaGFua3MsDQo+IFlpbHVuDQoNClll
cywgdGhpcyBoYXMgYmVlbiBkb25lIGluIHRoZSByZXZpc2VkIHBhdGNoICJmcGdhOiBkZmw6IGZh
Y3RvciBvdXQNCmZlYXR1cmUgZGF0YSBjcmVhdGlvbiBmcm9tIGJ1aWxkX2luZm9fY29tbWl0X2Rl
digpIi4NCg0KVGhhbmtzLA0KUGV0ZXINCg==

