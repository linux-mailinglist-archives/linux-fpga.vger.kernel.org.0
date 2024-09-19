Return-Path: <linux-fpga+bounces-726-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2890597CECB
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 23:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D1F1F21538
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 21:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470F1CD02;
	Thu, 19 Sep 2024 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcXWl5/h"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15114F121;
	Thu, 19 Sep 2024 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782021; cv=fail; b=RCKxVCMKJJI6cC/KbDl65bMXnUJYRyhOl5qbWko3eeLIxTo2VBvfnh0kt6zFOLLo8ngh9L8WeIn8y/1eMW6J9E2l3Wx80l83HXe2NtOUmYtYtPtGsed2qXV0S9RHrtf97AACu4ojFDtliW2clWRtv2q7Nu64e2Q9q+f8JhVeZ9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782021; c=relaxed/simple;
	bh=6nOUCTNz7ZCfX9Tlj+BJqJWcGGhO9yxyK8Hdbbba5So=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kVyLp+mnRaSZJJx+GohgwJmzvR0rzjm5Dn/pKyfntTRiFjvtOi+Fe4y/w8N6A0AckCw3qLWBtVgruBJiFyLlxoh66Qjz4ly2XlTtT87Q9fC0OtTBhahn4BAsOCpBnUehihjMBLHkabLiBtVR/SNhiHqJ2tiAHltG7uV8vSBTfOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UcXWl5/h; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726782019; x=1758318019;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6nOUCTNz7ZCfX9Tlj+BJqJWcGGhO9yxyK8Hdbbba5So=;
  b=UcXWl5/h8uJbL9f+En5GWKzaSfH8IZc22aNINZT867uEm5ETKhdQghtJ
   kWho8MxzlMbJ3wQVg/aGDvuagxMGEppeJ5d/kb+Hl4hC4bXURao5Hyyc3
   Jc8e0YeMd8FI+0TsgEGK8PNovSs0cqQB9QTHxT7K+6/X6ma/Vc/Ot6WvX
   jS/6Nxtw3pd0NUn4sSkPWrEJ3iVgs0JrfMVzXyWQCG5WXceTxqfAweuG6
   8fMQ/rKQG5+ye4Yf6QEREUJF0X7GbxCGOit8t9S5SBkZ5csiMjDwGSeWF
   E2OkHnmdfFXZLM3iAjjdfqUF/QIq/dQ0e7PJBPqpFgEiL73R3OgYhjFHt
   Q==;
X-CSE-ConnectionGUID: dfCP/k0JTJWHGoZg8tvL2g==
X-CSE-MsgGUID: YpvuxQPmQCuSn8i8kw8fhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="43292437"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="43292437"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:40:17 -0700
X-CSE-ConnectionGUID: vYu8x1s+Ry2FIuk6C4IczQ==
X-CSE-MsgGUID: aqNAKUzTSEy1CC4SiJfeqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="74858382"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 14:40:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 14:40:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 14:40:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 14:40:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ur5E0Qu1GZr+cUeMndkDr4JP4edHHysKZHCnUH1RsjPORjNWvSuHxF3LcM8aWmFwA9QNPM6eqtHgT0J61LEMruvM6jskG8jU1/gaOZIxINB0MiAxnh5x/X7N+x7xY5PNVaWzCmhrIKbgpN0Xt4eUzM4bVhCUWk3nY+9v1sATL+eQRiQYQmt96A0fKrbjhLUXm+/NCpqsQrh6e8V0CythrLWOYHf+JrQMeyJX300BFYgC0+/2szdctfA6T/YtfxOPbOrew9fvnwOM1rnu9TQx7BVGqjxB9gUfWObcuRzaKyZriwVs8c437Y22Q9QjVuPgZvoNKMoNWZPalFP5vSy9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nOUCTNz7ZCfX9Tlj+BJqJWcGGhO9yxyK8Hdbbba5So=;
 b=BS7KQPgew9L9fq0/gRuqWgeNEpZ+LapC6LyOzYvBxNkG1piwMA6i47cej1MLNaQsSp29qUKsxIZWtIy5GNNR9FgtngWIlucZ/RdO7OPqljytPqwkFr+RIe02tT6ZNd3fl+GeL5YYG2J0rSCjeimuWHaLR4Y/tNvyEhUrJytEuu6C4Dw+OB5pRW4ZLGcQxWDmMTRVtnEPGZda2hRvEtPuRk7dx12rTYabPesStRW6fOuANG/Eza/8uBp2QwD/x+i/5TyXLziUxgv0w2uVDkuT6IXu3KOerXF6bYXza7etnFaiNy28w7OCoNuiLSX1TqjBmwoJ1AqDLBxFqIfO8M6O4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by MN6PR11MB8170.namprd11.prod.outlook.com (2603:10b6:208:47c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 21:39:56 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%5]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 21:39:55 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao"
	<hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>,
	"trix@redhat.com" <trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [RFC PATCH v2 6/9] fpga: dfl: migrate Accelerated Function Unit
 driver to dfl_feature_dev_data
Thread-Topic: [RFC PATCH v2 6/9] fpga: dfl: migrate Accelerated Function Unit
 driver to dfl_feature_dev_data
Thread-Index: AQHbCtx3RCLqGalXu0OzNkBPFtyKYg==
Date: Thu, 19 Sep 2024 21:39:55 +0000
Message-ID: <7cafed682eb6757805b65bd82db1f5099e26b5a8.camel@intel.com>
References: <20240409233942.828440-1-peter.colberg@intel.com>
	 <20240409233942.828440-7-peter.colberg@intel.com>
	 <ZifGKL65IDARHHN/@yilunxu-OptiPlex-7050>
In-Reply-To: <ZifGKL65IDARHHN/@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|MN6PR11MB8170:EE_
x-ms-office365-filtering-correlation-id: f4c6c63f-350a-4b95-83b7-08dcd8f39a71
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QWhqWTdpYkRkUmJpZjhDbXhCd2ZzbXZrK1lXcVQrZjdZVE04c0c1T1NJYUdp?=
 =?utf-8?B?M1RHeXVDS2x6MFFnVWdHcjFvRnZucWNjV3pWVFVFSTB3a09ZUlBJMlIyRXRP?=
 =?utf-8?B?VWMwVUJMRUdIc1d1VHRGbkYySHVQV1owYXlISWo1RWM5SjZQajA4S3RZTjdv?=
 =?utf-8?B?a2hFQW04RE1ZcUtCd3hVQXlzbzFDRU5UU0Zoc2crUW9qV1F5VXFvSDZXbHVt?=
 =?utf-8?B?VjFmWHdWUTAzblcwN0g4SDVObC85Qk1Vd2pWdmJ0aXZzdkFzZ1V1cUF1VEs0?=
 =?utf-8?B?djdSVEhWeG9sWlB3V1pXL3NkWG1aTjBKcHBBbUdVbjl3NC9BckFqcDFiMnNN?=
 =?utf-8?B?RGU0SXBQbVRzVmZoUHpWRWVpakZXMlZoZjVVemJBM3JHRVZWazFvck5Hd0l6?=
 =?utf-8?B?QkxVQm9PQnM2TWxlb1VhdU0zZzRqSmNFVTRkVzdwZk14NFcrRW9BZldObll1?=
 =?utf-8?B?T0dpODk4a0N6TU5zNEJ5U0ZyaWtMMXg1QTM0MEo2ZFRTa0FDYUxGTVRiVVUw?=
 =?utf-8?B?am1pYU43OUcwWmFoemR0VnlYV2k5NmZiQ1hMWlphQ2VENDFiSVR5S04vamp3?=
 =?utf-8?B?RVUvTFlFWWJoQVFqdWFFS0tmdmZ6NFZ1UHYvVzBSbWZYcmFpdEdUZ2p1YjNT?=
 =?utf-8?B?bG5PMUtyUG9mMHBXeTIrVGxPaWYwMVJkWlpETjEyWGNkTW96b3ZIdEFlaU9U?=
 =?utf-8?B?VDFjUHRiZktaTGdxczIvZmxNeHNvWkhIMHRLdFo1R2RFdnQyYVZ2ak5jVzlk?=
 =?utf-8?B?WDZHNkxIcTNSVjROeThYTGkzUTBydk9sL2dIZWtuTE4vQWNxM1pKemVSWmJx?=
 =?utf-8?B?VzRiZ01CKzFVNG5ncjRPMzV5TmZiMEZxbG45SDFQZGQ4K1RvZG1YZjBYd0w3?=
 =?utf-8?B?b3c4ZkNpS3owNWZ5dktBZEFlcGR2Ym9uNThwcFpnZGpOcUpPV2VDMDIvczRG?=
 =?utf-8?B?Vk1WTGtXUDZLbGhUaEw5SGdZcXl4dEVIc3RudkhaQmMrNFQwNkM2WlFiSDhj?=
 =?utf-8?B?Uyt4T1JXV3grdGtDS1JDbkNLc2I3Wlk2b25zK0RkenpnSFFlNVBQbW82c2xv?=
 =?utf-8?B?dGNDZXdIN09ubWxEekpoVWN6WHN0RDNGVVliaWZuWklGenFhZHBObnhJRTZG?=
 =?utf-8?B?RE9jeTJ1ZlBDNnRmRW83dzBMRnliNytyVUh3b3dWQVNOdkNVZUEwNlFmM21i?=
 =?utf-8?B?SGpaRFZLYTZqd21Ra1ZTbmo5czJEWkE1SHptYU5RbEEyNmR5cU9wZ2MrbFFh?=
 =?utf-8?B?cFBRZlEwZFZWWUtaSjJiNC9wL1F3LzNnMVBQZ2psdGFpUmwxSUVsM3c2T2Y0?=
 =?utf-8?B?TzltNmttdlh2YUtOY0J6NUNSOTc2R21iNEtsSFQ4SVVoNTBLaldIZldoOE9W?=
 =?utf-8?B?dzRYNFJkRlNHbEFtSkVGQm9XcXMyTmloMlk1ODZITlg5b3d4WVpLblc3MUh1?=
 =?utf-8?B?dzk3WjJkTXpTdGVGR1d0aEVVamdOTVJmeTZyeW9lNTRiYjlGNDNMRlV0dU1E?=
 =?utf-8?B?VXNoS1V4T24rZXZaWGZHUmlRYWczVVB4Rk5WSjV1S1BhdXVXKzJhR0pyOW1N?=
 =?utf-8?B?cDgzS3lOVDVUcG5wTjBDOU4vMlZINS9GOHI5UVpHYkJDSHFhVjRsdDV2MHhJ?=
 =?utf-8?B?SFpOeGlmSThUd3JZVmRVcFFxS3hFU0d0RGozcEhadWZIMEtIdzF5cnRhby9w?=
 =?utf-8?B?Z3RUTlVWQWU3U0h5aFo3VWg2TzJic1ptL1cvaUYyRTNEcXFmVnphNXhGem5s?=
 =?utf-8?B?MGRyMnhlR3J6Rko5TndaaDR1UWpZaGRTTzZ3THFKMHhBUURrQ1JmeFAwdkJ1?=
 =?utf-8?B?T0RTdWJXYVY5aDF2ZG9sZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uy9zUmM1QjVnWnE5bVdBQmEyS1dzQURpQURqbll4UTg4UzlNR3RnT0lMNno0?=
 =?utf-8?B?UjhSSHBybEhmNzU4UGM3MGk4emhTZ044by9weDY4SW9wK3JSS1hvTlJNbW1s?=
 =?utf-8?B?SVZMWHpQNVFxWm9aYkJUMHAvamxZbksxcFV3dElXSE5pNktzOGczTFBiYnc1?=
 =?utf-8?B?cXNDL0pBQkZjQ1BINGZjOTlTRUoxV08zK3hERFNCTFNFeDFCQmJWQmFGdTJ1?=
 =?utf-8?B?QUpWbkVJcHNqemFNczdlb2FuZkkvU3ZZYWQxMU1ndE9RN0ZQamVFZmlxTXR2?=
 =?utf-8?B?RWVLVytSSGpzYlhabVNtNUxiQlV5VHlkcWZWL0FGREt5dURmR2JrY0N0TXI5?=
 =?utf-8?B?RUJqNjl5ZkZlTnN2eFZsTTVUSm84UW1mQnpWODZIdnhLZk5UdUZRbnVnVFFi?=
 =?utf-8?B?ZmhWbTMvaGRLZHRUSWZ2TGtxSVAvZHFPSjE3UkRVTjR6bDJzSm5wVTM2TzY0?=
 =?utf-8?B?Ukg1RVdQU0ZIV0JIY0l0WHpOSjR1VkN4alpqWGVnREJVWElsdVJtRmRSRlU3?=
 =?utf-8?B?TDhRd0hlRGxxWDUzODljL0RoVXQ4QXJHVHJGbVZXNGs0S0dSMUhiU1k4K2Z0?=
 =?utf-8?B?Z2pNUk9kamIyUmtMSXh4S2s1NWF3MkVYNGZuWS9PRCtRV0hMajFKdlpzek92?=
 =?utf-8?B?aW1VT0ZYV05Rb0JVeXo3MXZvZnh2Nmh0WFRrbHU4V0JPWWhsS3hCNG43NHRP?=
 =?utf-8?B?QlBJWThIOFY3OC9xaWRxYzBJUUhuaklNRS9kUXI1RmhLTEQ3Vmd2OUVSQUlo?=
 =?utf-8?B?WHJ4eEtZR1lkR3R6OTNmQlhybDZoRGJRcnVidXMvSkIwckRuYXhURTBmejI2?=
 =?utf-8?B?ZzdwRlJQTFJFM3RQZUgwNEdZSmlvL09WS0pJWGM3bWJzWGFtWjd6S2lOT1dO?=
 =?utf-8?B?Qi9ZUXBKYm1LeXVENVZwRDZnYkJOL2tMTE54Qk5FSmJJdGZ3aFQ2bHdHL2tJ?=
 =?utf-8?B?WllQb1pGSmhzZEc3emE2Q2tsYXhWYWJtSDF2UE5hZHJKazlwTDF6VG1PakhX?=
 =?utf-8?B?U1JoRDZWSUd4UkpNR1hzeWZQdWVlaDNVK1laMURobWRHMVVEbEtXT3YzNnkz?=
 =?utf-8?B?VEg3MXg3M2pKSmJPc3BqTWNLd2hOWVduQXVkT1JhaFFCZU1hRWhUdXZYbStN?=
 =?utf-8?B?MkVOVmJaUkM1bkVyS3FsSUdMMVNWanlDa0I2MUl0bFd1OGNOWUQxamxPcVd2?=
 =?utf-8?B?VllFbXMwaXFIL2FzWGx5ZE5rTUhzNlR3K2c5OUovTnRQSmpvd0hiRlBMZEZF?=
 =?utf-8?B?VG0vNk1QTmxCaWZGVXNac0tEZUU5TFJzZk1sK2crd2JqZFZuU1B1dlJaVkJw?=
 =?utf-8?B?cmlueGlFbFE4RS9PT1RQUVpJUUc1Z1lnVTFYSmhRNjIzU3EvSkV0aldBSlZ0?=
 =?utf-8?B?WVR3M2RtejA4cmQzMzFvV3Q1SStGZStZZzJPeUMyWFNUeldjekl1SDY4Nk9S?=
 =?utf-8?B?MHhnTnBiVkV5clUwemVNNlFxTEEwRUluVGhVNS9LN2VpeFNyZmlLWTZWQ0pV?=
 =?utf-8?B?Z2V2THpIOExaMlZJT2dZT1IrREw1djdEeWF1UG9CUWdqb09jeGdmaDVhQU1t?=
 =?utf-8?B?b0JUU1FzMXM5a2tqM2pwOFdnc1ZhZUxMZnlYM1ZyZkwvRHZSRmdXTjJjRjRy?=
 =?utf-8?B?NzZOZjlDU3VqYkp5S085cEJMSGNEcFY2NE9qSGU1a2FJS05qUU5lMXRMMUpO?=
 =?utf-8?B?Z1hmY1F5UHM2SW1XNkFmWGdFSWdEd2NBSDlHbytGY0NwYTRmVHc4L1BHZWlr?=
 =?utf-8?B?Q3JoVW5Wc0NuT1J4NVBBVGtXc2FqbDhhWUZ3REgrT0tnQWdmZkp2cCtvaHlY?=
 =?utf-8?B?WDI4TUNPZUZ3d0NrS2E5ZzNsV0lIUnRsbEh0VkNGMlNsZXdPbmRLSkdZaHBs?=
 =?utf-8?B?Q3hTd010d3ZVb3ByZDB6KzZiSC80aGFWMlVUQklZSzc3UDdUUVAwVGNUMjB2?=
 =?utf-8?B?cGZNQTJ5di9oS3c3V2M1S082b0NIVlBTb0lOeGt1cVRQNHNQZjhhWnBYcjZ3?=
 =?utf-8?B?TWxHWUZSTXE0aGVrdDRicXlxY1NLalptREcxaE1ZY29BMWJMeTI5K0NMYTRN?=
 =?utf-8?B?Q29qSVo1cWVWT3N0YldpMDNNOGFSRENGQ1cxcjltTzRFOGczVjg2dkp0TjFq?=
 =?utf-8?B?Skc2UWh0N0JIb0NsaGVtQjltS1ZkTzVCYUFmaDdXbXY1OS9PbEp4Wi92UG5E?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <108A6B483AC4DE44968BF0D943647956@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c6c63f-350a-4b95-83b7-08dcd8f39a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 21:39:55.9224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilCme7fNNCVCWLa263CeJated2gGmI3JtUcdqkeIR2QnK8P88nUByOlSuue7n348MY7nqJX/1AjMxPAGV9Awvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8170
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTIzIGF0IDIyOjMxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VHVlLCBBcHIgMDksIDIwMjQgYXQgMDc6Mzk6MzlQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBUaGlzIGNoYW5nZSBzZXBhcmF0ZXMgb3V0IG1vc3Qgb2YgdGhlIHN5bWJvbCBuYW1l
IGNoYW5nZXMgcmVxdWlyZWQgYnkgdGhpcw0KPiA+IHBhdGNoIHNlcmllcyBmb3IgdGhlIGZpbGU6
IGRyaXZlcnMvZnBnYS9kZmwtYWZ1LW1haW4uYy4gVGhpcyBpcyBkb25lIHRvDQo+ID4gc3BsaXQg
YSBzaW5nbGUgbW9ub2xpdGhpYyBjaGFuZ2UgaW50byBtdWx0aXBsZSwgc21hbGxlciBwYXRjaGVz
IGF0IHRoZQ0KPiA+IHJlcXVlc3Qgb2YgdGhlIG1haW50YWluZXIuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogUGV0ZXIgQ29sYmVyZyA8cGV0ZXIuY29sYmVyZ0BpbnRlbC5jb20+DQo+ID4gLS0t
DQo+ID4gdjI6DQo+ID4gLSBTcGxpdCBtb25vbGl0aGljIHBhdGNoIGludG8gc2VyaWVzIGF0IHJl
cXVlc3Qgb2YgbWFpbnRhaW5lcg0KPiA+IC0gQ2hhbmdlIGFmdV9pb2N0bF8qKCkgdG8gcmVjZWl2
ZSBkZmxfZmVhdHVyZV9kZXZfZGF0YSBpbnN0ZWFkIG9mDQo+ID4gICBkZmxfZmVhdHVyZV9wbGF0
Zm9ybV9kYXRhLg0KPiA+IC0gUmVwbGFjZSBsb2NhbCB2YXJpYWJsZSBwZGF0YSB3aXRoIGZkYXRh
IGluIGFmdV9tbWFwKCkuDQo+ID4gLSBSZW1vdmUgdW51c2VkIGxvY2FsIHZhcmlhYmxlIHBkYXRh
IGluIGFmdV9kZXZfe2luaXQsZGVzdHJveX0oKS4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9mcGdh
L2RmbC1hZnUtbWFpbi5jIHwgMTEwICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKSwgNTQgZGVsZXRpb25zKC0p
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9kZmwtYWZ1LW1haW4uYyBiL2Ry
aXZlcnMvZnBnYS9kZmwtYWZ1LW1haW4uYw0KPiA+IGluZGV4IDZiOTdjMDczODQ5ZS4uNjE4Njhj
ZGQ1YjBiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZnBnYS9kZmwtYWZ1LW1haW4uYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZnBnYS9kZmwtYWZ1LW1haW4uYw0KPiA+IEBAIC01MDQsOSArNTA0LDEx
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIHBvcnRfYWZ1X2dyb3VwID0g
ew0KPiA+ICBzdGF0aWMgaW50IHBvcnRfYWZ1X2luaXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldiwNCj4gPiAgCQkJIHN0cnVjdCBkZmxfZmVhdHVyZSAqZmVhdHVyZSkNCj4gPiAgew0KPiA+
ICsJc3RydWN0IGRmbF9mZWF0dXJlX2Rldl9kYXRhICpmZGF0YSA9DQo+ID4gKwkJCQkJdG9fZGZs
X2ZlYXR1cmVfZGV2X2RhdGEoJnBkZXYtPmRldik7DQo+ID4gIAlzdHJ1Y3QgcmVzb3VyY2UgKnJl
cyA9ICZwZGV2LT5yZXNvdXJjZVtmZWF0dXJlLT5yZXNvdXJjZV9pbmRleF07DQo+ID4gIA0KPiA+
IC0JcmV0dXJuIGFmdV9tbWlvX3JlZ2lvbl9hZGQoZGV2X2dldF9wbGF0ZGF0YSgmcGRldi0+ZGV2
KSwNCj4gPiArCXJldHVybiBhZnVfbW1pb19yZWdpb25fYWRkKGZkYXRhLA0KPiANCj4gQWdhaW4s
IHBsZWFzZSBrZWVwIHRoZSBjaGFuZ2Ugc2ltcGxlIGZvciBtYXNzaXZlIHJlcGxhY2VtZW50LiBJ
ZiB5b3UNCj4gd2FudCBvdGhlciBhZGp1c3RtZW50cywgZG8gaXQgaW4gYW5vdGhlciBwYXRjaC4N
Cg0KVGhpcyBpcyBub3cgcHJlcGFyZWQgaW4gImZwZ2E6IGRmbDogcGFzcyBmZWF0dXJlIHBsYXRm
b3JtIGRhdGEgaW5zdGVhZA0Kb2YgZGV2aWNlIGFzIGFyZ3VtZW50IiBmb2xsb3dlZCBieSB0aGUg
cGRhdGEgLT4gZmRhdGEgcmVwbGFjZW1lbnQgaW4NCiJmcGdhOiBkZmw6IHJlZmFjdG9yIGZ1bmN0
aW9ucyB0byB0YWtlL3JldHVybiBmZWF0dXJlIGRldmljZSBkYXRhIi4NCg0KVGhhbmtzLA0KUGV0
ZXINCg0KPiANCj4gVGhhbmtzLA0KPiBZaWx1bg0KDQo=

