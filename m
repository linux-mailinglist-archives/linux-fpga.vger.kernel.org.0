Return-Path: <linux-fpga+bounces-723-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5196697CEA9
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 23:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DE01C20892
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 21:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFB1143C6E;
	Thu, 19 Sep 2024 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8oxD07Y"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210BB2B9B8;
	Thu, 19 Sep 2024 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779792; cv=fail; b=DnFcgNLli0q0Dkh8iVHPoKGl1HvEwVnlAJz39NBaRjZDOR1hhPXIecVmuvQdG7TOnIQm/xlXFHiakgduBL93hsGyhGUXh/ECTbJ9KTT8ZV2mfY8QWapcRUj2Ww91EoMRSRRLP9gRRa8Osao8cOjeChiTqS4SHmv+yUtmsPM/REk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779792; c=relaxed/simple;
	bh=Y7RBBaPqO3Gg09bBBzHzt+MfwPt3hS7ho1FPV88aNzw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lD4dwGnm8NrQaUiMUlLBgrkbdoUtplk5AsI252bEIJjWKTBsDKsUui1Rb5mU5hWdxH79cz+ZekozE4YtaB9qcVJTpLe8AvZ7wY5oAFLgSYNi4hKe1JfEVWAtNyjQ5LNpBE3WCRGe7NQaBIO4i/7Og2eLa185jSFScRbzJu4hzEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8oxD07Y; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726779790; x=1758315790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y7RBBaPqO3Gg09bBBzHzt+MfwPt3hS7ho1FPV88aNzw=;
  b=d8oxD07YJBrnWAtAOo/OJJukxm9OTWHCTX4RK2W61f4l0vHN0oLOFTpA
   +GYkFKi1mRsv92DdDnXtsLXZAqxoY6Ty7ocxhZgXh3EjZ4PeAsDJP11JU
   9VGfGWV9GutqXS+y7pUxEb9H4iFpVJW3KvJkTFd01RsH2Q6SCfNqwonGF
   +Naqy7n+wxTfnCVZ/EbSRUb5cXlRLFKXUvDUWtj/LNrtdOj9kbrGWkkeg
   iHO4c4RFv3hUnVJd9dhYv80ZPi6CxckbK6PpUr0QzNvPV0PblgvHjfoBC
   k7n3w9tH5DLMprNv8VT60FgCZjw+9yJS+N7z78/vT0RWuCA4AyJXIjPIi
   w==;
X-CSE-ConnectionGUID: uICxDe2rSOi51uz1wSh7nQ==
X-CSE-MsgGUID: RE7HuhEVQDmXKSWru9W4og==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="51180753"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="51180753"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:03:09 -0700
X-CSE-ConnectionGUID: BKegjd3OT3CrDH8pYww6Jg==
X-CSE-MsgGUID: 6ilmJcI/QOS9FfvikrMiRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="70195573"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 14:03:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 14:03:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 14:03:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 14:03:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 14:03:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogruOZ6ygaRmVxkWK4E6w/Ak344yt+ptLnHMfXZ0Y2IqJVTznZKOIiWjTchF+4Aqku1M5xEG4kuZoHJ4O7w2qaBTkwXWNH/BRC+4RGdTWb9TKW1qF7vVS1MUB7ls2iQRW+R7zl4UiaKWG4QqMvL80IsYpftFE/i5Z4IqMiKQn4UahUBvWBjfD/YDabMIcclcGk8824qeJZyAqNGcnKvmM2mXgFpD+cdrWK8OTs/BYcDRtKWN1Z9qwoYCZ3wi2kcIZ+9EjwtaCwXMFEKUz0U9kCqnSI+5dY1eQvpLkDnz3VrfnbFL2fKJU92BqPXzCB09YFHZJ4pQhluu51lejHt5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7RBBaPqO3Gg09bBBzHzt+MfwPt3hS7ho1FPV88aNzw=;
 b=gSFtgJO8N/Jn1of7sdUE79QvF49e5S09UxzfyNhpsgVDlPTIfPldAPUXQquOaxbXZtKH4ygW9C+iduEZIyYqPpBqN16DIjbcy/Um72wY/UJLC9eS9syjLUeMGIt5rlmnZwkzP7CODL3N8HI2GDmyovq1q7ysgD83rRoUPFvtsFyr9nNFqgN54hRsi+4bQLp0XNZh9XGi7fMbCkLE0wIYOHgaR1ArsQgL+r1pnC91Wd4WseHbAs448WXnnwvuhjLZzrj37a595yZWugB6podqJW7G5N6r26B1MfGZ9clqVEZ6kTzlyaI4P8ZbGszGmwsAN9IIf7UW15/3RNwUBo+CGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by PH8PR11MB7048.namprd11.prod.outlook.com (2603:10b6:510:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 21:03:04 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%5]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 21:03:04 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao"
	<hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>,
	"trix@redhat.com" <trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [RFC PATCH v2 2/9] fpga: dfl: migrate AFU DMA region management
 driver to dfl_feature_dev_data
Thread-Topic: [RFC PATCH v2 2/9] fpga: dfl: migrate AFU DMA region management
 driver to dfl_feature_dev_data
Thread-Index: AQHbCtdRBk7XNUVL2U+oDp94HlobEQ==
Date: Thu, 19 Sep 2024 21:03:04 +0000
Message-ID: <798f35f297ab05a7af2550b48476cbfcc9bfe42b.camel@intel.com>
References: <20240409233942.828440-1-peter.colberg@intel.com>
	 <20240409233942.828440-3-peter.colberg@intel.com>
	 <Zid4/GH1hL5YRboH@yilunxu-OptiPlex-7050>
In-Reply-To: <Zid4/GH1hL5YRboH@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|PH8PR11MB7048:EE_
x-ms-office365-filtering-correlation-id: 8afa8bdb-405c-49eb-0850-08dcd8ee7479
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Wmx5TVNWeDlYL1E1WGZTdEJUN3B5Unc0UGlUQ0ZNQTdJTkNZbFNuT0gzWmI2?=
 =?utf-8?B?ZmNGeWYwa2svVEh5Rm1WeDNGZHZEdkN5dllvNFl5VlZ5SEZVb05CNFI2bkta?=
 =?utf-8?B?b2dYUXZMY3pIeCtTaStlZHNLSFN5QUNSOHgySXRDTThBUDlpUU1nL1kyWlM2?=
 =?utf-8?B?SEN6STlQR1VJWXpOTTVRdW5ZL1U0RjFsaDZNbnRIRGpwNGRRbmVGVmVFMmo1?=
 =?utf-8?B?Yi9SdVRuMEdnOEUwVDZxTTA5amhZRThnQUFnU0hINlB2QXFlVFNQM0k1NDdl?=
 =?utf-8?B?TDNndVB1MUJ6emZTekRRaXl5dWZDbVVYQUx2a1pXVzJtaVZlZmxZb2ZHdnh1?=
 =?utf-8?B?OXcxeHF6NTVhUlVuM2NFZ01Wb3FrdUlNSHhrcmcyNTNGcU1vVm40cE5zckNS?=
 =?utf-8?B?bWNSQm0rc2N4Q0M5bkphQ1FSRnpnYmcyeWZkT2dFaUk4eUFpaDdjWXVybkN1?=
 =?utf-8?B?ckkzaWxmUzhEeTJYdEM4ODZVbUdtSzVsaXJ3SUJ2TW1vNmZ5dk1haDdpd243?=
 =?utf-8?B?S211MEd2d1ZwTGV1NmZVVWZ6S09INWkvWldxcURPendxdElkc2s1MDJ4QnNQ?=
 =?utf-8?B?MlJXRExnbDlqVzdTcWozQ2E2M3hVbGM1Y0VDaDd1Sm9pNzh2eTEzNEtFTUpR?=
 =?utf-8?B?Z2tsSUUyd05kODlRellVRVpsQU5ZZCtQdXI0NlRyd3h6NEtsZ0tpN1o2T05x?=
 =?utf-8?B?ckRzd3lHTWZPamRKRXVCN08xUXNiYW5EQkwvWHN6T0t5NENKRm5CNkU0bHlK?=
 =?utf-8?B?OWdwSmdxcktMaUhpQ2ZyWEF2YWFhNUtiQlBLRHhBeGpOU2FxODN0aS9BOGcv?=
 =?utf-8?B?KzFVeldsQ3BLQVVnNHBqK3htOHJrcTJrYlNDVlBqOUg0dkxEYUhDa1k5akNO?=
 =?utf-8?B?UlFMMmErZ2tBZURZcGEycU5lSURWUVloMWpydStzZlhkVlFicDFYemtaOWx3?=
 =?utf-8?B?bXhMVHlEUFptTE5DRTBRUVk0ME5EQUs5M2VJLzBFNmNRUlVWOVFkMHRuU2Nr?=
 =?utf-8?B?a1d3dVMvZDlmdGE4VTEzeTVPMVNIZUdYb0RzNVRsbUttejlLQjhSZnFnTWNK?=
 =?utf-8?B?SWlWRU80M3ljWnVSWFFJMVAvd29VWExKKzJsQSs3ZWVZV2wwZmR1ZXVFa3Bu?=
 =?utf-8?B?a1RCZUdjK092WWZSRGNWR2x2S0w4SmZQaVRiY3JVbkxlWHJKNjQxYndHY3ho?=
 =?utf-8?B?R01wbHN0ZWdncVJCWUVLdDM0VmxPZGxMOHBCREpGOHdVa2lEVVQrZ3JFblFF?=
 =?utf-8?B?aU82dzc3RUhSeWErSnNNUGlBcDBTYzc4VGJESXNWYnUyRXpKKzdETTdUQXg1?=
 =?utf-8?B?TXJ5K2FVUk5rSHdRd0p2NkRCOS9wUlpTOTRvdlNzTURxS3JPWVJKQkNTU1hu?=
 =?utf-8?B?NStJc3BHYVJYMTNJUUQ2dUFJYmt5NVJURFlGb1M2KzV2REZ6b2xuc1AyUERu?=
 =?utf-8?B?bURqbmhZMDRTUXd2VHMreUkzK2hqT1lSTVlOaEx3Z1NZRzMvd3pUcmlKRlNE?=
 =?utf-8?B?c2RvL05aY2hZM1FUOGdRdFJHNU9SeDlFM2IzZkNYNENrV0lKamFXNlkwbHho?=
 =?utf-8?B?dTN1ZjJNU1J5R3NJK3BraVVrdGxSWGxHaHBPRy9OSkxSNWZjL1NIeSswaW5B?=
 =?utf-8?B?QVpCeHJrT3FRdmZmdkRnVzJYT2dBaDhIWTVXMjR5eXUwa1pNOXUwNEdFcXZU?=
 =?utf-8?B?NVdEdlhkZy93MTBkU0gxcnMxMHkzODUyTHc0RVdjOExCanJaMzB0cmU1KzlZ?=
 =?utf-8?B?V1JoQWhZNWY2NjZvMXo5djNKOTE2eXNEZjFOd2VBQnA5MXo0KzJ3T09hT3hF?=
 =?utf-8?B?Z2FoWXVOdlJUeFVpUmhFRDJPTldyTVlNSTdST3k5VGVEeUVhdisreFdMMmtF?=
 =?utf-8?B?R1Yrd0pGd0Q2N0lYYU1JK1QzY3VPcnQ1Q25xUTRxWDNnaFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDBGYmVyVFlFS3puNGc3ZkdhQit4b0ZXbktEQmF3RmViRFVYZk14NkRUaHUv?=
 =?utf-8?B?UEl5K1R3bWozTmhkSitrTlRVZ3haUVh6aGZYd3dkbzBJSDVzTEs4Mi9ORmsx?=
 =?utf-8?B?TlFpUlJYdHlJUjlua0owS3ptZlJuWHNvbTNYYThWZEZoZDVsL0t4RDAwWG96?=
 =?utf-8?B?aEYwN0lnM1VxWGQ0Q2N2WW9ncDU5SWZVVWg2WUViV1NHSnZrUnhPT1RmdVVP?=
 =?utf-8?B?Y2V6SFBQTi94djZDNnRCRUJnVHBLM0tnNjRVOUR2Z050eUpJUFJ2OWNjYklh?=
 =?utf-8?B?azQrQ0EwV0t5Qy8vYUtQMVRDRHFaSU5tcEQrZ2ZNZEZNZm9uNXBmRm9TZU11?=
 =?utf-8?B?Nm56OWxLaHJnLzlOcCtCdDdPRzR6YXFQVXgvYzNmTVdDbHpSejRIMXpWdmFk?=
 =?utf-8?B?Y0QvcVE5NFNtcThOSkJMOW5nQ1BEQVFFWVl4RUh6TGYrbEh0OFRYZ1VsczAy?=
 =?utf-8?B?OTM1UDJlOTlsdldYZmlERjNLMTAwOVUzNjRWSy96UmFVVVFUdC8xK1ZVMkxM?=
 =?utf-8?B?R3MxTDFCQnhzeXU1anA1UnAyUWF2eUMyQ1pwb2llZEZtYVk4RGs4Q1UrNmEx?=
 =?utf-8?B?bkQzeUZMaUhadUdCNzAxUm80bVdRUzdKek5HRG5CaEpNakdDUXlpSWNlTkxX?=
 =?utf-8?B?cVZIY2ZnS2dodFhwa1dFZDkyNmxMbUxVTHJraSsySGhtWnZ0VXVFVXYrTGRO?=
 =?utf-8?B?QWpPcGsxTEI0aGxuUWNxd21zeTBoOGRwOGptZXhrUEMxaWFnWGVzc1dpcVNB?=
 =?utf-8?B?ZUp1SzJIZ1pVQ0hNNkh1TXJ1a2VOaGlENXFvaVp1OFJ4NGJQRU5qQ2l3Wlgv?=
 =?utf-8?B?b2NlcjhnK2ZTYmdEV2x4RXFHMGY4aytRWURIUmllM2ZBUytkUUkvVVNTeHZJ?=
 =?utf-8?B?ZDlzZDJYQTM1bGU1K3QyY1MxVkRvRDliS1FEazdZVG5tdENFaXJqdjZvZExr?=
 =?utf-8?B?bFpMVGdhWUNsR3d0L1RwNUtjMW1FTkc1NUhyME9yU25zdDVobFcwTC90dDR6?=
 =?utf-8?B?ZTNleGx3N1RWakkyUXMvK1VBeG1jeGZzK0Q0N1N1aWRYeEVjeHFIRm9FY2lq?=
 =?utf-8?B?eWZLYUpOQjVsdXdNWEJYblFFb0JmMmpOUzZ6bjBMRWljcks0VjRrR0lNcFQ4?=
 =?utf-8?B?NmxPb3A3MDE1UFZKR3NBQVJ4TGtlUTVobUd3Q0ZkKytRdlBJOUc5bkJxWERM?=
 =?utf-8?B?bE13OFNzckNGYktHZzg3ZGljaXF2eVlLeXdQK3k2S2g4VjZvY3hiYnBKN0Qx?=
 =?utf-8?B?dTBPbU5QeWtCWWRNTUlwOW1ldXRGRm9paFc0YWZuVkRQaTQ2T0JRZUVSYW90?=
 =?utf-8?B?bDVaZ0RBRFU1Z1Q3c0tWTmNuaVQ3TTZqZDBZNGN3SkRwYmdTa251YlhJY3FD?=
 =?utf-8?B?QklLQjF5b2xraWJuUFFJRndoOUhzYWZpN0hGNGhiVUJ6UFFNTTdhQlpIdFdX?=
 =?utf-8?B?NkNhQXhRakhZNjQrcGZNaTJzODJqYk1GSUFGeUYyaFpnRHlibkh6azdaRG8r?=
 =?utf-8?B?SEcrWDZ3S0tEUXg4cFd1STBWazBhZGlwMjNnWVNIVGNKeGx0WHBvd3B3WUo5?=
 =?utf-8?B?UHZHZ0tXbXZhZEVRR2NZTHNBem1reVpYS3B0Mkx1ajk0RkZGZFJPdHJ0eFJM?=
 =?utf-8?B?MUFHY2hvK2ZxcjI3VTFmRCt5U0pCdzBhMmQrL2s3TE42NGFLanN1Ym5qYzlY?=
 =?utf-8?B?aERXY1ZWYlVTK3pETVBhdm93SmZJaVJFalBHV1JMNmFPNmVKYkZIaGpwMmtR?=
 =?utf-8?B?eDk4QlZ6ZlI3R2tabkFyakdUSzlnb3VsVVRLdWtkVHRkbnZ3WkZzV2lSQ0Ri?=
 =?utf-8?B?NnVLTlA2Yml0NVpUejlaMnIrOGdldS9FUU1KWFhkRDg2RVh2Z2FRSkRwVmUv?=
 =?utf-8?B?YmhTRkN2eVBjYWQ4ZWNrTisvR3FQRFgzWUh0R1VzOFNmRy91RWRDeFZYRzdn?=
 =?utf-8?B?Q2c1QmFkckVEenJPdUt0MHZwNk5PZWFTSzFvNFlQdWh3clJ6d1FpcWxBZFZB?=
 =?utf-8?B?bjQ4aTNyMVpkbEFXZVY5L1hIb2RvcUhIZkVvZlJXVUNkcFVpL2JSZzZ1K3VY?=
 =?utf-8?B?cDdEUjd6bXpaZFJya2hoWXhFV2RjUmcyeXZ3MkZQWm8wYUY2cEMyNmc3L3dx?=
 =?utf-8?B?RDBOVWRvS1k3MmFUTjBBMHJ5VjI2UzRGUjRud1B6Q0taNy9YcHJQMG5ObnNr?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2132CE00CB8DC748A38D7FDB58B86572@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afa8bdb-405c-49eb-0850-08dcd8ee7479
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 21:03:04.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhM0LIH1tAF/hCUMyqH6UD+puiBGRGukiVVskCFLxRXgQLysTai6RZV4CWgmAAsUvZ+YORv4viJZbKVLw/WgGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7048
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTIzIGF0IDE3OjAxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VHVlLCBBcHIgMDksIDIwMjQgYXQgMDc6Mzk6MzVQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBUaGlzIGNoYW5nZSBzZXBhcmF0ZXMgb3V0IG1vc3Qgb2YgdGhlIHN5bWJvbCBuYW1l
IGNoYW5nZXMgcmVxdWlyZWQgYnkgdGhpcw0KPiA+IHBhdGNoIHNlcmllcyBmb3IgdGhlIGZpbGU6
IGRyaXZlcnMvZnBnYS9kZmwtYWZ1LWRtYS1yZWdpb24uYy4gDQo+IA0KPiA+IFRoaXMgaXMgZG9u
ZQ0KPiA+IHRvIHNwbGl0IGEgc2luZ2xlIG1vbm9saXRoaWMgY2hhbmdlIGludG8gbXVsdGlwbGUs
IHNtYWxsZXIgcGF0Y2hlcyBhdCB0aGUNCj4gPiByZXF1ZXN0IG9mIHRoZSBtYWludGFpbmVyLg0K
PiANCj4gVGhpcyBzZW50ZW5jZSBwcm92aWRlcyBubyB1c2VmdWwgaW5mby4NCg0KSSBoYXZlIHJl
bW92ZWQgdGhpcyBzZW50ZW5jZSBhbmQgZGVzY3JpYmVkIHRoZSByZXN0cnVjdHVyaW5nIGludG8N
CmxvZ2ljYWwsIHNlbGYtY29udGFpbmVkIHBhdGNoZXMgaW4gdGhlIGNoYW5nZWxvZyBvZiB0aGUg
djMgc2VyaWVzLg0KDQo+IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFBldGVyIENvbGJlcmcg
PHBldGVyLmNvbGJlcmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOg0KPiA+IC0gU3BsaXQg
bW9ub2xpdGhpYyBwYXRjaCBpbnRvIHNlcmllcyBhdCByZXF1ZXN0IG9mIG1haW50YWluZXINCj4g
PiAtIFJlb3JkZXIgbG9jYWwgdmFyaWFibGVzIGluIGFmdV9kbWFfdW5waW5fcGFnZXMoKSB0byBy
ZXZlcnNlIENocmlzdG1hcw0KPiA+ICAgdHJlZSBvcmRlci4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9mcGdhL2RmbC1hZnUtZG1hLXJlZ2lvbi5jIHwgMTE5ICsrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgNTggZGVsZXRp
b25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9kZmwtYWZ1LWRtYS1y
ZWdpb24uYyBiL2RyaXZlcnMvZnBnYS9kZmwtYWZ1LWRtYS1yZWdpb24uYw0KPiA+IGluZGV4IDAy
YjYwZmRlMDQzMC4uZmI0NWU1MWIxMmFmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZnBnYS9k
ZmwtYWZ1LWRtYS1yZWdpb24uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZnBnYS9kZmwtYWZ1LWRtYS1y
ZWdpb24uYw0KPiA+IEBAIC0xNiwyNiArMTYsMjYgQEANCj4gPiAgDQo+ID4gICNpbmNsdWRlICJk
ZmwtYWZ1LmgiDQo+ID4gIA0KPiA+IC12b2lkIGFmdV9kbWFfcmVnaW9uX2luaXQoc3RydWN0IGRm
bF9mZWF0dXJlX3BsYXRmb3JtX2RhdGEgKnBkYXRhKQ0KPiA+ICt2b2lkIGFmdV9kbWFfcmVnaW9u
X2luaXQoc3RydWN0IGRmbF9mZWF0dXJlX2Rldl9kYXRhICpmZGF0YSkNCj4gPiAgew0KPiA+IC0J
c3RydWN0IGRmbF9hZnUgKmFmdSA9IGRmbF9mcGdhX3BkYXRhX2dldF9wcml2YXRlKHBkYXRhKTsN
Cj4gPiArCXN0cnVjdCBkZmxfYWZ1ICphZnUgPSBkZmxfZnBnYV9mZGF0YV9nZXRfcHJpdmF0ZShm
ZGF0YSk7DQo+ID4gIA0KPiA+ICAJYWZ1LT5kbWFfcmVnaW9ucyA9IFJCX1JPT1Q7DQo+ID4gIH0N
Cj4gPiAgDQo+ID4gIC8qKg0KPiA+ICAgKiBhZnVfZG1hX3Bpbl9wYWdlcyAtIHBpbiBwYWdlcyBv
ZiBnaXZlbiBkbWEgbWVtb3J5IHJlZ2lvbg0KPiA+IC0gKiBAcGRhdGE6IGZlYXR1cmUgZGV2aWNl
IHBsYXRmb3JtIGRhdGENCj4gPiArICogQGZkYXRhOiBmZWF0dXJlIGRldiBkYXRhDQo+ID4gICAq
IEByZWdpb246IGRtYSBtZW1vcnkgcmVnaW9uIHRvIGJlIHBpbm5lZA0KPiA+ICAgKg0KPiA+ICAg
KiBQaW4gYWxsIHRoZSBwYWdlcyBvZiBnaXZlbiBkZmxfYWZ1X2RtYV9yZWdpb24uDQo+ID4gICAq
IFJldHVybiAwIGZvciBzdWNjZXNzIG9yIG5lZ2F0aXZlIGVycm9yIGNvZGUuDQo+ID4gICAqLw0K
PiA+IC1zdGF0aWMgaW50IGFmdV9kbWFfcGluX3BhZ2VzKHN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0
Zm9ybV9kYXRhICpwZGF0YSwNCj4gPiArc3RhdGljIGludCBhZnVfZG1hX3Bpbl9wYWdlcyhzdHJ1
Y3QgZGZsX2ZlYXR1cmVfZGV2X2RhdGEgKmZkYXRhLA0KPiA+ICAJCQkgICAgIHN0cnVjdCBkZmxf
YWZ1X2RtYV9yZWdpb24gKnJlZ2lvbikNCj4gPiAgew0KPiA+ICAJaW50IG5wYWdlcyA9IHJlZ2lv
bi0+bGVuZ3RoID4+IFBBR0VfU0hJRlQ7DQo+ID4gLQlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRh
dGEtPmRldi0+ZGV2Ow0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJmZkYXRhLT5kZXYtPmRl
djsNCj4gPiAgCWludCByZXQsIHBpbm5lZDsNCj4gPiAgDQo+ID4gIAlyZXQgPSBhY2NvdW50X2xv
Y2tlZF92bShjdXJyZW50LT5tbSwgbnBhZ2VzLCB0cnVlKTsNCj4gPiBAQCAtNzMsMTcgKzczLDE3
IEBAIHN0YXRpYyBpbnQgYWZ1X2RtYV9waW5fcGFnZXMoc3RydWN0IGRmbF9mZWF0dXJlX3BsYXRm
b3JtX2RhdGEgKnBkYXRhLA0KPiA+ICANCj4gPiAgLyoqDQo+ID4gICAqIGFmdV9kbWFfdW5waW5f
cGFnZXMgLSB1bnBpbiBwYWdlcyBvZiBnaXZlbiBkbWEgbWVtb3J5IHJlZ2lvbg0KPiA+IC0gKiBA
cGRhdGE6IGZlYXR1cmUgZGV2aWNlIHBsYXRmb3JtIGRhdGENCj4gPiArICogQGZkYXRhOiBmZWF0
dXJlIGRldiBkYXRhDQo+ID4gICAqIEByZWdpb246IGRtYSBtZW1vcnkgcmVnaW9uIHRvIGJlIHVu
cGlubmVkDQo+ID4gICAqDQo+ID4gICAqIFVucGluIGFsbCB0aGUgcGFnZXMgb2YgZ2l2ZW4gZGZs
X2FmdV9kbWFfcmVnaW9uLg0KPiA+ICAgKiBSZXR1cm4gMCBmb3Igc3VjY2VzcyBvciBuZWdhdGl2
ZSBlcnJvciBjb2RlLg0KPiA+ICAgKi8NCj4gPiAtc3RhdGljIHZvaWQgYWZ1X2RtYV91bnBpbl9w
YWdlcyhzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEsDQo+ID4gK3N0YXRp
YyB2b2lkIGFmdV9kbWFfdW5waW5fcGFnZXMoc3RydWN0IGRmbF9mZWF0dXJlX2Rldl9kYXRhICpm
ZGF0YSwNCj4gPiAgCQkJCXN0cnVjdCBkZmxfYWZ1X2RtYV9yZWdpb24gKnJlZ2lvbikNCj4gPiAg
ew0KPiA+ICAJbG9uZyBucGFnZXMgPSByZWdpb24tPmxlbmd0aCA+PiBQQUdFX1NISUZUOw0KPiA+
IC0Jc3RydWN0IGRldmljZSAqZGV2ID0gJnBkYXRhLT5kZXYtPmRldjsNCj4gPiArCXN0cnVjdCBk
ZXZpY2UgKmRldiA9ICZmZGF0YS0+ZGV2LT5kZXY7DQo+ID4gIA0KPiA+ICAJdW5waW5fdXNlcl9w
YWdlcyhyZWdpb24tPnBhZ2VzLCBucGFnZXMpOw0KPiA+ICAJa2ZyZWUocmVnaW9uLT5wYWdlcyk7
DQo+ID4gQEAgLTEzMywyMCArMTMzLDIxIEBAIHN0YXRpYyBib29sIGRtYV9yZWdpb25fY2hlY2tf
aW92YShzdHJ1Y3QgZGZsX2FmdV9kbWFfcmVnaW9uICpyZWdpb24sDQo+ID4gIA0KPiA+ICAvKioN
Cj4gPiAgICogYWZ1X2RtYV9yZWdpb25fYWRkIC0gYWRkIGdpdmVuIGRtYSByZWdpb24gdG8gcmJ0
cmVlDQo+ID4gLSAqIEBwZGF0YTogZmVhdHVyZSBkZXZpY2UgcGxhdGZvcm0gZGF0YQ0KPiA+ICsg
KiBAZmRhdGE6IGZlYXR1cmUgZGV2IGRhdGENCj4gPiAgICogQHJlZ2lvbjogZG1hIHJlZ2lvbiB0
byBiZSBhZGRlZA0KPiA+ICAgKg0KPiA+ICAgKiBSZXR1cm4gMCBmb3Igc3VjY2VzcywgLUVFWElT
VCBpZiBkbWEgcmVnaW9uIGhhcyBhbHJlYWR5IGJlZW4gYWRkZWQuDQo+ID4gICAqDQo+ID4gLSAq
IE5lZWRzIHRvIGJlIGNhbGxlZCB3aXRoIHBkYXRhLT5sb2NrIGhlb2xkLg0KPiA+ICsgKiBOZWVk
cyB0byBiZSBjYWxsZWQgd2l0aCBmZGF0YS0+bG9jayBoZWxkLg0KPiA+ICAgKi8NCj4gPiAtc3Rh
dGljIGludCBhZnVfZG1hX3JlZ2lvbl9hZGQoc3RydWN0IGRmbF9mZWF0dXJlX3BsYXRmb3JtX2Rh
dGEgKnBkYXRhLA0KPiA+ICtzdGF0aWMgaW50IGFmdV9kbWFfcmVnaW9uX2FkZChzdHJ1Y3QgZGZs
X2ZlYXR1cmVfZGV2X2RhdGEgKmZkYXRhLA0KPiA+ICAJCQkgICAgICBzdHJ1Y3QgZGZsX2FmdV9k
bWFfcmVnaW9uICpyZWdpb24pDQo+ID4gIHsNCj4gPiAtCXN0cnVjdCBkZmxfYWZ1ICphZnUgPSBk
ZmxfZnBnYV9wZGF0YV9nZXRfcHJpdmF0ZShwZGF0YSk7DQo+ID4gKwlzdHJ1Y3QgZGZsX2FmdSAq
YWZ1ID0gZGZsX2ZwZ2FfZmRhdGFfZ2V0X3ByaXZhdGUoZmRhdGEpOw0KPiA+ICsJc3RydWN0IGRl
dmljZSAqZGV2ID0gJmZkYXRhLT5kZXYtPmRldjsNCj4gDQo+IERvbid0IGludHJvZHVjZSBhbnkg
b3RoZXIgdW5uZWNlc3NhcnkgY2hhbmdlcyBpbiB0aGUgYmlnDQo+IHN5bWJvbCByZXBsYWNlbWVu
dCBwYXRjaC4gIFBlb3BsZSBjb3VsZCByZWFkIG92ZXIgYWxsIHRoZSBzYW1lDQo+IHJlcGxhY2Vt
ZW50cyBxdWlja2x5LCBldmVuIGlmIHRoZXkgYXJlIG1hc3NpdmUuIEJ1dCBpZiB0aGVyZSBhcmUN
Cj4gc29tZSBvdGhlciBjaGFuZ2VzIGluIGJldHdlZW4uLi4NCg0KSSBoYXZlIG1vdmVkIHRoZSBh
ZGRpdGlvbiBvZiBsb2NhbCBgZGV2YCBwb2ludGVycyBpbnRvIGEgc2VwYXJhdGUgcGF0Y2gNCiJm
cGdhOiBkZmw6IGFmdTogZGVmaW5lIGxvY2FsIHBvaW50ZXIgdG8gZmVhdHVyZSBkZXZpY2UiLg0K
DQo+IA0KPiA+ICAJc3RydWN0IHJiX25vZGUgKipuZXcsICpwYXJlbnQgPSBOVUxMOw0KPiA+ICAN
Cj4gPiAtCWRldl9kYmcoJnBkYXRhLT5kZXYtPmRldiwgImFkZCByZWdpb24gKGlvdmEgPSAlbGx4
KVxuIiwNCj4gPiArCWRldl9kYmcoZGV2LCAiYWRkIHJlZ2lvbiAoaW92YSA9ICVsbHgpXG4iLA0K
PiA+ICAJCSh1bnNpZ25lZCBsb25nIGxvbmcpcmVnaW9uLT5pb3ZhKTsNCg0KVGhhbmtzLA0KUGV0
ZXINCg0K

