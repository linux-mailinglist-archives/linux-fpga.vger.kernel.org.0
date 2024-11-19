Return-Path: <linux-fpga+bounces-949-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F449D310C
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 00:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34289283DB8
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Nov 2024 23:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF7D15443F;
	Tue, 19 Nov 2024 23:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9rSqCMg"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A633F194A54;
	Tue, 19 Nov 2024 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059969; cv=fail; b=YSUD3SxowqWSZdHTNuvEllMxMGbe6HK0uO/9uLH8ayKZrrrV2vhdNVRBH95oNIhgsJ4VAkEpiwtP2cw/Ts52Tg5njCfi3aVv/9cOnFdAvSJW01+0c9x9cvPrgqL068VuVlrtffwHSCfdAvRT8LlWdeNyR+w1AB9utrYInfCEo8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059969; c=relaxed/simple;
	bh=9YaekoOvOdGhDhZjark5/F/lZiB9azPwjxWvGavXTDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UKFLpmEuqFmXR4SFCFJAroekWtk6cKnzREdqb7jUj+87h7ultHmW/KC+YrxigjlsR0q8vN2K5CjIMfXyI5ANMwDHJOZs5GR8LbEXeXkhxl+pM91ypvujKyqjb/MqdhO7dLtYAL4jg5fgDd5ymuqK2QAAG3qSM6DWY9Qw9BdPlL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9rSqCMg; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732059967; x=1763595967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9YaekoOvOdGhDhZjark5/F/lZiB9azPwjxWvGavXTDY=;
  b=O9rSqCMgKsiUSqlOwB1IgiN0SCMigYsbJGTKNgKO4Q5M/D6Q6js6BkEa
   /qVkFliAdfGH5teEFNw5uDyGAdzuPk2pYSEIHGltkQ4brrlAi/bWq/RFA
   noqXyUuVEk8cgro5UaL411cdikFWLbT9rFFR0GgEuUR9GRNcPIWFCAfLy
   mERyH+BS6ft/lvePXml8WtY29b2TeLHvVsD0rJmkxljA+0LFZfydN4347
   K9ic964WiHlKRquZSWWRzZxSC04jrcmVYMDMBfFLutU1dk+FZs2Weiyyc
   drPpe3fCQZfwSynNOpUr5d192NS0yERvjmSxVCuB5NpKD2I8XZsQwHThg
   g==;
X-CSE-ConnectionGUID: k1JCSBGAT+iM2Vjzl9/EiA==
X-CSE-MsgGUID: eSxjNCflSgG1Wx5fZ2fA2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42605866"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42605866"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 15:46:07 -0800
X-CSE-ConnectionGUID: zz98BpWfQZ2TKAHTg3Pdkw==
X-CSE-MsgGUID: aGL1oCkRTcWbIfbCzC+J/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93793001"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 15:46:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 15:46:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 15:46:06 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 15:46:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4amdmwAZ0/XcUT4JvCA+t5SFxxugUge2qIZk7Isx95UgAS/h0vsAEg63nPYlyqoOn5uY3iuEJxdXz4X+FqNykVHYZGzE5el3Q4ZrkFG8oTcvnbLedVBoQNj8IzTdsl0Y2hNbfqU8pylZYO4g57QAscDnZe729mR8Rzde8YQHpe0mizy1UaZYRSwDwj2F3Z6g3hjms8rWr7D35jZQ6mUokeWByb+83INn1kcBIXeGgaat9YFeVfC7KP1jZdHvSQip9msZwFRyYopvbOM7MjV0VHQunLqn5YiNqJL6uTdP0+O2l/i0fBRN5juCcPvs0HXLO5sM5FwOVkcX8tbDHrYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YaekoOvOdGhDhZjark5/F/lZiB9azPwjxWvGavXTDY=;
 b=bo2J7V0op1Z2sZ8BeYsstNjYEFTdq7uyA4OvpoY+jDeH/F3j5saJhZovOYsj/SL7TEfGqT7AT02/BDq7iVxw2igtkSzUDdpFzLUw100Yvs5ECSzOedZ0Qdo6ScAhDrO/NjdFdV43FingccAtId0jSo+eG6FV0isGM+lg9IrHTeGb3KK6t3ge0pOvZDhyWv06M626PHW+Z22nQfW1wUxrT3KKSd7dVVn9D7KaQFqRHE8uaFr3ago14Q0q5Xj63Mmz9G5v6qMjFx+47kfrPq4ARWdX1p+WMT9NVJ2vTnTC0iecpKHMPGdvVe5SZj4c9vryBLkOFhYgEdGXspDRT+meCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by IA1PR11MB7248.namprd11.prod.outlook.com (2603:10b6:208:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 23:46:03 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 23:46:03 +0000
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
	<matthew.gerlach@linux.intel.com>, "russell.h.weight@intel.com"
	<russell.h.weight@intel.com>
Subject: Re: [PATCH v4 19/19] fpga: dfl: destroy/recreate feature platform
 device on port release/assign
Thread-Topic: [PATCH v4 19/19] fpga: dfl: destroy/recreate feature platform
 device on port release/assign
Thread-Index: AQHbOt0wGiLIueRVSUyBDwU8LBoIhg==
Date: Tue, 19 Nov 2024 23:46:03 +0000
Message-ID: <505592bce45ce352e10a7e7ac9f5c1e67669f455.camel@intel.com>
References: <20241025223714.394533-1-peter.colberg@intel.com>
	 <20241025223714.394533-20-peter.colberg@intel.com>
	 <ZztYlcidn3zU2vn5@yilunxu-OptiPlex-7050>
In-Reply-To: <ZztYlcidn3zU2vn5@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|IA1PR11MB7248:EE_
x-ms-office365-filtering-correlation-id: 13069179-b5d6-45ff-e6e3-08dd08f4543e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Ti9scmVKMDJRcU9VUFJRalc5RUtHQ0o3aDBnNVozNzBucWtUSTlDWExBSzVO?=
 =?utf-8?B?azM5UW1ZbVJuNlpTRnFHYmwvUDB1ZEhXVVJ0K3ZJR1l3bEQ0VDhyZ2tzWVk1?=
 =?utf-8?B?KzBYR0hWNWE5Rlc4TXhtYXd6M1N0dmRjaDd6Y1QrVUtjS3lEVGdLTnhaNGJZ?=
 =?utf-8?B?Y29CbTZhZWZmZlh2WUdvSk9VSjRXWU9tRWhTNjRDazZaTlRVekh5amx5K3hY?=
 =?utf-8?B?dGxnQ002OXArREVsclNGeTZjUE5hZUFveEFjVGw3alRPb1NNbEdJUnU5QkJY?=
 =?utf-8?B?ZFVOc1VOa0N6aE9GcVlpVW1GK2k5dzErTW1keUN4eklBU0taTm5Hc2JPV1E4?=
 =?utf-8?B?Ry84Y1BPUVZvcnRiZ05KN3lTMlkzL3pBbXc1YzZSaU5Bdm5hUnpMOUhoeDNV?=
 =?utf-8?B?aVJuYU94WUFBY3dWS3ZaUDlpa0ZhS2ZCMkFmbmVsZ2N4alk0eDkvb1YxZkZr?=
 =?utf-8?B?UUpQVW1seGYyN05majk1QWtDSExLMTc5OTZFcjV3V0NwSjJlMlJUV2EvaFo4?=
 =?utf-8?B?K0xFcTBCd3YzV1hyWW5OYmZhUGZ0UGg4MUg1TVZ5cm55Tk9HQmRJMXJIeGVD?=
 =?utf-8?B?ZHdmMEs4MnAybGNzN2lWYU9WNUtzNlpaN1JsaHp5UUxxYTI0eW1yYTV4KzlR?=
 =?utf-8?B?aXdwRW5uQzB3RzEzNnJ5Ym1ySmRjRkVScmNvSit4YW9KcmE3U21NcVFNdnBr?=
 =?utf-8?B?ckI0cm9xUlB0UVI4MWgrUTVwU2tzTmdDakVVQmtLNDdnKzdWWEE5alR0UVhU?=
 =?utf-8?B?N3pCdU13dGtGMStIblZZV0RvSnJyOTUxWC9kRWxOTW1STnFwajRnVjEveXJD?=
 =?utf-8?B?bUFaZitUYlhzdHZVYkJuakoycjVtd0pkRnE4aWJpamFncm85cytDQjJYcVNU?=
 =?utf-8?B?VXFZVFFsb0l4NUtwWk90bmw2bVN0dTZIb21JdWNsOWxLM2FTazhWY20rS2Mz?=
 =?utf-8?B?cyt0SmQ3dUFTTC9IRGQwMk9BZEpkTkpLUFIvL0I2d0h1Z0t4RklCZmZheFNV?=
 =?utf-8?B?ajlJVXFWYnhRaURWdDVhMWw4T0w3cy9oRHhvbjY3M2Y1L0U1SnVNYzRXd1h0?=
 =?utf-8?B?VkRQakgwZWJUZGlEZityQWRCRTg2NXhTUk1LS2dQbVlkN2JLT09UVytldkdC?=
 =?utf-8?B?K1Z3RVdqRm1nMjBlTE0yUUd6YXZVQ0pIRVdLekFtd0EzWHJQOTB3UnVhZmNq?=
 =?utf-8?B?Z2tiN1c5ZGxFN1dVWUZQcWJBSmJiRFUwQWJFQ0NoYXhXV1lueUd3b1FyM1Jv?=
 =?utf-8?B?L2RQcG16UzErWmZOTmRtRlpEYVQ0dGhhcE9SSWx1SHdSdzl1NXFJdjVoMjJj?=
 =?utf-8?B?QXdhTmJFZlRtdTJKNS85V3JTQUJBZnlFd3BDY2hrOGswNlFYM24rRFNsYmJ3?=
 =?utf-8?B?Mm1CVjVUdlVuNTBwWUVJbVJCQTNzSUx5LzhTL0I0YTBacDlKc1cyS3BtNnFB?=
 =?utf-8?B?Y3lGVzUzc0kwMGloQUF2aEFVS3lkYVY1cVhGZEF4R2ZrdXZ6cFNCZWxBcmpm?=
 =?utf-8?B?dGpIRzcvWk9sQ2p3SGorV240VUx1Z3JpNy8wMFArK2JuL3U3Q3hJKytSY0hC?=
 =?utf-8?B?Qm94MVpCb29xdGMxL1YybzRnQUg5RTh5U1RTU3VPQVNuWXFOb00wV2h3cDQ3?=
 =?utf-8?B?SkRBcW1yUmhiTmdaajIwY0lTa3JHR1pWR3EyVlRDMDh3bCt5M1cwMlJaZlFn?=
 =?utf-8?B?V0lNS1JkbzY1TXRtdFVPRGoyZ3NjSFJkNUtybmRRSml4TDdlVzlnYTRNOTFp?=
 =?utf-8?B?dEI2dVdqQjkxQmxIMWJhVTI1UTFjRjlrS0ppVW5SbHl4V3c4a2JWR2N0V21Y?=
 =?utf-8?Q?xwrVuDeeWX7W5Oc5+VNQds++5LsaYTE3Jjzn8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnpIWVhWUTNTMEJEcE40anBhbzBpV3gvSnZTZW5BR2p5UUJYN3NhVmowQlJ4?=
 =?utf-8?B?elJxRVdvSVBhNXpJWmhQMWFPejkrZ2RNVW9HUlBOY0lsYmRrOUtaN2g4TjEw?=
 =?utf-8?B?ZTBFOUUzRGVKdE1SOVNLOU1JZ2VoNmQyQ1owckd5bnJLRCtlNG1ERTVPZlhx?=
 =?utf-8?B?cTY4SXVDOWdOTEJnanFzM0NyczRwVEVDTFFraXpheVhVMmZZSDZDL3ZLNENG?=
 =?utf-8?B?RVZvVnkzRnY5OFBma1RtU3pkOVE0K01IUGZXVjMzYzY2TUYxZU1PaGg4SUE3?=
 =?utf-8?B?ZHA4ZnQwS1dlZGQ2TWo3U0krSU5WNVZIS0pFSjdLTTJrYndtYk4wdGJaMUNw?=
 =?utf-8?B?VGdpYW1DNEVIWFZZcnd0bFM2ekczSnpZVVlma1RVcFo5aFE3a0hwR0ROaE9s?=
 =?utf-8?B?NG84b3lSMFZPdXR0TTJxMVV2d1dXeTdCN1VJakFDMG5lZ1V1RExyVHRBVUlV?=
 =?utf-8?B?ZTJMWnNwaDdnclEzUTBDSVJ1NVFFUWJhVVBaOTR3Q3AzMjlrUXhNTTFZRXFw?=
 =?utf-8?B?N0J6cXU0NE91alorS1oycXViaWRyZlV6eGFBOHRQWlUwSE5UeWV2RnNJTVR3?=
 =?utf-8?B?Um1hQzVaSUJ4N2UrdjEwM0pGR1d6UGxDMWRJd1BINGtXSmcwSldhVmZpUFM3?=
 =?utf-8?B?Zy9wMmpMdU1pSzRzS2EzeERYNW4wTmRVOU1kbE1TbE9KTDBvaUtUMDF6UUg1?=
 =?utf-8?B?eG80Y0RFeTYyNk1raFY3K2dwbTdCbnhScHVPNWhTMGdWTTkxV3RJQVhZZXda?=
 =?utf-8?B?NGNyOHMvbDN0dk9rU1F0aUJUU053ZzRkN1ZnUGltQ05va0pmTWZzSzFUOTBP?=
 =?utf-8?B?MndTc082N2t1MzFTN2lVUWN0emxBZnJDNWdYYkhxVzVjSERKazR6Z3ZWOUh2?=
 =?utf-8?B?M2tzdTdXQVJXY1N6cFVrb2FXb05ZL0xrNXdLbkNkUEhOckoxOStOUWRXcERa?=
 =?utf-8?B?a1prRzlUZ0c3ZEN3VXdRVXZvbGlZMFJhN3dWTFZoU1RjcTVNbFF4UVZwdmNp?=
 =?utf-8?B?VktETFhiWkc1NG9mMGRHTncxcDM4Q3d6alZUajE0Rmd0OTRUWHV0eDU3OHl3?=
 =?utf-8?B?a1hqQnc0clVYRCt2NGVvMzlnQi9XWFoySUFxcWZzM0FSbGZObjRXN2lDM2Ez?=
 =?utf-8?B?YVg3OWU2b0lualBDOG5VYzRRVlpGWjA3U3gwN3hiQ2dnc1pWSVN6WXRUVmsz?=
 =?utf-8?B?VHN3bC90bXNrUlZiL1A4VkNtVkYxY3lwVG44QVZxUWFkOEQ2MGdzRytMTVBT?=
 =?utf-8?B?U1phSFpqbGE3RnJQbVFBdC91QzVWZnRoa2U2WmF4ZTNWSlg0dGFZeVExbS95?=
 =?utf-8?B?OFBLYnZhcXVRSnp2NGEzK0J1T3dEanFsWHIxS1RRVTFnbTk2L29LTFU1K2lG?=
 =?utf-8?B?YThqRXdod3cwaFZtcTkxVEZZQ1R6VDE3RGxxeUxLT2dYSnkrVzZQNW5jQmVm?=
 =?utf-8?B?NnE3ZWROanhrcm9kUnUzbGFzNnFyTzBPZCtHRFg4di81UEJsT2xmZ0tza0Vt?=
 =?utf-8?B?Rk1lWjJWQkZNa0xjdnRxL3pGVmNzZW13TDcvK0twam9jM0FyTldwY1I4RkRB?=
 =?utf-8?B?NURteFJrbkVXbjFMMzROYVJHOGNSVi9ZR05PYUpNVEx3UUJoTGlyUWRVZlUz?=
 =?utf-8?B?NHVUWEdlREdMUEFZS2lSRFljMHRQTXA2UEJBOGJLVWFTMHpEaWREMDN2TjZj?=
 =?utf-8?B?QU1neFY5Tk9qY2RJZlI2OUZaZGc3bkZmQi9iSGhkNW1MZjlSVDdaMU5zZUJk?=
 =?utf-8?B?d2Q0NDdWdWREb1JrUnREZlZ2NnBaOGlpWExFVUtuYUtsS3Vkd2NTK1B5M203?=
 =?utf-8?B?alRCcGY1a2FvOWcrMkpuenRqOFJKcmNKbncyY2xUYzc2MDhhOFVYWjgwdmVL?=
 =?utf-8?B?YXMvQ0VLZmQ4ZDZLTklBYzVnSGlmZDArQ2FUak5UZGNzMkZSZWxnUXZ1eWRz?=
 =?utf-8?B?MThhYzJBbGdGWTJrQmxiMHM5aCtOWGFRMlZRVVJCRUU5bTRUbHBtdjc5ZEYv?=
 =?utf-8?B?Z2d0ZlhyTjJSN1dDNFg1ejFQcUNoS2FvSFZYbGdaempaMG5yYzRCSEp5QzI3?=
 =?utf-8?B?K3hYbzJWaEdXWWhRY0g2dUl0VmRLck5DcS9YQU5vbk9kcVhkYm5hWGxWaytm?=
 =?utf-8?B?MVA2eTAzYnVWTmQrR29DSjF4bHU1MjdQTTg5K1dqZGRJSTU1MVlMTTBxZjN5?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAC9B15707EBE04F80CA75DA95CEA3EE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13069179-b5d6-45ff-e6e3-08dd08f4543e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 23:46:03.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KhGxwDyK2gijz9Hw9eo0ZaWhvYLP339YyJLIXSfB98nr13zQE1pb2g+V7VipmiadndPTJDX9CzuBUCcQpKJLpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7248
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTExLTE4IGF0IDIzOjA5ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
RnJpLCBPY3QgMjUsIDIwMjQgYXQgMDY6Mzc6MTRQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBGcm9tOiBYdSBZaWx1biA8eWlsdW4ueHVAaW50ZWwuY29tPg0KPiA+IA0KPiA+IE5v
dyB0aGF0IHRoZSBpbnRlcm5hbCBERkwgQVBJcyBoYXZlIGJlZW4gY29udmVydGVkIHRvIGNvbnN1
bWUgREZMDQo+ID4gZW51bWVyYXRpb24gaW5mbyBmcm9tIGEgc2VwYXJhdGUgc3RydWN0dXJlLCBk
ZmxfZmVhdHVyZV9kZXZfZGF0YSwgd2hpY2gNCj4gPiBsaWZldGltZSBpcyBpbmRlcGVuZGVudCBv
ZiB0aGUgZmVhdHVyZSBkZXZpY2UsIHByb2NlZWQgdG8gY29tcGxldGVseQ0KPiA+IGRlc3Ryb3kg
YW5kIHJlY3JlYXRlIHRoZSBmZWF0dXJlIHBsYXRmb3JtIGRldmljZSBvbiBwb3J0IHJlbGVhc2Ug
YW5kDQo+ID4gYXNzaWduLCByZXNwZWN0aXZlbHkuIFRoaXMgcmVzb2x2ZXMgYSBsb25nc3RhbmRp
bmcgaXNzdWUgaW4gdGhlIHVzZSBvZg0KPiA+IHBsYXRmb3JtX2RldmljZV9hZGQoKSwgd2hpY2gg
c3RhdGVzIHRvICJub3QgY2FsbCB0aGlzIHJvdXRpbmUgbW9yZSB0aGFuDQo+ID4gb25jZSBmb3Ig
YW55IGRldmljZSBzdHJ1Y3R1cmUiIGFuZCB3aGljaCB1c2VkIHRvIHByaW50IGEga2VybmVsIHdh
cm5pbmcuDQo+ID4gDQo+ID4gVGhlIGZ1bmN0aW9uIGZlYXR1cmVfZGV2X3VucmVnaXN0ZXIoKSBy
ZXNldHMgdGhlIGRldmljZSBwb2ludGVyIGluIHRoZQ0KPiA+IGZlYXR1cmUgZGF0YSB0byBOVUxM
IHRvIHNpZ25hbCB0aGF0IHRoZSBmZWF0dXJlIHBsYXRmb3JtIGRldmljZSBoYXMgYmVlbg0KPiA+
IGRlc3Ryb3llZC4gVGhpcyBzdWJzdGl0dXRlcyB0aGUgcHJldmlvdXMgZGV2aWNlX2lzX3JlZ2lz
dGVyZWQoKSBjaGVja3MuDQo+IA0KPiBBY2tlZC1ieTogWHUgWWlsdW4gPHlpbHVuLnh1QGludGVs
LmNvbT4NCj4gDQo+IGZvciB0aGlzIHBhdGNoIGFuZCBhbGwgb3RoZXIgcGF0Y2hlcyB0aGF0IEkg
ZGlkbid0IGNvbW1lbnQgaW4gdGhpcw0KPiBzZXJpZXMuDQoNClRoYW5rIHlvdSBmb3IgdGhlIHRo
b3JvdWdoIHJldmlldyBhbmQgeW91ciBndWlkYW5jZSBpbiBjb252ZXJ0aW5nIHRoaXMNCmNoYW5n
ZSBpbnRvIGEgc2VyaWVzIG9mIHNtYWxsIHBhdGNoZXMgdGhhdCBhcmUgZWFzeSB0byByZWFzb24g
YWJvdXQuDQoNClBldGVyDQoNCj4gDQo+IFRoYW5rcy4NCj4gDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogWHUgWWlsdW4gPHlpbHVuLnh1QGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBS
dXNzIFdlaWdodCA8cnVzc2VsbC5oLndlaWdodEBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogUGV0ZXIgQ29sYmVyZyA8cGV0ZXIuY29sYmVyZ0BpbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQt
Ynk6IE1hdHRoZXcgR2VybGFjaCA8bWF0dGhldy5nZXJsYWNoQGxpbnV4LmludGVsLmNvbT4NCj4g
PiBSZXZpZXdlZC1ieTogQmFzaGVlciBBaG1lZCBNdWRkZWJpaGFsIDxiYXNoZWVyLmFobWVkLm11
ZGRlYmloYWxAbGludXguaW50ZWwuY29tPg0KDQo=

