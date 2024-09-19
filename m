Return-Path: <linux-fpga+bounces-727-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DC697CED1
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 23:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61DFEB217FC
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 21:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A2A1474D3;
	Thu, 19 Sep 2024 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHRqr+Ko"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF88142E70;
	Thu, 19 Sep 2024 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782209; cv=fail; b=K+ii4ePCQQPnGB+kmOaYJYL5k0LjmNgp1OVJLF9LA436jV16DLrU4Hh06/Y+51WbYM03plneEL5CaD1HvZqDNX+o8UWLUSgxynrU0xSO6mZOcMO4UF1VihYvJgObnieYtUCtfbR1E5eJIybFa95gOXN8UPz8SRNtGymm1kAjF7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782209; c=relaxed/simple;
	bh=uny6Df/6fp2JTq+c/lsNrlrSxVw8YZLp6YDgS+eSckM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dK5Tr979rjmjx66/VXeS12afkeFiUAdmzFE+/FTXoOCSHYBljOMJmxcoQ+rl3hGMG/HQrrq9FNoiwYQd9zj2Rlj42CAdljt7F2PLQuh3pczTCHHD597BUUduDgrTNXTFfn8k7A/2n5HV5pMQqiqT1gNif8cEMDYGb8FP4vhs2Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHRqr+Ko; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726782208; x=1758318208;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uny6Df/6fp2JTq+c/lsNrlrSxVw8YZLp6YDgS+eSckM=;
  b=LHRqr+KorFlkMCqvy2u4Kydi4NFUmxUcIU85Zy7RSCSB3fTSPyHUc63E
   T+3cIQQczFpneTsn7patagLioSvGHZ3kHl5ij1784IGVZl4X/LpWgqbPp
   0rMReOrUxB+Vc1/g190Z+nwT8eEH0fZoU/2QBNJgoyNj3C07gEQ/Kbqoo
   /4rry7pq7nWIr72ov0/5veCx7Z5IIB/VQd6WOUPnlJGlILOqyN+/O5c7p
   4Aghq4B+bAuqrngxJDfiB/H9u0CUlY1Cm+7zEY/N7t0vQiFYbVsYhlsR8
   SAzAfy/DKH3hhzTxp7wOf0053bHhk6Q0Gtv5sHtGDWdsom6apW/TrGTqo
   g==;
X-CSE-ConnectionGUID: Kd7BUHzsTX63zUg8RAUqGg==
X-CSE-MsgGUID: yVgrD2yTTYu2Pa85PA6GEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="43292790"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="43292790"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:43:02 -0700
X-CSE-ConnectionGUID: +cO81oWQT0C2vLueIn+rBw==
X-CSE-MsgGUID: uZgguhA/SDSVR/W8CVlX5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="74859035"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 14:43:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 14:42:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 14:42:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 14:42:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 14:42:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HA5lezSFDr6JmuOdStD6Yy9neH55cSukMZgxQ7ZVA+8G1NeMPuSpM+4BMidDGwhbm96qvUfl3gOMn8zyTOaxBbR+Jw6/Y8Ic3f+MstBG27lUoK1328lj6CrCZanPNdmXkTjaVIQdb0jIPfurgU8lGf4cDBmHnTpwy+7S21VMJvhBS/Q28QgWxXv/3k0qYA5Eu/tBQKuGguZvqGPRk3xgCWiouRxTPYM/Ww5KQEBj8pXpZZgpWfRRG8J07JbP15BUewwluTRsH7zy9Rwue4Zo90KCkVO0net+DPbY23l+0m6YltoJ57x7WfbHKCSnFZw83GZr23vaoqdTvZHG1Kn38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uny6Df/6fp2JTq+c/lsNrlrSxVw8YZLp6YDgS+eSckM=;
 b=qCUAab4EVxhz5QkSbyZg3FfyyFe7u3pzRiQdWIL0GgFdrK/wEBBTXBrJ4B7X5inJ9PYe+njxfMC00wfq3WeORcgMZpcQqmZVqo2GgWBMp8nYDArMth+VDiMvroIFIgbOzUNEIiRnExST7xU5T2aKULgzXq4Jhm1nRft4s/2WSbBccPI8xj1h/5eFrvg3OitmRlHvEQRwYl/Evgv/kJIOpi/VwTuvxicePjqwk6Bd1IKTyTD+y8+rwpmVxiVS38zOZ0UDsHRxeOTPs3r3srOA3rUPBk0XNNYl1JAg2VcNEWCJ8+E/t3Rlm8zq5FXL5PNG+3Tk0Lmc5rqry5ojSXXrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by MW4PR11MB6936.namprd11.prod.outlook.com (2603:10b6:303:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 19 Sep
 2024 21:42:54 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%5]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 21:42:53 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao"
	<hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>,
	"trix@redhat.com" <trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [RFC PATCH v2 8/9] fpga: dfl: migrate dfl_get_feature_by_id() to
 dfl_feature_dev_data
Thread-Topic: [RFC PATCH v2 8/9] fpga: dfl: migrate dfl_get_feature_by_id() to
 dfl_feature_dev_data
Thread-Index: AQHbCtzh+GjEq7AWikqIiLActcaGAw==
Date: Thu, 19 Sep 2024 21:42:53 +0000
Message-ID: <4d210cf326023c8e4d7bfe6e71a304e68247eedd.camel@intel.com>
References: <20240409233942.828440-1-peter.colberg@intel.com>
	 <20240409233942.828440-9-peter.colberg@intel.com>
	 <ZifQz/QJvYpFljMv@yilunxu-OptiPlex-7050>
In-Reply-To: <ZifQz/QJvYpFljMv@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|MW4PR11MB6936:EE_
x-ms-office365-filtering-correlation-id: a976a285-907f-446d-4f68-08dcd8f40424
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UVBoS3ArTU1jam5JZytRalh4a0RWK0pGZW04MkwvVkdvL2hUWDJCYVg4RjZz?=
 =?utf-8?B?UEwrMVNiMzQ0VWRBdW1McE1KVHdvUG1VMHRvcm9BLytJZ1M0dnF1dWpTWlkw?=
 =?utf-8?B?UndWQVZGYjRFV3RpOGluSjlOMmJ5Vkg2VENQNzRYUUFDUVlMVjVXZEdwK3JZ?=
 =?utf-8?B?WUUwY1J4VzFHNVQ3Mkd6YUttb3RNekxDSzc1UVo3Y3JSTTZySUJsR0ZuOHlN?=
 =?utf-8?B?WDFJUlpYRlduMEppMGgyTGxPWnZoak52d1dreWlhR0FMUjE2aXVHRi94dEVE?=
 =?utf-8?B?dDdKUUt6dkcrTXhBbkdHcU5GUnBObTU2U3NJTjhXUlZjQnE5VnQzTG52NEJa?=
 =?utf-8?B?TFJmQS83ZDd5VGptTnV5cU8vREdldFQrTnBxdWVpc2RkNmRMTGQ5clduMjNw?=
 =?utf-8?B?b1Ntb2ZYV3FjTHJpWDEzM0dNTy9vdThqZndBRGh2RjlDeXY3T2F1d0srdm5B?=
 =?utf-8?B?ZVoyTjFaWVFRQnZkVW1NTkEyWmxXWDRhVzRTRWhaeUpzRXNLcVhHUVNnelR4?=
 =?utf-8?B?cmx2RXZndklFcUtmZFlUSFNITHBYN1M2VkF0cmsrQlQvQ216UU5lUjdOb3lo?=
 =?utf-8?B?WUpYNnRkWVZUSnBxK2JNY3duNDdHR01jVUJhek93RzlVNTk4b3RXOTJYOWRk?=
 =?utf-8?B?U1RSYStnRlpmbXRzdUxaT1hGRjNzUDFjTGdra2ljT3l0WE11YmlId09XdWFp?=
 =?utf-8?B?ZVhzOFFYc0ZIam9yalBKbUw2SHJRNDFSVmNDUkl4YVJFWjJPQ1o5UTlJWEFF?=
 =?utf-8?B?aXpqUnk2ZUpjZkxZTlRnVEZDaDBIVDA3RDhuM25uZEUxZUYwaDJ5YUN0NkdR?=
 =?utf-8?B?UWhvQXNCMTBNa291Ujc4emg0Uk9kZnFKekRRWkxPaWloMkl2NjlGcjB6SXVo?=
 =?utf-8?B?Z0Nma0UyRUdja0ZkcTNEa1BwWko3WW1PSThDOGFsY0drK3VkeEp4VVhtVVlN?=
 =?utf-8?B?QkZRZHpOeDJwdkxzNFdNWUl0SnY3MTdEVWtQdmY5VHhCTTZhenQrVUVyc3hm?=
 =?utf-8?B?aUt5eDRndGhOaG5WUFgxdUFuM1ZnUUdHTmtGZHNwa3JyYUNLcExQTEE4bjU0?=
 =?utf-8?B?OXJOT0k3bWUvT2FOeFFrNHRTT1V2Zm41T1I1ZjI4UlpzQ3dHY0pFZm1hcDli?=
 =?utf-8?B?dVB1ZEVzMHNBSHloellJL2JvcDJEbXlNMVpuRHhxdEVMUDBFVFdJL0VlWEZD?=
 =?utf-8?B?eXVqc2Z1bko3UzNXYVpFU29EbXFzMEx3dXBCTVcybFpMeG9NZU93U3lGWXBa?=
 =?utf-8?B?UWJBVVoza1Y4K3RWUUM3Qm4zZnhITmJkWlBiaGlVdUZEb2RVeVBGQVA1WUp3?=
 =?utf-8?B?UDBDS3ZIUWJiNkdLdEYxV0VwSXJUOXRoc21Oc3VyYXI5Rzg1OHQ4K1RNTFV3?=
 =?utf-8?B?bVVoMUxacHBFVVBpNk9wMzhFV1JaZWRxSEV1Q09ORXJiYko2QnpnL002a0VZ?=
 =?utf-8?B?VUw2S2xCMUhTdWlYYlZLdDM0cm5OWGxXazllSkpRZTJTVC9nTldXcFNGUWxQ?=
 =?utf-8?B?TWpuMGFrdHZ6T0RteHJRWVVmVXdadkxvQWhOclhxMzU5Z1lSbHY1bVVwcVVC?=
 =?utf-8?B?bzViVWFwN0dYWTNoWGZYNjIxcDVySVI0QmtBamNDdytkRHUyVnFjUWlSei9J?=
 =?utf-8?B?QzVJWVpYYkR0dVIxYUIxZWxVMm41eVdla3p4SHQ5MjJpTDhmMnN1cHM3MmFB?=
 =?utf-8?B?WlZsTkQ3OHowbXlTMmpOUE5zb3l2aExkb2doME5aaDFyQjhQZlh3Q2RDR1hC?=
 =?utf-8?B?WFhJdFZDUWl0Y3BCZ3M4VHJYMFlxbnV0RFZ1b1JGWlpwT1RVWExDZlhVb1I3?=
 =?utf-8?B?V09IU1k0TmVMdU9yVzRIZTZpT2xuR3BuOW5jY1lzRUYvVGVER1JOZFRlMHA0?=
 =?utf-8?B?L1B1Q05KOGRVTHQ3eUVyN21kM0tRWDR3MksycUpzdHFUMEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T29yT2dPYVF3RVVvVGhadWdCLzh6RFBSVnl5dHJDbCt4SUhtdVlVZEdPSVNW?=
 =?utf-8?B?bFEwYVZXazM5emJMYm0wdExrcGpsbThBZzkzaHpHaUFzNFBVa1I1bm1qcnRD?=
 =?utf-8?B?dVU4cFdDZ0hDZHR4RjFOY3lONmZJQ2hoUFVrUFlGczY1UHVUVUpFS3hkMmtN?=
 =?utf-8?B?dnMwakM1dFZjQnVZdytPSlRoRjZmU0NleXFQUW54VXBJNXB2YXI4RTNSek5h?=
 =?utf-8?B?amlJY2FIOFNWWkUxUVVGVXNRNkpIb0Nycmc2ZkM3SzJFOTVIazUrSkRINDJu?=
 =?utf-8?B?ZllqcVF1MlRpL3RuWW9pdEgxaVloaU1zTGxyWkFTcDBhdlJScmZDQ2ZOZjVr?=
 =?utf-8?B?Vm5jRVpFVS9ENGlxTWhEVUgvR0krcnlEMDRaY2M3ZjFxVXk5M0JrRXBJVDF4?=
 =?utf-8?B?MU9ZaVhqT21yV3ZXUEU1QklwL3YvRXlRcm9qRldxOVhTZHJMcUVwTjZQT3p1?=
 =?utf-8?B?dmxZME9xS0dsNjJ0T3JoRlYrQWN0RzhGN0ZUU1VCbDBjQU10YzI4YjgveGlu?=
 =?utf-8?B?Y2E5SW0wV1puU1NPbW1EQ0RjbjBZcHRWRW4yU2p3RWxoT2g5RHVwa2NmU1E1?=
 =?utf-8?B?SFdoVDhSYytyVTBUWTNaTVllTlU0anY4MmN2THZicGlWRmpiak9xaGh6eGdo?=
 =?utf-8?B?dVRCOXZNZzhOOW1qRmpTaEpGU0xPL2h5a1hIZEIzaG8rdmMvVW9jUk1BYk9M?=
 =?utf-8?B?Q3owNVl0WlhNYVhmNHdTS3NPeTJpUk1vUElyR05GTGEyS1Y2TjhEclA4UHBp?=
 =?utf-8?B?c0dlb08zV0s1UWM0N2dNcmV5Y2dvejA4cmNnM2NmYkpVRGVHUzhLcndnaTNj?=
 =?utf-8?B?U1RHRnI0bVhUQVhNbmZXMGRTcEpOanREb0JJK3crUXI5NTdQRFYrYlllRFBi?=
 =?utf-8?B?SzRzSGgzdlRhUWxyZWRkb2orRytvUzV5a1JUSVZnRytaKzgyQUFSV0IyMkYz?=
 =?utf-8?B?clNUWUdBMzBMR0xCUDdwVDgvMEYvRVRsMjBQeDZweHNxUHhGRmphTlhGTm9U?=
 =?utf-8?B?YXc4NVFlUElFczBsdGx0UEpZQnFJK1R5N3pVK3JDdllQY2l4YnJoYjZ6a25X?=
 =?utf-8?B?TVNHR2gzNFVBY3VrY29OWVJDN2dnSTBJRnRqaHdrbnFKZW1KS1FIY2dQendS?=
 =?utf-8?B?NWRDMFJURmNpTmJESUJ0VnNDY3ora0xlSDZISDBwaUdYSEQvRlAzWHRRd2cv?=
 =?utf-8?B?ZURVamd0WGxQSUdzREJCQ1hkM2JKMkk1S05oVjkzcGFXMnlmRHo5eWUyeUFE?=
 =?utf-8?B?SWgybkRpSmJ2VnpiK1B4ekpBQ0ltUnRHL2ZGenRhRkZUSWs3Rjh2cy85YnFF?=
 =?utf-8?B?V2JibTY1MWlNdmY2TmxjTVhENVhKTjJubXZUYnVlMWYrNHA3OGhlTURZZUhB?=
 =?utf-8?B?TzdRbEZpWEZWc2o4dzFRajk2Q1VkQ0VhclFKWTZXL3piZWdkMEttUlpaWVlm?=
 =?utf-8?B?aGNLbHdjNkdBVjVySzlrVXJmUHNidHlrYVdxKzdsK3VYQnVGeVNpZUEwVjhu?=
 =?utf-8?B?VlZRNitDamtock9QOHpOSnhFdC8rWCtGbnRGVmlVdTN6Z25abFhSd2JmbUNu?=
 =?utf-8?B?M3h4SHlrYnhUb3FnWWlCcEJmVmFCZGVURnB5RlpRMEtPcWd5ZmdVckxJdkxH?=
 =?utf-8?B?R3Y0NkdxU0hSZmh3eXFlQWkzK0JJODgwOGhBMUcrRCtURjE4U1hPaGVMYXNv?=
 =?utf-8?B?MEdpUHk2aU5EUnBEYktyeEs5VndNendTaWl4Vi9sZ2FrR2huSzBEQ25HUnZu?=
 =?utf-8?B?WGE2aEM5cXdjaXpneGVBVStZNkdZVjhoZjdDUHhod2J3Y2xNaTBydjh1Yk9O?=
 =?utf-8?B?VVRmcVJNd1hsWmdjWlpsZUZ5Q0U5YVZpRjgvbWdEWHovQm10TUthT0VSbzJV?=
 =?utf-8?B?NnJPeEJkVEo2Sy9MZlRIN29SUmNVQVU1dXFpck9weWUxWUZGOUtDV0xDdW1Z?=
 =?utf-8?B?Yk5LdDZOVkJ5Ulc1UWJhTlloVWNkckVmaGhjblJiK0I5ditwQWcyMjlSVzdU?=
 =?utf-8?B?Y3lYTFRDWEF5T2I4dGhFTmtYZExBc1pORUU4Y0FKR0FtU0xrRS81Um56ZlFq?=
 =?utf-8?B?c3FweWVSSVEyUG93Y1hIcjBKaE5PNmxpeDdFd1hoRDBVRytTOVhuci9UMlJu?=
 =?utf-8?B?alUvT05rK3V5YkZ1V0ozdU85RGtYU1JsbGQyQjl3UTZjTW5VMDcwcmpBWnF5?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45AA73634C64104FA562DE8EE3DC10F6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a976a285-907f-446d-4f68-08dcd8f40424
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 21:42:53.2509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vfmrO9mNGD+0lf7pHyqENo16IqaMX1OBhidYK2obFrGdXdRWQhnFXj6XvoWiKmEQEY6I/fwpbLZRoFWGFihgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6936
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTIzIGF0IDIzOjE2ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VHVlLCBBcHIgMDksIDIwMjQgYXQgMDc6Mzk6NDFQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBUaGlzIGNoYW5nZSBzZXBhcmF0ZXMgb3V0IG1vc3Qgb2YgdGhlIHN5bWJvbCBuYW1l
IGNoYW5nZXMgcmVxdWlyZWQgYnkgdGhpcw0KPiA+IHBhdGNoIHNlcmllcyBmb3IgdGhlIGZ1bmN0
aW9uOiBkZmxfZ2V0X2ZlYXR1cmVfYnlfaWQoKS4gVGhpcyBpcyBkb25lIHRvDQo+ID4gc3BsaXQg
YSBzaW5nbGUgbW9ub2xpdGhpYyBjaGFuZ2UgaW50byBtdWx0aXBsZSwgc21hbGxlciBwYXRjaGVz
IGF0IHRoZQ0KPiA+IHJlcXVlc3Qgb2YgdGhlIG1haW50YWluZXIuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogUGV0ZXIgQ29sYmVyZyA8cGV0ZXIuY29sYmVyZ0BpbnRlbC5jb20+DQo+ID4gLS0t
DQo+ID4gdjI6DQo+ID4gLSBTcGxpdCBtb25vbGl0aGljIHBhdGNoIGludG8gc2VyaWVzIGF0IHJl
cXVlc3Qgb2YgbWFpbnRhaW5lcg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2ZwZ2EvZGZsLWFmdS1l
cnJvci5jIHwgIDU5ICsrKysrKystLS0tLS0NCj4gPiAgZHJpdmVycy9mcGdhL2RmbC1hZnUtbWFp
bi5jICB8IDE2NiArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICBkcml2
ZXJzL2ZwZ2EvZGZsLWFmdS5oICAgICAgIHwgIDI2ICsrKy0tLQ0KPiA+ICBkcml2ZXJzL2ZwZ2Ev
ZGZsLWZtZS1lcnJvci5jIHwgIDk4ICsrKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+ICBkcml2ZXJz
L2ZwZ2EvZGZsLWZtZS1tYWluLmMgIHwgIDE4ICsrLS0NCj4gPiAgZHJpdmVycy9mcGdhL2RmbC1m
bWUtcHIuYyAgICB8ICAgNiArLQ0KPiA+ICBkcml2ZXJzL2ZwZ2EvZGZsLmMgICAgICAgICAgIHwg
ICAzICstDQo+ID4gIGRyaXZlcnMvZnBnYS9kZmwuaCAgICAgICAgICAgfCAgMTMgKystDQo+ID4g
IDggZmlsZXMgY2hhbmdlZCwgMjAzIGluc2VydGlvbnMoKyksIDE4NiBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2RmbC1hZnUtZXJyb3IuYyBiL2RyaXZl
cnMvZnBnYS9kZmwtYWZ1LWVycm9yLmMNCj4gPiBpbmRleCBhYjdiZTYyMTczNjguLjBmMzkyZDFm
NmQ0NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2ZwZ2EvZGZsLWFmdS1lcnJvci5jDQo+ID4g
KysrIGIvZHJpdmVycy9mcGdhL2RmbC1hZnUtZXJyb3IuYw0KPiA+IEBAIC0yOCwzNyArMjgsMzYg
QEANCj4gPiAgI2RlZmluZSBFUlJPUl9NQVNLCQlHRU5NQVNLX1VMTCg2MywgMCkNCj4gPiAgDQo+
ID4gIC8qIG1hc2sgb3IgdW5tYXNrIHBvcnQgZXJyb3JzIGJ5IHRoZSBlcnJvciBtYXNrIHJlZ2lz
dGVyLiAqLw0KPiA+IC1zdGF0aWMgdm9pZCBfX2FmdV9wb3J0X2Vycl9tYXNrKHN0cnVjdCBkZXZp
Y2UgKmRldiwgYm9vbCBtYXNrKQ0KPiA+ICtzdGF0aWMgdm9pZCBfX2FmdV9wb3J0X2Vycl9tYXNr
KHN0cnVjdCBkZmxfZmVhdHVyZV9kZXZfZGF0YSAqZmRhdGEsIGJvb2wgbWFzaykNCj4gDQo+IE1h
eWJlIGZpcnN0IHJlcGxhY2UgYWxsICJzdHJ1Y3QgZGV2aWNlICpkZXYiIGFyZ3VtZW50cyB3aXRo
ICJzdHJ1Y3QNCj4gZGZsX2ZlYXR1cmVfcGxhdGZvcm0gZGF0YSAqcGRhdGEiLCB0aGVuIHlvdSBj
b3VsZCBkbyBzaW1wbGUNCj4gcGRhdGEtPmZkYXRhIHJlcGxhY2VtZW50IHRoZSBzYW1lIGFzIG90
aGVyIHBhdGNoZXMuDQoNClRoYW5rIHlvdSBmb3IgdGhlIHN1Z2dlc3Rpb247IHRoaXMgaGFzIGJl
ZW4gZG9uZSBpbiB0aGUgcGF0Y2ggImZwZ2E6DQpkZmw6IHBhc3MgZmVhdHVyZSBwbGF0Zm9ybSBk
YXRhIGluc3RlYWQgb2YgZGV2aWNlIGFzIGFyZ3VtZW50Ii4NCj4gDQo+ID4gIHsNCj4gPiAgCXZv
aWQgX19pb21lbSAqYmFzZTsNCj4gPiAgDQo+ID4gLQliYXNlID0gZGZsX2dldF9mZWF0dXJlX2lv
YWRkcl9ieV9pZChkZXYsIFBPUlRfRkVBVFVSRV9JRF9FUlJPUik7DQo+ID4gKwliYXNlID0gZGZs
X2dldF9mZWF0dXJlX2lvYWRkcl9ieV9pZChmZGF0YSwgUE9SVF9GRUFUVVJFX0lEX0VSUk9SKTsN
Cj4gPiAgDQo+ID4gIAl3cml0ZXEobWFzayA/IEVSUk9SX01BU0sgOiAwLCBiYXNlICsgUE9SVF9F
UlJPUl9NQVNLKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIHZvaWQgYWZ1X3BvcnRfZXJy
X21hc2soc3RydWN0IGRldmljZSAqZGV2LCBib29sIG1hc2spDQo+ID4gIHsNCj4gPiAtCXN0cnVj
dCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhICpwZGF0YSA9IGRldl9nZXRfcGxhdGRhdGEoZGV2
KTsNCj4gPiArCXN0cnVjdCBkZmxfZmVhdHVyZV9kZXZfZGF0YSAqZmRhdGEgPSB0b19kZmxfZmVh
dHVyZV9kZXZfZGF0YShkZXYpOw0KPiA+ICANCj4gPiAtCW11dGV4X2xvY2soJnBkYXRhLT5sb2Nr
KTsNCj4gPiAtCV9fYWZ1X3BvcnRfZXJyX21hc2soZGV2LCBtYXNrKTsNCj4gPiAtCW11dGV4X3Vu
bG9jaygmcGRhdGEtPmxvY2spOw0KPiA+ICsJbXV0ZXhfbG9jaygmZmRhdGEtPmxvY2spOw0KPiA+
ICsJX19hZnVfcG9ydF9lcnJfbWFzayhmZGF0YSwgbWFzayk7DQo+ID4gKwltdXRleF91bmxvY2so
JmZkYXRhLT5sb2NrKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgLyogY2xlYXIgcG9ydCBlcnJvcnMu
ICovDQo+ID4gIHN0YXRpYyBpbnQgYWZ1X3BvcnRfZXJyX2NsZWFyKHN0cnVjdCBkZXZpY2UgKmRl
diwgdTY0IGVycikNCj4gPiAgew0KPiA+IC0Jc3RydWN0IGRmbF9mZWF0dXJlX3BsYXRmb3JtX2Rh
dGEgKnBkYXRhID0gZGV2X2dldF9wbGF0ZGF0YShkZXYpOw0KPiA+IC0Jc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOw0KPiA+ICsJc3RydWN0IGRm
bF9mZWF0dXJlX2Rldl9kYXRhICpmZGF0YSA9IHRvX2RmbF9mZWF0dXJlX2Rldl9kYXRhKGRldik7
DQo+ID4gIAl2b2lkIF9faW9tZW0gKmJhc2VfZXJyLCAqYmFzZV9oZHI7DQo+ID4gIAlpbnQgZW5h
YmxlX3JldCA9IDAsIHJldCA9IC1FQlVTWTsNCj4gPiAgCXU2NCB2Ow0KPiA+ICANCj4gPiAtCWJh
c2VfZXJyID0gZGZsX2dldF9mZWF0dXJlX2lvYWRkcl9ieV9pZChkZXYsIFBPUlRfRkVBVFVSRV9J
RF9FUlJPUik7DQo+ID4gLQliYXNlX2hkciA9IGRmbF9nZXRfZmVhdHVyZV9pb2FkZHJfYnlfaWQo
ZGV2LCBQT1JUX0ZFQVRVUkVfSURfSEVBREVSKTsNCj4gPiArCWJhc2VfZXJyID0gZGZsX2dldF9m
ZWF0dXJlX2lvYWRkcl9ieV9pZChmZGF0YSwgUE9SVF9GRUFUVVJFX0lEX0VSUk9SKTsNCj4gPiAr
CWJhc2VfaGRyID0gZGZsX2dldF9mZWF0dXJlX2lvYWRkcl9ieV9pZChmZGF0YSwgUE9SVF9GRUFU
VVJFX0lEX0hFQURFUik7DQo+ID4gIA0KPiA+IC0JbXV0ZXhfbG9jaygmcGRhdGEtPmxvY2spOw0K
PiA+ICsJbXV0ZXhfbG9jaygmZmRhdGEtPmxvY2spOw0KPiA+ICANCj4gPiAgCS8qDQo+ID4gIAkg
KiBjbGVhciBQb3J0IEVycm9ycw0KPiA+IEBAIC04MCwxMiArNzksMTIgQEAgc3RhdGljIGludCBh
ZnVfcG9ydF9lcnJfY2xlYXIoc3RydWN0IGRldmljZSAqZGV2LCB1NjQgZXJyKQ0KPiA+ICAJfQ0K
PiA+ICANCj4gPiAgCS8qIEhhbHQgUG9ydCBieSBrZWVwaW5nIFBvcnQgaW4gcmVzZXQgKi8NCj4g
PiAtCXJldCA9IF9fYWZ1X3BvcnRfZGlzYWJsZShwZGV2KTsNCj4gPiArCXJldCA9IF9fYWZ1X3Bv
cnRfZGlzYWJsZShmZGF0YSk7DQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJCWdvdG8gZG9uZTsNCj4g
PiAgDQo+ID4gIAkvKiBNYXNrIGFsbCBlcnJvcnMgKi8NCj4gPiAtCV9fYWZ1X3BvcnRfZXJyX21h
c2soZGV2LCB0cnVlKTsNCj4gPiArCV9fYWZ1X3BvcnRfZXJyX21hc2soZmRhdGEsIHRydWUpOw0K
PiA+ICANCj4gPiAgCS8qIENsZWFyIGVycm9ycyBpZiBlcnIgaW5wdXQgbWF0Y2hlcyB3aXRoIGN1
cnJlbnQgcG9ydCBlcnJvcnMuKi8NCj4gPiAgCXYgPSByZWFkcShiYXNlX2VyciArIFBPUlRfRVJS
T1IpOw0KPiA+IEBAIC0xMDIsMjggKzEwMSwyOCBAQCBzdGF0aWMgaW50IGFmdV9wb3J0X2Vycl9j
bGVhcihzdHJ1Y3QgZGV2aWNlICpkZXYsIHU2NCBlcnIpDQo+ID4gIAl9DQo+ID4gIA0KPiA+ICAJ
LyogQ2xlYXIgbWFzayAqLw0KPiA+IC0JX19hZnVfcG9ydF9lcnJfbWFzayhkZXYsIGZhbHNlKTsN
Cj4gPiArCV9fYWZ1X3BvcnRfZXJyX21hc2soZmRhdGEsIGZhbHNlKTsNCj4gPiAgDQo+ID4gIAkv
KiBFbmFibGUgdGhlIFBvcnQgYnkgY2xlYXJpbmcgdGhlIHJlc2V0ICovDQo+ID4gLQllbmFibGVf
cmV0ID0gX19hZnVfcG9ydF9lbmFibGUocGRldik7DQo+ID4gKwllbmFibGVfcmV0ID0gX19hZnVf
cG9ydF9lbmFibGUoZmRhdGEpOw0KPiA+ICANCj4gPiAgZG9uZToNCj4gPiAtCW11dGV4X3VubG9j
aygmcGRhdGEtPmxvY2spOw0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZmZGF0YS0+bG9jayk7DQo+ID4g
IAlyZXR1cm4gZW5hYmxlX3JldCA/IGVuYWJsZV9yZXQgOiByZXQ7DQo+ID4gIH0NCj4gPiAgDQo+
ID4gIHN0YXRpYyBzc2l6ZV90IGVycm9yc19zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ID4gIAkJCSAgIGNoYXIgKmJ1ZikNCj4gPiAgew0K
PiA+IC0Jc3RydWN0IGRmbF9mZWF0dXJlX3BsYXRmb3JtX2RhdGEgKnBkYXRhID0gZGV2X2dldF9w
bGF0ZGF0YShkZXYpOw0KPiA+ICsJc3RydWN0IGRmbF9mZWF0dXJlX2Rldl9kYXRhICpmZGF0YSA9
IHRvX2RmbF9mZWF0dXJlX2Rldl9kYXRhKGRldik7DQo+ID4gIAl2b2lkIF9faW9tZW0gKmJhc2U7
DQo+ID4gIAl1NjQgZXJyb3I7DQo+ID4gIA0KPiA+IC0JYmFzZSA9IGRmbF9nZXRfZmVhdHVyZV9p
b2FkZHJfYnlfaWQoZGV2LCBQT1JUX0ZFQVRVUkVfSURfRVJST1IpOw0KPiA+ICsJYmFzZSA9IGRm
bF9nZXRfZmVhdHVyZV9pb2FkZHJfYnlfaWQoZmRhdGEsIFBPUlRfRkVBVFVSRV9JRF9FUlJPUik7
DQo+ID4gIA0KPiA+IC0JbXV0ZXhfbG9jaygmcGRhdGEtPmxvY2spOw0KPiA+ICsJbXV0ZXhfbG9j
aygmZmRhdGEtPmxvY2spOw0KPiA+ICAJZXJyb3IgPSByZWFkcShiYXNlICsgUE9SVF9FUlJPUik7
DQo+ID4gLQltdXRleF91bmxvY2soJnBkYXRhLT5sb2NrKTsNCj4gPiArCW11dGV4X3VubG9jaygm
ZmRhdGEtPmxvY2spOw0KPiA+ICANCj4gPiAgCXJldHVybiBzcHJpbnRmKGJ1ZiwgIjB4JWxseFxu
IiwgKHVuc2lnbmVkIGxvbmcgbG9uZyllcnJvcik7DQo+ID4gIH0NCj4gPiBAQCAtMTQ2LDE1ICsx
NDUsMTUgQEAgc3RhdGljIERFVklDRV9BVFRSX1JXKGVycm9ycyk7DQo+ID4gIHN0YXRpYyBzc2l6
ZV90IGZpcnN0X2Vycm9yX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ICAJCQkJc3RydWN0
IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikNCj4gPiAgew0KPiA+IC0Jc3RydWN0
IGRmbF9mZWF0dXJlX3BsYXRmb3JtX2RhdGEgKnBkYXRhID0gZGV2X2dldF9wbGF0ZGF0YShkZXYp
Ow0KPiA+ICsJc3RydWN0IGRmbF9mZWF0dXJlX2Rldl9kYXRhICpmZGF0YSA9IHRvX2RmbF9mZWF0
dXJlX2Rldl9kYXRhKGRldik7DQo+ID4gIAl2b2lkIF9faW9tZW0gKmJhc2U7DQo+ID4gIAl1NjQg
ZXJyb3I7DQo+ID4gIA0KPiA+IC0JYmFzZSA9IGRmbF9nZXRfZmVhdHVyZV9pb2FkZHJfYnlfaWQo
ZGV2LCBQT1JUX0ZFQVRVUkVfSURfRVJST1IpOw0KPiA+ICsJYmFzZSA9IGRmbF9nZXRfZmVhdHVy
ZV9pb2FkZHJfYnlfaWQoZmRhdGEsIFBPUlRfRkVBVFVSRV9JRF9FUlJPUik7DQo+ID4gIA0KPiA+
IC0JbXV0ZXhfbG9jaygmcGRhdGEtPmxvY2spOw0KPiA+ICsJbXV0ZXhfbG9jaygmZmRhdGEtPmxv
Y2spOw0KPiA+ICAJZXJyb3IgPSByZWFkcShiYXNlICsgUE9SVF9GSVJTVF9FUlJPUik7DQo+ID4g
LQltdXRleF91bmxvY2soJnBkYXRhLT5sb2NrKTsNCj4gPiArCW11dGV4X3VubG9jaygmZmRhdGEt
PmxvY2spOw0KPiA+ICANCj4gPiAgCXJldHVybiBzcHJpbnRmKGJ1ZiwgIjB4JWxseFxuIiwgKHVu
c2lnbmVkIGxvbmcgbG9uZyllcnJvcik7DQo+ID4gIH0NCj4gPiBAQCAtMTY0LDE2ICsxNjMsMTYg
QEAgc3RhdGljIHNzaXplX3QgZmlyc3RfbWFsZm9ybWVkX3JlcV9zaG93KHN0cnVjdCBkZXZpY2Ug
KmRldiwNCj4gPiAgCQkJCQlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4gPiAgCQkJ
CQljaGFyICpidWYpDQo+ID4gIHsNCj4gPiAtCXN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9k
YXRhICpwZGF0YSA9IGRldl9nZXRfcGxhdGRhdGEoZGV2KTsNCj4gPiArCXN0cnVjdCBkZmxfZmVh
dHVyZV9kZXZfZGF0YSAqZmRhdGEgPSB0b19kZmxfZmVhdHVyZV9kZXZfZGF0YShkZXYpOw0KPiA+
ICAJdm9pZCBfX2lvbWVtICpiYXNlOw0KPiA+ICAJdTY0IHJlcTAsIHJlcTE7DQo+ID4gIA0KPiA+
IC0JYmFzZSA9IGRmbF9nZXRfZmVhdHVyZV9pb2FkZHJfYnlfaWQoZGV2LCBQT1JUX0ZFQVRVUkVf
SURfRVJST1IpOw0KPiA+ICsJYmFzZSA9IGRmbF9nZXRfZmVhdHVyZV9pb2FkZHJfYnlfaWQoZmRh
dGEsIFBPUlRfRkVBVFVSRV9JRF9FUlJPUik7DQo+ID4gIA0KPiA+IC0JbXV0ZXhfbG9jaygmcGRh
dGEtPmxvY2spOw0KPiA+ICsJbXV0ZXhfbG9jaygmZmRhdGEtPmxvY2spOw0KPiA+ICAJcmVxMCA9
IHJlYWRxKGJhc2UgKyBQT1JUX01BTEZPUk1FRF9SRVEwKTsNCj4gPiAgCXJlcTEgPSByZWFkcShi
YXNlICsgUE9SVF9NQUxGT1JNRURfUkVRMSk7DQo+ID4gLQltdXRleF91bmxvY2soJnBkYXRhLT5s
b2NrKTsNCj4gPiArCW11dGV4X3VubG9jaygmZmRhdGEtPmxvY2spOw0KPiA+ICANCj4gPiAgCXJl
dHVybiBzcHJpbnRmKGJ1ZiwgIjB4JTAxNmxseCUwMTZsbHhcbiIsDQo+ID4gIAkJICAgICAgICh1
bnNpZ25lZCBsb25nIGxvbmcpcmVxMSwgKHVuc2lnbmVkIGxvbmcgbG9uZylyZXEwKTsNCj4gPiBA
QCAtMTkxLDEyICsxOTAsMTQgQEAgc3RhdGljIHVtb2RlX3QgcG9ydF9lcnJfYXR0cnNfdmlzaWJs
ZShzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gPiAgCQkJCSAgICAgIHN0cnVjdCBhdHRyaWJ1dGUg
KmF0dHIsIGludCBuKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBrb2JqX3Rv
X2Rldihrb2JqKTsNCj4gPiArCXN0cnVjdCBkZmxfZmVhdHVyZV9kZXZfZGF0YSAqZmRhdGE7DQo+
ID4gIA0KPiA+ICsJZmRhdGEgPSB0b19kZmxfZmVhdHVyZV9kZXZfZGF0YShkZXYpOw0KPiA+ICAJ
LyoNCj4gPiAgCSAqIHN5c2ZzIGVudHJpZXMgYXJlIHZpc2libGUgb25seSBpZiByZWxhdGVkIHBy
aXZhdGUgZmVhdHVyZSBpcw0KPiA+ICAJICogZW51bWVyYXRlZC4NCj4gPiAgCSAqLw0KPiA+IC0J
aWYgKCFkZmxfZ2V0X2ZlYXR1cmVfYnlfaWQoZGV2LCBQT1JUX0ZFQVRVUkVfSURfRVJST1IpKQ0K
PiA+ICsJaWYgKCFkZmxfZ2V0X2ZlYXR1cmVfYnlfaWQoZmRhdGEsIFBPUlRfRkVBVFVSRV9JRF9F
UlJPUikpDQo+ID4gIAkJcmV0dXJuIDA7DQo+ID4gIA0KPiA+ICAJcmV0dXJuIGF0dHItPm1vZGU7
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9kZmwtYWZ1LW1haW4uYyBiL2RyaXZlcnMv
ZnBnYS9kZmwtYWZ1LW1haW4uYw0KPiA+IGluZGV4IDYxODY4Y2RkNWIwYi4uNDI5MjhjYzdlNDJi
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZnBnYS9kZmwtYWZ1LW1haW4uYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZnBnYS9kZmwtYWZ1LW1haW4uYw0KPiA+IEBAIC0yNiw3ICsyNiw3IEBADQo+ID4g
IA0KPiA+ICAvKioNCj4gPiAgICogX19hZnVfcG9ydF9lbmFibGUgLSBlbmFibGUgYSBwb3J0IGJ5
IGNsZWFyIHJlc2V0DQo+ID4gLSAqIEBwZGV2OiBwb3J0IHBsYXRmb3JtIGRldmljZS4NCj4gPiAr
ICogQGZkYXRhOiBwb3J0IGZlYXR1cmUgZGV2IGRhdGEuDQo+ID4gICAqDQo+ID4gICAqIEVuYWJs
ZSBQb3J0IGJ5IGNsZWFyIHRoZSBwb3J0IHNvZnQgcmVzZXQgYml0LCB3aGljaCBpcyBzZXQgYnkg
ZGVmYXVsdC4NCj4gPiAgICogVGhlIEFGVSBpcyB1bmFibGUgdG8gcmVzcG9uZCB0byBhbnkgTU1J
TyBhY2Nlc3Mgd2hpbGUgaW4gcmVzZXQuDQo+ID4gQEAgLTM1LDE4ICszNSwxNyBAQA0KPiA+ICAg
Kg0KPiA+ICAgKiBUaGUgY2FsbGVyIG5lZWRzIHRvIGhvbGQgbG9jayBmb3IgcHJvdGVjdGlvbi4N
Cj4gPiAgICovDQo+ID4gLWludCBfX2FmdV9wb3J0X2VuYWJsZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiA+ICtpbnQgX19hZnVfcG9ydF9lbmFibGUoc3RydWN0IGRmbF9mZWF0dXJl
X2Rldl9kYXRhICpmZGF0YSkNCj4gDQo+IFNhbWUgc3VnZ2VzdGlvbi4gUmVwbGFjZSAic3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldiIgd2l0aCAic3RydWN0DQo+IGRmbF9mZWF0dXJlX3BsYXRm
b3JtX2RhdGEgKnBkYXRhIiBmaXJzdC4gVGhlbiBkbyBtYXNzaXZlIHBkYXRhLT5mZGF0YQ0KPiBy
ZXBsYWNlbWVudC4NCg0KVGhpcyBoYXMgYmVlbiBkb25lIGluIHRoZSBwYXRjaCAiZnBnYTogZGZs
OiBwYXNzIGZlYXR1cmUgcGxhdGZvcm0gZGF0YQ0KaW5zdGVhZCBvZiBkZXZpY2UgYXMgYXJndW1l
bnQiLg0KDQpUaGFua3MsDQpQZXRlcg0KDQo+IA0KPiBUaGFua3MsDQo+IFlpbHVuDQoNCg==

