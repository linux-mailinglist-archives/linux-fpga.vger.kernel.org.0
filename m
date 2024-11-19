Return-Path: <linux-fpga+bounces-948-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAA49D3105
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 00:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D263E283DFC
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Nov 2024 23:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D821D2F74;
	Tue, 19 Nov 2024 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFKoB4Wj"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681CA1BD9F3;
	Tue, 19 Nov 2024 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059610; cv=fail; b=GkLdDbVwWO72IVcHt+LhheyjcM6N7Nx3lxClQOtafswb2cr1hGPJCUTtxrRWUDVuGXOyUyabey5TLCV0Eq4Bj4g28N/6M5Cvjhz4Rt5txIsi7/yXoFN3uMS59YQ0IfKbtBg9EhJYa0korvudY3u1MQv2L0xEs3m08VM4QGbkofE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059610; c=relaxed/simple;
	bh=0Q3UXPukoZcuDmUJLk+e5LS1hyTm5aMeg6PNdUsXejM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qlOFw7gtEHY4kuCstPqfPQaam87ETnS0aVf3JmJu+FVzxRdAnTHjdlshLF4w57ikWAqPMppIwfH7uVL7C/jS9CKeiaiN87B2wrsAlzF3zmQPvHQxXG5bcsl9yR9n/tIC8QqgxHBUTxCrRyzigA2yprmyxXJIJWnzfgxjc53XKCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFKoB4Wj; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732059608; x=1763595608;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0Q3UXPukoZcuDmUJLk+e5LS1hyTm5aMeg6PNdUsXejM=;
  b=GFKoB4WjJAOfu/hnxI5pVXprnOm+txQQNKCYJVcs8z0YZXv7b9Jy8f1w
   MnSpfB8mrlZul2CDG7huddLSxIoEMU2kxBfK1WK3lzpYufqiq1jSP5jSO
   CERNmKrU66R5xu6bwyvp18Q5v2gYTM5xqmisTfhoV654kZg71qLFm8r/a
   8HZDwoYL5+DV7/bREpQeO74zOZWGSI7gI7I+JqCQvSysOnryXOIXkqmED
   li9pbnD4fCweuZ5ieo1GRi/0Ol8xNxthR1BjxS+6GC7xJbQdEN3cD5vwl
   LcIqQpnmRS1IsopEhB/dCqOsQGZFUsuDsFAPnRhaHcJ9mNZgrMGqhfWPK
   w==;
X-CSE-ConnectionGUID: RuUKguGKSUu+7oIbSyV6bw==
X-CSE-MsgGUID: 7iKFbA8+S065+Iz0lZXvMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32199975"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="32199975"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 15:40:08 -0800
X-CSE-ConnectionGUID: AspnZAfPRQiEbGzasB1T/g==
X-CSE-MsgGUID: 9aqt577oTXigf6l8prPKvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="113012427"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 15:40:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 15:40:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 15:40:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 15:40:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDiuHB9WFpdHbWxCG/x4jZ22FDaS9wZy0S4R/0WC6BmRZUkbB/rCKrQyV+9cV/DucyOqz0Yy/fezJIsMmBTel9ndWyzwqN8vfFOg/uqvpHeNNRL2VnFo9qjExKYn9kCqKc20ytRaB1KMi2azgZ8BNRXSiy1zDcmoizjcERYqDPUOvb5o7GQ+N8Uy0t2cWXKKWCr3eyb8COpVQHb/nQLyQ25omXijqX48VIMpO4VmWVgchTriWmWyIT9YXe0eBoEIaD+7y7YSOAN7wDUi3lOj1MKrBJ3/EB3VOKSR5CLkEGCJfiMQvbZt3TlbmZkJ0jlCT8vc1p5oXbZnxpmJXbdeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q3UXPukoZcuDmUJLk+e5LS1hyTm5aMeg6PNdUsXejM=;
 b=U7keMO3sMaWJN/6LDYxWacnj9Qqpsl1TB779qt1DZz2/w1N7u6x/iflubJ4RX7H/F7kIYohA/zCJG7ClyxlWDoYX/P+56JQ62PomXd/ZFa5OIIPYz6lMzuWu3xvAibgwjvikjegYwRnZRH8EF+Oz0rGAamu//rc42EPaa2zHPlkQ7SGxauJDG/civ8XGLvRIwq/LaY2e1De/5z9uvqlVr90UNwvOPZARWBnb8IsKEfz7wgmq2XUIwtSu2htdM6Wb/9Xizm9FqvX0ypUdQp4QiLwJhcqaybiYbzDmMJckWVd5mZ6UZuGqqqEzhfCg3ynVpt0KY1h5WXSVyP5vH2SSOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 23:40:03 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 23:40:03 +0000
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
Subject: Re: [PATCH v4 17/19] fpga: dfl: remove unneeded function
 build_info_create_dev()
Thread-Topic: [PATCH v4 17/19] fpga: dfl: remove unneeded function
 build_info_create_dev()
Thread-Index: AQHbOtxbuB8W+Q0pF0a3+0LurY0fIQ==
Date: Tue, 19 Nov 2024 23:40:03 +0000
Message-ID: <3255394602db0fa9d93edf3c0024d0860c538dbd.camel@intel.com>
References: <20241025223714.394533-1-peter.colberg@intel.com>
	 <20241025223714.394533-18-peter.colberg@intel.com>
	 <ZztV/d8PPk2f33wk@yilunxu-OptiPlex-7050>
In-Reply-To: <ZztV/d8PPk2f33wk@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|PH7PR11MB7605:EE_
x-ms-office365-filtering-correlation-id: 9a5635fd-aa52-4fad-e7f0-08dd08f37de2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Vkp4Szcza3RzbklhakE5Uno4aVZDc09TSlJTVHhnVXNmVzBid09SVldmZmda?=
 =?utf-8?B?SkN0MTVtTnlYdVdDZ2VPN3BaRFFMc0NZZ1BWK0xYUUFEalJCZW52cUg5eCtF?=
 =?utf-8?B?UWY4UXlwOEFQdUJzYUlRR3dHblI2enFHVTg3Rk1RMzFLa3VBVnQ0aGhZSlJO?=
 =?utf-8?B?TmYzV0NYRVJBY3RYdng5ODZmTnZRQXpwd01Db3VkNXRqUGV1Tno5bmc4Nmts?=
 =?utf-8?B?T0tkM0YrTExQZUUwVkx1UmtXbjZyVzlFUVpUUkNlUFZaOUowV2ZzeE1VL1pC?=
 =?utf-8?B?L3F4OUFNOTMyb3o2Q1N1cXNlZ1NEV205UUV5eG9ITFdsSHY1UXpReHVvYlBE?=
 =?utf-8?B?QnlHQ2JwU1ZJbTA5N3hsTXpoczhza1kyT3hnb01qV1hZYmxtYXBrdGdYNTB6?=
 =?utf-8?B?RU5hUzZzeVBPQzdpaWFtQnpvUlhhbU8zQVpWY0UvRmIxTUlkTFNISGZwak5H?=
 =?utf-8?B?a2Zzam81QzNQbnlZU09nWHRHYlFYMHNzNm82UGVSZ3hLUkJFL202U3lNSnZF?=
 =?utf-8?B?OERZT1BRbHdhMEhYUDE0SFlYeG5VSFRYcnh2cllvMXhXTkNMa1BzYlh6Ym45?=
 =?utf-8?B?YzRsdXZhSkN6WEJ4S1NudWxTM21SSVYrcEpybDI0UVdyaDJVVk55VHZjM3l1?=
 =?utf-8?B?V3FSRDYzYTFQdFk3WWFnMGZ3K3lIb2pOQU1sRDZTTFpteWg2alZtRlE0bG5I?=
 =?utf-8?B?UFhlY2FFUi9iNDBJU0p5YzJyemwyR2kydnZzMCtMMzlCekJ0SFE1WmFrY3J4?=
 =?utf-8?B?Y2Mwbk8xRFZkTnJHWHJZQWdUSU5rQmhYSEZSRHdhOTZmYzdDalpVZ3JJb0p5?=
 =?utf-8?B?Wi9VVjM1NEJPVUxDUTBHeDh0eTQvMEdmQ2JTOE12dGdWNWoxblpCNktkZThx?=
 =?utf-8?B?Y2ZaUnJkRGpreU00MVowU2RXbVFlZk8zcHdaVm9kSTg5eUZxRURudkY0RFVZ?=
 =?utf-8?B?MnUzbDRxaUpINWh1d3NYM05nQ01DTmZvU0V1ZG15Mjg5cXFKeXZoVHMxQWRO?=
 =?utf-8?B?dGVqRnluMzlycEZnUDNnNCtCR09FZng3TUszT0lYMnJQLzdxUDZLNTJGQW5V?=
 =?utf-8?B?QlUvNjdJTEUrRjBsb1E1WGlrelpsOFZOTjdvV2lWOG55dEVScXBPOGd6UTFU?=
 =?utf-8?B?UldmOVQzV3VoYzFYakM1SWhqTXlNTnVSVU43dTBWNGVqR2Z5UHdKU09tOGdZ?=
 =?utf-8?B?d2VEVXUwTDBGQy9scnZIQzhkc0EzeG8zWEMzREVOVFZtVkQwYUNCY21iS0tr?=
 =?utf-8?B?TXBMU2kvQTRZakg3Wlo2aVE3ejgreDYweVZhbXJTZzNTZWpMWHU5aWdLOUFM?=
 =?utf-8?B?R0hla1RSYzdCRU53YUdUWUJ6WTFnRXF4dmJnYUMzWjZOVkVJdVJDOWpkNHdD?=
 =?utf-8?B?MC9RbXFqM2luQmVadHZYN28yK0dqZWpDc1RmVTJBQ2JTV0g0L2REUW8zMThL?=
 =?utf-8?B?SEpPKzNwSy9KVlFEUHduQnhxNkVtZXZ4UjZ0ZFo0ODJBYmtlVWFSOS9Ic1Zo?=
 =?utf-8?B?bEM2Tm8ycnNrRitLY29vbW9CeWZBRk82bnlJKzE0T2xSMnQvNG9BRWV1ZHRw?=
 =?utf-8?B?ZTV3OWttUWdTdHBtNE9LSVpvbDY5STNIMUdpekhWNXVpcklnL29COFlBWmw4?=
 =?utf-8?B?cTllLzdpRHBpMWF0dVd1ZG1TRUd3bmdTNVU5YW5JbXJTazNOY2FETnNWRlR2?=
 =?utf-8?B?OVlpUTBhdXBwN2JkOFdtRnlWMDhyWVdIUjBYZllUcDBDYmZIajd4MU5HWnVj?=
 =?utf-8?B?RkdaSUZmdkFmUU45RzZVaUtpa0c4SjRoS0lSdklHd3RPVWh3ZjgvSzRiRFEy?=
 =?utf-8?Q?nHGxpDKXBwEi1KWSj7X8sfABMJKl2i6FdrKs8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3NsMzUyZlRFTk1FQnZ1MVczTTNIazFnZVdmRWlJbFBYL2NNbi9lK0NzZmtn?=
 =?utf-8?B?djZlMVFtelhpRXZob1lCbmFIeXZoZFNHbi85d1o1VFgvcEIwRSs4M3cvVU56?=
 =?utf-8?B?T1VjTmg5MS9tTCtGaThzZ1k3aHhGSGVJRHZXd2dzZWloOTJ6Yk9sKzRKdDdn?=
 =?utf-8?B?Ri9TZDJZWkNYNUVWQjRlYXNaRE4yY04zL3k3ZUpGbXpHNDlrQWNuMkhlYldi?=
 =?utf-8?B?eFV4OVYzMFV0d2tmR0xUVk1hMEgrMkg1WlRTQ3J3akFnWDNkcUJqejVONFJE?=
 =?utf-8?B?TjI3ckxXOEFOc3BqK1lMUkwwa0lBSGEzM0dpY0Zna1JMZzZRTlp2NGVEbUI5?=
 =?utf-8?B?TlMwRFBUd3VnQnV0Mnk0TUE1cTJEd3l1c1doZlpMYkJPekdzTVVFc3pRelg3?=
 =?utf-8?B?RnBCNXNxaXRJa2VMdm5mOVNtekxncUZRYWZoenMvamdJek5vL0UyVUVKZGJv?=
 =?utf-8?B?ZFVxblRpY0x3WHF6bTdrUmZFRmRGenp4Wkl1dXB5Mk5nZXVqZG8yVmJqdW45?=
 =?utf-8?B?R1MxT0dNcTliVGVSTkpSUEs4YlBzVEtFZ3RhRkdvb0FYS0FnRnhHVlh0akY3?=
 =?utf-8?B?RzdqdWtqWnc2d0JpdWs3emhoZXBWa1ZhWCtWbHdzTmVjeExyNjhDUEdYRTBE?=
 =?utf-8?B?elc2SWFWTWg4d3ZrV3N5d0Nud1BvbEliVitjUW1lWUdiWm1vdG03TnYySlJh?=
 =?utf-8?B?eVhOL24vZWlJY3JteHB6SFIxazNkOU5CUmVlNFMyV0srUXM0TWhLTE0wQWJZ?=
 =?utf-8?B?TzZkSWJmNkFBWHBZQ0VQSWE2WTZMSkMwMFVaMUk4eEJMdUgrVnVoQWUyUTU2?=
 =?utf-8?B?cjFTcWFxcEZrdC8vZGw4MlE4dzg4K2hmWk5mRHlwZHlpMnlySkNVUENvcmQx?=
 =?utf-8?B?bVU3ZStycG9hdkZ6a0pwYUJaRU1CSkUybURFUVVkSHBjc3h4eWRaaXVFbit0?=
 =?utf-8?B?dEIvV1k3NGJIRDREMlpVVFRKdlZIMlpEUkxDQUY0L3ZiRmhHamJhcUl2QzJI?=
 =?utf-8?B?VTB2S1NEamEyMGhZTnBwS2V5L0Z6dFNWNTVPQ1Fick1NM0N3bEtMdDVwRExl?=
 =?utf-8?B?NE52YTF1QVBsL3lxb3pwM3VlcnR2V2R3Z3d1TGppa1RGYkViRUhGaFNPeFEy?=
 =?utf-8?B?akFuUTYxQUU0dHhTZW1JQVNXdVVLSGFwaTlyRW51cnpLdmM4NlRGMlVVaXpr?=
 =?utf-8?B?WW1SRjFYVnlYc0V5ZXE2ZFQvQUtUVTBBRmVjRmpyeDNXUVdKVlBveDhYOGRw?=
 =?utf-8?B?YnVPWUxRWHBoRjVoK2FtV0JDM3EyQ2VOQ0ZoWk9IVDNJWFZTOTZ0RnNFV1Bs?=
 =?utf-8?B?Z29mZE1lK2ROS1h2b0pTNEpKaFFJYmhtVmhjeEdCcG5jdlNpWmkvVXpYcFFB?=
 =?utf-8?B?ZmpFanI0OFFWL3p1eHhmM0piSWpYY0hWTjcxRDIrUnJ0TkkvcUVTTjF2d2tj?=
 =?utf-8?B?aFFWVDVTU3ZIS0ZYdFJvQWcrV3l2TEQwaFp0WlFLVmk5MTZ3Wld2OGZFWkRT?=
 =?utf-8?B?WXZOQ0NYMkRmWG44cjZ2d240VjR5RDU2a3pwS1diMHZiT20xbmloLzdWZEZ1?=
 =?utf-8?B?bjJ3Tm0vMHNQS0d5dnRhUTl0OGpPVlFTVWNwUDhRb3hJbkpFd2pEWnRNWGht?=
 =?utf-8?B?SWRRcllNcXFFN2JVcWlERDRHc1FudXRFTnZLS00vTG42OTBsZTMva1ZEd2Y2?=
 =?utf-8?B?dzQ4OTVPZG52WmpjK2pzeGVHRkJ3c3BNMzFjU0Q4VkpFYnFJd0djbmJGTURW?=
 =?utf-8?B?czhlRGNjWXR5OFdhUHZxTzc0QUtWN0x4MExvOVpWTk53R1Bwazd2LzN1bG9R?=
 =?utf-8?B?NFJWYlVsOWJFNVFiQXBUd3BleDhHSXFKaTcvQklVWEVYNjhjS29tUjZwUldk?=
 =?utf-8?B?R2VGWXBKYmRhb2tLT1hTQ3hyTml6d1ExNTRmRlpQOW9SaUZEZVlxaE4xbWsr?=
 =?utf-8?B?NXQ3N2dBYk1OUjVGL1gvZXZHQTVWSUVLTjZVV1JqSmd5UGxSSlRCRHlzTks2?=
 =?utf-8?B?dzMzUE1OMjVib3dWMFg2djIrUk9hK0tsTjN1OHo2WjZJcG9lNTIyRGhuM3ln?=
 =?utf-8?B?M3g0Vkxhb2VDMGxyS3VFUzE0dnNZMm9xUG1Nb0ZGWmNxQjMySzNtYUx4R0NP?=
 =?utf-8?B?OWs5aXFBTXRDL2xlSElMYlBWSXZ6K1JMWGthWVlOZTFYbGNnTGNqbzl4RE1X?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FE051B264D3464A8CFBA937E3A28A38@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5635fd-aa52-4fad-e7f0-08dd08f37de2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 23:40:03.7958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iH0pw3szxF4WsacXe0cjM2wv7uwT2gvo8xSTGq9Epxl3gwxqgmK5VePWuImUbEHgrM1NvNWYi9AKPTiN1Trq/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7605
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTExLTE4IGF0IDIyOjU4ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
RnJpLCBPY3QgMjUsIDIwMjQgYXQgMDY6Mzc6MTJQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBOb3cgdGhhdCB0aGUgcGxhdGZvcm0gZGV2aWNlIGFsbG9jYXRpb24gaGFzIGJlZW4g
bW92ZWQgZnJvbQ0KPiA+IGJ1aWxkX2luZm9fY3JlYXRlX2RldigpIHRvIGZlYXR1cmVfZGV2X3Jl
Z2lzdGVyKCksIHRoZSBmb3JtZXINCj4gPiBubyBsb25nZXIgc2VydmVzIGl0cyBvcmlnaW5hbCBw
dXJwb3NlIGFuZCBtYXkgYmUgcmVtb3ZlZC4NCj4gDQo+IG1heSBiZSByZW1vdmVkPyBJdCBpcyBy
ZW1vdmVkIGluIHRoaXMgcGF0Y2gsIHBsZWFzZSBiZSBjb25maXJtYXRpdmUuDQoNClRoZSBjb21t
aXQgZGVzY3JpcHRpb24gaGFzIGJlZW4gcmV2aXNlZCBpbiBbUEFUQ0ggdjUgMTYvMThdLg0KDQpU
aGFua3MsDQpQZXRlcg0KDQo+IA0KPiBUaGFua3MsDQo+IFlpbHVuDQo+IA0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IFBldGVyIENvbGJlcmcgPHBldGVyLmNvbGJlcmdAaW50ZWwuY29tPg0KPiA+
IFJldmlld2VkLWJ5OiBNYXR0aGV3IEdlcmxhY2ggPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRl
bC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEJhc2hlZXIgQWhtZWQgTXVkZGViaWhhbCA8YmFzaGVl
ci5haG1lZC5tdWRkZWJpaGFsQGxpbnV4LmludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2Vz
IHNpbmNlIHYzOg0KPiA+IC0gTmV3IHBhdGNoIGV4dHJhY3RlZCBmcm9tIGxhc3QgcGF0Y2ggb2Yg
djMgc2VyaWVzLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2ZwZ2EvZGZsLmMgfCAxNyArKy0tLS0t
LS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxNSBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2RmbC5jIGIvZHJp
dmVycy9mcGdhL2RmbC5jDQo+ID4gaW5kZXggZDljZWYxNTBlZDBkLi5hMjQ1OWIwY2JjNjggMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9mcGdhL2RmbC5jDQo+ID4gKysrIGIvZHJpdmVycy9mcGdh
L2RmbC5jDQo+ID4gQEAgLTg1OCwxNiArODU4LDYgQEAgYmluZm9fY3JlYXRlX2ZlYXR1cmVfZGV2
X2RhdGEoc3RydWN0IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbykNCj4gPiAgCXJldHVy
biBmZGF0YTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAtc3RhdGljIGludA0KPiA+IC1idWlsZF9pbmZv
X2NyZWF0ZV9kZXYoc3RydWN0IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbykNCj4gPiAt
ew0KPiA+IC0JYmluZm8tPmZlYXR1cmVfbnVtID0gMDsNCj4gPiAtDQo+ID4gLQlJTklUX0xJU1Rf
SEVBRCgmYmluZm8tPnN1Yl9mZWF0dXJlcyk7DQo+ID4gLQ0KPiA+IC0JcmV0dXJuIDA7DQo+ID4g
LX0NCj4gPiAtDQo+ID4gIC8qDQo+ID4gICAqIHJlZ2lzdGVyIGN1cnJlbnQgZmVhdHVyZSBkZXZp
Y2UsIGl0IGlzIGNhbGxlZCB3aGVuIHdlIG5lZWQgdG8gc3dpdGNoIHRvDQo+ID4gICAqIGFub3Ro
ZXIgZmVhdHVyZSBwYXJzaW5nIG9yIHdlIGhhdmUgcGFyc2VkIGFsbCBmZWF0dXJlcyBvbiBnaXZl
biBkZXZpY2UNCj4gPiBAQCAtMTMxNiwxMSArMTMwNiw4IEBAIHN0YXRpYyBpbnQgcGFyc2VfZmVh
dHVyZV9maXUoc3RydWN0IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbywNCj4gPiAgCQly
ZXR1cm4gLUVJTlZBTDsNCj4gPiAgDQo+ID4gIAliaW5mby0+dHlwZSA9IHR5cGU7DQo+ID4gLQ0K
PiA+IC0JLyogY3JlYXRlIHBsYXRmb3JtIGRldmljZSBmb3IgZGZsIGZlYXR1cmUgZGV2ICovDQo+
ID4gLQlyZXQgPSBidWlsZF9pbmZvX2NyZWF0ZV9kZXYoYmluZm8pOw0KPiA+IC0JaWYgKHJldCkN
Cj4gPiAtCQlyZXR1cm4gcmV0Ow0KPiA+ICsJYmluZm8tPmZlYXR1cmVfbnVtID0gMDsNCj4gPiAr
CUlOSVRfTElTVF9IRUFEKCZiaW5mby0+c3ViX2ZlYXR1cmVzKTsNCj4gPiAgDQo+ID4gIAlyZXQg
PSBjcmVhdGVfZmVhdHVyZV9pbnN0YW5jZShiaW5mbywgMCwgMCwgMCk7DQo+ID4gIAlpZiAocmV0
KQ0KPiA+IC0tIA0KPiA+IDIuNDcuMA0KPiA+IA0KPiA+IA0KDQo=

