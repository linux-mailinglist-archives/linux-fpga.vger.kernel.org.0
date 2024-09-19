Return-Path: <linux-fpga+bounces-724-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0452C97CEBF
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 23:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A6A28476D
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 21:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBED13B294;
	Thu, 19 Sep 2024 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4NvgsSW"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966D622612;
	Thu, 19 Sep 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726780975; cv=fail; b=ogN2LsN8u+mISfifzptXfzHnuWhPGseZ2eUqzFo4Kz6P2hNkfaYaIIjirgGBEgN23My0UNJIPDd8cqV5s0rsTW01Aadjhg2HKQkIxRkcPjVaBL9tnPjz913+1QY3sn4sMB70Yz+YY0QJxe6uUIBfrWF5l7nAEPo1cg2Xju/QeXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726780975; c=relaxed/simple;
	bh=4z+ce7LbZZHJoh1vK05TeaFHq2koYb19RMfr6iSR6HA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nblr2poAHMmWtLv7IuZiEWku1IJEBnRQPPBEuFLIqQHB8vyx2tsSxHGiUClQR31R5d4JFQHMyo/Ri/WCxwKgzKsoxmrHQatxdv84tc+MRwbPLBk8vmxxUui3k/ppKKTUw1ogszU29CtL2mkwHDk62t6PrXH56j24AIGoUTI2hCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4NvgsSW; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726780973; x=1758316973;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4z+ce7LbZZHJoh1vK05TeaFHq2koYb19RMfr6iSR6HA=;
  b=U4NvgsSWMsX/J0teClhQE/vI566xw7ZRUWdQJLW9Tj0PthYPjcB52OFf
   BiKsKj92lmRkVJUZfg9aGk1HFqRvOG73+SzGp+VCgEk0w4lMRfQGFoL9x
   dOdI+kNuyfqR2irOXyTGiv5CGLoRA8Q/kS6G2kRUjWQAIV34Fm0ICqZrO
   Rv9Oyv9GXkhBpO+LNqH91m3JiVsmi3+HYDQCMztbybzM0bynCV30u4DF8
   krGTxWnPbP/JOQEpHUuRevq+9nStqK6opfqrSIhjG0SrJ+H9yyvAqoIpB
   pUfIG0NekzAHzOgPPsXgNEJvSl5a9Ck5ZYBCsBRpSagxDJEI4MXhO+B+q
   g==;
X-CSE-ConnectionGUID: Sx6O1Fw6S4W+0sOWQT27fA==
X-CSE-MsgGUID: iebW/yAyS+CAm228WggDTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25294488"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25294488"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:22:52 -0700
X-CSE-ConnectionGUID: C/Tm7rQ9QoaEwyObKSIttg==
X-CSE-MsgGUID: gwvSkC3VTcCYePRKYJDCbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="69658557"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 14:22:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 14:22:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 14:22:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 14:22:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 14:22:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5q3lB+pd5q/rnRo/CsgxQJcgYsqreo/gyZiik3/Zuu91vJ8EBU3LgN64z4OZ/j/FyCPOP596n7KulYiWtL875G1ItB/iTGKV7SZw2QzVh51GJhpTSeSEOCZZmarPeyYx7+rAfCOBcxNw/Q5gHAO9/URF6q1Ks8bzT3Y6VYaD683TLkJCwKosnIrlQziu6d1cEObd/vSI7e7zJRMtrZQ4HwRoeOdmN/K9wUlKq/2jtZaWm7zS8Grj6utcdSaSBmJ9DnKu3TjDnMckw+0K/Wfm40L71AATrvIrDvaM3IhWS1C/aMOWjWy4waq2DSZI7uyl3ryS12cENl/Xf0Z65I36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4z+ce7LbZZHJoh1vK05TeaFHq2koYb19RMfr6iSR6HA=;
 b=qFAPECvMUXmrDgvYePzyYQlMMKou/LtKVeoZtK3zB6SKRJ6P8wP0T1I0wKQytuua+Wb2PSA2eP8I369bKPyKHtu3aUCFpxt0BUEK8GsiS2y1FH+pzS/mmNIspr8rRJK1z6z44CwT9N2WTpB4q2CHdzFB0hzoa/WuNWd//1SbtHlaVAviIjHuxhjcUzaZ7ziXdWGLRCROrCKy7P5pQnJ2cKfQVN1HSrIpzrRnruDU+96JTJhjCeQE1ZmdXv6xjoyhmaumGNsv9TBrZPkc5Y5vEmH2JibGxzLMGbMOye2NULZeeqUTaR6ug12vjZxwibFGYlTR/64sV5R6D5mUadpIxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by DM4PR11MB8159.namprd11.prod.outlook.com (2603:10b6:8:17d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 21:22:49 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%5]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 21:22:48 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao"
	<hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>,
	"trix@redhat.com" <trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [RFC PATCH v2 3/9] fpga: dfl: migrate AFU MMIO region management
 driver to dfl_feature_dev_data
Thread-Topic: [RFC PATCH v2 3/9] fpga: dfl: migrate AFU MMIO region management
 driver to dfl_feature_dev_data
Thread-Index: AQHbCtoTXabfPR3eUkSvaKtZOs52pw==
Date: Thu, 19 Sep 2024 21:22:48 +0000
Message-ID: <0f04b25b290a93980e2de0988640c978b6b0d302.camel@intel.com>
References: <20240409233942.828440-1-peter.colberg@intel.com>
	 <20240409233942.828440-4-peter.colberg@intel.com>
	 <1aa50550adfb3917e94dd4f553ee88005133cd15.camel@intel.com>
	 <ZifEQ42hMPazjiWd@yilunxu-OptiPlex-7050>
In-Reply-To: <ZifEQ42hMPazjiWd@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|DM4PR11MB8159:EE_
x-ms-office365-filtering-correlation-id: 45216904-ca91-46ba-7fe5-08dcd8f13649
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aGZVVHRSSkNoTHl3eGdheU12ZkRiYnVFTUVxdXpFNXA0L1hJRkNxcTdKR2dh?=
 =?utf-8?B?NE14ME1scFFadFJISVJrZmhsT1dVaG0zMVBiVTBoeFlwQVNGd09LMVlQbzJo?=
 =?utf-8?B?OEsrdFlSTElld2xnY01FbkFKRW81ZUhaNThyZUo4eFFrWmkySzFKaEl6di96?=
 =?utf-8?B?ZFN4bkJZUmRIdUhDdkU4eURMR0V5VGZxeTlWYm1ZM2x0ZnJZelRFcVJpK2s4?=
 =?utf-8?B?bjZpYWtVZThNSEt1Y1pBOFdTT1FTVU5aRWVnQXFUOFBLWk5qbGlOOHBDaEEz?=
 =?utf-8?B?emowQmJtL29mMHlLWEtRU29SSlNzRmMwOVNoYjNuNFdNWHNhYjFsNFgrM1pY?=
 =?utf-8?B?Z2FFZ2FhelFCa1h0WVErWDFpRjZpbGdVekd2VFJ5REE0cmZWNXM1M05Xd0xR?=
 =?utf-8?B?YUU3MG44QUdtcGlGL3RacDlOZ3gwWmxIcHp6aVFJMHpwNEs1ano1cWxSVS9y?=
 =?utf-8?B?Z0dlSTJDWXFYek5OZ2c2cnpUOGRnNEFGMnpBbnVJZHhPVDZlU0dUZ0ZDaU51?=
 =?utf-8?B?NUpOcENSQmVGZlVSV2hLVzNSdkRvRkNtc0FPWi9NazJWbFA5a1NEMlJobklD?=
 =?utf-8?B?enhUUXVJSGJRSUhLVExvaExzYjhlRVNSV2tjTUNkMENMUU9CanNHUTFRVHd0?=
 =?utf-8?B?ZTVsNFEvN2RJbkYxYWZ5RXBWSXF3TTl3Q1IwVHJnNEI3VW9BN0tNQmp1L0Jh?=
 =?utf-8?B?ZURBYXNmWmdZbXpRdlFmWFRnWkMvZ0tkT1NwWnJsUE5wUVZyS1A2eVdSRnQr?=
 =?utf-8?B?SkFsNHVDbkRDUnVtREpCSzB5ZlJIVVdNbHB6SWlIL2RmcEp6Q2ZNcGV5T0xL?=
 =?utf-8?B?VEUyd0tSOThBa09abzBRZnlPamw1cCtSTHhtSkxEUEFISkMwVGlxSWZNV2Jm?=
 =?utf-8?B?bnJNWm95Ui9jdURxdzNOaFBYSlNjcWlvYlR3KzRpcUVRdUE3RjJWUnNtZis4?=
 =?utf-8?B?VUdWTzlUcndFbFMwcEd1V2t4bGYwQURKUDgxTldyV0h2VG83dnlJR1NGMk55?=
 =?utf-8?B?M0xMaC9OcUFOUUlxNmZLV2J2c1ltT2VMK0lURjQ4d1Naa0JIbkYydE1yY3Z6?=
 =?utf-8?B?c3JqUXRUaTdGZjNUdUNxZGFXYm5vdWE5dGRKNVo1cklOVkZUZjFHZ3FHL240?=
 =?utf-8?B?Y1NScXNIelN2cW9JdnkvSkZUeTNJaEdLeStSMnZwYnloWmhoQnJNNG00aVhq?=
 =?utf-8?B?VTZ3NU1PMmNuZ1V3TUw0K0s1QWtDa0VjU3ArZFZXbFNWbG9yVXZYVDZEM1g1?=
 =?utf-8?B?NGRHMlI2U0dxamluWDJUbW1jTG1DL05BKzF4cXF2azhjeDBCRmpiejFGbWp1?=
 =?utf-8?B?dTAwQzVSbG1lOXBEYStyZjdRZTJNbHQvM3dOODRSV29oVnJ2NFVnaU5wKzhM?=
 =?utf-8?B?UEQ1ZDQzMVBPdVpnTGt6OW92cEJpK3h5TzBKaUMwTkk4c1FOajdzK3MyVVcw?=
 =?utf-8?B?THlQN1dFc1BUeEJ6WkNENndLOXdHQVI4aml4dkRSWW1RZjlld3NQdUY1SEV4?=
 =?utf-8?B?WmN4aEFUMXBYYUg5OGI2aWt3T1F6VGRIQXM4VGVVdmJCdDJNZVJuUnRybEYw?=
 =?utf-8?B?OGJCVU53eThJVzNQUVhLRkZwUnpmbjNmTFFJU2JMVGxWOE9Ha08yUVNJS0dB?=
 =?utf-8?B?UHlxemJtdWx2SGpGNzQ3dDJvZldjd3NaS2NCK1N5UmhYcUJmY1ZLYlYycU1i?=
 =?utf-8?B?aldvaHpPNUhhckF2VkxVNGQrK29uYzdnRlYwQVFSeVMza3ZmZTRla2xmVi9m?=
 =?utf-8?B?RFI4ZS9pS3FKVHE1YWI3bUNvMmVhai9lcU9JRXBmaTJiYStmN285RTVpVms1?=
 =?utf-8?B?NnZJNmpybzJJTFlrYWEzUGtOc21JODQ4UllXcnF1UU9rdm02R01ZVGIzNWVz?=
 =?utf-8?B?SjdvTXZXRVdFQW5DMWUyaGdIK0NJMklqcXhxbndCQUJ5a1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME5zMGNEWnlKNGJnTlpaUG5tU2ErS2hSY3VZNjNHQzlrWmNnMSszR0gwK1Vu?=
 =?utf-8?B?QkpXU2FOUHpkR2ZRbGtJNklydHJ3dkZKbXNOaytISWxWckFxR0N5MmlPUmgx?=
 =?utf-8?B?bFVOUENFOGYxTENXOGpIUjRMaTB0TVd5b29rMHpKOEsxUFlpL2dUUFpaRVlT?=
 =?utf-8?B?a3phUGRUZUp6WGxYRGF5TE1JV00wVGNkZ2l0SXhUcE1GV0V1K1lKa0VwaUlz?=
 =?utf-8?B?bW9aOXcwenoyNE1WVUVtaWdocEEyYXZ4S2hVelh2WWFtMnY4T3pqZ0kwcFBQ?=
 =?utf-8?B?aERxQ2k3Z0xJKzVlZ0ZudHg1TTVvNlRXTUVnK3RXWE9uMWpjbWJUZTVDclFn?=
 =?utf-8?B?UEliK3cvREg2dDBnSmt4RGNtWlYzUXh2UCtWdllJaTErWDA5T21iRFNGcHNP?=
 =?utf-8?B?UWlJN1ByZEhRVE5RejhKZmNyeWdIMzh4a0ZxL3hJNThvd0dmWGl5WWtMRlFr?=
 =?utf-8?B?eUpoWk50YU1pREF3K2pOM2F5TUJaemxWRE9lR1VvMWlwNUlDRzIwTVhhYnJD?=
 =?utf-8?B?aEU3bUJjbEs1ejVWNFRmT1JwYkJaaWMwTzZFUE1WUm55dnRnU3lXdUlCR3B2?=
 =?utf-8?B?aWZsQVRvcUhZOWI1eXRmS0RoYllVQTJVZ3VYWklQV2ZlZjdiNzhSRDZlR1BL?=
 =?utf-8?B?Y1VLMC9xcFhSSDZwQk9GMndrTDliMS9iRDJ6UGh0aHUzeis4V2lLYzZQa0E2?=
 =?utf-8?B?WmdVd3BqRTdoRmkzNC9UQzVIcm1sanQ3SnRLaEU3L2JBSTlheTRPbWxKZXd4?=
 =?utf-8?B?bnk3N3dyV280RWJYVVB3emQ2ZjNianBMQUtJT2FNQUxZS3RwdW1tK2ZwUVdy?=
 =?utf-8?B?dTJlRjBZQVJaMlVwakw2YXNuUlJHbzNmRUVPMGpic0pzcFNGT0xtOEF6WCtJ?=
 =?utf-8?B?WC84NWdUZGEvckk5V0pUUCtVQkMyQzdUSS84UjB2UUFDR1hLRDQrdHhsbm1O?=
 =?utf-8?B?ZTBySDZRemlSNnA4eTV4cTFwRnBkUjQwOHEzMmd0NWxWZjNDWmpTdzNSRllw?=
 =?utf-8?B?TzF2ak1KS29hZm5kZkh4dHZBYkdIVnJMb1BsM0JReVBVTW41bDVIRjE1MHlI?=
 =?utf-8?B?REtoY05HdjR6alY5Q1l2YUJXcXlyYU5HbEhJenNkMm5zbElxQkU0TWhLS0Rh?=
 =?utf-8?B?OUpQRnhlZExKOVZ1ci81ZHlxNTdoRHJlcVRPQmlRVTlyZnVqRkRvcWtXYXdl?=
 =?utf-8?B?YmdpZFVMMDV2RDdlNkRIM2Q4RWV6NVlnRWZJUkFibTVHY3NWUmlJWmZDK0xa?=
 =?utf-8?B?c0tEdHZ1RytXUnlPK2JmT1gxL0VjY1dHS0FleTZiODhQdXFWYjZpN3ptWms2?=
 =?utf-8?B?OUJybU1zZk5yMEFZUjdUVFlmZkltR3h4VTk3ZDk0MEhSVUU1bjZDNUROSVdv?=
 =?utf-8?B?MkdmYVhNelMzMzMxdEV5KzJERHVMRytkTnpTYXZMSzhDZmtUMDkySGY0NG92?=
 =?utf-8?B?WG9HT2FVM2xaL2tJd0piVjR6bCt0TEtJbzg1SkFDT3VERXRNTC9BZUlsdVpo?=
 =?utf-8?B?aDZITUFmVWxReThhZ2JuWTZvNms5UnhBWnVSRE9la2NWaUVUL3p2dlh3aHdV?=
 =?utf-8?B?YzFoWU5oTWRiUVA0UFpSWFZiOVRqLzRBS2JPSW8vUXAwTEU2c2VkUmxRMUZ2?=
 =?utf-8?B?b0FkY3ZRZkJSRGZ0dEFpWENhT2V1VU1OcGF3V1c5WHVYZTV2Mml6cWE1bTlO?=
 =?utf-8?B?aTBFa281RGZ0N2s2RWlkVy9PaEwzS1lFU0lETFBnalJxUk90QVBCNzMyQ0hU?=
 =?utf-8?B?RFg0b01vZ2RDRS9HNjlVOFNMaS9ja2dmejJhRkIvM2RpL1p6cTZ5QzROemNq?=
 =?utf-8?B?ZzlIRkd5cWprY1JwWkEwWVVOTmNYeGorUmhUQlJBenpxVmcxVTk3d0pDRnhk?=
 =?utf-8?B?NDBiOEVJWHpBWm9BTk9jZGl1Zm9pOU9xbUpOenZ0MVJORWxLMEFKOVBwblk1?=
 =?utf-8?B?bVJ5aG1mdzJ4Zms1WkFsZE1hZDNQSEJPVVBvYVJxNlZNdjdjcmtCL3U0OWl6?=
 =?utf-8?B?ZC9pbWhYY2Y5N0NnaWZrUzUzM2dMbE5Fd1JnSG44RngvaW1oejV5U1grZyt3?=
 =?utf-8?B?ZGtRaVhOb1kvc1Z2endldWlsQVJ3dkcvRSt3a1R3TmdoUUFCL3gva0Vjd2Ez?=
 =?utf-8?B?dTNDdWtMbjR6NU1Jc3hzNzVOald3RUp0dXRLNlhDdllhR283QkZHei8wYjM3?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <209EEC12BA4D934DB6BCEC859A2E0445@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45216904-ca91-46ba-7fe5-08dcd8f13649
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 21:22:48.8672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OiRnYqPmPWZnvv/SLy8c/82xKsflQvGGTQhkL761wz68l6Rhgoj6HQOXQD3vCnNbUqq+NZY+NhHR2OfQJXmWvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8159
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTIzIGF0IDIyOjIyICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VHVlLCBBcHIgMDksIDIwMjQgYXQgMTE6NTY6MTlQTSArMDAwMCwgQ29sYmVyZywgUGV0ZXIgd3Jv
dGU6DQo+ID4gT24gVHVlLCAyMDI0LTA0LTA5IGF0IDE5OjM5IC0wNDAwLCBQZXRlciBDb2xiZXJn
IHdyb3RlOg0KPiA+ID4gVGhpcyBjaGFuZ2Ugc2VwYXJhdGVzIG91dCBtb3N0IG9mIHRoZSBzeW1i
b2wgbmFtZSBjaGFuZ2VzIHJlcXVpcmVkIGJ5IHRoaXMNCj4gPiA+IHBhdGNoIHNlcmllcyBmb3Ig
dGhlIGZpbGU6IGRyaXZlcnMvZnBnYS9kZmwtYWZ1LXJlZ2lvbi5jLiBUaGlzIGlzIGRvbmUgdG8N
Cj4gPiA+IHNwbGl0IGEgc2luZ2xlIG1vbm9saXRoaWMgY2hhbmdlIGludG8gbXVsdGlwbGUsIHNt
YWxsZXIgcGF0Y2hlcyBhdCB0aGUNCj4gPiA+IHJlcXVlc3Qgb2YgdGhlIG1haW50YWluZXIuDQo+
ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBldGVyIENvbGJlcmcgPHBldGVyLmNvbGJlcmdA
aW50ZWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiB2MjoNCj4gPiA+IC0gU3BsaXQgbW9ub2xpdGhp
YyBwYXRjaCBpbnRvIHNlcmllcyBhdCByZXF1ZXN0IG9mIG1haW50YWluZXINCj4gPiA+IC0tLQ0K
PiA+ID4gIGRyaXZlcnMvZnBnYS9kZmwtYWZ1LXJlZ2lvbi5jIHwgNTEgKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9u
cygrKSwgMjUgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2ZwZ2EvZGZsLWFmdS1yZWdpb24uYyBiL2RyaXZlcnMvZnBnYS9kZmwtYWZ1LXJlZ2lvbi5jDQo+
ID4gPiBpbmRleCAyZTdiNDE2Mjk0MDYuLmIxMWE1YjIxZTY2NiAxMDA2NDQNCj4gPiA+IC0tLSBh
L2RyaXZlcnMvZnBnYS9kZmwtYWZ1LXJlZ2lvbi5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2ZwZ2Ev
ZGZsLWFmdS1yZWdpb24uYw0KPiA+ID4gQEAgLTEyLDExICsxMiwxMSBAQA0KPiA+ID4gIA0KPiA+
ID4gIC8qKg0KPiA+ID4gICAqIGFmdV9tbWlvX3JlZ2lvbl9pbml0IC0gaW5pdCBmdW5jdGlvbiBm
b3IgYWZ1IG1taW8gcmVnaW9uIHN1cHBvcnQNCj4gPiA+IC0gKiBAcGRhdGE6IGFmdSBwbGF0Zm9y
bSBkZXZpY2UncyBwZGF0YS4NCj4gPiA+ICsgKiBAZmRhdGE6IGFmdSBmZWF0dXJlIGRldiBkYXRh
DQo+ID4gPiAgICovDQo+ID4gPiAtdm9pZCBhZnVfbW1pb19yZWdpb25faW5pdChzdHJ1Y3QgZGZs
X2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEpDQo+ID4gPiArdm9pZCBhZnVfbW1pb19yZWdp
b25faW5pdChzdHJ1Y3QgZGZsX2ZlYXR1cmVfZGV2X2RhdGEgKmZkYXRhKQ0KPiA+ID4gIHsNCj4g
PiA+IC0Jc3RydWN0IGRmbF9hZnUgKmFmdSA9IGRmbF9mcGdhX3BkYXRhX2dldF9wcml2YXRlKHBk
YXRhKTsNCj4gPiA+ICsJc3RydWN0IGRmbF9hZnUgKmFmdSA9IGRmbF9mcGdhX2ZkYXRhX2dldF9w
cml2YXRlKGZkYXRhKTsNCj4gPiA+ICANCj4gPiA+ICAJSU5JVF9MSVNUX0hFQUQoJmFmdS0+cmVn
aW9ucyk7DQo+ID4gPiAgfQ0KPiA+ID4gQEAgLTM5LDcgKzM5LDcgQEAgc3RhdGljIHN0cnVjdCBk
ZmxfYWZ1X21taW9fcmVnaW9uICpnZXRfcmVnaW9uX2J5X2luZGV4KHN0cnVjdCBkZmxfYWZ1ICph
ZnUsDQo+ID4gPiAgLyoqDQo+ID4gPiAgICogYWZ1X21taW9fcmVnaW9uX2FkZCAtIGFkZCBhIG1t
aW8gcmVnaW9uIHRvIGdpdmVuIGZlYXR1cmUgZGV2Lg0KPiA+ID4gICAqDQo+ID4gPiAtICogQHBk
YXRhOiBhZnUgcGxhdGZvcm0gZGV2aWNlJ3MgcGRhdGEuDQo+ID4gPiArICogQGZkYXRhOiBhZnUg
ZmVhdHVyZSBkZXYgZGF0YQ0KPiA+ID4gICAqIEByZWdpb25faW5kZXg6IHJlZ2lvbiBpbmRleC4N
Cj4gPiA+ICAgKiBAcmVnaW9uX3NpemU6IHJlZ2lvbiBzaXplLg0KPiA+ID4gICAqIEBwaHlzOiBy
ZWdpb24ncyBwaHlzaWNhbCBhZGRyZXNzIG9mIHRoaXMgcmVnaW9uLg0KPiA+ID4gQEAgLTQ3LDE0
ICs0NywxNSBAQCBzdGF0aWMgc3RydWN0IGRmbF9hZnVfbW1pb19yZWdpb24gKmdldF9yZWdpb25f
YnlfaW5kZXgoc3RydWN0IGRmbF9hZnUgKmFmdSwNCj4gPiA+ICAgKg0KPiA+ID4gICAqIFJldHVy
bjogMCBvbiBzdWNjZXNzLCBuZWdhdGl2ZSBlcnJvciBjb2RlIG90aGVyd2lzZS4NCj4gPiA+ICAg
Ki8NCj4gPiA+IC1pbnQgYWZ1X21taW9fcmVnaW9uX2FkZChzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxh
dGZvcm1fZGF0YSAqcGRhdGEsDQo+ID4gPiAraW50IGFmdV9tbWlvX3JlZ2lvbl9hZGQoc3RydWN0
IGRmbF9mZWF0dXJlX2Rldl9kYXRhICpmZGF0YSwNCj4gPiA+ICAJCQl1MzIgcmVnaW9uX2luZGV4
LCB1NjQgcmVnaW9uX3NpemUsIHU2NCBwaHlzLCB1MzIgZmxhZ3MpDQo+ID4gPiAgew0KPiA+ID4g
KwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmZmRhdGEtPmRldi0+ZGV2Ow0KPiA+ID4gIAlzdHJ1Y3Qg
ZGZsX2FmdV9tbWlvX3JlZ2lvbiAqcmVnaW9uOw0KPiA+ID4gIAlzdHJ1Y3QgZGZsX2FmdSAqYWZ1
Ow0KPiA+ID4gIAlpbnQgcmV0ID0gMDsNCj4gPiA+ICANCj4gPiA+IC0JcmVnaW9uID0gZGV2bV9r
emFsbG9jKCZwZGF0YS0+ZGV2LT5kZXYsIHNpemVvZigqcmVnaW9uKSwgR0ZQX0tFUk5FTCk7DQo+
ID4gPiArCXJlZ2lvbiA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqcmVnaW9uKSwgR0ZQX0tF
Uk5FTCk7DQo+ID4gPiAgCWlmICghcmVnaW9uKQ0KPiA+ID4gIAkJcmV0dXJuIC1FTk9NRU07DQo+
ID4gPiAgDQo+ID4gPiBAQCAtNjMsMTMgKzY0LDEzIEBAIGludCBhZnVfbW1pb19yZWdpb25fYWRk
KHN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhICpwZGF0YSwNCj4gPiA+ICAJcmVnaW9u
LT5waHlzID0gcGh5czsNCj4gPiA+ICAJcmVnaW9uLT5mbGFncyA9IGZsYWdzOw0KPiA+ID4gIA0K
PiA+ID4gLQltdXRleF9sb2NrKCZwZGF0YS0+bG9jayk7DQo+ID4gPiArCW11dGV4X2xvY2soJmZk
YXRhLT5sb2NrKTsNCj4gPiA+ICANCj4gPiA+IC0JYWZ1ID0gZGZsX2ZwZ2FfcGRhdGFfZ2V0X3By
aXZhdGUocGRhdGEpOw0KPiA+ID4gKwlhZnUgPSBkZmxfZnBnYV9mZGF0YV9nZXRfcHJpdmF0ZShm
ZGF0YSk7DQo+ID4gPiAgDQo+ID4gPiAgCS8qIGNoZWNrIGlmIEBpbmRleCBhbHJlYWR5IGV4aXN0
cyAqLw0KPiA+ID4gIAlpZiAoZ2V0X3JlZ2lvbl9ieV9pbmRleChhZnUsIHJlZ2lvbl9pbmRleCkp
IHsNCj4gPiA+IC0JCW11dGV4X3VubG9jaygmcGRhdGEtPmxvY2spOw0KPiA+ID4gKwkJbXV0ZXhf
dW5sb2NrKCZmZGF0YS0+bG9jayk7DQo+ID4gPiAgCQlyZXQgPSAtRUVYSVNUOw0KPiA+ID4gIAkJ
Z290byBleGl0Ow0KPiA+ID4gIAl9DQo+ID4gPiBAQCAtODAsMzcgKzgxLDM3IEBAIGludCBhZnVf
bW1pb19yZWdpb25fYWRkKHN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhICpwZGF0YSwN
Cj4gPiA+ICANCj4gPiA+ICAJYWZ1LT5yZWdpb25fY3VyX29mZnNldCArPSByZWdpb25fc2l6ZTsN
Cj4gPiA+ICAJYWZ1LT5udW1fcmVnaW9ucysrOw0KPiA+ID4gLQltdXRleF91bmxvY2soJnBkYXRh
LT5sb2NrKTsNCj4gPiA+ICsJbXV0ZXhfdW5sb2NrKCZmZGF0YS0+bG9jayk7DQo+ID4gPiAgDQo+
ID4gPiAgCXJldHVybiAwOw0KPiA+ID4gIA0KPiA+ID4gIGV4aXQ6DQo+ID4gPiAtCWRldm1fa2Zy
ZWUoJnBkYXRhLT5kZXYtPmRldiwgcmVnaW9uKTsNCj4gPiA+ICsJZGV2bV9rZnJlZShkZXYsIHJl
Z2lvbik7DQo+ID4gDQo+ID4gQW4gaW50ZXJuYWwgcmV2aWV3ZXIgY29tbWVudGVkIHRoYXQgY2Fs
bGluZyBkZXZtX2tmcmVlKCkgaW4gYWxtb3N0IGFsbA0KPiA+IGNhc2VzIHNob3dzIGEgbWlzdW5k
ZXJzdGFuZGluZyBvZiBvYmplY3QgbGlmZXRpbWUgYW5kIG1heSB1bnZlaWwgYnVncy4NCj4gPiBU
aGV5IHN1Z2dlc3RlZCB0byBlaXRoZXIgZHJvcCB0aGUgZXhwbGljaXQgZGV2bV9rZnJlZSgpLCBv
ciBtb3ZlIGZyb20NCj4gPiBkZXZtXyooKSB0byBwbGFpbiBhbGxvY2F0aW9uLg0KPiA+IA0KPiA+
IEkgY291bGQgbm90IGZpbmQgc3BlY2lmaWMgZG9jdW1lbnRhdGlvbiBvbiB0aGUgcmVjb21tZW5k
ZWQgdXNlIGNhc2VzDQo+ID4gZm9yIGRldm1fa2ZyZWUoKSB0byBpbW1lZGlhdGVseSBmcmVlIGEg
cmVzb3VyY2Ugb24gZXJyb3IsIGJ1dCB0aGUNCj4gPiBkZXNjcmlwdGlvbiBvZiBkZXZyZXMgZ3Jv
dXBzIGFkdmlzZXMgdGhhdCBleHBsaWNpdCBmcmVlaW5nIHVzaW5nDQo+ID4gZGV2cmVzX3JlbGVh
c2VfZ3JvdXAoKSBpcyB1c3VhbGx5IHVzZWZ1bCBpbiBtaWRsYXllciBkcml2ZXJzIHdoZXJlDQo+
ID4gaW50ZXJmYWNlIGZ1bmN0aW9ucyBzaG91bGQgbm90IGhhdmUgc2lkZSBlZmZlY3RzIFsxXS4N
Cj4gPiANCj4gPiBXaGljaCBpbXBsZW1lbnRhdGlvbiB3b3VsZCB5b3UgcHJlZmVyIGFuZCB3aHk/
IERyb3BwaW5nIGRldm1fa2ZyZWUoKSwNCj4gPiBtb3ZpbmcgdG8gcGxhaW4gYWxsb2NhdGlvbiwg
b3IgbGVhdmluZyBldmVyeXRoaW5nIGFzIGlzPw0KPiANCj4gVXNpbmcgZGV2bV8qKCkgdXN1YWxs
eSBtZWFucyB0aGUgbGlmZWN5Y2xlIG9mIHRoZSBhbGxvY2F0ZWQgb2JqZWN0DQo+IHNob3VsZCBi
ZSB0aGUgc2FtZSBhcyB0aGUgZGV2aWNlLiBPdGhlcndpc2UgdXNlIHRoZSBwbGFpbiBhbGxvY2F0
aW9uLg0KPiBQbGVhc2UgY2hlY2sgd2hpY2ggY2FzZSBmaXRzIGZvciB5b3UuDQoNCmRldm1fa3ph
bGxvYygpIGFzIHVzZWQgY3VycmVudGx5IGlzIGFwcHJvcHJpYXRlIHNpbmNlIHRoZSBhbGxvY2F0
ZWQNCm9iamVjdCBzaG91bGQgaGF2ZSB0aGUgc2FtZSBsaWZldGltZSBhcyB0aGUgZGV2aWNlLg0K
DQpUaGFua3MsDQpQZXRlcg0KDQo+IA0KPiBUaGFua3MsDQo+IFlpbHVuDQo+IA0KPiA+IA0KPiA+
IFsxXcKgaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvZHJpdmVyLWFwaS9kcml2ZXItbW9kZWwvZGV2
cmVzLmh0bWwjZGV2cmVzLWdyb3VwIA0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBQZXRlcg0KPiA+
IA0KPiA+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ID4gIH0NCj4gPiA+ICANCj4gPiA+ICAvKioNCj4g
PiA+ICAgKiBhZnVfbW1pb19yZWdpb25fZGVzdHJveSAtIGRlc3Ryb3kgYWxsIG1taW8gcmVnaW9u
cyB1bmRlciBnaXZlbiBmZWF0dXJlIGRldi4NCj4gPiA+IC0gKiBAcGRhdGE6IGFmdSBwbGF0Zm9y
bSBkZXZpY2UncyBwZGF0YS4NCj4gPiA+ICsgKiBAZmRhdGE6IGFmdSBmZWF0dXJlIGRldiBkYXRh
DQo+ID4gPiAgICovDQo+ID4gPiAtdm9pZCBhZnVfbW1pb19yZWdpb25fZGVzdHJveShzdHJ1Y3Qg
ZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEpDQo+ID4gPiArdm9pZCBhZnVfbW1pb19y
ZWdpb25fZGVzdHJveShzdHJ1Y3QgZGZsX2ZlYXR1cmVfZGV2X2RhdGEgKmZkYXRhKQ0KPiA+ID4g
IHsNCj4gPiA+IC0Jc3RydWN0IGRmbF9hZnUgKmFmdSA9IGRmbF9mcGdhX3BkYXRhX2dldF9wcml2
YXRlKHBkYXRhKTsNCj4gPiA+ICsJc3RydWN0IGRmbF9hZnUgKmFmdSA9IGRmbF9mcGdhX2ZkYXRh
X2dldF9wcml2YXRlKGZkYXRhKTsNCj4gPiA+ICAJc3RydWN0IGRmbF9hZnVfbW1pb19yZWdpb24g
KnRtcCwgKnJlZ2lvbjsNCj4gPiA+ICANCj4gPiA+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZl
KHJlZ2lvbiwgdG1wLCAmYWZ1LT5yZWdpb25zLCBub2RlKQ0KPiA+ID4gLQkJZGV2bV9rZnJlZSgm
cGRhdGEtPmRldi0+ZGV2LCByZWdpb24pOw0KPiA+ID4gKwkJZGV2bV9rZnJlZSgmZmRhdGEtPmRl
di0+ZGV2LCByZWdpb24pOw0KPiA+ID4gIH0NCj4gPiA+ICANCj4gPiA+ICAvKioNCj4gPiA+ICAg
KiBhZnVfbW1pb19yZWdpb25fZ2V0X2J5X2luZGV4IC0gZmluZCBhbiBhZnUgcmVnaW9uIGJ5IGlu
ZGV4Lg0KPiA+ID4gLSAqIEBwZGF0YTogYWZ1IHBsYXRmb3JtIGRldmljZSdzIHBkYXRhLg0KPiA+
ID4gKyAqIEBmZGF0YTogYWZ1IGZlYXR1cmUgZGV2IGRhdGENCj4gPiA+ICAgKiBAcmVnaW9uX2lu
ZGV4OiByZWdpb24gaW5kZXguDQo+ID4gPiAgICogQHByZWdpb246IHB0ciB0byByZWdpb24gZm9y
IHJlc3VsdC4NCj4gPiA+ICAgKg0KPiA+ID4gICAqIFJldHVybjogMCBvbiBzdWNjZXNzLCBuZWdh
dGl2ZSBlcnJvciBjb2RlIG90aGVyd2lzZS4NCj4gPiA+ICAgKi8NCj4gPiA+IC1pbnQgYWZ1X21t
aW9fcmVnaW9uX2dldF9ieV9pbmRleChzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAq
cGRhdGEsDQo+ID4gPiAraW50IGFmdV9tbWlvX3JlZ2lvbl9nZXRfYnlfaW5kZXgoc3RydWN0IGRm
bF9mZWF0dXJlX2Rldl9kYXRhICpmZGF0YSwNCj4gPiA+ICAJCQkJIHUzMiByZWdpb25faW5kZXgs
DQo+ID4gPiAgCQkJCSBzdHJ1Y3QgZGZsX2FmdV9tbWlvX3JlZ2lvbiAqcHJlZ2lvbikNCj4gPiA+
ICB7DQo+ID4gPiBAQCAtMTE4LDggKzExOSw4IEBAIGludCBhZnVfbW1pb19yZWdpb25fZ2V0X2J5
X2luZGV4KHN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhICpwZGF0YSwNCj4gPiA+ICAJ
c3RydWN0IGRmbF9hZnUgKmFmdTsNCj4gPiA+ICAJaW50IHJldCA9IDA7DQo+ID4gPiAgDQo+ID4g
PiAtCW11dGV4X2xvY2soJnBkYXRhLT5sb2NrKTsNCj4gPiA+IC0JYWZ1ID0gZGZsX2ZwZ2FfcGRh
dGFfZ2V0X3ByaXZhdGUocGRhdGEpOw0KPiA+ID4gKwltdXRleF9sb2NrKCZmZGF0YS0+bG9jayk7
DQo+ID4gPiArCWFmdSA9IGRmbF9mcGdhX2ZkYXRhX2dldF9wcml2YXRlKGZkYXRhKTsNCj4gPiA+
ICAJcmVnaW9uID0gZ2V0X3JlZ2lvbl9ieV9pbmRleChhZnUsIHJlZ2lvbl9pbmRleCk7DQo+ID4g
PiAgCWlmICghcmVnaW9uKSB7DQo+ID4gPiAgCQlyZXQgPSAtRUlOVkFMOw0KPiA+ID4gQEAgLTEy
NywxNCArMTI4LDE0IEBAIGludCBhZnVfbW1pb19yZWdpb25fZ2V0X2J5X2luZGV4KHN0cnVjdCBk
ZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhICpwZGF0YSwNCj4gPiA+ICAJfQ0KPiA+ID4gIAkqcHJl
Z2lvbiA9ICpyZWdpb247DQo+ID4gPiAgZXhpdDoNCj4gPiA+IC0JbXV0ZXhfdW5sb2NrKCZwZGF0
YS0+bG9jayk7DQo+ID4gPiArCW11dGV4X3VubG9jaygmZmRhdGEtPmxvY2spOw0KPiA+ID4gIAly
ZXR1cm4gcmV0Ow0KPiA+ID4gIH0NCj4gPiA+ICANCj4gPiA+ICAvKioNCj4gPiA+ICAgKiBhZnVf
bW1pb19yZWdpb25fZ2V0X2J5X29mZnNldCAtIGZpbmQgYW4gYWZ1IG1taW8gcmVnaW9uIGJ5IG9m
ZnNldCBhbmQgc2l6ZQ0KPiA+ID4gICAqDQo+ID4gPiAtICogQHBkYXRhOiBhZnUgcGxhdGZvcm0g
ZGV2aWNlJ3MgcGRhdGEuDQo+ID4gPiArICogQGZkYXRhOiBhZnUgZmVhdHVyZSBkZXYgZGF0YQ0K
PiA+ID4gICAqIEBvZmZzZXQ6IHJlZ2lvbiBvZmZzZXQgZnJvbSBzdGFydCBvZiB0aGUgZGV2aWNl
IGZkLg0KPiA+ID4gICAqIEBzaXplOiByZWdpb24gc2l6ZS4NCj4gPiA+ICAgKiBAcHJlZ2lvbjog
cHRyIHRvIHJlZ2lvbiBmb3IgcmVzdWx0Lg0KPiA+ID4gQEAgLTE0NCw3ICsxNDUsNyBAQCBpbnQg
YWZ1X21taW9fcmVnaW9uX2dldF9ieV9pbmRleChzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1f
ZGF0YSAqcGRhdGEsDQo+ID4gPiAgICoNCj4gPiA+ICAgKiBSZXR1cm46IDAgb24gc3VjY2Vzcywg
bmVnYXRpdmUgZXJyb3IgY29kZSBvdGhlcndpc2UuDQo+ID4gPiAgICovDQo+ID4gPiAtaW50IGFm
dV9tbWlvX3JlZ2lvbl9nZXRfYnlfb2Zmc2V0KHN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9k
YXRhICpwZGF0YSwNCj4gPiA+ICtpbnQgYWZ1X21taW9fcmVnaW9uX2dldF9ieV9vZmZzZXQoc3Ry
dWN0IGRmbF9mZWF0dXJlX2Rldl9kYXRhICpmZGF0YSwNCj4gPiA+ICAJCQkJICB1NjQgb2Zmc2V0
LCB1NjQgc2l6ZSwNCj4gPiA+ICAJCQkJICBzdHJ1Y3QgZGZsX2FmdV9tbWlvX3JlZ2lvbiAqcHJl
Z2lvbikNCj4gPiA+ICB7DQo+ID4gPiBAQCAtMTUyLDggKzE1Myw4IEBAIGludCBhZnVfbW1pb19y
ZWdpb25fZ2V0X2J5X29mZnNldChzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRh
dGEsDQo+ID4gPiAgCXN0cnVjdCBkZmxfYWZ1ICphZnU7DQo+ID4gPiAgCWludCByZXQgPSAwOw0K
PiA+ID4gIA0KPiA+ID4gLQltdXRleF9sb2NrKCZwZGF0YS0+bG9jayk7DQo+ID4gPiAtCWFmdSA9
IGRmbF9mcGdhX3BkYXRhX2dldF9wcml2YXRlKHBkYXRhKTsNCj4gPiA+ICsJbXV0ZXhfbG9jaygm
ZmRhdGEtPmxvY2spOw0KPiA+ID4gKwlhZnUgPSBkZmxfZnBnYV9mZGF0YV9nZXRfcHJpdmF0ZShm
ZGF0YSk7DQo+ID4gPiAgCWZvcl9lYWNoX3JlZ2lvbihyZWdpb24sIGFmdSkNCj4gPiA+ICAJCWlm
IChyZWdpb24tPm9mZnNldCA8PSBvZmZzZXQgJiYNCj4gPiA+ICAJCSAgICByZWdpb24tPm9mZnNl
dCArIHJlZ2lvbi0+c2l6ZSA+PSBvZmZzZXQgKyBzaXplKSB7DQo+ID4gPiBAQCAtMTYyLDYgKzE2
Myw2IEBAIGludCBhZnVfbW1pb19yZWdpb25fZ2V0X2J5X29mZnNldChzdHJ1Y3QgZGZsX2ZlYXR1
cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEsDQo+ID4gPiAgCQl9DQo+ID4gPiAgCXJldCA9IC1FSU5W
QUw7DQo+ID4gPiAgZXhpdDoNCj4gPiA+IC0JbXV0ZXhfdW5sb2NrKCZwZGF0YS0+bG9jayk7DQo+
ID4gPiArCW11dGV4X3VubG9jaygmZmRhdGEtPmxvY2spOw0KPiA+ID4gIAlyZXR1cm4gcmV0Ow0K
PiA+ID4gIH0NCj4gPiANCg0K

