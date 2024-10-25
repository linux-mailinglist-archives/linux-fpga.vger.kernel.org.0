Return-Path: <linux-fpga+bounces-914-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DDE9B12EF
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB55283B98
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A772161F3;
	Fri, 25 Oct 2024 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MI6QOlfq"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D610E213147;
	Fri, 25 Oct 2024 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729896063; cv=fail; b=IW1ZH+GwOMIQKG1xVERcPKrrPF2dKNN0Pc5Zh7LrrplbyzJr4x15ta9Br04Qm0hlWHciBo+wCjonLEucrKR0Eldi5iY7WvAzSY8fFXfINuCJbNuH+VU0KqFxAb0wCNlmzuQ3ZmNQwZJyWBffUE8ZsWkJsARq1Pk6Jzz6awLI1sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729896063; c=relaxed/simple;
	bh=s1FB2wEMepZL1Au78+bYNW87ohGHs6KZBD1SuRbwyJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PpGDm1fhhWwc1qaZ66PUdIjbE9ihanakYKJfjGFhtiwQMm6RNAbsfEvkAVlTNM3PHp/BKqCeXApcKCiNJmWkMv3goZ9TeAZnIIp9kaJoWBpb0mogNAaJqpBTgl74pQ35Jt5T7RjMCWdqKoYayihnKPlCrWiFzNP1pysP0govrko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MI6QOlfq; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729896062; x=1761432062;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s1FB2wEMepZL1Au78+bYNW87ohGHs6KZBD1SuRbwyJM=;
  b=MI6QOlfqnaPD7N3vZEOj3Pcr+8zB2GES4S0sU7AsqFR0D0t5DFh3wSBj
   yiCXcz4sNRqEplo8SyM0GokjbgTAYyzzSHrsi+Gq3IpbVRYbGQVVzg0XK
   AgGYhpwq9xf7w9E2BUHamHBiAqsXMFebyltWUJ8yGIFqBWVawVMpM9eph
   zu01MtKisqnTjYKvFPzN3JgDZg2AMDlWd6PveBiIx4dyz8IE69ySxomIt
   +I5462+L9aOb8CxNw7MVANkoZyM6SHG6MOPCamnMmCtiOgkBnFD5jZhb+
   wH0mR4vHj4yg4z8eqqNjuDLzyrnx3OdBLxIKHgGBkeHqN4ckttWMnU5rL
   A==;
X-CSE-ConnectionGUID: d2307ge4Qh+/3Qx7t8Cv7A==
X-CSE-MsgGUID: 8ozzhfbqQZqkHoJHB9KHyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474986"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474986"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:41:01 -0700
X-CSE-ConnectionGUID: 73qATuFfQxm7ikP4byqgqw==
X-CSE-MsgGUID: fEmKZkGVSvOIX0Hczb5xLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="80694464"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 15:41:01 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 15:41:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 15:41:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 15:41:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBEJaGaN6nKrxzMojjPJsg4zBuZ9jTv9/VQWglZ1Rn3apfFYFUeslDiW3NZtdJkZRboD5Jczm7dHp/o/Nq6IYcBG7z76oDD/qmYAARXNtDaMPtzI8vXRm1DHEa46Vd5WMBR0t5ZC+niT9bYU6Ogt/mb9qIReHCMbqIB/1JN2inaJt6x3qQWXlbsdmCgSjt22oBtzFaFhlcQ5Wg7LhknJln7FHOJPk9O64pUZVpAfD2+5SfPIfcakseM4fP+sP1MMuYIKg1ORIwtEuanE6Wz1i3cR3K61XPbths7J+NjQSOBcdnYSMZvDX08ZM5ilpnN9UVPSsUl2FbMarYljqWV9Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1FB2wEMepZL1Au78+bYNW87ohGHs6KZBD1SuRbwyJM=;
 b=if/uEmoIpiLC48CjUNVg97tkhwSsQDFeDJp7OPsecaEFcciRHvZ+asNeDN/ex0hgNLnWqpX7GdEGMd+t0KjCL0bBljG5bzJ67YMwkc+DKVhlc0DHsBQToV+udOtBZFe5UsJrUoUaD0jfZGMWrWm8xP8lifjo8wqVGMbw1ATSIwae12b5+kPf8LG6BrIVMSmCi9hqVYlpR9iQYNDZJJbhRsFGT3+0MuIlAQliOEnAgKdfoeo8zB70MWWaSJaiz/v/FvfLq7geDhrv0H12E2CAgJeivL1p0cuKw4UIK46oGFJhK1R5W5xL6Pn4Rhz4aUsbCEx3xf9j5qeQdKaXJmZr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by SA3PR11MB7463.namprd11.prod.outlook.com (2603:10b6:806:304::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 22:40:57 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%6]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 22:40:57 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao"
	<hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>,
	"trix@redhat.com" <trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v3 2/9] fpga: dfl: omit unneeded null pointer check from
 {afu,fme}_open()
Thread-Topic: [PATCH v3 2/9] fpga: dfl: omit unneeded null pointer check from
 {afu,fme}_open()
Thread-Index: AQHbJy704meLN5EyiE+qoS7kJ6JSTQ==
Date: Fri, 25 Oct 2024 22:40:57 +0000
Message-ID: <bb513adfecd4806f73b03ff25a23e80bc69f075d.camel@intel.com>
References: <20240919203430.1278067-1-peter.colberg@intel.com>
	 <20240919203430.1278067-3-peter.colberg@intel.com>
	 <ZvJfLplAyNTrPz+E@yilunxu-OptiPlex-7050>
In-Reply-To: <ZvJfLplAyNTrPz+E@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|SA3PR11MB7463:EE_
x-ms-office365-filtering-correlation-id: 5d862226-a6e3-4f3c-cbea-08dcf54617f0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q3pDc3l0bitvT3MwQUsyZ0M0ZmZLa3pWU0FKS05LL0YySUtIVitZQ3pjWUdN?=
 =?utf-8?B?OUpYbCsvbmxBSGMyUktpdUpxei9ZeG5kMzBHM2tLU1ZhZ3owdlRZQjZISlBs?=
 =?utf-8?B?M0tEbkxtVDFEMzFtMTRqYmdFa0ZBcEh4dFU5OHhjVHhzVDM5OEY0aEJvZWd5?=
 =?utf-8?B?YWwzZ0w4dFdkQkZ6S3NmTGlkQStIL0NuRGUvSjBNOENQM3dEa3JrT0FnVjhq?=
 =?utf-8?B?OXF6dkliR2w2WGZNeSs2NVFpTGRkL3oranhUSS9wZ2xSWXhhVEE5VHJLVCtH?=
 =?utf-8?B?U2V0bGFzdUp5Slp0aWRyQjNQRUplb0p3TkZudVZwcGtGQmNzMVhzM2Q1Z0ph?=
 =?utf-8?B?ODRHTUN3UnZpektzSXU2dHRiN050bnRYUDNCUVlua3dHZFhYS0xUK2l2STJz?=
 =?utf-8?B?ckhXMkRjTWw4ZzUreWVFRmFJajhKdmEvN0wxeVpFcFd0UGFuZGNmTnRHY2s2?=
 =?utf-8?B?Q0pVYmc1eEdBK1JjcG8wT0JQNHNHam0zRnpFUFVJb1NyQ3F6VlJMQSsyalZ2?=
 =?utf-8?B?NmxrZ0Y1bnNEUTZuSVBFU2Nqb2RaTnJ1ck5PL1BqL0ViUzZUYjltUlhmTnd2?=
 =?utf-8?B?OVBBaFoxSGwvNGY1NFlOeTJkY2R2OHZvalI3cmNKellqVmNyU0NvQkM3WWUz?=
 =?utf-8?B?Q2J0aG9RQ2w5eUEzVGJXTjhPdVQ0U21NUGY4Q3daZklFWVZudit5YlJId05C?=
 =?utf-8?B?QW0xNkM0WG1tandOQ3pHaTBDU3BwSkVrL1BMWWJORVhiMmpYYkpNZlZXQXpM?=
 =?utf-8?B?Y3E2QWJxRnBuTVJTUXYzQS9BNERwQjlmaGVxZ1BGL3BEeHdWWW4vSElrVy9X?=
 =?utf-8?B?YnlKUWtLYkZaVm85STlhWUpvRG9UZFRLYi8yaGh4UVpTdThtaCtpRTZlaTls?=
 =?utf-8?B?bmQySFdKSTdERVZlWTFqYk1pYnV1bzRpayt0VmtQM29YSHl4bmFiNFVDaEtn?=
 =?utf-8?B?NERHMjhJRVZ0dXVwMUc2WTcweTZ4TU9nRVM3OEtxUDVXK1hDdDdrVWhsbDJk?=
 =?utf-8?B?M0REaUlUMVo5bmF5dkY4MVFiaHRNYzhIMTR4ZjJoY2NLcGNZSmZyOGhJQnY4?=
 =?utf-8?B?TW55dkFIb2E4NUhudlRqbTg4cVRrbFRZSTBHYUVCUnFWbEZGNGVJOVFTN0ZG?=
 =?utf-8?B?SFgwT3BvcjkvOENWbHpNRlBTWWVabWJvWlJvT0wwZVNZVUdNcEwyS1R3WndD?=
 =?utf-8?B?SCs0cjU3eWRFazFEODkybWVQS1Zuald3dEhKeFpWMnFabGd3ZjJQdmF1b2Nk?=
 =?utf-8?B?V3RlY0Npb1NhM1hCTGlMSmkveUNtRU1pbUJ2S21EcCtLZXZyd09UR0dYSnVC?=
 =?utf-8?B?QlBzNzFvSWRXWm9NOUhTRjl0Z0ZkMDdZL3ZiU3lWdnJ4alNrOXdPdFE0WjhN?=
 =?utf-8?B?SlJDRkVpQzZMRVVIekRIS3FmZWZzQ05TaG5JOHZpajlpK3djelk4RWNFb1dp?=
 =?utf-8?B?ZFFPNC9SZzVRby82S0dVMWo5b3liL0k3cm1CUTdIM1RpVS9PVXRYQTJaMnYv?=
 =?utf-8?B?RjVDVVc5Zit4M2kyZjFNd1JIQXFvYS8xdE5UL2V5L05nVHhxSEU1QWtiN3VS?=
 =?utf-8?B?bmkvMFRSemkzK2JEMzF0YjZxcjF0SlNiYVdMelhWamdGWjkwL21kWGlybStG?=
 =?utf-8?B?VDZDMEx5MjdkSHB2aHl2WFY4WmY2SG1TUXZZM1hPTit3YXdCVFhCeG55K2Er?=
 =?utf-8?B?RDcrMjRUcWU3ZWNSK0NFUlFOcDFrbG1hQyt1eFY1c3krWEtyWGxrU0Y0ZUtw?=
 =?utf-8?B?SW8vMGhqL05xbHdsVDJ4SkRpU1BGVVc3OE1ud2RVZFFTTWR0alVpQzExamts?=
 =?utf-8?Q?G7roSO6vQchi6qfttSvBbi9a25w2A+FTMgdpw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWlTSzlQVWxLUkgzQTVoT0RGeVBqcmcyT3BwWDYycWM4Wms1Z0ZJa1pKR1gz?=
 =?utf-8?B?V21DbW9vMHZHQjdNSUIxbUZpQzFHK2IxOWtrNnovQ2VjRmt3NlpyTDZ3aUpT?=
 =?utf-8?B?ai9Wc05EemRzNmVpNmtkUXNQRklySU1rZXRhZGE4UTJubUVYQy80aVNuYXpp?=
 =?utf-8?B?SlNIMUR2eGYrRVBvc25COVpXWEpHcWtUbHUxbmJlY0FHQ1hKeEE4eStZWlVU?=
 =?utf-8?B?RHA4Tnpxd2tvNXk2RWQrUUtxS2EwYXVKa3UwSzVqcmpKR3RQcUY5cDJqUHN5?=
 =?utf-8?B?eEludUFSZE5GREVkSXg0VGQ5YVFZMi9ZMnk5Y2ZsWmxSWEIrN1h1cTE4YkRr?=
 =?utf-8?B?NEZxQTlDeHBENGtsMlpUVjBleHhrcjU1dnpzTTJxM2psc3lRZFo2VW9DNGJX?=
 =?utf-8?B?QjJaRkhZZ3lUc09KNzFMcEN2bW1rclk4dXhRV1hKVWhaTmRIbmJMRnNOMkpm?=
 =?utf-8?B?RnhJOVFnZE5xWi9KR1lyK1FveVVGYTNvcFFyS3FJNWh3b2VJUWNEVk9wL2hz?=
 =?utf-8?B?NmtocWsvZ09Vb0pPRWNZckt6Y0daVS9IeDdjSUpLOWZBY0YvRTRYcWx2V2ty?=
 =?utf-8?B?SHMwUUVNUytVU0d6U0NWWWtGTmcrVTFOYVUzS2Zab25xMm9BTW90ZFFSYnJS?=
 =?utf-8?B?ejVsTURicFZaQXVaMXJvaVYwVFZzaC9Uc1N3cVdMWG9FOWRHMXk4Ukp6ZDE3?=
 =?utf-8?B?eklFMGk4djBWclR6Y0pORGhWUlJ2RE01SUluSTFQRlBqdy8yVXRLcG16TFhN?=
 =?utf-8?B?K29tbERWajZNc0thN1VHUWFJV3hEaFlRcTdYQTRhZUtsQmZsTzlRZ2E5VTNV?=
 =?utf-8?B?MnFZNE4zaG81ZXR3OWY0Q3BOUDAzc1VFd25GeVVzdUlxa243aytPMlJkWkZT?=
 =?utf-8?B?SzkzWGlNSktGZVRUcmVXK1QvMlU1WWlTRFA0UjQyQm40bWFUOWJ0N003d1Nw?=
 =?utf-8?B?cXdEa0dwcXR3YjgvNjhBd2tVZDZvV05HdlJnVTdpU2tZZUJ5WVFBSGx0eWVk?=
 =?utf-8?B?bkdpL2ZpN2dCM2tDQWJLYUVDaGptZUFwdHpNR0NUcmJ0TUVCUUtla2ovZlpF?=
 =?utf-8?B?Tm1WY1p5T3FRZFg2eVNDbWUvZ1F6cUtJYVBGQWlMVEdqYm9rekU3V0N4TXdh?=
 =?utf-8?B?NmlMUUpGOU42cXJXcCtGVWpBb1RhUW44Z0xJVGRhc2ZDN1hKazlsNStGVnJS?=
 =?utf-8?B?TDMxSnozN1BTMCtiSWZrVE5SZVdnYndLeFozYllibDR2aXBHb1IxYzdiZEhh?=
 =?utf-8?B?Vm42NjZyMU4xb1YyTS9vQW0vcXN1VEJXLzZFdkpNQlI4Z3RFR0VaVncxNjJs?=
 =?utf-8?B?M3NzalRxazA5MG1TZy9UQzFjWVFvZnZVQmRUOEdnR1ltRzlNbUlOcDF4VEZv?=
 =?utf-8?B?RWZGcWcxUzdIb3p3c01vR2pkNy9vMUNKS2RQOUFXUXYyZHBEd2dWWG9DT1M0?=
 =?utf-8?B?a0FwbFR0UFJ1STFYZlZjRnFHZThEOWJQaUFPQU9TR3pPTGg4ZU1GQjZ4cTF5?=
 =?utf-8?B?VHpBTmVxcDVHUVdDOXg5UksxaG1rZ2QvVGtBMDFRalFyWkdHYW5sNytNSjNi?=
 =?utf-8?B?OW9vY3I0TEJ6Wk9wRThKY1R6T3FBZEtqRGpFZXk3N0h0RmQ5TWdBR0VSaFJm?=
 =?utf-8?B?bG1nK1J3ZVdiM0RmRHRoL0dha1lRd0NFVTJrcElWVzByeFNJajBVVkJPZVZy?=
 =?utf-8?B?M3dCbExyNm5VVkV6YWoreDBsNUpRbStya0pEaUNkbFBtcFgxcGFZbFpSc2dm?=
 =?utf-8?B?T0hQZTFyNDVtcndjN3FQaXhnaDgwVGJHVEwzWmUzMUg0aDkvdng2OEJ5djM5?=
 =?utf-8?B?T09uKzN4WXcrNElJWHBHQzQyS2QrS1BkRDhsVC9WWHprbGExNWRiVGJORkx2?=
 =?utf-8?B?a0pMK2RpRW5adHM3cWU5OGJkT3dLdDBvcEl1RVJkK3pPYk1NQ0RvRjRhL1o5?=
 =?utf-8?B?ZUxXME9tOEY1OEZraDJFUGZicHl4VEtzNVlMZ0NHS3lTSUZNT1dvdWxIWXVK?=
 =?utf-8?B?bTcxb09tZHRIRTRneUdSeU9OYW5hU3lLS2FkK2gxNW5ITHFpTUxiK0RnWWRQ?=
 =?utf-8?B?QkRsT0ZVQkgwY29UV1ppL0hMb1dUZGFrbHBCMkJnTGtTdmJmV2JlWHE3b0pJ?=
 =?utf-8?B?USsxK0M0SWxDL0h6alJMTmttVWFVbUt3SExOVmdBdUpINFZHdmxtaVZvV2FB?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD780E8F40AE72429616AA24DC6861B3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d862226-a6e3-4f3c-cbea-08dcf54617f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 22:40:57.7528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rocMtXqALjV3qiEVa+RmYeer4a2QL62/z3H8k6fbHvjL7EvHdqX6mLOTeeDVeIZ+iRM6ZEvRHpPp5kfhyt6MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7463
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA5LTI0IGF0IDE0OjQxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VGh1LCBTZXAgMTksIDIwMjQgYXQgMDQ6MzQ6MjNQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBUaGUgZmVhdHVyZSBwbGF0Zm9ybSBkZXZpY2UgaXMgZ3VhcmFudGVlZCB0byBoYXZl
IGFuIGFzc29jaWF0ZWQgcGxhdGZvcm0NCj4gPiBkYXRhLiBSZWZhY3RvciBkZmxfZnBnYV9pbm9k
ZV90b19mZWF0dXJlX2Rldl9kYXRhKCkgdG8gZGlyZWN0bHkgcmV0dXJuDQo+ID4gdGhlIHBsYXRm
b3JtIGRhdGEgYW5kIHJldHJpZXZlIHRoZSBkZXZpY2UgZnJvbSB0aGUgZGF0YS4NCj4gDQo+IFRo
ZXNlIGNoYW5nZWxvZyBiZXR0ZXIgZGVzY3JpYmVzIHRoZSBjaGFuZ2UsIGJ1dCB0aGUgc2hvcnQg
bG9nIGRvZXMgbm90Lg0KPiBQbGVhc2UgdXBkYXRlLg0KPiANCj4gVGhhbmtzLA0KPiBZaWx1bg0K
DQpUaGUgc3ViamVjdCBoYXMgYmVlbiByZXZpc2VkIGluIHRoZSBwYXRjaCAiZnBnYTogZGZsOiBy
ZXR1cm4gcGxhdGZvcm0NCmRhdGEgZnJvbSBkZmxfZnBnYV9pbm9kZV90b19mZWF0dXJlX2Rldl9k
YXRhKCkiLg0KDQpUaGFua3MsDQpQZXRlcg0KDQo+IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFBldGVyIENvbGJlcmcgPHBldGVyLmNvbGJlcmdAaW50ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5
OiBNYXR0aGV3IEdlcmxhY2ggPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRlbC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvZnBnYS9kZmwtYWZ1LW1haW4uYyB8IDggKystLS0tLS0NCj4gPiAg
ZHJpdmVycy9mcGdhL2RmbC1mbWUtbWFpbi5jIHwgNyArKy0tLS0tDQo+ID4gIGRyaXZlcnMvZnBn
YS9kZmwuaCAgICAgICAgICB8IDYgKysrLS0tDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9mcGdhL2RmbC1hZnUtbWFpbi5jIGIvZHJpdmVycy9mcGdhL2RmbC1hZnUtbWFpbi5jDQo+ID4g
aW5kZXggNmI5N2MwNzM4NDllLi42MTI1ZTJmYWFkYTggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9mcGdhL2RmbC1hZnUtbWFpbi5jDQo+ID4gKysrIGIvZHJpdmVycy9mcGdhL2RmbC1hZnUtbWFp
bi5jDQo+ID4gQEAgLTU5NSwxNCArNTk1LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgZGZsX2ZlYXR1cmVf
ZHJpdmVyIHBvcnRfZmVhdHVyZV9kcnZzW10gPSB7DQo+ID4gIA0KPiA+ICBzdGF0aWMgaW50IGFm
dV9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxwKQ0KPiA+ICB7DQo+
ID4gLQlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpmZGV2ID0gZGZsX2ZwZ2FfaW5vZGVfdG9fZmVh
dHVyZV9kZXYoaW5vZGUpOw0KPiA+IC0Jc3RydWN0IGRmbF9mZWF0dXJlX3BsYXRmb3JtX2RhdGEg
KnBkYXRhOw0KPiA+ICsJc3RydWN0IGRmbF9mZWF0dXJlX3BsYXRmb3JtX2RhdGEgKnBkYXRhID0g
ZGZsX2ZwZ2FfaW5vZGVfdG9fZmVhdHVyZV9kZXZfZGF0YShpbm9kZSk7DQo+ID4gKwlzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpmZGV2ID0gcGRhdGEtPmRldjsNCj4gPiAgCWludCByZXQ7DQo+ID4g
IA0KPiA+IC0JcGRhdGEgPSBkZXZfZ2V0X3BsYXRkYXRhKCZmZGV2LT5kZXYpOw0KPiA+IC0JaWYg
KFdBUk5fT04oIXBkYXRhKSkNCj4gPiAtCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiAtDQo+ID4gIAlt
dXRleF9sb2NrKCZwZGF0YS0+bG9jayk7DQo+ID4gIAlyZXQgPSBkZmxfZmVhdHVyZV9kZXZfdXNl
X2JlZ2luKHBkYXRhLCBmaWxwLT5mX2ZsYWdzICYgT19FWENMKTsNCj4gPiAgCWlmICghcmV0KSB7
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9kZmwtZm1lLW1haW4uYyBiL2RyaXZlcnMv
ZnBnYS9kZmwtZm1lLW1haW4uYw0KPiA+IGluZGV4IDg2NDkyNGY2OGY1ZS4uNDgwYTE4NzI4OWJi
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZnBnYS9kZmwtZm1lLW1haW4uYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZnBnYS9kZmwtZm1lLW1haW4uYw0KPiA+IEBAIC01OTgsMTMgKzU5OCwxMCBAQCBz
dGF0aWMgbG9uZyBmbWVfaW9jdGxfY2hlY2tfZXh0ZW5zaW9uKHN0cnVjdCBkZmxfZmVhdHVyZV9w
bGF0Zm9ybV9kYXRhICpwZGF0YSwNCj4gPiAgDQo+ID4gIHN0YXRpYyBpbnQgZm1lX29wZW4oc3Ry
dWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbHApDQo+ID4gIHsNCj4gPiAtCXN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKmZkZXYgPSBkZmxfZnBnYV9pbm9kZV90b19mZWF0dXJlX2Rldihp
bm9kZSk7DQo+ID4gLQlzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBk
ZXZfZ2V0X3BsYXRkYXRhKCZmZGV2LT5kZXYpOw0KPiA+ICsJc3RydWN0IGRmbF9mZWF0dXJlX3Bs
YXRmb3JtX2RhdGEgKnBkYXRhID0gZGZsX2ZwZ2FfaW5vZGVfdG9fZmVhdHVyZV9kZXZfZGF0YShp
bm9kZSk7DQo+ID4gKwlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpmZGV2ID0gcGRhdGEtPmRldjsN
Cj4gPiAgCWludCByZXQ7DQo+ID4gIA0KPiA+IC0JaWYgKFdBUk5fT04oIXBkYXRhKSkNCj4gPiAt
CQlyZXR1cm4gLUVOT0RFVjsNCj4gPiAtDQo+ID4gIAltdXRleF9sb2NrKCZwZGF0YS0+bG9jayk7
DQo+ID4gIAlyZXQgPSBkZmxfZmVhdHVyZV9kZXZfdXNlX2JlZ2luKHBkYXRhLCBmaWxwLT5mX2Zs
YWdzICYgT19FWENMKTsNCj4gPiAgCWlmICghcmV0KSB7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZnBnYS9kZmwuaCBiL2RyaXZlcnMvZnBnYS9kZmwuaA0KPiA+IGluZGV4IDUwNjNkNzNiMGQ4
Mi4uMjI4NTIxNWY0NDRlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZnBnYS9kZmwuaA0KPiA+
ICsrKyBiL2RyaXZlcnMvZnBnYS9kZmwuaA0KPiA+IEBAIC0zOTgsMTQgKzM5OCwxNCBAQCBpbnQg
ZGZsX2ZwZ2FfZGV2X29wc19yZWdpc3RlcihzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0K
PiA+ICAJCQkgICAgICBzdHJ1Y3QgbW9kdWxlICpvd25lcik7DQo+ID4gIHZvaWQgZGZsX2ZwZ2Ff
ZGV2X29wc191bnJlZ2lzdGVyKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpOw0KPiA+ICAN
Cj4gPiAtc3RhdGljIGlubGluZQ0KPiA+IC1zdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZmxfZnBn
YV9pbm9kZV90b19mZWF0dXJlX2RldihzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KPiA+ICtzdGF0aWMg
aW5saW5lIHN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhICoNCj4gPiArZGZsX2ZwZ2Ff
aW5vZGVfdG9fZmVhdHVyZV9kZXZfZGF0YShzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KPiA+ICB7DQo+
ID4gIAlzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGE7DQo+ID4gIA0KPiA+
ICAJcGRhdGEgPSBjb250YWluZXJfb2YoaW5vZGUtPmlfY2Rldiwgc3RydWN0IGRmbF9mZWF0dXJl
X3BsYXRmb3JtX2RhdGEsDQo+ID4gIAkJCSAgICAgY2Rldik7DQo+ID4gLQlyZXR1cm4gcGRhdGEt
PmRldjsNCj4gPiArCXJldHVybiBwZGF0YTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgI2RlZmluZSBk
ZmxfZnBnYV9kZXZfZm9yX2VhY2hfZmVhdHVyZShwZGF0YSwgZmVhdHVyZSkJCQkgICAgXA0KPiA+
IC0tIA0KPiA+IDIuNDYuMQ0KPiA+IA0KPiA+IA0KDQo=

